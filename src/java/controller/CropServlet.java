/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.CropDAO;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.sql.Date;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import model.Crop;


/**
 *
 * @author Nabil Nasri
 */

@WebServlet("/crops")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2,
                 maxFileSize = 1024 * 1024 * 10,
                 maxRequestSize = 1024 * 1024 * 50)
public class CropServlet extends HttpServlet {

    private static final String UPLOAD_DIRECTORY = "uploads";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if (action != null && action.equalsIgnoreCase("delete")) {
            handleDelete(request, response);
        } else {
            try {
                CropDAO cropDao = new CropDAO();
                request.setAttribute("crops", cropDao.getAllCrops());
                request.getRequestDispatcher("crops.jsp").forward(request, response);
            } catch (SQLException e) {
                e.printStackTrace();
                request.setAttribute("error", "Error loading crops: " + e.getMessage());
                request.getRequestDispatcher("crops.jsp").forward(request, response);
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        try {
            if ("add".equalsIgnoreCase(action)) {
                handleAddCrop(request, response);
            } else if ("update".equalsIgnoreCase(action)) {
                handleUpdateCrop(request, response);
            } else {
                response.sendRedirect("crops");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error processing request: " + e.getMessage());
            request.getRequestDispatcher("crops.jsp").forward(request, response);
        }
    }

    private void handleDelete(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            int cropId = Integer.parseInt(request.getParameter("cropId"));
            CropDAO cropDao = new CropDAO();
            Crop cropToDelete = cropDao.getCropById(cropId);
            
            if (cropToDelete != null && cropToDelete.getImagePath() != null && !cropToDelete.getImagePath().isEmpty()) {
                Path filePath = Paths.get(getServletContext().getRealPath("") + java.io.File.separator + cropToDelete.getImagePath());
                try {
                    Files.deleteIfExists(filePath);
                } catch (IOException e) {
                    System.err.println("Error deleting image file: " + e.getMessage());
                }
            }
            
            if (cropDao.deleteCrop(cropId)) {
                response.sendRedirect("crops");
            } else {
                request.setAttribute("error", "Failed to delete crop");
                request.getRequestDispatcher("crops.jsp").forward(request, response);
            }
        } catch (NumberFormatException | SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Error deleting crop: " + e.getMessage());
            request.getRequestDispatcher("crops.jsp").forward(request, response);
        }
    }

    private void handleAddCrop(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ParseException, SQLException {
        CropDAO cropDao = new CropDAO();
        Crop crop = new Crop();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

        String cropName = request.getParameter("cropName");
        if ("Other".equals(cropName)) {
            cropName = request.getParameter("otherCropName");
        }
        crop.setCropName(cropName);

        String imagePath = handleFileUpload(request);
        crop.setImagePath(imagePath);

        java.util.Date date = sdf.parse(request.getParameter("plantingDate"));
        crop.setPlantingDate(new Date(date.getTime()));
        crop.setStatus(request.getParameter("status"));
        crop.setNotes(request.getParameter("notes"));

        if (cropDao.addCrop(crop)) {
            response.sendRedirect("crops");
        } else {
            if (imagePath != null) {
                Path uploadedFilePath = Paths.get(getServletContext().getRealPath("") + java.io.File.separator + imagePath);
                Files.deleteIfExists(uploadedFilePath);
            }
            request.setAttribute("error", "Failed to add crop");
            request.getRequestDispatcher("crops.jsp").forward(request, response);
        }
    }

    private void handleUpdateCrop(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ParseException, SQLException {
        CropDAO cropDao = new CropDAO();
        Crop crop = new Crop();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

        String cropName = request.getParameter("cropName");
        if ("Other".equals(cropName)) {
            cropName = request.getParameter("otherCropName");
        }
        crop.setCropName(cropName);

        int cropId = Integer.parseInt(request.getParameter("cropId"));
        crop.setCropId(cropId);

        java.util.Date date = sdf.parse(request.getParameter("plantingDate"));
        crop.setPlantingDate(new Date(date.getTime()));
        crop.setStatus(request.getParameter("status"));
        crop.setNotes(request.getParameter("notes"));

        String oldImagePath = request.getParameter("existingImagePath");
        String imagePath = handleFileUpload(request);
        
        if (imagePath != null) {
            crop.setImagePath(imagePath);
            if (oldImagePath != null && !oldImagePath.isEmpty()) {
                Path oldFilePath = Paths.get(getServletContext().getRealPath("") + java.io.File.separator + oldImagePath);
                try {
                    Files.deleteIfExists(oldFilePath);
                } catch (IOException e) {
                    System.err.println("Error deleting old image file: " + e.getMessage());
                }
            }
        } else {
            crop.setImagePath(oldImagePath);
        }

        if (cropDao.updateCrop(crop)) {
            response.sendRedirect("crops");
        } else {
            if (imagePath != null) {
                Path uploadedFilePath = Paths.get(getServletContext().getRealPath("") + java.io.File.separator + imagePath);
                Files.deleteIfExists(uploadedFilePath);
            }
            request.setAttribute("error", "Failed to update crop");
            request.getRequestDispatcher("crops.jsp").forward(request, response);
        }
    }

    private String handleFileUpload(HttpServletRequest request) throws IOException, ServletException {
        Part filePart = request.getPart("image");
        if (filePart == null || filePart.getSize() == 0) {
            return null;
        }

        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
        String uploadPath = getServletContext().getRealPath("") + java.io.File.separator + UPLOAD_DIRECTORY;
        java.io.File uploadDir = new java.io.File(uploadPath);
        
        if (!uploadDir.exists()) {
            uploadDir.mkdir();
        }

        String uniqueFileName = System.currentTimeMillis() + "_" + fileName;
        Path filePath = Paths.get(uploadPath + java.io.File.separator + uniqueFileName);
        
        try (InputStream fileContent = filePart.getInputStream()) {
            Files.copy(fileContent, filePath);
        }
        
        return UPLOAD_DIRECTORY + "/" + uniqueFileName;
    }
}
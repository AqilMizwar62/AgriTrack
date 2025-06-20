package controller;

import dao.CropDAO;
import dao.HarvestDAO;
import java.io.IOException;
import java.sql.Date;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate; 
import java.time.format.DateTimeParseException; 
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Crop;
import model.HarvestPlan;

@WebServlet("/harvest")
public class HarvestServlet extends HttpServlet {

    private HarvestDAO harvestDAO;
    private CropDAO cropDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        harvestDAO = new HarvestDAO();
        cropDAO = new CropDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            listHarvestPlans(request, response);
        } catch (SQLException e) {
            handleError(request, response, "Error retrieving data: " + e.getMessage());
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        try {
            if (action == null || action.isEmpty()) {
                addHarvestPlan(request, response);
            } else {
                switch (action) {
                    case "update":
                        updateHarvestPlan(request, response);
                        break;
                    case "delete":
                        deleteHarvestPlan(request, response);
                        break;
                    default:
                        // If an unrecognized action, handle as an error or redirect
                        request.getSession().setAttribute("error", "Unknown action requested.");
                        response.sendRedirect("harvest");
                        break;
                }
            }
        } catch (NumberFormatException | ParseException | DateTimeParseException e) {
            request.getSession().setAttribute("error", "Invalid input or date format: " + e.getMessage());
            response.sendRedirect("harvest");
        } catch (SQLException e) {
            request.getSession().setAttribute("error", "Database error: " + e.getMessage());
            response.sendRedirect("harvest");
        }
    }

    private void listHarvestPlans(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        List<HarvestPlan> harvestPlans = harvestDAO.getAllHarvestPlans();
        List<Crop> crops = cropDAO.getAllCrops();
        
        request.setAttribute("harvestPlans", harvestPlans);
        request.setAttribute("crops", crops);
        
        if (harvestPlans.isEmpty()) {
            request.setAttribute("info", "No harvest plans found.");
        }
        
        request.getRequestDispatcher("harvest.jsp").forward(request, response);
    }

    private void addHarvestPlan(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ParseException, ServletException, IOException {
        int cropId = Integer.parseInt(request.getParameter("cropId"));
        String harvestDateStr = request.getParameter("harvestDate");
        String seasonType = request.getParameter("seasonType");
        
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        Date harvestDate = new Date(sdf.parse(harvestDateStr).getTime());

        // Basic validation: ensure harvest date is not in the past
        if (harvestDate.toLocalDate().isBefore(LocalDate.now())) {
            request.getSession().setAttribute("error", "Harvest date cannot be in the past.");
            response.sendRedirect("harvest");
            return;
        }
        
        HarvestPlan plan = new HarvestPlan();
        plan.setCropId(cropId);
        plan.setHarvestDate(harvestDate);
        plan.setSeasonType(seasonType);
        
        if (harvestDAO.addHarvestPlan(plan)) {
            request.getSession().setAttribute("message", "Harvest scheduled successfully!");
        } else {
            request.getSession().setAttribute("error", "Failed to schedule harvest. It might be already scheduled for this crop.");
        }
        response.sendRedirect("harvest");
    }

    private void updateHarvestPlan(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ParseException, ServletException, IOException {
        int planId = Integer.parseInt(request.getParameter("planId"));
        String harvestDateStr = request.getParameter("harvestDate");
        String seasonType = request.getParameter("seasonType");

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        Date harvestDate = new Date(sdf.parse(harvestDateStr).getTime());

        // Basic validation: ensure harvest date is not in the past
        if (harvestDate.toLocalDate().isBefore(LocalDate.now())) {
            request.getSession().setAttribute("error", "Harvest date cannot be in the past.");
            response.sendRedirect("harvest");
            return;
        }

        HarvestPlan plan = new HarvestPlan();
        plan.setPlanId(planId);
        plan.setHarvestDate(harvestDate);
        plan.setSeasonType(seasonType);

        if (harvestDAO.updateHarvestPlan(plan)) {
            request.getSession().setAttribute("message", "Harvest plan updated successfully!");
        } else {
            request.getSession().setAttribute("error", "Failed to update harvest plan.");
        }
        response.sendRedirect("harvest");
    }

    private void deleteHarvestPlan(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        int planId = Integer.parseInt(request.getParameter("planId"));
        
        if (harvestDAO.deleteHarvestPlan(planId)) {
            request.getSession().setAttribute("message", "Harvest plan deleted successfully!");
        } else {
            request.getSession().setAttribute("error", "Failed to delete harvest plan.");
        }
        response.sendRedirect("harvest");
    }

    private void handleError(HttpServletRequest request, HttpServletResponse response, String errorMessage)
            throws ServletException, IOException {
        // Set error message in session to be displayed on redirect
        request.getSession().setAttribute("error", errorMessage);
        response.sendRedirect("harvest"); // Redirect to the main harvest page
    }
}
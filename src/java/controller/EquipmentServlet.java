/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dao.EquipmentDAO;
import model.Equipment;
import java.io.IOException;
import java.sql.Date;
import java.sql.SQLException;
import java.util.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/equipment")
public class EquipmentServlet extends HttpServlet {
    private EquipmentDAO equipmentDAO = new EquipmentDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String userEmail = (String) request.getSession().getAttribute("userEmail");
        if (userEmail == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        try {
            List<Equipment> equipmentList = equipmentDAO.getEquipmentByUserEmail(userEmail);
            request.setAttribute("equipmentList", equipmentList);
            
            Map<String, Integer> healthStats = equipmentDAO.getEquipmentHealthStats();
            request.setAttribute("healthStats", healthStats);
            
            List<Equipment> maintenanceAlerts = equipmentDAO.getUpcomingMaintenance();
            request.setAttribute("maintenanceAlerts", maintenanceAlerts);
            
            String weatherAlert = getWeatherAlert();
            if (weatherAlert != null) {
                request.setAttribute("weatherAlert", weatherAlert);
            }
            
            if (equipmentList.isEmpty()) {
                request.setAttribute("info", "No equipment found. Click 'Refresh' to load data.");
            }
            
        } catch (SQLException e) {
            request.setAttribute("error", "Database error: " + e.getMessage());
        }
        
        RequestDispatcher dispatcher = request.getRequestDispatcher("equipment.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String userEmail = (String) request.getSession().getAttribute("userEmail");
        if (userEmail == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        String editId = request.getParameter("editId");
        String name = request.getParameter("name");
        String condition = request.getParameter("condition");
        String lastMaintenanceStr = request.getParameter("lastMaintenance");
        String hoursUsedStr = request.getParameter("hoursUsed");
        String equipmentType = request.getParameter("equipmentType");
        
        try {
            Equipment equip = new Equipment();
            equip.setName(name);
            equip.setConditionStatus(condition);
            equip.setEquipmentType(equipmentType);
            equip.setUserEmail(userEmail);
            
            if (lastMaintenanceStr != null && !lastMaintenanceStr.isEmpty()) {
                Date lastMaintenance = Date.valueOf(lastMaintenanceStr);
                equip.setLastMaintenance(lastMaintenance);
                
                // Calculate next maintenance (3 months later)
                Calendar cal = Calendar.getInstance();
                cal.setTime(lastMaintenance);
                cal.add(Calendar.MONTH, 3);
                equip.setNextMaintenance(new Date(cal.getTimeInMillis()));
            }
            
            if (hoursUsedStr != null && !hoursUsedStr.isEmpty()) {
                equip.setHoursUsed(Integer.parseInt(hoursUsedStr));
            }
            
            if (editId != null && !editId.isEmpty()) {
                equip.setId(Integer.parseInt(editId));
                equipmentDAO.updateEquipment(equip);
                request.getSession().setAttribute("message", "Equipment updated successfully!");
            } else {
                equipmentDAO.addEquipment(equip);
                request.getSession().setAttribute("message", "Equipment added successfully!");
            }
        } catch (Exception e) {
            request.getSession().setAttribute("error", "Error: " + e.getMessage());
        }
        
        response.sendRedirect("equipment");
    }

    @Override
    protected void doDelete(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String userEmail = (String) request.getSession().getAttribute("userEmail");
        if (userEmail == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        String idStr = request.getParameter("id");
        if (idStr != null && !idStr.isEmpty()) {
            try {
                int id = Integer.parseInt(idStr);
                equipmentDAO.deleteEquipment(id, userEmail);
                response.setStatus(HttpServletResponse.SC_OK);
            } catch (SQLException e) {
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            }
        } else {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
        }
    }

    private String getWeatherAlert() {
        Random rand = new Random();
        int chance = rand.nextInt(10);
        
        if (chance > 7) {
            return "Heavy rain expected tomorrow - avoid field work";
        } else if (chance > 5) {
            return "High winds forecasted - secure equipment";
        }
        return null;
    }
}
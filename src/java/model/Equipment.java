/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Nabil Nasri
 */

import java.sql.Date;
import java.util.List;

public class Equipment {
    
    private int id;
    private String name;
    private String conditionStatus;
    private Date lastMaintenance;
    private Date nextMaintenance;
    private int hoursUsed;
    private String equipmentType;

    // Constructors
    public Equipment() {}

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { 
        if (name == null || name.trim().isEmpty()) {
            throw new IllegalArgumentException("Name cannot be empty");
        }
        this.name = name; 
    }

    public String getConditionStatus() { return conditionStatus; }
    public void setConditionStatus(String conditionStatus) {
        if (!List.of("Excellent", "Good", "Needs Maintenance", "Out of Service").contains(conditionStatus)) {
            throw new IllegalArgumentException("Invalid condition status");
        }
        this.conditionStatus = conditionStatus;
    }

    public Date getLastMaintenance() { return lastMaintenance; }
    public void setLastMaintenance(Date lastMaintenance) { 
        this.lastMaintenance = lastMaintenance; 
    }

    public Date getNextMaintenance() { return nextMaintenance; }
    public void setNextMaintenance(Date nextMaintenance) {
        this.nextMaintenance = nextMaintenance;
    }

    public int getHoursUsed() { return hoursUsed; }
    public void setHoursUsed(int hoursUsed) {
        if (hoursUsed < 0) throw new IllegalArgumentException("Hours cannot be negative");
        this.hoursUsed = hoursUsed;
    }

    public String getEquipmentType() { return equipmentType; }
    public void setEquipmentType(String equipmentType) {
        this.equipmentType = equipmentType;
    }
}
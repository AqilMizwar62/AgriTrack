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

public class Crop {
    
    private int cropId;
    private String cropName;
    private Date plantingDate;
    private String status;
    private String notes;
    private String imagePath;

    // Getters and setters
    public int getCropId() { 
        return cropId; 
    }
    
    public void setCropId(int cropId) { 
        this.cropId = cropId; 
    }
    
    public String getCropName() { 
        return cropName; 
    }
    
    public void setCropName(String cropName) { 
        this.cropName = cropName; 
    }
    
    public Date getPlantingDate() { 
        return plantingDate; 
    }
    
    public void setPlantingDate(Date plantingDate) { 
        this.plantingDate = plantingDate; 
    }
    
    public String getStatus() { 
        return status; 
    }
    
    public void setStatus(String status) { 
        this.status = status; 
    }
    
    public String getNotes() { 
        return notes; 
    }
    
    public void setNotes(String notes) { 
        this.notes = notes; 
    }
    public String getImagePath() {
        return imagePath;
    }

    public void setImagePath(String imagePath) {
        this.imagePath = imagePath;
    }
}
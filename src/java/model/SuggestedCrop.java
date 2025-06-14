// SuggestedCrop.java
package model;

import java.sql.Timestamp;

public class SuggestedCrop {
    private int suggestionId;
    private String cropName;
    private int suggestedByUserId; // Optional
    private Timestamp suggestionDate;

    // Constructors
    public SuggestedCrop() {
    }

    public SuggestedCrop(String cropName) {
        this.cropName = cropName;
    }

    public SuggestedCrop(String cropName, int suggestedByUserId) {
        this.cropName = cropName;
        this.suggestedByUserId = suggestedByUserId;
    }

    // Getters and Setters
    public int getSuggestionId() {
        return suggestionId;
    }

    public void setSuggestionId(int suggestionId) {
        this.suggestionId = suggestionId;
    }

    public String getCropName() {
        return cropName;
    }

    public void setCropName(String cropName) {
        this.cropName = cropName;
    }

    public int getSuggestedByUserId() {
        return suggestedByUserId;
    }

    public void setSuggestedByUserId(int suggestedByUserId) {
        this.suggestedByUserId = suggestedByUserId;
    }

    public Timestamp getSuggestionDate() {
        return suggestionDate;
    }

    public void setSuggestionDate(Timestamp suggestionDate) {
        this.suggestionDate = suggestionDate;
    }
}
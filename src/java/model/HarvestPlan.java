package model;

import java.sql.Date;
import java.time.LocalDate;
import java.time.ZoneId;
import java.time.temporal.ChronoUnit;

public class HarvestPlan {
    private int planId;
    private int cropId;
    private String cropName;
    private Date plantingDate;
    private Date harvestDate;
    private String seasonType;

    public HarvestPlan() {}

    public int getPlanId() {
        return planId;
    }

    public void setPlanId(int planId) {
        this.planId = planId;
    }

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

    public Date getHarvestDate() {
        return harvestDate;
    }

    public void setHarvestDate(Date harvestDate) {
        this.harvestDate = harvestDate;
    }

    public String getSeasonType() {
        return seasonType;
    }

    public void setSeasonType(String seasonType) {
        this.seasonType = seasonType;
    }


    public long getDaysRemaining() {
        if (this.harvestDate == null) {
            return 0;
        }
        LocalDate today = LocalDate.now();
        LocalDate harvest = this.harvestDate.toLocalDate();

        if (harvest.isBefore(today)) {
            return 0;
        } else {
            return ChronoUnit.DAYS.between(today, harvest);
        }
    }
}
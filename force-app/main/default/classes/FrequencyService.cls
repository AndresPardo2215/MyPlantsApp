public with sharing class FrequencyService {
    public static Integer getWateringDays(Species__c specie) {
        // specie.Summer_Watering_Frequency__c, Winter_Watering_Frequency__c

        return 20;
    }

    public static Integer getFertilizationDays(Species__c specie) {
        return 30;
    }
}
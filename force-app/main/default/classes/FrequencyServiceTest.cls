@isTest
private with sharing class FrequencyServiceTest {
    
    @isTest
    static void getWateringDays_wateringFreqDailyAndWinter_oneDay() {
        // TODO: mock System.today() - emular en el test quen que mes del año estoy
        // GIVEN Creación de datos, escenario
        Species__c specie = new Species__c();
        specie.Summer_Watering_Frequency__c = 'Daily';

        // WHEN llamamos al método
        Integer days = FrequencyService.getWateringDays(specie);

        // THEN chequear el resultado esperado
        Integer expectedDays = 1;
        System.assertEquals(expectedDays, days, 'Expected 1 day returned');
    }

    @isTest
    static void getWateringDays_wateringFreqTwicePerWeekAndWinter_threeDays() {
        // TODO: mock System.today() - emular en el test quen que mes del año estoy
        // GIVEN Creación de datos, escenario
        Species__c specie = new Species__c();
        specie.Summer_Watering_Frequency__c = 'Twice per week';

        // WHEN llamamos al método
        Integer days = FrequencyService.getWateringDays(specie);

        // THEN chequear el resultado esperado
        Integer expectedDays = 3;
        System.assertEquals(expectedDays, days, 'Expected 3 days returned');
    }
}
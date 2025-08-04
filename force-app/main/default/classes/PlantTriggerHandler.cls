public with sharing class PlantTriggerHandler {
  public void beforeInsert(List<Plant__c> newSObjects) {
    // Precargar información necesario de objetos relacionados
    Set<Id> speciesIds = new Set<Id>();
    for (Plant__c newPlant : newSObjects) {
      speciesIds.add(newPlant.Species__c);
    }

    // Query precarga objetos relacionados
    List<Species__c> species = [
      SELECT Summer_Watering_Frequency__c, Winter_Watering_Frequency__c
      FROM Species__c
      WHERE Id IN :speciesIds
    ];
    Map<Id, Species__c> speciesById = preloadRelatedSpecies(speciesIds);

    //prepopulate Next Watering Date
    for (Plant__c newPlant : newSObjects) {
      populateNextWateringDate(newPlant, speciesById);
    }
  }
  public void beforeUpdate(
    List<Plant__c> oldSObjects,
    Map<ID, Plant__c> oldSObjectsMap,
    List<Plant__c> updatedSObjects,
    Map<ID, Plant__c> updatedSObjectsMap
  ) {
    // cuando se crea o actualiza una planta (cambiando su fecha de regado) --> calcular sig fecha de riego
    // Precargar información necesario de objetos relacionados
    Set<Id> speciesIds = new Set<Id>();
    for (Plant__c newPlant : updatedSObjects) {
      Plant__c oldPlant = oldSObjectsMap.get(newPlant.Id);
      if (oldPlant.Last_Watered__c != newPlant.Last_Watered__c) {
        speciesIds.add(newPlant.Species__c);
      }
    }

    //Query precarga de objetos relacionados
    Map<Id, Species__c> speciesById = preloadRelatedSpecies(speciesIds);

    // si esta cambiando la fecha de riego
    // Trigger.old / newSObjects / Trigger.oldMap / Trigger.newMap
    // Obtener valor nuevo fecha de riego  de Trigger.new
    // Obtener valor nuevo fecha de riego  de Trigger.oldMap
    for (Plant__c newPlant : updatedSObjects) {
      Plant__c oldPlant = oldSObjectsMap.get(newPlant.Id);
      if (oldPlant.Last_Watered__c != newPlant.Last_Watered__c) {
        populateNextWateringDate(newPlant, speciesById);
      }
    }
  }

  private static Map<Id, Species__c> preloadRelatedSpecies(Set<Id> speciesIds) {
    List<Species__c> species = [
      SELECT Summer_Watering_Frequency__c, Winter_Watering_Frequency__c
      FROM Species__c
      WHERE Id IN :speciesIds
    ];
    return new Map<Id, Species__c>(species);
  }

  private static void populateNextWateringDate(
    Plant__c newPlant,
    Map<Id, Species__c> speciesById
  ) {
    // Calcular sig fecha de riego
    // clacular sig fecha de riego
    // ver de que especie es mi planta
    Id specieId = newPlant.Species__c;
    //Traer objeto specie
    // MAL ---{  Species__c specie = [SELECT Summer_Watering_Frequency__c FROM Species__c WHERE Id = :specieId];
    Species__c specie = speciesById.get(specieId); // BIEN!!!
    // Pedir frecuencia de riego para esa especie
    Integer daysToAdd = FrequencyService.getWateringDays(specie, new DateService());
    // sig fecha de riego = ultima fecha de riego + dias devueltos
    newPlant.Next_Watered__c = newPlant.Last_Watered__c.addDays(daysToAdd);
  }
}

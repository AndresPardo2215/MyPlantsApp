trigger PlantTrigger on Plant__c(before insert, before update) {
  // Trigger.isBefore, Trigger.isInsert ... variables de contexto que nos a que evento estamos

  // cuando se crea o actualiza una planta (cambiando su fecha de regado) --> calcular sig fecha de riego

  // ... List<Species__c>Species__c species = [SELECT Summer_Watering_Frequency__c FROM Species__c WHERE Id IN = :specieId];

  if (Trigger.isInsert || Trigger.isUpdate) {
    // Precargar información necesario de objetos relacionados
    Set<Id> speciesIds = new Set<Id>();
    for (Plant__c newPlant : Trigger.new) {
      Plant__c oldPlant = (Trigger.isUpdate)
        ? Trigger.oldMap.get(newPlant.Id)
        : null;
      if (
        oldPlant == null ||
        (oldPlant.Last_Watered__c != newPlant.Last_Watered__c)
      ) {
        speciesIds.add(newPlant.Species__c);
      }
    }

    List<Species__c> species = [
      SELECT Summer_Watering_Frequency__c, Winter_Watering_Frequency__c
      FROM Species__c
      WHERE Id IN :speciesIds
    ];
    Map<Id, Species__c> speciesById = new Map<Id, Species__c>(species);

    // si esta cambiando la fecha de riego
    // Trigger.old / Trigger.new / Trigger.oldMap / Trigger.newMap
    // Obtener valor nuevo fecha de riego  de Trigger.new
    // Obtener valor nuevo fecha de riego  de Trigger.oldMap
    for (Plant__c newPlant : Trigger.new) {
      Plant__c oldPlant = (Trigger.isUpdate) ? Trigger.oldMap.get(newPlant.Id): null;
      if ( oldPlant == null || (oldPlant.Last_Watered__c != newPlant.Last_Watered__c)) {
        // clacular sig fecha de riego
        // ver de que especie es mi planta
        Id specieId = newPlant.Species__c;
        //Traer objeto specie
        // MAL ---{  Species__c specie = [SELECT Summer_Watering_Frequency__c FROM Species__c WHERE Id = :specieId];
        Species__c specie = speciesById.get(specieId); // BIEN!!!
        // Pedir frecuencia de riego para esa especie
        Integer daysToAdd = FrequencyService.getWateringDays(specie);
        // sig fecha de riego = ultima fecha de riego + dias devueltos
        newPlant.Next_Watered__c = newPlant.Last_Watered__c.addDays(daysToAdd);
      }
    }
  }
  // cuando se crea o actualiza una planta (cambiando su fecha de abonado) --> calcular sig fecha de abonado
}

trigger PlantTrigger on Plant__c(before insert, before update) {
  // Trigger.isBefore, Trigger.isInsert ... variables de contexto que nos a que evento estamos
      //───────────────────────────────────────────────────────────────────────────┐
  // Instantiate the Trigger Handler, then dispatch to the correct Action  
  // Handler Method (eg. BEFORE INSERT or AFTER UPDATE).
  //───────────────────────────────────────────────────────────────────────────┘
  PlantTriggerHandler handler = new PlantTriggerHandler();

  /* Before Insert */
  if (Trigger.isInsert && Trigger.isBefore) {
    handler.beforeInsert(Trigger.new);
  }
  /* Before Update */
  else if (Trigger.isUpdate && Trigger.isBefore) {
    handler.beforeUpdate(Trigger.old, Trigger.oldMap, Trigger.new, Trigger.newMap);
  }
}

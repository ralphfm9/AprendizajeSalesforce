public class OpportunityTriggerHandler {
     public static void afterUpdate(List<Opportunity> newOpps, Map<Id, Opportunity> oldMap){
        //guardar esas oportunidades filtradas
        List<Opportunity> oppsToUpdate = new List<Opportunity>();
        //loop que recorre newOpps y filtra solo las que:
        // Ahora tienen StageName == 'Closed Won'
        //Antes tenían un StageName diferente
         for(Opportunity opp : newOpps){
             Opportunity oldOpp = oldMap.get(opp.Id);
             if (opp.StageName == 'Closed Won' && oldOpp.StageName != 'Closed Won'){
                 oppsToUpdate.add(opp);
             }
         }

         //para guardar las tareas antes de insertarlas
         List<Task> tasksToInsert = new List<Task>();
         // loop que recorre oppsToUpdate y crea una Tarea por cada oportunidad 
            for(Opportunity opp : oppsToUpdate){
                Task t = new Task(
                    WhatId = opp.Id,
                    Subject = 'Seguimiento post-venta',
                    ownerId = opp.OwnerId,
                    ActivityDate = Date.today().addDays(7),
                    Status = 'Not Started'
                );
                tasksToInsert.add(t);
            }
            if (!tasksToInsert.isEmpty()) {
            insert tasksToInsert;
}
            
    }
}
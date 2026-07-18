// Trigger que dispara la lógica de conteo de contactos por cuenta
trigger ContactoTrigger on Contact (after insert, after update, after delete, after undelete) {
    if(Trigger.isAfter){
        if(Trigger.isInsert) ContactoTriggerHandler.afterInsert(Trigger.new);
        if(Trigger.isDelete) ContactoTriggerHandler.afterDelete(Trigger.old);
        if(Trigger.isUpdate) ContactoTriggerHandler.afterUpdate(Trigger.new, Trigger.old);

    }

     

}
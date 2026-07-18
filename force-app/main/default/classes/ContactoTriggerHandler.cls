// TODO: mejorar lógica de conteo para incluir contactos inactivos
public class ContactoTriggerHandler {
    //METODO
    public static void afterInsert(List<Contact> newContacts){
        //Paso 1 - recolectar los Ids de las cuentas relacionadas
        Set<Id> accountIds = new Set<Id>();
        for (Contact c: newContacts){
            if (c.AccountId != null){
                accountIds.add(c.AccountId);
            }
        }

        //Paso 2 - contar contactos por cuenta
        Map<Id, Integer> conteo = new Map<Id, Integer>();
        for (Id accId : accountIds){
            conteo.put(accId, 0);
        }

        for (AggregateResult ar : [
            SELECT AccountId, COUNT(Id) total
            FROM Contact
            WHERE AccountId IN :accountIds
            GROUP BY AccountId
        ]){
            conteo.put((Id)ar.get('AccountId'), (Integer)ar.get('total'));
        }

        //Paso 3 - actualizar las cuentas
        List<Account> cuentasToUpdate = new List<Account>();
        for (Id accId : conteo.keySet()){
            cuentasToUpdate.add(new Account(
                Id = accId,
                Total_Contacts__c = conteo.get(accId)
            ));
        }
        update cuentasToUpdate;
            
        }

    //METODO
    public static void afterDelete(List<Contact> oldContacts){
            Set<Id> accountIds = new Set<Id>();
            for (Contact c : oldContacts){
                if (c.AccountId != null){
                    accountIds.add(c.AccountId);
                }
            }

            Map<Id, Integer> conteo = new Map<Id, Integer>();
            for (Id accid : accountIds) {
                conteo.put(accId, 0);
            }

            for(AggregateResult ar : [
                SELECT AccountId, COUNT(Id) total
                FROM Contact
                WHERE AccountId IN :accountIds
                GROUP BY AccountId
            ]){
                conteo.put((Id)ar.get('AccountId'), (Integer)ar.get('total'));
            }

            List<Account> cuentasToUpdate = new List<Account>();
            for (Id accId : conteo.keySet()){
                cuentasToUpdate.add(new Account(
                    Id = accId,
                    Total_Contacts__c = conteo.get(accId)
                ));
        }
        update cuentasToUpdate;
    }
    //METODO
    public static void afterUpdate(List<Contact> newContacts, List<Contact> oldContacts){
        Set<Id> accountIds = new Set<Id>();
        for (Contact c : newContacts ) {
            if (c.AccountId != null){
                accountIds.add(c.AccountId);
            }
        }

        for (Contact c : oldContacts ) {
            if (c.AccountId != null){
                accountIds.add(c.AccountId);
            }
        }

        Map<Id, Integer> conteo = new Map<Id, Integer>();
        for (Id accId : accountIds) {
            conteo.put(accId, 0);
        }
        for(AggregateResult ar : [
                SELECT AccountId, COUNT(Id) total
                FROM Contact
                WHERE AccountId IN :accountIds
                GROUP BY AccountId
            ]){
                conteo.put((Id)ar.get('AccountId'), (Integer)ar.get('total'));
            }

            List<Account> cuentasToUpdate = new List<Account>();
            for (Id accId : conteo.keySet()){
                cuentasToUpdate.add(new Account(
                    Id = accId,
                    Total_Contacts__c = conteo.get(accId)
            ));
        }
        update cuentasToUpdate;
    }
}
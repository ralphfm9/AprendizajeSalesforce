// TODO: mejorar lógica de conteo para incluir contactos inactivos
public class ContactoTriggerHandler {

    public static void afterInsert(List<Contact> newContacts) {
        Set<Id> accountIds = recolectarAccountIds(newContacts, null);
        recalcularConteo(accountIds);
    }

    public static void afterDelete(List<Contact> oldContacts) {
        Set<Id> accountIds = recolectarAccountIds(oldContacts, null);
        recalcularConteo(accountIds);
    }

    public static void afterUpdate(List<Contact> newContacts, List<Contact> oldContacts) {
        Set<Id> accountIds = recolectarAccountIds(newContacts, oldContacts);
        recalcularConteo(accountIds);
    }

    // Recolecta los AccountId de una o dos listas de contactos (para cubrir update: antes y después)
    private static Set<Id> recolectarAccountIds(List<Contact> contactos1, List<Contact> contactos2) {
        Set<Id> accountIds = new Set<Id>();

        for (Contact c : contactos1) {
            if (c.AccountId != null) {
                accountIds.add(c.AccountId);
            }
        }

        if (contactos2 != null) {
            for (Contact c : contactos2) {
                if (c.AccountId != null) {
                    accountIds.add(c.AccountId);
                }
            }
        }

        return accountIds;
    }

    // Recalcula y actualiza el conteo de contactos para un set de cuentas
    private static void recalcularConteo(Set<Id> accountIds) {
        if (accountIds.isEmpty()) {
            return;
        }

        Map<Id, Integer> conteo = new Map<Id, Integer>();
        for (Id accId : accountIds) {
            conteo.put(accId, 0);
        }

        for (AggregateResult ar : [
            SELECT AccountId, COUNT(Id) total
            FROM Contact
            WHERE AccountId IN :accountIds
            GROUP BY AccountId
        ]) {
            conteo.put((Id) ar.get('AccountId'), (Integer) ar.get('total'));
        }

        List<Account> cuentasToUpdate = new List<Account>();
        for (Id accId : conteo.keySet()) {
            cuentasToUpdate.add(new Account(
                Id = accId,
                Total_Contacts__c = conteo.get(accId)
            ));
        }
        update cuentasToUpdate;
    }
}

/*// TODO: mejorar lógica de conteo para incluir contactos inactivos
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
}*/
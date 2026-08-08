global class RecalcularConteoContactosBatch implements Database.Batchable<sObject> {

    // START: trae TODAS las cuentas de la org, sin importar cuántas sean
    global Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator('SELECT Id FROM Account');
    }

    // EXECUTE: corre una vez por cada lote de cuentas (por defecto, 200 a la vez)
    global void execute(Database.BatchableContext bc, List<Account> scope) {

        // Paso 1: junto los Ids de las cuentas de este lote en un Set
        Set<Id> accountIds = new Set<Id>();
        for (Account acc : scope) {
            accountIds.add(acc.Id);
        }

        // Paso 2: mismo patrón que ya conoces - cuento contactos por cuenta
        Map<Id, Integer> conteo = new Map<Id, Integer>();
        for (Id accId : accountIds) {
            conteo.put(accId, 0); // inicializo en 0 por si la cuenta no tiene contactos
        }

        for (AggregateResult ar : [
            SELECT AccountId, COUNT(Id) total
            FROM Contact
            WHERE AccountId IN :accountIds
            GROUP BY AccountId
        ]) {
            conteo.put((Id) ar.get('AccountId'), (Integer) ar.get('total'));
        }

        // Paso 3: armo la lista de cuentas a actualizar con su conteo correcto
        List<Account> cuentasToUpdate = new List<Account>();
        for (Id accId : conteo.keySet()) {
            cuentasToUpdate.add(new Account(
                Id = accId,
                Total_Contacts__c = conteo.get(accId)
            ));
        }

        update cuentasToUpdate;
    }

    // FINISH: corre una sola vez, cuando ya se procesaron TODAS las cuentas
    global void finish(Database.BatchableContext bc) {
        System.debug('Recalculo de conteo de contactos terminado para toda la org');
    }
}
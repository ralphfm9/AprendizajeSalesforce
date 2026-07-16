public with sharing class CuentaController {

    @AuraEnabled(cacheable=true)
    public static List<Account> getCuentas() {
        return [SELECT Id, Name, Phone, Industry FROM Account LIMIT 10];
    }
}
public with sharing class ListaCuentasController {
    public List<Account> cuentas { get; set; }

    public ListaCuentasController() {
        cuentas = [SELECT Id, Name, Total_Contacts__c FROM Account LIMIT 10];
    }
}
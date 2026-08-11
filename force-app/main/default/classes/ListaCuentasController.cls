public with sharing class ListaCuentasController {
    public List<Account> cuentas { get; set; }
    public String nombreBusqueda { get; set; }

    public ListaCuentasController() {
        cuentas = [SELECT Id, Name, Total_Contacts__c FROM Account LIMIT 10];
    }

    public void buscar() {
        if (String.isBlank(nombreBusqueda)) {
            cuentas = [SELECT Id, Name, Total_Contacts__c FROM Account LIMIT 10];
        } else {
            cuentas = [
                SELECT Id, Name, Total_Contacts__c
                FROM Account
                WHERE Name LIKE :('%' + nombreBusqueda + '%')
                LIMIT 10
            ];
        }
    }
}
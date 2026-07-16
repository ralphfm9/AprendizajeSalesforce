@isTest
private class ContactoTriggerHandlerTest {

    @TestSetup
    static void makeData() {
        // aquí va la cuenta nueva
        Account acc = new Account(Name = 'Cuenta de prueba');
        insert acc;
    }

    @isTest
    static void testInsertContacto( ){ 
        // aquí va la prueba
        //ARRANGE 
        Account cuenta = [SELECT Id FROM account WHERE name = 'Cuenta de prueba' LIMIT 1];
        //ACT
        insert new Contact(FirstName = 'Juan', LastName = 'Perez', AccountId = cuenta.Id);

        //ASSERT
        Account cuenta2  = [SELECT Id, Total_Contacts__c FROM account WHERE Id = :cuenta.Id LIMIT 1];
        System.assertEquals(1, cuenta2.Total_Contacts__c, 'El campo debe ser 1');

    } 

    @isTest
    static void testDeleteContacto( ){
        //ARRANGE
        Account cuenta = [SELECT Id FROM account WHERE name = 'Cuenta de prueba' LIMIT 1];
        Contact contacto = new Contact(FirstName = 'Juan', LastName = 'Perez', AccountId = cuenta.Id);
        insert contacto;
        //ACT
        delete contacto;
        //ASSERT
        Account cuenta2  = [SELECT Id, Total_Contacts__c FROM account WHERE Id = :cuenta.Id LIMIT 1];
        System.assertEquals(0, cuenta2.Total_Contacts__c, 'El campo debe ser 0');
    }

    @isTest
    static void testUpdateContacto( ){
        //ARRANGE
        Account cuenta = [SELECT Id FROM account WHERE name = 'Cuenta de prueba' LIMIT 1];
        Account cuenta2 = new Account(Name = 'Cuenta de prueba 2');
        insert cuenta2;
        Contact contacto = new Contact(FirstName = 'Juan', LastName = 'Perez', AccountId = cuenta.Id);
        insert contacto; 
        //ACT
        contacto.AccountId = cuenta2.Id;
        update contacto;
        //ASSERT  
        Account cuenta3  = [SELECT Id, Total_Contacts__c FROM account WHERE Id = :cuenta.Id LIMIT 1];
        Account cuenta4  = [SELECT Id, Total_Contacts__c FROM account WHERE Id = :cuenta2.Id LIMIT 1];
        System.assertEquals(0, cuenta3.Total_Contacts__c, 'El campo debe ser 0');
        System.assertEquals(1, cuenta4.Total_Contacts__c, 'El campo debe ser 1');
        
}      

}
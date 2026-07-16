 @isTest

private class OpportunityTriggerHandlerTest {
   @TestSetup
   static void makeData(){
    opportunity opp = new Opportunity(Name = 'Oportunidad de prueba', StageName = 'Prospecting', CloseDate = Date.today());
    insert opp;
   }

    @isTest 

    static void testCerrarOportunidad (){
        //ARRANGE
        Opportunity opp = [SELECT Id, StageName FROM Opportunity WHERE Name = 'Oportunidad de prueba' LIMIT 1];
        //ACT
        opp.StageName = 'Closed Won';
        update opp;
        //ASSERT
        Opportunity opp2 = [SELECT Id, StageName FROM Opportunity WHERE Id = :opp.Id LIMIT 1];
        System.assertEquals('Closed Won', opp2.StageName, 'El campo debe ser Closed Won');

        Task t = [SELECT Id, Subject, ActivityDate FROM Task LIMIT 1];
        system.assertEquals('Seguimiento post-venta', t.Subject, 'El campo debe ser Seguimiento post-venta');
        system.assertEquals(Date.today().addDays(7), t.ActivityDate, 'El campo debe ser la fecha de hoy + 7 días');
        



    
    }

    
}
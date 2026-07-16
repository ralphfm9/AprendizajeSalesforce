    @isTest
    //clase que prueba todo usando el Mock
    private class IntegracionServiceTest {
    
    @isTest
    static void testObtenerTodo() {
        // Configurar el mock
        // Primero registras el Mock
        Test.setMock(HttpCalloutMock.class, new MockHttpService());
        //intenta llamar a la API
        //Salesforce intercepta → llama a MockHttpService.respond()
        // Luego llamas al método
        String titulo = IntegracionService.obtenerTodo();
        //Assert verifica el resultado
        System.assertEquals('delectus aut autem', titulo, 'El título debe coincidir');
        
        }

    @isTest
    static void testCrearTarea () {
        // Configurar el mock
        Test.setMock(HttpCalloutMock.class, new MockHttpService());
        // Llamar al método que realiza el POST (si existiera)
        // Por ejemplo: String resultado = IntegracionService.crearTarea('Nueva tarea');
        // Aquí podrías verificar que el resultado sea el esperado
        Integer Id = IntegracionService.crearTarea();
        System.assertEquals(201, Id, 'El ID de la tarea creada debe ser 201');
        }

    @isTest
    static void testActualizarTarea () {
        // Configurar el mock
        Test.setMock(HttpCalloutMock.class, new MockHttpService());
        // Llamar al método que realiza el PUT (si existiera)
        Boolean resultado = IntegracionService.actualizarTarea();
        System.assertEquals(true, resultado, 'La tarea debe actualizarse correctamente');   
        }

    @isTest
    static void testEliminarTarea () {
        // Configurar el mock
        Test.setMock(HttpCalloutMock.class, new MockHttpService());
        // Llamar al método que realiza el DELETE (si existiera)
        Integer Id = IntegracionService.eliminarTarea();
        System.assertEquals(200, Id, 'El statusCode debe ser 200');   
        }   


        
    }

        
    
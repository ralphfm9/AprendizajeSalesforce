public with sharing class HolaMundo {

    public static void variables() {

        // Texto
        String nombre = 'Rafael';

        // Número entero
        Integer edad = 30;

        // Número con decimales
        Decimal salario = 15000.50;

        // Verdadero o falso
        Boolean activo = true;

        // Imprime todo
        System.debug('Nombre: ' + nombre);
        System.debug('Edad: ' + edad);
        System.debug('Salario: ' + salario);
        System.debug('Activo: ' + activo);
    }

    public static void datosContacto() {

        String apellido = 'Franco';
        System.debug('Apellido: ' + apellido);
        Integer codigoPostal = 67160;
        System.debug('Código postal: ' + codigoPostal);
        Boolean Linkedin = true;
        System.debug('Linkedin: ' + Linkedin);
        Decimal anosExperiencia = 5.5;
        System.debug('Años de experiencia: ' + anosExperiencia);
    }

    public static void verificarExperiencia() {

        Integer anios  = 3;

        if (anios < 2) {
            System.debug('Perfil Trainee');
        } else if (anios >= 2 && anios <= 4) {
            System.debug('Perfil Junior');
        } else if (anios >= 5) {
            System.debug('Perfil Semi-Senior');
        }
    }

    public static void listaContactos() {

        List<String> contactos = new List<String>();
        contactos.add('Rafael');
        contactos.add('dago');
        contactos.add('tavito');
        contactos.add('flaca');

        System.debug('Total de contactos: ' + contactos.size());
        for (String contacto : contactos) {
            System.debug('Contacto: ' + contacto);
        }
        contactos.remove(0); // elimina el primero
        System.debug('Después de eliminar: ' + contactos.size());
    }

    public static void filtrarcontactos() {

        List<String> contactos = new List<String>{'Rafael', 'dago', 'tavito', 'flaca', 'loco'};
        List<String> contactosFiltrados = new List<String>();

        for (String contacto : contactos) {
            if (contacto.length() > 4) {
                contactosFiltrados.add(contacto);
            }
        }

        System.debug('Contactos filtrados: ' + contactosFiltrados);
    }

    public static void directorioContactos() {

        Map<String, String> directorio = new Map<String, String>();
        directorio.put('Rafael', 'rafael@example.com');
        directorio.put('dago', 'dago@example.com');
        directorio.put('tavito', 'tavito@example.com');
        
        String email = directorio.get('Rafael');
        System.debug(email);
        
        // Ver si existe una clave
        System.debug(directorio.containsKey('flaca'));

        for (String nombre : directorio.keySet()) {
            System.debug(nombre + ' → ' + directorio.get(nombre));
        }
    }

    public static void consultarCuentas(){
        List<Account> cuentas = [
            SELECT Id, Name, Industry
            FROM Account
            WHERE Industry = 'Technology'
            ORDER BY Name
            LIMIT 5
            ];
        for (Account cuenta : cuentas) {
            System.debug(cuenta.Name);
        }
    }

    public static void buscarContactos (){
        List<Contact> contactos = [
            SELECT FirstName, LastName, Email
            FROM Contact
            WHERE LastName != null
            LIMIT 5
        ];
        for (Contact contacto : contactos){
            System.debug(contacto.FirstName + ' ' + contacto.LastName);
        }
    }

    public static void crearCuenta(){
        Account cuenta = new Account(Name = 'Mi Empresa', Phone = '8127688505');
        insert cuenta;
        System.debug('Id generado: ' + cuenta.Id);
    }

    public static void actualizarCuenta(){
        Account cuenta = [
            SELECT Id, Name, Phone FROM Account WHERE Name = 'Mi Empresa' LIMIT 1];
            cuenta.phone = '8124567893';
            update cuenta;
            System.debug(cuenta.phone);
       
    }

    public static void crearContactos (){
        Account cuenta = [SELECT Id FROM Account WHERE Name = 'Mi Empresa' LIMIT 1];

        List<Contact> contactos = new List<Contact>();
        contactos.add(new Contact(FirstName = 'Juan',   LastName = 'Perez', AccountId = cuenta.Id));
        contactos.add(new Contact(FirstName = 'Maria',  LastName = 'Lopez', AccountId = cuenta.Id));
        contactos.add(new Contact(FirstName = 'Carlos', LastName = 'Garcia', AccountId = cuenta.Id));
    
        insert contactos;
        System.debug('Contactos creados: ' + contactos.size());

    }

   
}
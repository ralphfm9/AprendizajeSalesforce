//clase que hace las llamadas reales
public class IntegracionService {

    public static string obtenerTodo() {
        // 1. Configurar la petición 
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://jsonplaceholder.typicode.com/todos/1');
        req.setMethod('GET');

        // 2. Enviar la petición
        Http http = new Http();
        //recibir la respuesta
        HttpResponse res = http.send(req);

        // 3. Procesar verificar si fue exitosa
        if (res.getStatusCode() == 200) {
        Map<String, Object> datos = 
            (Map<String, Object>) JSON.deserializeUntyped(res.getBody());
            
        return (String) datos.get('title');
    }
    return null;
    }

    public static void guardarTareas() {
        // 1. Configurar la petición 
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://jsonplaceholder.typicode.com/todos');
        req.setMethod('GET');

         // 2. Enviar la petición
        Http http = new Http();
        //recibir la respuesta
        HttpResponse res = http.send(req);

         // 3. Procesar verificar si fue exitosa
        if (res.getStatusCode() == 200) {
            System.debug(res.getBody());
             // parsear el JSON
            List<Object> tareas = (List<Object>) JSON.deserializeUntyped(res.getBody());
            
                list<Tarea_Externa__c> listaTareas = new list<Tarea_Externa__c>();
                Integer contador = 0;
                for (Object tarea : tareas) {
                    if (contador == 5) break;
                    //que hace aqui?
                    Map<String, Object> datos = (Map<String, Object>) tarea;
                    Tarea_Externa__c tareaExterna = new Tarea_Externa__c();
                    tareaExterna.Titulo__c = (String) datos.get('title');
                    tareaExterna.Completado__c = (Boolean) datos.get('completed');
                    tareaExterna.Id_Externo__c = (Integer) datos.get('id');
                    listaTareas.add(tareaExterna);
                    contador++;
                }
                insert listaTareas;
                
                  
        } else {
            System.debug('Error: ' + res.getStatusCode());
            
        }

    }

    public static Integer crearTarea(){
        // 1. Configurar la petición 
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://jsonplaceholder.typicode.com/todos');
        req.setMethod('POST');
        req.setHeader('Content-Type', 'application/json');
        // Cuerpo de ejemplo
        Map<String, Object> cuerpo = new Map<String, Object>(); 
        cuerpo.put('userId', 1);
        cuerpo.put('title', 'Mi tarea desde Salesforce');
        cuerpo.put('completed', false);
        req.setBody(JSON.serialize(cuerpo));
        // 2. Enviar la petición
        Http http = new Http();
        //recibir la respuesta
        HttpResponse res = http.send(req);
        if (res.getStatusCode() == 201) {
            Map<String, Object> datos = 
            (Map<String, Object>) JSON.deserializeUntyped(res.getBody());
        return (Integer) datos.get('id');
        } else {
            System.debug('Error al crear la tarea: ' + res.getStatusCode());
            return null;
        }
    }       

    public static Boolean actualizarTarea (){
        // 1. Configurar la petición 
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://jsonplaceholder.typicode.com/todos/1');
        req.setMethod('PUT');
        req.setHeader('Content-Type', 'application/json');
        // Cuerpo de ejemplo
        Map<String, Object> cuerpo = new Map<String, Object>(); 
        cuerpo.put('userId', 1);
        cuerpo.put('title', 'Tarea actualizada desde Salesforce');
        cuerpo.put('completed', true);
        req.setBody(JSON.serialize(cuerpo));
        // 2. Enviar la petición
        Http http = new Http();
        //recibir la respuesta
        HttpResponse res = http.send(req);
        if (res.getStatusCode() == 200) {
            System.debug('Tarea actualizada: ' + res.getBody());
            return true;
        } else {
            System.debug('Error al actualizar la tarea: ' + res.getStatusCode());
            return false;
        }
    }

    public static Integer eliminarTarea (){
        // 1. Configurar la petición 
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://jsonplaceholder.typicode.com/todos/1');
        req.setMethod('DELETE');
        // 2. Enviar la petición
        Http http = new Http();
        //recibir la respuesta
        HttpResponse res = http.send(req);
        if (res.getStatusCode() == 200) {
            return res.getStatusCode();
        }
        return null;

        }
    }

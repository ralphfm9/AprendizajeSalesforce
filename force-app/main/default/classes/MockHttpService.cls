@isTest
//clase que finge ser la API
public class MockHttpService implements HttpCalloutMock {
    //Salesforce intercepta → llama a MockHttpService.respond()
    public HttpResponse respond(HttpRequest req) {
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        if (req.getMethod() == 'GET') {
        res.setStatusCode(200);
        res.setBody('{"userId": 1, "id": 1, "title": "delectus aut autem", "completed": false}');
        } else if (req.getMethod() == 'POST') {
        res.setStatusCode(201);
        res.setBody('{"userId": 1, "id": 201, "title": "Mi tarea desde Salesforce", "completed": false}');
        }
        else if (req.getMethod() == 'PUT') {
        res.setStatusCode(200);
        res.setBody('{"userId": 1, "id": 1, "title": "Tarea actualizada desde Salesforce", "completed": true}');
        }
        else if (req.getMethod() == 'DELETE') {
        res.setStatusCode(200);
        res.setBody('{"userId": 1, "id": 1, "title": "Tarea eliminada desde Salesforce", "completed": true}');
        }   
    
    return res;
    }

    
}
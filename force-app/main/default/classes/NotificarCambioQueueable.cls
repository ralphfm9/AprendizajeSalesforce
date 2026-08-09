public class NotificarCambioQueueable implements Queueable {

    private List<Id> accountIds;

    public NotificarCambioQueueable(List<Id> accountIds) {
        this.accountIds = accountIds;
    }

    public void execute(QueueableContext context) {
        for (Id accId : accountIds) {
            System.debug('Procesando cuenta: ' + accId);
        }
    }
}
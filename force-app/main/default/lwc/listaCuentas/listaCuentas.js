import { LightningElement, wire, track } from 'lwc';
import getCuentas from '@salesforce/apex/CuentaController.getCuentas';

export default class ListaCuentas extends LightningElement {
    @track cuentasFiltradas = [];
    cuentasOriginales = [];

    @wire(getCuentas)
    wiredCuentas({ data, error }) {
        if (data) {
            this.cuentasOriginales = data;
            this.cuentasFiltradas = data;
        }
    }

    handleSearch(event) {
        const busqueda = event.target.value.toLowerCase();
        this.cuentasFiltradas = this.cuentasOriginales.filter(cuenta =>
            cuenta.Name.toLowerCase().includes(busqueda)
        );
    }
}
import { LightningElement, api, wire } from "lwc";
import { getRecord } from 'lightning/uiRecordApi';
import getOrders from "@salesforce/apex/ExampleController.getOrders";

export default class ExampleOrderHistory extends LightningElement {
  @api recordId;
  loading = true;
  orders;
  hasError;
  errorMessage;

  @wire(getRecord, { recordId: '$recordId', fields: ['Account.AccountNumber']})
  account;

  async connectedCallback() {
    try {
      await Promise.resolve();
      const result = await getOrders({ customerId: this.account.data.fields.AccountNumber.value });
      console.log(result);
      this.orders = result.orders;
    } catch (e) {
      console.error(e);
      this.hasError = true;
      this.errorMessage = e.body?.message;
    } finally {
      this.loading = false;
    }
  }

  get hasOrders() {
    return this.orders && this.orders.length > 0;
  }
}

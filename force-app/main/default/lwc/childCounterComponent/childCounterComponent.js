import { LightningElement, api} from 'lwc';

export default class ChildCounterComponent extends LightningElement {
    @api
    counter = 0;

   
}
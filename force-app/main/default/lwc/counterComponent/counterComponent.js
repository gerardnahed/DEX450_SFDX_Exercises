import { LightningElement } from 'lwc';

export default class CounterComponent extends LightningElement {
    handleIncrementClick(){
        let childComp = this.template.querySelector('c-child-counter-component');

        if(childComp){
           childComp.counter = childComp.counter + 1;
        }
    }
}
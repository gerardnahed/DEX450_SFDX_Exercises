import { LightningElement, track } from 'lwc';

export default class StatusComponent extends LightningElement {
   @track child1Status = 'Deselected';
   @track child2Status = 'Deselected';

    handleChildStatusChange(event){
       const nameOfChild = event.detail.childName;
       const statusOfChild = event.detail.childStatus;

       if(nameOfChild === 'Child Component A'){
        this.child1Status = statusOfChild;
       }else if(nameOfChild ==='Child Component B'){
        this.child2Status = statusOfChild;
       }
    }
}
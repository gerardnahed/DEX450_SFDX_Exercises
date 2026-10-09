import { LightningElement , track , api} from 'lwc';

export default class StatusChildComponent extends LightningElement {
    @api name = '';
    
  @track  status = 'Deselected';

      get buttonVariant() {
        return this.status === 'Selected' ? 'brand' : 'neutral';
    }

    handleToggle(){
        this.status = this.status === 'Selected'? 'Deselected' : 'Selected';

        const toggleEvent = new CustomEvent('statuschange',{
            detail: {
                childName: this.name,
                childStatus: this.status
            }
        });
        this.dispatchEvent(toggleEvent);
    }
}
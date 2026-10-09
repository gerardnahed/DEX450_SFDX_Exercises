import { LightningElement, wire } from 'lwc';
import getAccounts from '@salesforce/apex/AccountControl.getAccounts';
import{ NavigationMixin } from 'lightning/navigation';
import createAccount from '@salesforce/apex/AccountControl.createAccount';


export default class CreateAccount extends LightningElement {
    accountName;
    maxRecords=10;
    accounts;
    errors;
    
    @wire(getAccounts, {maxRecords:"$maxRecords"}) accounts;
    wired_getAccounts({errors, data}){
        if(data){
            this.accounts=data; this.errors = undefined;
        }else if(errors){
            this.errors=errors; this.accounts=undefined;
        }
    }
     handleNameChange(event){
        this.accountName= event.target.value;
    }
  
    handleClick(){
        
        createAccount({accountName:this.accountName})
        .then(result=>{
            console.log('Account Created: ', JSON.stringify(result)); 
            this.accountName='';
        }).catch(error=>{
            console.error('Error creating account: ', error);
        });
    }
    //let user choose how many records to display
    handleRecordsChange(event){
        this.maxRecords= event.target.value;
    }
   

}
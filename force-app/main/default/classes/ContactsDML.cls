public with sharing class ContactsDML {
    public static void ContactsDML() {
Contact name1= new Contact(LastName='Minkowitz');
Contact name2= new Contact(LastName='Singh');
List<Contact> contacts = new List<Contact>();
contacts.add(name1);
contacts.add(name2);
insert contacts;
System.debug('Name1 Id:'+name1.Id);
System.debug('Name2 Id:'+name2.Id);


}
public static void databaseMethodDML(){
    Contact name1=new Contact();
    Contact name2=new Contact(LastName='Picasso');
    List<Contact> contacts = new List<Contact>();
    contacts.add(name1);
    contacts.add(name2);
    Database.insert(contacts);

    
} 
public static void databaseMethodPartialCommit(){
    Contact name1= new Contact();
    Contact name2 = new Contact(LastName='Picasso');
    List<Contact> contacts = new List<Contact>();
    contacts.add(name1);
    contacts.add(name2);
    Database.insert(contacts,false);
    System.debug('Name2 id: '+name2.Id);
}
public static void exceptionsDML(){
    List<Contact> contacts = new List<Contact>();
     Contact noName = new Contact();
        contacts.add(noName);

        Contact newContact = new Contact(LastName = 'Benett');
        contacts.add(newContact);

        Contact longName = new Contact(LastName = '00085chars00085chars00085chars00085chars00085chars00085chars00085chars00085chars00085');
        contacts.add(longName);
         List<Contact> newListContact = new List<Contact>(contacts);
    List<Database.SaveResult> lsr = Database.insert(newListContact, false);
    for(Database.SaveResult sr : lsr){
        if (!sr.isSuccess()){
            for(Database.Error err : sr.getErrors()){
              Error_Log__c error_DML = new Error_Log__c();
            error_DML.Source__c = 'exceptionsDML';
            error_DML.Message__c = err.getStatusCode()+ ': ' + err.getMessage();
            insert error_DML;
                
            }
        }
    }
     newListContact[1] = null;
        try {
            List<Database.SaveResult> lsr2 = Database.insert(newListContact, false);
        } catch(ListException e) {
            Error_Log__c error_null = new Error_Log__c();
            error_null.Source__c = 'exceptionsDML';
            error_null.Message__c = e.getMessage();
            insert error_null;
        }
    

}
}
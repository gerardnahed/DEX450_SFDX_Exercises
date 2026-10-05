//TODO #1  Declare a variable whose type is Course__c named newCourse  
//         and initialize it to a newly constructed Course__c sObject,
//         assigning the field Name the value '[104] Introduction to Programming',
//         the field Course_Description__c the value 'Learn the basics of programming with OOP',
//         the field Status__c the value 'Active',
//         the field Duration__c the value 5.

//TODO #2  Use the insert statement to insert newCourse into the database.

Course__c newCourse = new Course__c(Name='[104] Introduction to Programming'
,Description__c='Learn the basics of programming with OOP',
Status__c='Active',Duration__c=5);

insert newCourse;

 // 2. Create a list to hold the related deliveries for bulk insertion
        List<Course_Delivery__c> deliveriesToInsert = new List<Course_Delivery__c>();
        
        // 3. Loop X times to generate the related delivery records
            Course_Delivery__c delivery = new Course_Delivery__c(
                // Assuming Name or a custom field distinguishes the delivery
                Name = courseName + ' - Delivery ' + i, 
                // Link the delivery to the newly created course via the Lookup/Master-Detail field
                Course__c = newCourse.Id 
            );
            deliveriesToInsert.add(delivery);
        }
        
        // 4. Insert all delivery records at once (Bulk DML)
        if (!deliveriesToInsert.isEmpty()) {
            insert deliveriesToInsert;
        }
    


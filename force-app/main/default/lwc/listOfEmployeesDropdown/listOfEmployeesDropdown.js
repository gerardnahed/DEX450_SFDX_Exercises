import { LightningElement , track} from 'lwc';

export default class ListOfEmployeesDropdown extends LightningElement {
   @track selectedDepartment = '';
  @track  filteredEmployees = [];
 @track  selectedEmployee = null;

    employees = [
    {
        id: 1,
        name: 'John Smith',
        department: 'IT',
        position: 'Developer'
    },
    {
        id: 2,
        name: 'Sarah Johnson',
        department: 'HR',
        position: 'Recruiter'
    },
    {
        id: 3,
        name: 'Mike Brown',
        department: 'IT',
        position: 'QA Engineer'
    },
    {
        id: 4,
        name: 'Emma Davis',
        department: 'Finance',
        position: 'Accountant'
    },
    {
        id: 5,
        name: 'Chris Wilson',
        department: 'HR',
        position: 'HR Manager'
    }
];
get departmentOptions() {
        return [
            { label: 'Information Technology (IT)', value: 'IT' },
            { label: 'Human Resources (HR)', value: 'HR' },
            { label: 'Finance', value: 'Finance' }
        ];
    }

   // get isButtonDisabled(){
   //     return !this.selectedDepartment;
   // }
    handleDepartmentChange(event){
        this.selectedDepartment = event.detail.value;
          this.selectedEmployee = null;

        // 3. Instantly filter the master list based on the new selection
        this.filteredEmployees = this.employees.filter(
            emp => emp.department === this.selectedDepartment
        );
    }
    
   
    handleSelectedEmployee(event){
        const empId = Number(event.currentTarget.dataset.id);
        this.selectedEmployee = this.employees.find(emp => emp.id === empId);
    }
}
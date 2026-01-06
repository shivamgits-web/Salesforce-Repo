public class PerformanceManager {

    //**Method 1: createPerformanceReview**
        public static void createPerformanceReview(Integer EmyId,Date ReviewDate,String Feedback){
        
        Employee__c empyName=[SELECT Id, Name, Employee_ID__c FROM Employee__c where Employee_ID__c =:EmyId LIMIT 1];
        system.debug('Employee Name'+empyName.Name);
        Performance_Review__c perComp=new Performance_Review__c();
        perComp.Employees__c = empyName.Id;
        system.debug('Performance Employee Data'+ perComp.Employees__c);
        perComp.Review_Date__c = ReviewDate;
        perComp.FeedBack__c = Feedback;
        insert perComp;
        
     } 
    
    //Integer empId=2302;
    //Date da = Date.valueOf('2024-03-16');
    //String stg = 'Average';
    //PerformanceManager.createPerformanceReview(empId,da,stg);
    
    
    //- **Method 2: calculateOverallScore**
    public static String calculateOverallScore(Integer EmploId){
         Performance_Review__c performanceData=
             [SELECT Id, Name, Review_Date__c,Employees__c,
              Rating__c,Score__c,Employees__r.Employee_ID__c FROM Performance_Review__c where Employees__r.Employee_ID__c =:EmploId];
        
        system.debug('Empolyees Records'+performanceData);
        
       
         if(performanceData.Rating__c=='1')
         {
            return '15';     
         }
         else if(performanceData.Rating__c=='2')
         {
            return 'Between 16 to 25'; 
         }
         else if(performanceData.Rating__c=='3')
         {
            return 'Between 26 to 50';         }
         else if(performanceData.Rating__c=='4')
         {
             return 'Between 51 to 75';  
         }
        else{
            return 'Between 76 to 100';
        }
                
    }
    //String PerformanceScore = PerformanceManager.calculateOverallScore(2302);
    //system.debug('Performance Score is '+PerformanceScore);

    
    //**Additional Method: getEmployeeDetails**
    public static List<Employee__c> employeeDetails(Integer EmplId){
        return [SELECT Id, Name, Department__c, Date_of_Hire__c, Employee_ID__c FROM Employee__c where Employee_ID__c =:EmplId LIMIT 1];
    }
    
    //List<Employee__c> employeeData = PerformanceManager.employeeDetails(2302);
    //system.debug('EmployeeData'+employeeData);
    
    // ** Trigger Method calculateOverallScor
    public static void calculateOverallScor(List<Performance_Review__c> performanceReviews) {
        List<Employee__c> employeesToUpdate = new List<Employee__c>();
        for (Performance_Review__c performanceReview : performanceReviews) {
            if(performanceReview.Rating__c=='1'){
                performanceReview.Score__c=15;
                updateEmployeeDepartment(performanceReview, 15 , employeesToUpdate);
            }else if(performanceReview.Rating__c=='2'){
                performanceReview.Score__c=30;
                updateEmployeeDepartment(performanceReview, 30, employeesToUpdate);
            }else if(performanceReview.Rating__c=='3'){
                performanceReview.Score__c=50;
                updateEmployeeDepartment(performanceReview, 50 , employeesToUpdate);
            }else if(performanceReview.Rating__c=='4'){
                performanceReview.Score__c=70;
                updateEmployeeDepartment(performanceReview, 70 , employeesToUpdate);
            }else{
                performanceReview.Score__c=100;
                updateEmployeeDepartment(performanceReview, 100 , employeesToUpdate);
            }
            
            if (!employeesToUpdate.isEmpty()) {  
                update employeesToUpdate; 
            }
        
          }
       }
        
      private static void updateEmployeeDepartment(Performance_Review__c performanceReview, Integer score, List<Employee__c> employeesToUpdate) {
                 if (performanceReview.Employees__c != null) {
                           Employee__c employee = new Employee__c(
                                                  Id = performanceReview.Employees__c,
                                                  Employee_Performance_Score__c = score );
                           employeesToUpdate.add(employee);
     }
        
       
    }// method is end 
    
    
    

    
    
    
   }
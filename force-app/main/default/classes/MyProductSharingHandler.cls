public with sharing class MyProductSharingHandler{
    
    public static void shareMyProjectRecord(Id projectId) {
        
        User userId = [select id from user where Name='Shivam Test' LIMIT 1];
        My_Product__share productShare = new My_Product__share();
        
        productShare.ParentId = projectId;         
        productShare.UserOrGroupId = userId.Id;       
        productShare.AccessLevel = 'Read';       
        productShare.RowCause = Schema.My_Product__share.RowCause.Manual; 
        
        system.debug('My Product Share '+productShare);
        
        try {
            insert productShare;
            System.debug('Record shared successfully!');
        } catch (Exception e) {
            System.debug('Error sharing record: ' + e.getMessage());
        }
        
    }
}
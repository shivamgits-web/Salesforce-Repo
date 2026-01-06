/**
* @File Name : CSVController.cls
* @Description :
* @Author :
* @Last Modified By :
* @Last Modified On : November 30, 2024
* @Modification Log :
*==============================================================================
* Ver | Date | Author | Modification
*==============================================================================
* 1.0 | November 30, 2024 |   | Initial Version
**/

public with sharing class CSVController {

    @AuraEnabled
    public static string loadCSVData(Id contentDocumentId){

        ContentVersion contentVersionObj = [ SELECT Id, VersionData FROM 
                                             ContentVersion WHERE 
                                             ContentDocumentId =:contentDocumentId ];
        
         list<account> acclist=new list<Account>();
         
         String data= contentVersionObj.VersionData.toString();

         string[] csvFileLines=data.split('\n');

         for(Integer i=1;i<csvFileLines.size();i++){
            
            string[] csvRecordData = csvFileLines[i].split(',');
            
            Account accObj = new Account() ;
            accObj.Name = csvRecordData[0] ;             
            accObj.Active__c = csvRecordData[1];
            accObj.RecordTypeId = csvRecordData[2];
			accObj.TickerSymbol = csvRecordData[3];
                                                                                       
            acclist.add(accObj);   
        }

        insert acclist;

        return string.valueOf(acclist.size());
    

    }
}
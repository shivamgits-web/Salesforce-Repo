@isTest
public class GetFileInfoTest {
    @isTest
    static void testGetFileInfo() {
        
        Account acc = new Account(Name = 'Test Account');
        insert acc;

        ContentVersion cv = new ContentVersion(
            Title = 'Test File',
            PathOnClient = 'TestFile.txt',
            VersionData = Blob.valueOf('This is a test file content')
        );
        insert cv;

        cv = [SELECT Id, ContentDocumentId FROM ContentVersion WHERE Id = :cv.Id];

        ContentDocumentLink cdl = new ContentDocumentLink(
            ContentDocumentId = cv.ContentDocumentId,
            LinkedEntityId = acc.Id,
            ShareType = 'V',
            Visibility = 'AllUsers'
        );
        insert cdl;

        List<Id> inputRecordIds = new List<Id>{ acc.Id };
        List<GetFileInfo.FileInfo> result = GetFileInfo.getFileInfo(inputRecordIds);
        
        System.assertEquals(1, result.size(), 'Should return one file info record');
        System.assertEquals(cv.ContentDocumentId, result[0].contentDocumentId);
        System.assertEquals('Test File', result[0].fileName);
        System.assert(result[0].fileSizeKB > 0, 'File size should be greater than 0');
    }
}
public class GetFileInfo {

    public class FileInfo {
        @InvocableVariable(label='File Name')
        public String fileName;

        @InvocableVariable(label='File Size (KB)')
        public Integer fileSizeKB;

        @InvocableVariable(label='Content Document Id')
        public Id contentDocumentId;
    }

    @InvocableMethod(label='Get File Info From Related Record')
    public static List<FileInfo> getFileInfo(List<Id> recordIds) {
        List<FileInfo> results = new List<FileInfo>();

        List<ContentDocumentLink> links = [
            SELECT ContentDocumentId
            FROM ContentDocumentLink
            WHERE LinkedEntityId IN :recordIds
        ];

        if (!links.isEmpty()) {
            Set<Id> contentDocIds = new Set<Id>();
            for (ContentDocumentLink link : links) {
                contentDocIds.add(link.ContentDocumentId);
            }

            List<ContentVersion> contentVersions = [
                SELECT ContentDocumentId, ContentSize, Title, CreatedDate
                FROM ContentVersion
                WHERE IsLatest = true AND ContentDocumentId IN :contentDocIds
                ORDER BY CreatedDate DESC
                LIMIT 1
            ];

            for (ContentVersion cv : contentVersions) {
                FileInfo info = new FileInfo();
                info.contentDocumentId = cv.ContentDocumentId;
                info.fileName = cv.Title;
                info.fileSizeKB = cv.ContentSize;
                results.add(info);
            }
        }
        system.debug('Results -->>'+results);
        return results;
    }
}
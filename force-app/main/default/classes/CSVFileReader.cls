public class CSVFileReader {
    // Method to read the CSV data from Static Resource
    public static List<Map<String, String>> parseCSV(String staticResourceName) {
        List<Map<String, String>> parsedData = new List<Map<String, String>>();
        
        // Fetch the static resource
        StaticResource staticResource = [SELECT Body FROM StaticResource WHERE Name = :staticResourceName LIMIT 1];
        
        // Convert the Blob content to a string (if it's a plain CSV)
        String csvContent = staticResource.Body.toString();
        
        // Split the CSV content by lines
        List<String> lines = csvContent.split('\n');
        
        // Extract headers (first line)
        List<String> headers = lines[0].split(',');
        
        // Process each line (excluding header)
        for (Integer i = 1; i < lines.size(); i++) {
            String line = lines[i].trim();
            if (line != '') {
                List<String> values = line.split(',');
                Map<String, String> rowData = new Map<String, String>();
                
                for (Integer j = 0; j < headers.size(); j++) {
                    rowData.put(headers[j].trim(), values[j].trim());
                }
                
                parsedData.add(rowData);
            }
        }
        
        return parsedData;
    }
}
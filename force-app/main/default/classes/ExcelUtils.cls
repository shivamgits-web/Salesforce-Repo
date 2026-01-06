public class ExcelUtils {
    public static List<Map<String, String>> parse(Blob csvBlob) {
        List<Map<String, String>> result = new List<Map<String, String>>();
        
        // Convert Blob to String
        String csvString = csvBlob.toString();
        System.debug('CSV String: ' + csvString);

        // Split into rows
        List<String> rows = csvString.split('\n');
        if (rows.isEmpty()) {
            System.debug('CSV file is empty.');
            return result;
        }

        // Process headers
        List<String> headers = rows[0].split(',');
        System.debug('Headers: ' + headers);

        // Process each row
        for (Integer i = 1; i < rows.size(); i++) {
            List<String> values = rows[i].split(',');

           

            Map<String, String> rowData = new Map<String, String>();
            for (Integer j = 0; j < headers.size() && j < values.size(); j++) {
                rowData.put(headers[j].trim(), values[j].trim());
            }
            result.add(rowData);
        }
        
        return result;
    }
}
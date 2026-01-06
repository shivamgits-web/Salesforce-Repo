public class CityBankCallout {

    @future(callout=true)
    public static void sendCityBankData(String cityName, Boolean paymentStatus) {
        try {
            Http http = new Http();
            HttpRequest request = new HttpRequest();

            // Use Named Credential — DO NOT manually add Authorization header
            request.setEndpoint('callout:Animal_Callout/services/apexrest/InsertCityBank/');
            request.setMethod('POST');
            request.setHeader('Content-Type', 'application/json');

            // Build the JSON payload
            Map<String, Object> payload = new Map<String, Object>();
            payload.put('city', cityName);
            payload.put('Payment', paymentStatus);

            request.setBody(JSON.serialize(payload));

            // Send the request
            HttpResponse response = http.send(request);

            // Debug response
            System.debug('Status: ' + response.getStatus());
            System.debug('Body: ' + response.getBody());

        } catch (Exception e) {
            System.debug('Callout error: ' + e.getMessage());
        }
    }
}
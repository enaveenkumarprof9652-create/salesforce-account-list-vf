public class SpotifyIntegration {
    @AuraEnabled
    public static String spotifyMethod(String trackName) {
        Http http = new Http();
        Httprequest request = new Httprequest();
        String encoded = EncodingUtil.urlEncode(trackName, 'UTF-8');
        request.setEndpoint('callout:Spotify/v1/search?q='+encoded+'&type=track&limit=1&offset=1');
        request.setMethod('GET');
        httpresponse response = http.send(request);
        System.debug('Response Body: '+response.getBody());
        System.debug('Response Status: '+response.getStatus());
        System.debug('Response Status Code: '+response.getStatusCode());
        //return response.getBody();
        if (response.getStatusCode() == 200) {
            return response.getBody();
        }else{
            throw new AuraHandledException('Spotify Integration Failed: '+ response.getStatus()+' '+response.getStatusCode());
        }
    }
}
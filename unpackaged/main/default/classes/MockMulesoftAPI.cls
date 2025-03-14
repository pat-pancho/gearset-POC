@RestResource(urlMapping='/sfsc-eapi/*')
global class MockMulesoftAPI {

    @HttpGet global static void doGet(){
        System.debug('URI: ' + RestContext.request.requestURI);
        String[] uriArray = RestContext.request.requestURI.split('/');
        if(uriArray != null && uriArray.size() > 0) {
            System.debug(uriArray[3]);
            switch on uriArray[3] {
                when 'delivery' { delivery(RestContext.request.requestURI); }
                when 'products' { products(RestContext.request.requestURI); }
                when else { 
                    RestResponse res = RestContext.response;
                    res.addHeader('Content-Type', 'application/text');
                    res.responseBody = Blob.valueOf('Invalid API method. Please check URL.');
                    res.statusCode = 400;
                }
            }
        }
    }
    
    @HttpPost global static void doPost() {
        System.debug('URI: ' + RestContext.request.requestURI);
        String[] uriArray = RestContext.request.requestURI.split('/');
        if(uriArray != null && uriArray.size() > 0) {
            System.debug(uriArray[3]);
            switch on uriArray[3] {
                when 'orders' { orders(RestContext.request.requestURI); }
                when 'delivery' { delivery(RestContext.request.requestURI); }
                when 'carts' { carts(RestContext.request.requestURI); }
                when 'products' { products(RestContext.request.requestURI); }
                when else { 
                    RestResponse res = RestContext.response;
                    res.addHeader('Content-Type', 'application/text');
                    res.responseBody = Blob.valueOf('Invalid API method. Please check URL.');
                    res.statusCode = 400;
                }
            }
        }
    }
    
    private static void orders(String reqURI) {
        String[] uriArray = RestContext.request.requestURI.split('/');
        String sfID = uriArray[4];
        if(reqURI.contains('generateReturnLabel')) {
            RestResponse res = RestContext.response;
            res.addHeader('Content-Type', 'application/text');
            res.responseBody = Blob.valueOf('Working Integration');
            res.statusCode = 200;
        }
    }
    
    private static void delivery(String reqURI) {
        List<String> lstArray = new List<String> {'Delivered','In Transit','Billing Information Received','Billing Information Voided','Pickup','Exception','Returned to Shipper','Delivered Origin CFS (Freight Only)','Delivered Destination CFS (Freight Only)','Warehousing (Freight Only)','Not Available','Out for Delivery'}; 
        Double randomNumber = Math.random(); 
		Integer arrayLength = lstArray.size(); 
		Integer randomIndex = (randomNumber *(arrayLength-1)).intValue(); 
        RestResponse res = RestContext.response;
        res.addHeader('Content-Type', 'application/json');
        
        Map<String, Object> resp = new Map<String, Object>();
        resp.put('status', lstArray[randomIndex]);
        resp.put('status', 'In Transit');
        resp.put('datetime', System.now().format('yyyy-MM-dd\'T\'hh:mm:ss'));
        res.responseBody = Blob.valueOf(JSON.serialize(resp));
        res.statusCode = 200;
    }
    
    
    //CARTS
    private static void carts(String reqURI) {
        RestResponse res = RestContext.response;
        res.addHeader('Content-Type', 'application/json');
		String[] uriArray = RestContext.request.requestURI.split('/');
        System.debug(uriArray);
        
        if(uriArray.size() == 4) { //create cart
            Integer IntrandomNumber = Integer.valueof((Math.random() * 10));
            Map<String, Object> resp = new Map<String, Object>();
            resp.put('CSS_GUID__c', 'c90b34f4-0722-4bdc-b728-a7e5c28b0b09');
            res.responseBody = Blob.valueOf(JSON.serialize(resp));
            res.statusCode = 201;
        } else if(uriArray.size() == 5) { //update cart
            
        }
    }
    //CARTS
    
    //PRODUCTS
    private static void products(String reqURI) {
        RestResponse res = RestContext.response;
        res.addHeader('Content-Type', 'application/json');
        
        RestRequest req = RestContext.request;
        System.debug(req.params);
        
        String sku = req.params.get('sku');
        
        if(sku == '206698-01') {
            res.responseBody = Blob.valueOf('[{"CurrencyIsoCode":"USD","CSS_ProductName__c":"DC40 Origin Excl US Ir/BSv/SRFu","CSS_MachineFriendlyName__c":"Dyson DC40 Origin Exclusive vacuum","CSS_SKUNumber__c":"206698-01","enableNotifyMe":false,"stock":{"stockLevelStatus":"inStock"},"stockBand":"A","isWebProduct":true,"UnitPrice":{"formattedNetPrice":"$399.99","netPrice":399.99},"documentType":"FINISHED_GOODS","finishedGoods":true}]');
            res.statusCode = 200;
        } else {
            res.responseBody = Blob.valueOf('[{"CurrencyIsoCode":"USD","CSS_ProductName__c":"DC40 Origin Excl US Ir/BSv/SRFu","CSS_MachineFriendlyName__c":"Dyson DC40 Origin Exclusive vacuum","CSS_SKUNumber__c":"206698-02","enableNotifyMe":false,"stock":{"stockLevelStatus":"inStock"},"stockBand":"A","isWebProduct":true,"UnitPrice":{"formattedNetPrice":"$399.99","netPrice":399.99},"documentType":"SPARE","finishedGoods":false}]');
            res.statusCode = 200;
        }
    }
}
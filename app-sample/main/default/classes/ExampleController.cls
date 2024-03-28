public with sharing class ExampleController {
  @AuraEnabled
  public static OrderResponse getOrders(String customerId) {
    HttpRequest req = new HttpRequest();
    req.setMethod('GET');
    req.setEndpoint('callout:StubAPI/customer/' + customerId + '/orders');
    HttpResponse res = (new Http()).send(req);
    OrderResponse result = (OrderResponse)JSON.deserialize(res.getBody(), OrderResponse.class);
    if (res.getStatusCode() != 200) {
      throw new HttpResponseException(result.error);
    }
    return result;
  }

  public class HttpResponseException extends Exception {
  }

  public class OrderResponse {
    @AuraEnabled
    public List<Order> orders;

    @AuraEnabled
    public String error;
  }

  public class Order {
    @AuraEnabled
    public String orderId { get; set; }

    @AuraEnabled
    public String status { get; set; }

    @AuraEnabled
    public Date purchasedDate { get; set; }

    @AuraEnabled
    public List<Product> products { get; set; }
  }

  public class Product {
    @AuraEnabled
    public String name { get; set; }

    @AuraEnabled
    public Integer price { get; set; }

    @AuraEnabled
    public Integer amount { get; set; }
  }
}

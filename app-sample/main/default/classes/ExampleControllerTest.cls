@IsTest
public with sharing class ExampleControllerTest {
  @isTest
  public static void testGetOrdersSuccess() {
    Test.setMock(HttpCalloutMock.class, new GetOrdersSuccessMock());
    ExampleController.OrderResponse result = ExampleController.getOrders('aaaa');
    Assert.areEqual(null, result.error);
    Assert.areEqual(1, result.orders.size());
    Assert.areEqual(1, result.orders.size());
    Assert.areEqual('1116-2897', result.orders[0].orderId);
    Assert.areEqual(Date.newInstance(2024,3,15), result.orders[0].purchasedDate);
    Assert.areEqual('Completed', result.orders[0].status);
    Assert.areEqual(2, result.orders[0].products.size());
    Assert.areEqual('Test Product 03', result.orders[0].products[0].name);
    Assert.areEqual(2800, result.orders[0].products[0].price);
    Assert.areEqual(3, result.orders[0].products[0].amount);
  }

  @isTest
  public static void testGetOrdersFailure() {
    Test.setMock(HttpCalloutMock.class, new GetOrdersFailureMock());
    Exception ex;
    try {
      ExampleController.getOrders('bbbb');
    } catch (Exception e) {
      ex = e;
    }
    Assert.areEqual('ExampleController.HttpResponseException', ex.getTypeName());
  }

  public class GetOrdersSuccessMock implements HttpCalloutMock {
    public HttpResponse respond(HttpRequest req) {
      HttpResponse res = new HttpResponse();
      res.setStatusCode(200);
      res.setBody('{"error":null,"orders":[{"orderId":"1116-2897","purchasedDate":"2024-03-15","status":"Completed","products":[{"name":"Test Product 03","price":2800,"amount":3},{"name":"Test Product 04","price":4000,"amount":4}]}]}');
      return res;
    }
  }

  public class GetOrdersFailureMock implements HttpCalloutMock {
    public HttpResponse respond(HttpRequest req) {
      HttpResponse res = new HttpResponse();
      res.setStatusCode(500);
      res.setBody('{"error":"Unexpected error occurred.","orders":[]}');
      return res;
    }
  }
}

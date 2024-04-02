/**
 * @description Test class for MockWebService class
 * Notice that this class has dependencies to 'MockWebServiceTest' static resource and custom metadata record
 * because they can't be created dynamically in test class
 */
@IsTest(seeAllData=true)
public with sharing class MockWebServiceTest {
  /**
   * @description Tests HTTP GET
   */
  @IsTest
  public static void testGet() {
    RestRequest request = new RestRequest();
    request.httpMethod = 'GET';
    request.requestURI = '/mock/apex-test';
    RestContext.request = request;

    RestResponse response = new RestResponse();
    RestContext.response = response;

    MockWebService.doGet();

    Map<String, String> responseBody = (Map<String, String>) JSON.deserialize(
      response.responseBody.toString(),
      Map<String, String>.class
    );
    Assert.areEqual('Hello World!', responseBody.get('message'));
    Assert.areEqual(200, response.statusCode);
  }

  /**
   * @description Tests HTTP POST
   */
  @IsTest
  public static void testPost() {
    RestRequest request = new RestRequest();
    request.httpMethod = 'POST';
    request.requestURI = '/mock/apex-test';
    RestContext.request = request;

    RestResponse response = new RestResponse();
    RestContext.response = response;

    MockWebService.doPost();

    Map<String, String> responseBody = (Map<String, String>) JSON.deserialize(
      response.responseBody.toString(),
      Map<String, String>.class
    );
    Assert.areEqual('Hello World!', responseBody.get('message'));
    Assert.areEqual(200, response.statusCode);
  }

  /**
   * @description Tests HTTP PUT
   */
  @IsTest
  public static void testPut() {
    RestRequest request = new RestRequest();
    request.httpMethod = 'PUT';
    request.requestURI = '/mock/apex-test';
    RestContext.request = request;

    RestResponse response = new RestResponse();
    RestContext.response = response;

    MockWebService.doPut();

    Map<String, String> responseBody = (Map<String, String>) JSON.deserialize(
      response.responseBody.toString(),
      Map<String, String>.class
    );
    Assert.areEqual('Hello World!', responseBody.get('message'));
    Assert.areEqual(200, response.statusCode);
  }

  /**
   * @description Tests HTTP DELETE
   */
  @IsTest
  public static void testDelete() {
    RestRequest request = new RestRequest();
    request.httpMethod = 'DELETE';
    request.requestURI = '/mock/apex-test';
    RestContext.request = request;

    RestResponse response = new RestResponse();
    RestContext.response = response;

    MockWebService.doDelete();

    Map<String, String> responseBody = (Map<String, String>) JSON.deserialize(
      response.responseBody.toString(),
      Map<String, String>.class
    );
    Assert.areEqual('Hello World!', responseBody.get('message'));
    Assert.areEqual(200, response.statusCode);
  }
}

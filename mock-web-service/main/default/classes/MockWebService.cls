/**
 * @description This class provides methods for API mock.
 */
@RestResource(urlMapping='/mock/*')
global with sharing class MockWebService {
  /**
   * @description Handles HTTP GET request
   */
  @HttpGet
  global static void doGet() {
    setResponse();
  }

  /**
   * @description Handles HTTP POST request
   */
  @HttpPost
  global static void doPost() {
    setResponse();
  }

  /**
   * @description Handles HTTP PUT request
   */
  @HttpPut
  global static void doPut() {
    setResponse();
  }

  /**
   * @description Handles HTTP DELETE request
   */
  @HttpDelete
  global static void doDelete() {
    setResponse();
  }

  /**
   * @description Set fake JSON response based on the setting custom metadata and csv files
   */
  private static void setResponse() {
    MockWebServiceSetting__mdt mockSetting = [
      SELECT StaticResourceName__c, FilePath__c, StatusCode__c
      FROM MockWebServiceSetting__mdt
      WHERE RequestURI__c = :RestContext.request.requestURI
    ];
    StaticResource sr = [SELECT Body FROM StaticResource WHERE Name = :mockSetting.StaticResourceName__c];
    Compression.ZipReader reader = new Compression.ZipReader(sr.body);
    RestContext.response.addHeader('Content-Type', 'application/json');
    RestContext.response.responseBody = reader.extract(mockSetting.FilePath__c);
    RestContext.response.statusCode = Integer.valueOf(mockSetting.StatusCode__c);
  }
}

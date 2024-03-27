/**
 * @description This class provides methods for stub API.
 */
@RestResource(urlMapping='/stub/*')
global with sharing class StubWebService {
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
    StubWebServiceSetting__mdt stubSetting = [
      SELECT StaticResourceName__c, FilePath__c, StatusCode__c
      FROM StubWebServiceSetting__mdt
      WHERE RequestURI__c = :RestContext.request.requestURI
    ];
    StaticResource sr = [SELECT Body FROM StaticResource WHERE Name = :stubSetting.StaticResourceName__c];
    Compression.ZipReader reader = new Compression.ZipReader(sr.body);
    Compression.ZipEntry jsonFile = reader.getEntry(stubSetting.FilePath__c);
    Blob jsonBlob = reader.extract(jsonFile);
    RestContext.response.addHeader('Content-Type', 'application/json');
    RestContext.response.responseBody = jsonBlob;
    RestContext.response.statusCode = Integer.valueOf(stubSetting.StatusCode__c);
  }
}

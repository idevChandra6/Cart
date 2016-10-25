//
//  BaseService.swift
//  OneMarket
//
//  Created by Jain, Vijay on 6/8/15.
//  Copyright (c) 2015 VISA. All rights reserved.
//

import UIKit

public protocol BaseParsingErrorType: Error
{
    func errorDescription() -> String
}

open class BaseService: NSObject {
   
    var serviceAgent:ServiceAgent?
    var authorizationValue:String?
    public var accessToken : String?
    
    public init(serviceAgent:ServiceAgent = ServiceAgent())
    {
        if (ConfiguredEnv.isMockServiceEnabled == false)
        {
            self.serviceAgent = ServiceAgent()
        }
        else
        {
            self.serviceAgent = MockServiceAgent()
        }
        self.accessToken = ""
        super.init()
    }
    
    open func sendRequest(_ requestUrl:String?, accessToken:String?, errorHandler:@escaping (_ error:Error?) -> (), completionHandler:@escaping ()->())
    {
        serviceAgent?.authorizationValue = self.authorizationValue
        if let urlRequest = serviceAgent?.createRequest(requestUrl, accessToken:accessToken, postData: self.createPostData(), putData: self.createPutData())
        {
            serviceAgent?.sendRequest(urlRequest: urlRequest, errorHandler: errorHandler, parseResponse: {
                (responseDictionary) -> Bool in
                var returnValue = false
                if let dictionary = responseDictionary
                {
                    //// Log.print("dictionary:\(dictionary)")
                    returnValue = true
                    do
                    {
                        try self.parseResponseDictionary(dictionary)
                        completionHandler()
                    }
                    catch let errorType
                    {
                        let anError = self.createParseError(errorType)
                        errorHandler(anError)
                        completionHandler()
                    }
                }
                else
                {
                    completionHandler()
                }
                return returnValue
            })
        }
    }
    
    open func createPostData() -> Data?
    {
        return nil
    }

    open func createPutData() -> Data?
    {
        return nil
    }

    open func createParseError(_ errorType:Error) -> Error?
    {
        var string = NSLocalizedString("Parsing failed. Please try again.", comment:"")
        if let errorType = errorType as? BaseParsingErrorType
        {
            string = NSLocalizedString("\(NSLocalizedString("Parsing Failed", comment: "")): \(errorType.errorDescription()).", comment:"")
        }
        let userInfo = [NSLocalizedDescriptionKey: string]
        return NSError(domain: NSLocalizedString("Parsing error", comment: ""), code: -1000, userInfo: userInfo)
    }
    
    open func parseResponseDictionary(_ dictionary:NSDictionary) throws
    {

    }
    

}

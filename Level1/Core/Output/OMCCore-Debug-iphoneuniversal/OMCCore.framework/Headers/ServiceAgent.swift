//
//  ServiceAgent.swift
//  OneMarket
//
//  Created by Jain, Vijay on 6/3/15.
//  Copyright (c) 2015 VISA. All rights reserved.
//

import UIKit

open class ServiceAgent: NSObject, URLSessionDelegate
{
    let timeoutInterval:TimeInterval = 30.0
    var authorizationValue:String?
    
    func createRequest(_ requestURL: String?, accessToken: String?, postData: Data? = nil, putData: Data?=nil) -> URLRequest?
    {
        var request: URLRequest? = nil
        if let encodedURL = requestURL?.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        {
            let url = encodedURL.replacingOccurrences(of: "+", with: "%2B")
            //request = NSMutableURLRequest(URL: NSURL(string: url)!, cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringCacheData, timeoutInterval: timeoutInterval)
            
            request = URLRequest(url: URL(string: url)!, cachePolicy: NSURLRequest.CachePolicy.reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: timeoutInterval)
            
            request?.setValue("application/json", forHTTPHeaderField:"Content-Type")
            
            if (self.authorizationValue != nil)
            {
                request?.setValue(authorizationValue, forHTTPHeaderField: "authorization")
            }
            else if let accessToken = accessToken
            {
                if !accessToken.isEmpty
                {
                    request?.setValue(accessToken, forHTTPHeaderField: "x-access-token")
                    request?.setValue(ConfiguredEnv.sharedInstance.apiToken, forHTTPHeaderField: "x-api-key")
                }
            }
            
            if (postData != nil)
            {
                request?.httpBody = postData
                request?.httpMethod = "POST"
            }
            else if (putData != nil)
            {
                request?.httpBody = putData
                request?.httpMethod = "PUT"
            }
            else
            {
                request?.httpMethod = "GET"
            }
        }
        return request
    }
    
    func convertToJSONDictionary(_ data:Data)-> NSDictionary?
    {
        var dictionary:NSDictionary? = nil
        do
        {
            dictionary = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary
            return dictionary
        }
        catch
        {
            // Log.dlog("Could not convert to JSON structure")
            return nil
        }
        
    }
    
    func sendRequest (urlRequest aUrlRequest: URLRequest?, errorHandler:@escaping (_ error:Error?) ->(), parseResponse: @escaping (_ responseDictionay: NSDictionary?) -> Bool)
    {
        if let urlRequest = aUrlRequest
        {
            NSLog("Sending request to URL:\(urlRequest.url!.absoluteString)")
            let sessionConfiguration = URLSessionConfiguration.default
            sessionConfiguration.timeoutIntervalForRequest = 30.0;
            sessionConfiguration.timeoutIntervalForResource = 60.0;
            let session = Foundation.URLSession(configuration: sessionConfiguration, delegate: self, delegateQueue: nil)
            
            session.dataTask(with: urlRequest, completionHandler:
            { (data, response, error) -> Void in

                if let error = error
                {
                    errorHandler(error)
                    return
                }
                if let urlResponse = response as? HTTPURLResponse
                {
                    if let anError = error
                    {
                        errorHandler(anError)
                        return
                    }
                    
                    if  urlResponse.statusCode == 200 || urlResponse.statusCode == 201
                    {
                        NSLog("Successful Response with status code \(urlResponse.statusCode) for url: \(urlResponse.url!)")
                        if let responseData = data, responseData.count > 0
                        {
                            if((urlRequest.url?.lastPathComponent.contains(".html")) == true)
                            {
//                                let cachedURLResponse = NSCachedURLResponse(response: urlResponse, data: (responseData as NSData), userInfo: nil, storagePolicy: .Allowed)
//                                NSURLCache.sharedURLCache().storeCachedResponse(cachedURLResponse, forRequest: urlRequest)
                            }
                            do
                            {
                                if let jsonDictionary = try JSONSerialization.jsonObject(with: responseData, options: JSONSerialization.ReadingOptions()) as? [NSObject: AnyObject]
                                {
                                    let status = parseResponse(jsonDictionary as NSDictionary?)
                                    if status == false
                                    {
                                        // Log.dlog("Could not parse the response for url: \(urlResponse.URL!)")
                                        let string = NSLocalizedString("Could not parse the response successfully", comment:"")
                                        let userInfo = [NSLocalizedDescriptionKey: string]
                                        let anError = NSError(domain: "Parse Error", code: -100, userInfo: userInfo)
                                        errorHandler(anError)
                                        return
                                    }
                                }
                            }
                            catch
                            {
                                errorHandler(error)
                                return
                            }
                        }
                    }
                    else if urlResponse.statusCode == 202
                    {
                        NSLog("Successful Response with status code \(urlResponse.statusCode) for url: \(urlResponse.url!)")
                        let _ = parseResponse(nil)
                        // No valid response data is expcted to parse, server just eats up the request
                    }
                    else
                    {
                        NSLog("Response with status code \(urlResponse.statusCode) for url: \(urlResponse.url)")
                        var message:String?
                        switch (urlResponse.statusCode)
                        {
                        case 404:
                            message = NSLocalizedString("Not found", comment:"")
                        default:
                            message = NSLocalizedString("There was a connection problem", comment:"")
                        }
                        if let msg = message
                        {
                            let userInfo = [NSLocalizedDescriptionKey: msg]
                            let anError = NSError(domain: "Response Error", code:urlResponse.statusCode, userInfo: userInfo)
                            errorHandler(anError)
                        }
                        NSLog("Response failed with error code: \(urlResponse.statusCode)")
                    }
                }
            }).resume()
        }
    }
}

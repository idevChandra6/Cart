//
//  PutLocaleService.swift
//  Authentication
//
//  Created by Hadkar, Soniya on 6/30/16.
//  Copyright © 2016 Visa Inc. All rights reserved.
//

import UIKit
import OMCCore

class PutLocaleService: BaseService
{
    
    var locale:String?
    
    func putLocale(_ errorHandler:@escaping (_ error:Error?) -> (), completionHandler:@escaping  ()->())
    {
        if let user = AuthManager.sharedInstance.authenticatedUser
        {
            if let userId = user.uid
            {
                let requestURL = "\(ConfiguredEnv.sharedInstance.baseVerApiUrl)users/\(userId)"
                
                if(user.packageType?.lowercased() == "consumer")
                {
                    if let culture = App.culture
                    {
                        if let localeString = culture["locale"]
                        {
                            locale = localeString as? String
                        }
                    }
                }
                else
                {
                    locale = "en-US"
                }
                let accessToken = AuthManager.sharedInstance.authenticatedUser?.accessToken
                self.sendRequest(requestURL, accessToken:accessToken, errorHandler: errorHandler, completionHandler: completionHandler)
            }
        }
    }
    
    override func createPutData() -> Data?
    {
        var jsonPostData: Data? = nil
        let data = NSMutableDictionary()
        if let locale = self.locale
        {
            data.setObject(locale, forKey: "locale" as NSCopying)
            
        }
        NSLog("data:\(data)")
        do
        {
            jsonPostData = try JSONSerialization.data(withJSONObject: data, options: JSONSerialization.WritingOptions())
        }
        catch
        {
            
        }
        
        return jsonPostData
    }
    
    override func parseResponseDictionary(_ dictionary: NSDictionary) throws
    {
        
    }
}

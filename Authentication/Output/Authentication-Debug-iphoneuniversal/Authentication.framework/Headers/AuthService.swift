//
//  AuthService.swift
//  OneMarket
//
//  Created by Jain, Vijay on 6/23/15.
//  Copyright (c) 2015 VISA. All rights reserved.
//

import UIKit
import Core


class AuthService: BaseService
{
    var userId:String?
    var password:String?
    
    var user:User?
    var verifyFlag = false
    var signoutFlag = false
    
    func authenticateUser(_ userId:String, password:String, errorHandler:@escaping (_ error:Error?) -> (), completionHandler:@escaping ()->())
    {
        self.verifyFlag = true
        self.userId = userId
        self.password = password
        
        let requestUrl = ConfiguredEnv.sharedInstance.baseApiUrl + "authenticate"
        self.sendRequest(requestUrl, accessToken:nil, errorHandler:errorHandler, completionHandler:completionHandler)
        
    }
    
    func singOutUser(_ userId:String, errorHandler:@escaping (_ error:Error?) -> (), completionHandler:@escaping ()->())
    {
        self.signoutFlag = true
        self.userId = userId
        let requestUrl = "\(ConfiguredEnv.sharedInstance.baseApiUrl)accounts/signout"
        let accessToken = AuthManager.sharedInstance.authenticatedUser?.accessToken
        self.sendRequest(requestUrl, accessToken:accessToken, errorHandler:errorHandler, completionHandler:completionHandler)
    }
    
    override func createPostData() -> Data?
    {
        var jsonPostData: Data? = nil
        let dictionary = NSMutableDictionary()
        
        if let userId = self.userId
        {
            dictionary.setObject(userId, forKey: "username" as NSCopying)
            if let password = self.password
            {
                dictionary.setObject(password, forKey: "password" as NSCopying)
            }
            do
            {
                jsonPostData = try JSONSerialization.data(withJSONObject: dictionary, options: JSONSerialization.WritingOptions())
            }
            catch {
                // Log.dlog("Could not create JSON for the Post data")
            }
        }
        
        return jsonPostData
    }
    
    
    override func parseResponseDictionary(_ dictionary:NSDictionary) throws
    {
        if let success = dictionary["success"] as? Bool , success == true
        {
            if let token = dictionary["token"] as? String , token.characters.count > 0
            {
                if let userObject = dictionary["user"] as? NSDictionary
                {
                    if let uid = userObject["id"] as? String , uid.characters.count > 0
                    {
                        self.user = User(userId:uid, accessToken:token)
                    }
                    if let firstName = userObject["first_name"] as? String , firstName.characters.count > 0
                    {
                        self.user?.firstName = firstName
                    }
                    if let lastName = userObject["last_name"] as? String , lastName.characters.count > 0
                    {
                        self.user?.lastName = lastName
                    }
                    self.user?.Save()
                }
            }
            
            
   
//            if let uid = dictionary["id"] as? String , uid.characters.count > 0
//            {
//                if let token = dictionary["token"] as? String , token.characters.count > 0
//                {
//                    self.user = User(userId:uid, accessToken:token)
//                }
//                if let firstName = dictionary["first_name"] as? String , firstName.characters.count > 0
//                {
//                    self.user?.firstName = firstName
//                }
//                
//                self.user?.Save()
//            }
        }
    }
}

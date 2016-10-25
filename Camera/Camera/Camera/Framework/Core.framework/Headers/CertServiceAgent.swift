//
//  CertServiceAgent.swift
//  Core
//
//  Created by Jain, Vijay on 9/27/16.
//  Copyright © 2016 Visa Inc. All rights reserved.
//

import UIKit

class CertServiceAgent: ServiceAgent
{
    public func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Swift.Void)
    {
        if let serverTrust = challenge.protectionSpace.serverTrust {
            if let certificate = SecTrustGetCertificateAtIndex(serverTrust, 0) {
                
                // Set SSL policies for domain name check
                let policies = NSMutableArray();
                policies.add(SecPolicyCreateSSL(true, (challenge.protectionSpace.host as CFString?)))
                SecTrustSetPolicies(serverTrust, policies);
                
                // Evaluate server certificate
                var result: SecTrustResultType = SecTrustResultType.unspecified
                SecTrustEvaluate(serverTrust, &result)
                let isServerTrusted:Bool = (result == SecTrustResultType.unspecified || result == SecTrustResultType.proceed)
                
                // Get local and remote cert data
                let remoteCertificateData:Data = SecCertificateCopyData(certificate) as Data
                
                var pathToCert = Bundle.main.path(forResource: "StagingCertificate", ofType: "cer")
                if (ConfiguredEnv.environment == "Production")
                {
                    pathToCert = Bundle.main.path(forResource: "ProductionCertificate", ofType: "cer")
                }
                
                let localCertificate:Data = try! Data(contentsOf: URL(fileURLWithPath: pathToCert!))
                
                if (isServerTrusted && (remoteCertificateData == localCertificate))
                {
                    let credential:URLCredential = URLCredential(trust: serverTrust)
                    completionHandler(.useCredential, credential)
                }
                else
                {
                    NSLog("Server Certificate Authentication failed, cancelling request")
                    completionHandler(.cancelAuthenticationChallenge, nil)
                }
            }
        }
    }

}

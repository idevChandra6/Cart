//
//  AuthUIProtocolExtension.swift
//  Authentication
//
//  Created by Hadkar, Soniya on 10/05/16.
//  Copyright © 2016 Visa Inc. All rights reserved.
//

import UIKit

public extension CameraProtocol where Self:UIViewController
{
    func displayCameraView(delegate:CameraAdaptor)
    {
        let frameworkBundle = Bundle(identifier: "com.visa.onemarket.Camera")
        let cameraStoryboard = UIStoryboard(name: "Camera", bundle: frameworkBundle)
        if let cameraNavigationController = cameraStoryboard.instantiateViewController(withIdentifier: "CameraNavigationController") as? UINavigationController
        {
            if let cameraViewController = cameraNavigationController.viewControllers[0] as? CameraCaptureViewController
            {
                cameraViewController.cameraAdapterDelegate = delegate
                self.present(cameraNavigationController, animated: true, completion: nil)
            }
        }
    }
    
    func clickImage()
    {
        print("clickImage in CameraProtocolExtension")
    }
    
}

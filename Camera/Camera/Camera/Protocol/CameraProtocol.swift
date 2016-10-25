//
//  CameraProtocol.swift
//  Camera
//
//  Created by Hadkar, Soniya on 10/5/16.
//  Copyright © 2016 VisaOMC. All rights reserved.
//

import UIKit

public protocol CameraProtocol: class
{
    func displayCameraView(delegate:CameraAdaptor)
    func willClickImage()
    func clickImage()
    func didClickedImage()
}

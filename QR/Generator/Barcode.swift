//
//  Barcode.swift
//  FidelityFundManagement
//
//  Created by Ziaurehman Amini on 8/22/16.
//  Copyright © 2016 Visa Inc. All rights reserved.
//

import Foundation
import UIKit
import CoreImage

public func createQRFromString(_ str: String, size: CGSize) -> UIImage? {
    let data = str.data(using: String.Encoding.isoLatin1, allowLossyConversion: false)
    
    let filter = CIFilter(name: "CIQRCodeGenerator")
    filter!.setValue(data, forKey: "inputMessage")
    
    let qrImage:CIImage = filter!.outputImage!
    
    let scaleX = size.width / qrImage.extent.size.width
    let scaleY = size.height / qrImage.extent.size.height
    
    let resultQrImage = qrImage.applying(CGAffineTransform(scaleX: scaleX, y: scaleY))
    return UIImage(ciImage: resultQrImage)
}

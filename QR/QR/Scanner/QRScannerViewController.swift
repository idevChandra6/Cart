//
//  QRScannerViewController.swift
//  QR
//
//  Created by Ziaurehman Amini on 10/5/16.
//  Copyright © 2016 Visa. All rights reserved.
//

import UIKit

public protocol QRScannerViewControllerDelegate: class {
    func didScanBarcodeWith(resultString: String)
    func didEncounterError(error: NSError)
}


open class QRScannerViewController: UIViewController {

    var previewView = UIView()
    
    open weak var delegate: QRScannerViewControllerDelegate?
    
    var scanner: MTBBarcodeScanner?
    
    override open func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        view.addSubview(previewView)
        
        self.view.translatesAutoresizingMaskIntoConstraints = false
        self.previewView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[subview]-0-|", options: NSLayoutFormatOptions.directionLeadingToTrailing, metrics:nil, views:["subview":previewView]))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[subview]-0-|", options: NSLayoutFormatOptions.directionLeadingToTrailing, metrics:nil, views:["subview":previewView]))
    }

    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        scanner = MTBBarcodeScanner(previewView: previewView)

        var error : NSError? = nil
        
        self.scanner?.startScanning(resultBlock: {results -> Void in
            if let readable = results?.first as? AVMetadataMachineReadableCodeObject {
                if let resultString = readable.stringValue {
                    self.delegate?.didScanBarcodeWith(resultString: resultString)
                }
            } else if let error = error {
                self.delegate?.didEncounterError(error: error)
            }
        }, error: &error)
    }
 
    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

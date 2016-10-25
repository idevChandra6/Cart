//
//  CameraCaptureViewController.swift
//  Concierge
//
//  Created by Hadkar, Soniya on 5/2/16.
//  Copyright © 2016 Visa Inc. All rights reserved.
//

import UIKit
import AVFoundation
import Photos
import Core

fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}


public class CameraCaptureViewController: BaseViewController
{
    
    var cameraAdapterDelegate: CameraAdaptor?
    
    var captureSession = AVCaptureSession()
    let stillImageOutput = AVCaptureStillImageOutput()
    var position:AVCaptureDevicePosition?
    var newCamera:AVCaptureDevice?
    var newInput:AVCaptureDeviceInput?
    var previewLayer:AVCaptureVideoPreviewLayer?
    var photoCaptureTime:Date?
    var sessionStart:Date?
    var sessionEnd:Date?
    var flashBool: Bool = false
    
    @IBOutlet weak var yellowView:UIView!
    @IBOutlet weak var libraryButton:UIButton!
    @IBOutlet weak var libraryButtonView:UIView!
    @IBOutlet weak var shareButton:UIButton!
    @IBOutlet weak var cameraButton:UIButton!
    @IBOutlet weak var flashButton:UIButton!
    @IBOutlet weak var cameraSwitchButton:UIButton!
    @IBOutlet weak var imageViewer: UIView!
    
    @IBOutlet weak var uploadingLabel: UILabel!
    @IBOutlet weak var autoUploadCountLabel: UILabel!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    @IBOutlet weak var photoStackView:UIView!
    @IBOutlet weak var capturedPhotoImageView:UIImageView!
    @IBOutlet weak var imageCountButton:UIButton!
    @IBOutlet weak var stackBorderImageView:UIImageView!
    
    var capturedImage:UIImage?
    var photosToUploadCount:Int = 0
    
    override public var analyticsScreenName:String
        {
        get
        {
            return "Camera Capture"
        }
    }
    
    override public func viewDidLoad()
    {
        super.viewDidLoad()
        //print("self.timeline?.photoFetchResult?.count:\(self.timeline?.photoFetchResult?.count)")
        self.autoUploadCountLabel.isHidden = true
        self.activityIndicatorView.isHidden = true
        self.uploadingLabel.isHidden = true
    }
    
    override  public func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if let videoPreviewLayer = self.previewLayer {
            let videoOrientation = self.interfaceOrientationToVideoOrientation(UIApplication.shared.statusBarOrientation)
            if videoPreviewLayer.connection.isVideoOrientationSupported
                && videoPreviewLayer.connection.videoOrientation != videoOrientation {
                videoPreviewLayer.connection.videoOrientation = videoOrientation
            }
            videoPreviewLayer.frame = self.imageViewer.bounds
        }
    }
    
    func updateCount()
    {
//        if let _ = self.sessionStart
//        {
//            let badgeNumber = self.timeline.photosToUpload.count
//            if badgeNumber == 0
//            {
//                self.photoStackView.isHidden = true
//                self.imageCountButton.isHidden = true
//            }
//            else
//            {
//                self.imageCountButton.isHidden = false
//                self.imageCountButton.setBadge(badgeNumber)
//                self.photoStackView.isHidden = false
//            }
//        }
    }
    
    func orientationChanged(_ notification:Notification)
    {
        self.handleOrientation(UIApplication.shared.statusBarOrientation)
    }
    
    func handleOrientation(_ orientation:UIInterfaceOrientation)
    {
        if (orientation == UIInterfaceOrientation.landscapeLeft || orientation == UIInterfaceOrientation.landscapeRight)
        {
            if let navigationCtrller = self.navigationController
            {
                navigationCtrller.setNavigationBarHidden(true, animated: false)
            }
            
        }
        else
        {
            if let navigationCtrller = self.navigationController
            {
                navigationCtrller.setNavigationBarHidden(false, animated: false)
            }
        }
    }
    
    override public func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        self.capturedPhotoImageView.transform = CGAffineTransform.identity
        self.photoStackView.isHidden = true
        self.setupUploadablePhotos()
        self.updateCount()

        NotificationCenter.default.addObserver(self, selector: #selector(CameraCaptureViewController.orientationChanged(_:)), name:NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
        if UIDeviceOrientationIsLandscape(UIDeviceOrientation.landscapeLeft) || UIDeviceOrientationIsLandscape(UIDeviceOrientation.landscapeRight)
        {
            self.handleOrientation(UIApplication.shared.statusBarOrientation)
        }
        self.title = NSLocalizedString("Camera", comment: "")
        DispatchQueue.main.async {
            if (self.sessionStart == nil)
            {
                self.sessionStart = Date()
            }
            self.startCapturing()
        }
    }
    
    override public func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        DispatchQueue.main.async {
            self.captureSession.stopRunning()
            
            self.previewLayer?.removeFromSuperlayer()
            
            if let inputs = self.captureSession.inputs as? [AVCaptureDeviceInput] {
                for input in inputs {
                    self.captureSession.removeInput(input)
                }
            }
            
            if let outputs = self.captureSession.outputs as? [AVCaptureOutput] {
                for output in outputs {
                    self.captureSession.removeOutput(output)
                }
            }
            
            self.previewLayer = nil
            
            for subview in self.imageViewer.subviews
            {
                subview.removeFromSuperview()
            }
        }
    }
    
    
    func startCapturing()
    {
        let devices = AVCaptureDevice.devices().filter{ ($0 as AnyObject).hasMediaType(AVMediaTypeVideo) && ($0 as AnyObject).position == AVCaptureDevicePosition.back }
        if let captureDevice = devices.first as? AVCaptureDevice  {
            do
            {
                self.newCamera = captureDevice
                try self.captureSession.addInput(AVCaptureDeviceInput(device: captureDevice))
                DispatchQueue.main.async(execute: {
                    self.previewLayer = AVCaptureVideoPreviewLayer(session: self.captureSession)
                })
                self.newInput = try AVCaptureDeviceInput(device: captureDevice)
                self.captureSession.sessionPreset = AVCaptureSessionPresetPhoto
                self.captureSession.startRunning()
                stillImageOutput.outputSettings = [AVVideoCodecKey:AVVideoCodecJPEG]
                if self.captureSession.canAddOutput(stillImageOutput) {
                    DispatchQueue.main.async(execute: {
                        self.captureSession.addOutput(self.stillImageOutput)
                    })
                    
                }
                
                DispatchQueue.main.async(execute: {
                    if let previewLayer = self.previewLayer {
                        previewLayer.bounds = self.imageViewer.bounds
                        previewLayer.position = CGPoint(x: self.imageViewer.bounds.midX, y: self.imageViewer.bounds.midY)
                        previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
                        let cameraPreview = UIView(frame: CGRect(x: 0.0, y: 0.0, width: self.imageViewer.bounds.size.width, height: self.imageViewer.bounds.size.height))
                        cameraPreview.layer.addSublayer(previewLayer)
                        self.imageViewer.addSubview(cameraPreview)
                    }
                })
                
            }
            catch
            {
                //print("error")
            }
            
        }
    }
    
    @IBAction func saveToCamera(_ sender: UIButton)
    {
        AnalyticsAgent.sharedInstance.trackButtonTapped(self.analyticsScreenName, buttonName: NSLocalizedString("saveToCamera", comment: ""))
        if let videoConnection = stillImageOutput.connection(withMediaType: AVMediaTypeVideo)
        {
            self.setFlashMode(self.newCamera!)
            
            self.stillImageOutput.connection(withMediaType: AVMediaTypeVideo).videoOrientation = (self.previewLayer?.connection.videoOrientation)!
            stillImageOutput.captureStillImageAsynchronously(from: videoConnection)
            {
                (imageDataSampleBuffer, error) -> Void in
                do
                {
                    try self.newCamera?.lockForConfiguration()
                    if (self.flashBool == true && self.newCamera?.flashMode == AVCaptureFlashMode.on)
                    {
                        self.newCamera?.flashMode = AVCaptureFlashMode.off
                    }
                    self.newCamera?.unlockForConfiguration()
                }
                catch
                {
                    //NSLog("Camera Capture Flash OFF Error")
                }
                
                self.photoCaptureTime = Date()
                let imageData = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(imageDataSampleBuffer)
                if let imagedata = UIImage(data: imageData!)
                { 
                    DispatchQueue.main.async(execute: {
                        UIImageWriteToSavedPhotosAlbum(imagedata, self, #selector(CameraCaptureViewController.image(_:didFinishSavingWithError:contextInfo:)), nil)
                        self.capturedImage = imagedata
                    })
                }
            }
        }
    }
    
    func setFlashMode(_ device: AVCaptureDevice) {
        let flashMode:AVCaptureFlashMode?
        
        if(self.flashBool == true)
        {
            flashMode = AVCaptureFlashMode.on
        }
        else
        {
            flashMode = AVCaptureFlashMode.off
        }
        if device.isFlashAvailable && device.isFlashModeSupported(flashMode!) {
            do{
                try device.lockForConfiguration()
                device.flashMode = flashMode!
                device.unlockForConfiguration()
            }
            catch
            {
                //NSLog("Error turning on flash")
            }
        }
    }
    
    func setupUploadablePhotos()
    {
        if let startTime = self.sessionStart
        {
            if let endTime = self.sessionEnd
            {
//                self.timeline.photoFetchResult = TimelineManager.sharedInstance.getTimelineLibraryPhotos(startTime, endTime: endTime)
//                TimelineManager.sharedInstance.creatUploadablePhotosForTimeline(self.timeline)
            }
        }
    }
    
    func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo:UnsafeRawPointer)
    {
        if error == nil
        {
            self.sessionEnd = Date()
            self.setupUploadablePhotos()
            self.updatePhotoStack()
            
        }
        else
        {
            let ac = UIAlertController(title: "Photo Save Error", message: error?.localizedDescription, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(ac, animated: true, completion: nil)
        }
    }
    
    func uploadPhoto()
    {
//        self.photoLibraryManager.getLastSavedPhotoToUpload()
//        {
//            (uploadPhoto:UploadPhoto?) in
//            self.photosToUploadCount = self.photosToUploadCount + 1
//            DispatchQueue.main.async
//            {
//                self.autoUploadCountLabel.text = String(self.photosToUploadCount)
//            }
//            
//            if let uploadPhoto = uploadPhoto
//            {
//                PhotoUploadManager.sharedInstance.statusChangedForPhoto(uploadPhoto, toStatus:.selected)
//                {
//                    let selectedCount = PhotoUploadManager.sharedInstance.countForStatus(.selected)
//                    if (selectedCount  > 0)
//                    {
//                        DispatchQueue.main.async
//                        {
//                            self.capturedPhotoImageView.isHidden = false
//                            self.uploadingLabel.isHidden = false
//                            self.activityIndicatorView.isHidden = false
//                        }
//                        PhotoUploadManager.sharedInstance.statusChangedForPhoto(uploadPhoto, toStatus:.beginToUpload)
//                        {
//                            PhotoUploadManager.sharedInstance.statusChangedForPhoto(uploadPhoto, toStatus:.upload)
//                            {
//                                DispatchQueue.main.async
//                                {
//                                    let stillToUploadPhotos = PhotoUploadManager.sharedInstance.countForStatus(.upload)
//                                    self.photosToUploadCount = self.photosToUploadCount - 1
//                                    NSLog("photosToUploadCount: \(self.photosToUploadCount)")
//                                    
//                                    if (stillToUploadPhotos == 0)
//                                    {
//                                        self.activityIndicatorView.isHidden = true
//                                        self.uploadingLabel.isHidden = true
//                                        self.autoUploadCountLabel.isHidden = true
//                                        self.capturedPhotoImageView.isHidden = false
//                                        self.capturedPhotoImageView.image = UIImage(named:"SuccessCheck")
//                                        self.photoStackView.isHidden = false
//                                        self.stackBorderImageView.isHidden = true
//                                        let transform = CGAffineTransform.identity
//                                        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.0, options: UIViewAnimationOptions(), animations:
//                                            {
//                                                self.capturedPhotoImageView.transform = transform.scaledBy(x: 2.0, y: 2.0)
//                                            }, completion: {
//                                                [weak self]
//                                                (value: Bool) in
//                                                if (value == true)
//                                                {
//                                                    if let strongSelf = self
//                                                    {
//                                                        strongSelf.capturedPhotoImageView.transform = CGAffineTransform.identity
//                                                        strongSelf.sessionStart = Date()
//                                                    }
//                                                }
//                                            })
//                                        
//                                    }
//                                }
//                            }
//                        }
//                    }
//                }
//            }
//        }
    }
    
    func updatePhotoStack()
    {
        self.stackBorderImageView.isHidden = false
        let clonedImageView = UIImageView(image: self.capturedImage)
        clonedImageView.contentMode = UIViewContentMode.scaleAspectFit
        
        let offset = self.imageViewer.frame.size.height - self.imageViewer.frame.size.height
        
        let point = CGPoint(x: self.imageViewer.frame.origin.x, y: self.imageViewer.frame.origin.y + offset)
        
        let sourcePoint = self.imageViewer.convert(point, to: self.view.window)
        clonedImageView.frame = CGRect(x: sourcePoint.x, y: sourcePoint.y, width: self.imageViewer.frame.size.width/3, height: self.imageViewer.frame.size.height/3)
        self.imageViewer.addSubview(clonedImageView)
        
        let destPoint = self.capturedPhotoImageView.convert(self.capturedPhotoImageView.frame.origin, to: self.view.window)
        UIView.animate(withDuration: 1.0, delay: 0.3, options: UIViewAnimationOptions(),
                                   animations:
            {
                () -> Void in
                clonedImageView.frame = CGRect(x: destPoint.x, y: destPoint.y , width: 0, height: 0)
            })
        {
            (finished) -> Void in
            if finished
            {
                clonedImageView.removeFromSuperview()
                self.photoStackView.isHidden = false
                self.capturedPhotoImageView.image = self.capturedImage
//                DispatchQueue.main.async(execute: {
//                                if ((self.userPreferences.isPhotoAutoUploadEnabled == true) && (NetworkManager.isConnectedToNetwork()))
//                                {
//                                    self.imageCountButton.isHidden = true
//                                    self.autoUploadCountLabel.isHidden = false
//                                    self.activityIndicatorView.isHidden = false
//                                    self.uploadPhoto()
//                                }
//                                else
//                                {
//                                    self.imageCountButton.isHidden = false
//                                    self.autoUploadCountLabel.isHidden = true
//                                    self.activityIndicatorView.isHidden = true
//                                    self.imageCountButton.setBadge(self.timeline.photosToUpload.count)
//                                }
//                })
            }
        }
    }
    
    @IBAction func libraryButtonTouched(_ sender:UIButton)
    {
        AnalyticsAgent.sharedInstance.trackButtonTapped(self.analyticsScreenName, buttonName: NSLocalizedString("Library", comment: ""))
    }
    
    @IBAction func shareButtonTouched(_ sender:UIButton)
    {
        
    }
    
    @IBAction func toggleFlash(_ sender:UIButton)
    {
        AnalyticsAgent.sharedInstance.trackButtonTapped(self.analyticsScreenName, buttonName: NSLocalizedString("ToggleFlash", comment: ""))
        //self.newCamera?.torchMode = AVCaptureTorchMode.Off
        if ((self.newCamera?.isFlashAvailable == true) && (self.newCamera?.isFlashModeSupported(AVCaptureFlashMode.off)) == true)
        {
            self.flashBool = !self.flashBool
            if (self.flashBool == true)
            {
                self.flashButton.setImage(UIImage(named: "cameraFlash"), for: UIControlState())
            }
            else
            {
                self.flashButton.setImage(UIImage(named: "cameraFlashOff"), for: UIControlState())
            }
        }
    }
    
    @IBAction func toggleCamera(_ sender:UIButton)
    {
        AnalyticsAgent.sharedInstance.trackButtonTapped(self.analyticsScreenName, buttonName: NSLocalizedString("ToggleCamera", comment: ""))
        if(self.captureSession.isRunning)
        {
            let inputArray = self.captureSession.inputs
            for inputs in inputArray!
            {
                if let input = inputs as? AVCaptureDeviceInput
                {
                    let device = input.device
                    if (device?.hasMediaType(AVMediaTypeVideo))!
                    {
                        self.position = device?.position
                        
                        if(position == AVCaptureDevicePosition.front)
                        {
                            self.newCamera = self.cameraWithPosition(AVCaptureDevicePosition.back)
                            
                        }
                        else
                        {
                            self.newCamera = self.cameraWithPosition(AVCaptureDevicePosition.front)
                        }
                        do
                        {
                            self.newInput = try AVCaptureDeviceInput.init(device: newCamera)
                            self.captureSession.beginConfiguration()
                            self.captureSession.removeInput(input)
                            self.captureSession.addInput(newInput)
                            self.captureSession.commitConfiguration()
                        }
                        catch
                        {
                            //print("Error creating new Device")
                        }
                    }
                }
                
            }
        }
    }
    
    func cameraWithPosition(_ position:AVCaptureDevicePosition) -> AVCaptureDevice
    {
        var deviceRequested:AVCaptureDevice?
        let deviceArray = AVCaptureDevice.devices(withMediaType: AVMediaTypeVideo)
        for devices in deviceArray!
        {
            if let device = devices as? AVCaptureDevice
            {
                if (device.position == position )
                {
                    deviceRequested = device
                }
            }
        }
        return deviceRequested!
    }
    
    
    @IBAction func dismissButtonTouched()
    {
        AnalyticsAgent.sharedInstance.trackButtonTapped(self.analyticsScreenName, buttonName: NSLocalizedString("Dismiss", comment: ""))
        self.dismiss(animated: true, completion: nil)
    }
    
    override public func willAnimateRotation(to toInterfaceOrientation: UIInterfaceOrientation, duration: TimeInterval)
    {
        
//        var frame:CGRect = self.navigationBarManager.navigationController.navigationBar.frame
//        
//        if (toInterfaceOrientation == UIInterfaceOrientation.portrait)
//        {
//            frame = self.navigationBarManager.navigationController.navigationBar.frame
//        }
//        else
//        {
//            self.navigationBarManager.navigationController.navigationBar.frame = frame
//        }
        
    }
    
    func interfaceOrientationToVideoOrientation(_ orientation : UIInterfaceOrientation) -> AVCaptureVideoOrientation {
        switch (orientation) {
        case .unknown:
            fallthrough
        case .portrait:
            return AVCaptureVideoOrientation.portrait
        case .portraitUpsideDown:
            return AVCaptureVideoOrientation.portraitUpsideDown
        case .landscapeLeft:
            return AVCaptureVideoOrientation.landscapeLeft
        case .landscapeRight:
            return AVCaptureVideoOrientation.landscapeRight
        }
    }
    
    
//    @IBAction func uploadPhotosButtonToucherd(_ sender:BadgeButton)
//    {
//        AnalyticsAgent.sharedInstance.trackButtonTapped(self.analyticsScreenName, buttonName: NSLocalizedString("uploadPhoto", comment: ""))
//        performSegue(withIdentifier: "segueToUploadImages", sender: self.timeline)
//    }
    
    override public func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if (segue.identifier == "segueToUploadImages")
//        {
//            if let eventPhotosUploadViewController = segue.destination as? EventPhotosUploadViewController
//            {
//                if let timeline = sender as? Timeline
//                {
//                    eventPhotosUploadViewController.timeline = timeline
//                }
//            }
//        }
    }
    
    @IBAction func pinchGestureReconized(_ gestureRecognizer:UIPinchGestureRecognizer)
    {
        AnalyticsAgent.sharedInstance.trackButtonTapped(self.analyticsScreenName, buttonName: NSLocalizedString("PinchGesture", comment: ""))
        let numberOFTouches = gestureRecognizer.numberOfTouches
        if( numberOFTouches > 1)
        {
            let vZoomFactor = gestureRecognizer.scale
            //let error:NSError!
            do
            {
                try self.newCamera?.lockForConfiguration()
                if let currentZoomFactor = self.newCamera?.videoZoomFactor
                {
                    self.newCamera?.videoZoomFactor = currentZoomFactor
                }
                else
                {
                    self.newCamera?.videoZoomFactor = 1
                }
                
                if (vZoomFactor < self.newCamera?.activeFormat.videoMaxZoomFactor && vZoomFactor > 1)
                {
                    self.newCamera?.videoZoomFactor = vZoomFactor
                }
                else
                {
                    if var currentZoomFactor = self.newCamera?.videoZoomFactor
                    {
                        currentZoomFactor -= vZoomFactor
                        
                        if(currentZoomFactor < 1)
                        {
                            self.newCamera?.videoZoomFactor = 1
                        }
                        else
                        {
                            self.newCamera?.videoZoomFactor = currentZoomFactor
                        }
                    }
                }
                self.newCamera?.unlockForConfiguration()
            }
            catch _
            {
                
            }
        }
    }
    
}


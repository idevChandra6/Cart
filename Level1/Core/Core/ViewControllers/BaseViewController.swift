//
//  BaseViewController.swift
//  Core
//
//  Created by Jain, Vijay on 9/20/16.
//  Copyright © 2016 Visa Inc. All rights reserved.
//

import UIKit

open class BaseViewController: UIViewController, ErrorHandlingProtocol
{
    var aProgressView:UIView!
    
    public var progressView:UIView!
        {
        get
        {
            return aProgressView
        }
        set
        {
            aProgressView = newValue
        }
    }

    open var analyticsScreenName:String
        {
        get
        {
            return ""
        }
    }
    
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        AnalyticsAgent.sharedInstance.trackScreenViewStarted(self.analyticsScreenName)
    }

    override open func viewWillDisappear(_ animated: Bool)
    {
        super.viewWillDisappear(animated)
        AnalyticsAgent.sharedInstance.trackScreenViewEnded(self.analyticsScreenName)
    }
    
    public func displayProgressViewWithText(_ text:String, inView:UIView? = nil)
    {
        if (self.progressView == nil)
        {
            if let frameworkBundle = Bundle(identifier: "com.visa.onemarket.Core")
            {
                if let views = frameworkBundle.loadNibNamed("OMCProgressView", owner: self, options: nil)
                {
                    if let progressView = views[0] as? UIView
                    {
                        var aView = self.view
                        if (inView != nil)
                        {
                            aView = inView
                        }
                        self.progressView = progressView
                        if let aProgressView = self.progressView.viewWithTag(100)
                        {
                            aProgressView.layer.cornerRadius = 10.0
                            aProgressView.clipsToBounds = true
                        }
                        
                        //check for the activity indicator in the progressview and scale it
                        let activityViews = self.progressView.subviews[1].subviews.filter() {
                            return $0.isKind(of: UIActivityIndicatorView.self)
                        }
                        
                        let activityIndicator: UIView = activityViews[0]
                        let  transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
                        activityIndicator.transform = transform;
                        
                        self.progressView.translatesAutoresizingMaskIntoConstraints = false
                        aView?.addSubview(progressView)
                        
                        aView?.addConstraint(NSLayoutConstraint(item: self.progressView, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: aView, attribute: NSLayoutAttribute.bottom, multiplier: 1.0, constant: 0.0))
                        aView?.addConstraint(NSLayoutConstraint(item: self.progressView, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: aView, attribute: NSLayoutAttribute.top, multiplier: 1.0, constant: 0.0))
                        aView?.addConstraint(NSLayoutConstraint(item: self.progressView, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: aView, attribute: NSLayoutAttribute.leading, multiplier: 1.0, constant: 0.0))
                        aView?.addConstraint(NSLayoutConstraint(item: self.progressView, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal, toItem: aView, attribute: NSLayoutAttribute.trailing, multiplier: 1.0, constant: 0.0))
                        
                        //                    }
                        aView?.bringSubview(toFront: self.progressView)
                    }
                }
            }
        }
        if (self.progressView != nil)
        {
            if let loadingLabel = self.progressView.viewWithTag(200) as? UILabel
            {
                loadingLabel.text = text
            }
            self.progressView.isHidden = false
        }
    }
    
    public func hideProgressView(_ inView:UIView? = nil)
    {
        if self.progressView != nil
        {
            self.progressView.isHidden = true
        }
    }

}

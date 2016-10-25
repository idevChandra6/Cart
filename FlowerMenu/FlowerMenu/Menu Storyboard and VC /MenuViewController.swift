//
//  MenuViewController.swift
//  Concierge
//
//  Created by Jain, Vijay on 4/25/16.
//  Copyright © 2016 Visa Inc. All rights reserved.
//

import UIKit

public protocol MainMenuDelegate: class {
    func mainMenuExpanded()
    func mainMenuCollapsed()
    func didTapMenuIconItemAtIndex(index: Int)
    func didTapMenuListItemAtIndex(index: Int)
}

open class MenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    
    @IBOutlet var iconButtons: [UIButton]!
    
    @IBOutlet weak var mainButton:UIButton!
    @IBOutlet weak var mainButtonImageView:UIImageView!
    
    @IBOutlet weak var secondaryButtonsView:UIView!
    @IBOutlet weak var overlayImageView:UIImageView!
    @IBOutlet weak var ovalImageView:UIImageView!
    @IBOutlet weak var mainButtonDistanceToBottomConatraint:NSLayoutConstraint!
    
    @IBOutlet weak var tableView:UITableView!
    @IBOutlet weak var tableViewHeightConatraint:NSLayoutConstraint!

    let duration:TimeInterval = 0.2
    let distanceFromMainButtton = 120.0
    let pie = 3.14159
    var tableViewHeight:CGFloat = 310.0
    
    open var moreItems = [String]()
    
    fileprivate var iconImages = [UIImage]()
    
    open func setIconImages(images: [UIImage]) -> Bool {
        if images.count > 6 {
            return false
        } else {
            iconImages = images
            return true
        }
    }
    
    var anItem = ""
    
    enum MainButtonState
    {
        case collapsed
        case expanded
        case more
    }
    
    var mainButtonState:MainButtonState = .collapsed
    
    static var animationImagesToMore:[UIImage]? = nil
    static var animationImagesToCross:[UIImage]? = nil
    
    open weak var delegate:MainMenuDelegate?
    
    override open func viewDidLoad()
    {
        super.viewDidLoad()
        self.loadAnimationImages()
        self.mainButtonDistanceToBottomConatraint.constant = 0
        
        self.mainButton.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        
        self.overlayImageView.alpha = 0.0
        self.ovalImageView.isHidden = true
        self.tableView.reloadData()
        self.tableViewHeightConatraint.constant = 0
        self.tableView.alpha = 0.0
        for button in self.iconButtons
        {
            button.isHidden = true
        }
        self.tableViewHeight = self.calculateTableViewHeightBasedOnPhoneModel()
        
        setIconImages()
    }
    
    func setIconImages() {
        var i = 0
        while i < iconButtons.count && i < iconImages.count {
            let button = iconButtons[i]
            button.isHidden = false
            let image = iconImages[i]
            button.setImage(image, for: .normal)
            i += 1
        }
        
        while i < iconButtons.count {
            let button = iconButtons[i]
            button.isHidden = true
            i += 1
        }
    }
    
    func calculateTableViewHeightBasedOnPhoneModel() -> CGFloat {
        let interfaceOrientation = UIApplication.shared.statusBarOrientation
        if (UIInterfaceOrientationIsPortrait(interfaceOrientation)) {
            return  UIScreen.main.bounds.size.height * 0.4
        } else {
            return  UIScreen.main.bounds.size.width * 0.4
        }
    }
    
    func loadAnimationImages() {
        if (MenuViewController.animationImagesToMore == nil) || (MenuViewController.animationImagesToCross == nil) {
            MenuViewController.animationImagesToMore = self.loadImages("ToMore")
            MenuViewController.animationImagesToCross = self.loadImages("ToCross")
        }
    }
    
    func loadImages(_ filenameStartingWith:String) -> [UIImage] {
        var imageIndex = 1
        let totalCount = 21
        var animationImages = [UIImage]()
        repeat
        {
            let imageName = "\(filenameStartingWith)_\(imageIndex).png"
            if let filePath = Bundle(identifier: "com.visa.FlowerMenu")?.path(forResource: imageName, ofType: "")
            {
                if let data = try? Data(contentsOf: URL(fileURLWithPath: filePath))
                {
                    if let image = UIImage(data: data)
                    {
                        animationImages.append(image)
                    }
                }
            }
            
            imageIndex = imageIndex + 1
        } while imageIndex <= totalCount
        return animationImages
    }
    
    @IBAction func mainButonTouched()
    {
        DispatchQueue.main.async(execute: { () -> Void in
            if (self.mainButtonState == .collapsed)
            {
                self.animateImageToMore()
                self.expandButtonsToMore()
            }
            else if (self.mainButtonState == .more)
            {
                self.animateImageToCross()
                self.displayMoreTableView()
            }
            else
            {
                self.animateImageToArrow()
                self.collapseButtons(nil)
            }
        })
    }
    
    func animateImageToArrow()
    {
        if let imageView = self.mainButtonImageView
        {
            imageView.image = MenuViewController.animationImagesToMore?.first
        }
    }
    
    func animateImageToMore()
    {
        if let imageView = self.mainButtonImageView
        {
            imageView.image = MenuViewController.animationImagesToMore?.last
            imageView.animationImages = MenuViewController.animationImagesToMore
            imageView.animationRepeatCount = 1
            imageView.animationDuration = 0.4
            imageView.startAnimating()
        }
    }
    
    func displayMoreTableView()
    {
        self.mainButtonState = .expanded
        let transform = CGAffineTransform.identity
        UIView.animate(withDuration: 0.3, delay: 0.0, options: UIViewAnimationOptions(), animations:
            {
                self.mainButton.transform = transform.translatedBy(x: 0, y: -1 * self.tableViewHeight)
                self.mainButtonImageView.transform = transform.translatedBy(x: 0, y: -1 * self.tableViewHeight)
                self.secondaryButtonsView.transform = transform.translatedBy(x: 0, y: -1 * self.tableViewHeight)
                self.ovalImageView.transform = transform.translatedBy(x: 0, y: -1 * self.tableViewHeight)
                self.tableView.alpha = 1.0
                self.tableViewHeightConatraint.constant = self.tableViewHeight
                self.tableView.layoutIfNeeded()
            }, completion: {
                [weak self]
                (value: Bool) in
                if (value == true)
                {
                    if let _ = self
                    {
                    }
                }
            })
    }
    
    func animateImageToCross()
    {
        if let imageView = self.mainButtonImageView
        {
            imageView.image = MenuViewController.animationImagesToCross?.last
            imageView.animationImages = MenuViewController.animationImagesToCross
            imageView.animationRepeatCount = 1
            imageView.animationDuration = 0.4
            imageView.startAnimating()
        }
    }
    
    func expandButtonsToMore()
    {
        self.delegate?.mainMenuExpanded()
        var multiplier = 1.0
        self.mainButtonState = .more
        
        UIView.animate(withDuration: 0.3, delay: 0.0, options: UIViewAnimationOptions(), animations:
            {
                self.mainButtonDistanceToBottomConatraint.constant = 70
                self.overlayImageView.alpha = 1.0
            }, completion: {
                [weak self]
                (value: Bool) in
                if (value == true)
                {
                    if let _ = self
                    {
                    }
                }
            })
        
        self.ovalImageView.isHidden = false
        self.ovalImageView.alpha = 1.0
        
        for (index, button) in self.iconButtons.enumerated()
        {
            if index < self.iconButtons.count/2
            {
                multiplier = -1.0
            }
            
            let transform = CGAffineTransform.identity
            let delay = (Double(index) * self.duration/3)
            self.secondaryButtonsView.transform = CGAffineTransform(rotationAngle: -0.1)
            if (index == 0)
            {
                self.ovalImageView.transform = CGAffineTransform(scaleX: 1/3.8, y: 1/3.8)
            }
            UIView.animate(withDuration: self.duration, delay: delay, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.0, options: UIViewAnimationOptions(), animations:
                {
                    var angleInRadians: Double = 0
                    
                    if self.iconImages.count > 4 {
                        angleInRadians = ((Double(index)-0.5) * self.pie/Double(self.iconImages.count - 2))
                    } else if self.iconImages.count == 4 {
                        if index == 0 {
                            angleInRadians = 0
                        } else if index == 1 {
                            angleInRadians = 1.072
                        } else if index == 2 {
                            angleInRadians = 1.072 * 2
                        } else if index == 3 {
                            angleInRadians = 3.14159
                        }
                    } else if self.iconImages.count == 3 {
                        if index == 0 {
                            angleInRadians = 0.785398
                        } else if index == 1 {
                            angleInRadians = 1.5708
                        } else if index == 2 {
                            angleInRadians = 0.785398 * 3
                        }
                    } else if self.iconImages.count == 2 {
                        if index == 0 {
                            angleInRadians = 1.072
                        } else if index == 1 {
                            angleInRadians = 1.072 * 2
                        }
                    } else {
                        angleInRadians = 1.5708
                    }
                    
                    let xValue = self.distanceFromMainButtton * Double(cos(angleInRadians))
                    let yValue = self.distanceFromMainButtton * sin(angleInRadians) //+ Double(multiplier * 40.0)
                    
                    button.isHidden = false
                    button.transform = transform.translatedBy(x: CGFloat(multiplier * xValue), y: CGFloat(-1 * yValue))
                    button.transform = button.transform.scaledBy(x: 1.2, y: 1.2)
                    self.secondaryButtonsView.transform = CGAffineTransform(rotationAngle: 0.0)
                    
                    if (index == 0)
                    {
                        self.ovalImageView.transform = transform.scaledBy(x: 1.0, y: 1.0)
                    }
                    
                }, completion: {
                    [weak self]
                    (value: Bool) in
                    if (value == true)
                    {
                        if let _ = self
                        {
                        }
                    }
                })
        }
        
        UIView.animate(withDuration: 0.3, delay: 0.3, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.0, options: UIViewAnimationOptions(), animations:
            {
                var aTransform = CGAffineTransform.identity
                aTransform = aTransform.translatedBy(x: 0, y: -60.0)
                
            }, completion: {
                [weak self]
                (value: Bool) in
                if (value == true)
                {
                    if let _ = self
                    {
                        
                    }
                }
            })
    }
    
    func collapseButtons(_ completion: (()->Void)?)
    {
        self.mainButtonState = .collapsed
        let transform = CGAffineTransform.identity
        
        for (index, button) in self.iconButtons.enumerated()
        {
            UIView.animate(withDuration: 0.2, delay: 0.0, options: UIViewAnimationOptions(), animations:
                {
                    button.transform = CGAffineTransform.identity
                    if (index == 0)
                    {
                        self.tableView.alpha = 0.0
                        self.ovalImageView.alpha = 0.0
                    }
                }, completion: {
                    [weak self]
                    (value: Bool) in
                    if (value == true)
                    {
                        if let strongSelf = self
                        {
                            button.isHidden = true
                            
                            if (index == strongSelf.iconButtons.count-1)
                            {
                                UIView.animate(withDuration: 0.2, delay: 0.0, options: UIViewAnimationOptions(), animations:
                                    {
                                        strongSelf.ovalImageView.isHidden = true
                                        strongSelf.tableViewHeightConatraint.constant = 0
                                        strongSelf.tableView.layoutIfNeeded()
                                        strongSelf.tableView.alpha = 0.0
                                        
                                        strongSelf.mainButton.transform = transform
                                        strongSelf.mainButtonImageView.transform = transform
                                        strongSelf.secondaryButtonsView.transform = transform
                                        strongSelf.overlayImageView.alpha = 0.0
                                    }, completion: {
                                        [weak self]
                                        (value: Bool) in
                                        if (value == true)
                                        {
                                            if let aSelf = self
                                            {
                                                aSelf.collapseMainButton(completion)
//                                                                                                aSelf.mainButtonDistanceToBottomConatraint.constant = 0
//                                                                                                aSelf.view.layoutIfNeeded()
//                                                                                                aSelf.delegate?.mainMenuCollapsed()
//                                                                                                completion?()
                                            }
                                        }
                                    })
                            }
                        }
                    }
                })
        }
    }
    
    func collapseMainButton(_ completion: (()->Void)?)
    {
        UIView.animate(withDuration: 0.2, delay: 0.0, options: UIViewAnimationOptions(), animations:
            {
                self.mainButtonDistanceToBottomConatraint.constant = 7
            }, completion: {
                [weak self]
                (value: Bool) in
                if (value == true)
                {
                    if let aSelf = self
                    {
                        aSelf.view.layoutIfNeeded()
                        aSelf.delegate?.mainMenuCollapsed()
                        completion?()
                    }
                }
            })
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moreItems.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:UITableViewCell!
        cell = tableView.dequeueReusableCell(withIdentifier: "MenuMoreTableViewCell")
        if let agendaItemTitleTableViewCell = cell as? MenuMoreTableViewCell {
            let moreItem = self.moreItems[(indexPath as NSIndexPath).row]
            agendaItemTitleTableViewCell.setupTitle(moreItem)
        }
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        DispatchQueue.main.async(execute: { () -> Void in
            self.delegate?.didTapMenuListItemAtIndex(index: indexPath.row)
            self.animateImageToArrow()
            self.collapseButtons(nil)
        })
    }
    
    @IBAction func didTapIcon(_ sender: UIButton) {
        if sender.tag >= iconImages.count {
            return
        }
        
        DispatchQueue.main.async(execute: { () -> Void in
            self.delegate?.didTapMenuIconItemAtIndex(index: sender.tag)
            self.animateImageToArrow()
            self.collapseButtons(nil)
        })
    }

    
    @IBAction func tapGestureRecognized(_ tapGestureRecognizer:UITapGestureRecognizer)
    {
        DispatchQueue.main.async(execute: { () -> Void in
            if (tapGestureRecognizer.view?.tag == 105)
            {
                self.animateImageToArrow()
                self.collapseButtons(nil)
            }
        })
    }

    @IBAction func panGestureRecognized(_ panGestureRecognizer:UIPanGestureRecognizer)
    {
        DispatchQueue.main.async(execute: { () -> Void in
            if (panGestureRecognizer.view?.tag == 105)
            {
                self.animateImageToArrow()
                self.collapseButtons(nil)
            }
        })
    }
}


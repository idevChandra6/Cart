//
//  CarouselViewController.swift
//  Carousel
//
//  Created by Ziaurehman Amini on 10/3/16.
//  Copyright © 2016 Visa. All rights reserved.
//

import UIKit

// MARK:- CarouselViewData Struct

public struct CarouselViewData {
    public init(imageName: String, title: String, subTitle: String) {
        self.imageName = imageName
        self.title = title
        self.subTitle = subTitle
    }
    
    public var imageName: String!
    public var title: String!
    public var subTitle: String!
}

// MARK:- CarouselViewControllerDelegate

public protocol CarouselViewControllerDelegate: class {
    func didScrollToItemAtIndex(index: Int)
    func selectButtonTouched(index: Int)
}

// MARK:- UIViewController

open class CarouselViewController: UIViewController {

    // MARK: Properties
    
    open var currentCard = 0
    open weak var delegate: CarouselViewControllerDelegate?
    
    var carouselViewData = [CarouselViewData]() {
        didSet {
            setupCarouselViews()
        }
    }
    
    var carouselHolderView = iCarousel()
    var carouselViews = [CarousalView]()
    var selected = false

    // MARK: View Methods
    
    override open func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        view.addSubview(carouselHolderView)
        carouselHolderView.boundInside(superView: view)
        carouselHolderView.delegate = self
        carouselHolderView.dataSource = self
        carouselHolderView.type = .rotary
        carouselHolderView.isPagingEnabled = true
    }
    
    override open func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        for carouselView in carouselViews {
            carouselView.frame = view.frame
        }
        
        if currentCard > 0 && currentCard < carouselViews.count {
            carouselHolderView.currentItemIndex = currentCard
        }
    }
    
    open func setCarouselViewData(carouselViewData: [CarouselViewData], currentCard: Int?) {
        self.carouselViewData = carouselViewData
        
        if let currentCard = currentCard {
            self.currentCard = currentCard
        }
    }
    
    func setupCarouselViews() {
        for carouselViewDatum in carouselViewData {
            let carouselView = Bundle.init(identifier: "com.visa.CarouselControl")?.loadNibNamed("AccountTypePortraitCarousalView", owner: self, options: nil)?[0]  as! CarousalView
            
            carouselViews.append(carouselView)
            carouselView.tag = carouselViews.index(of: carouselView)!
            
            carouselView.setupCarousalView(title: carouselViewDatum.title, subtitle: carouselViewDatum.subTitle, imageName: carouselViewDatum.imageName)
            carouselView.visualEffectView.alpha = (carouselView.tag == currentCard) ? 0.0 : 0.5
            carouselView.selectButton.isEnabled = true
            carouselView.delegate = self
        }
    }
    
}

// MARK:- iCarouselDataSource

extension CarouselViewController: iCarouselDataSource {
    public func numberOfItems(in carousel: iCarousel) -> Int {
        return carouselViews.count
    }
        
    public func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        
        return carouselViews[index]
    }
    
}

// MARK:- iCarouselDelegate

extension CarouselViewController: iCarouselDelegate {
    public func carouselDidScroll(_ carousel:iCarousel)
    {
        if carousel.currentItemIndex >= carouselViews.count || carousel.currentItemIndex < 0 {
            return
        }
        
        delegate?.didScrollToItemAtIndex(index: carousel.currentItemIndex)
        
        let carouselView = carouselViews[carousel.currentItemIndex]
        
        if carousel.currentItemIndex == 0 {
            if (carousel.scrollOffset > CGFloat(carouselViews.count) - 0.5) {
                carouselView.visualEffectView.alpha = CGFloat(carouselViews.count) - carousel.scrollOffset
            } else {
                carouselView.visualEffectView.alpha = carousel.scrollOffset
            }
        } else {
            if (carousel.scrollOffset <= CGFloat(carousel.currentItemIndex)) {
                carouselView.visualEffectView.alpha = CGFloat(carousel.currentItemIndex) - carousel.scrollOffset
            } else {
                carouselView.visualEffectView.alpha = carousel.scrollOffset - CGFloat(carousel.currentItemIndex)
            }
        }
    }
}

// MARK:- CarousalViewSelectionDelegate

extension CarouselViewController: CarousalViewSelectionDelegate {
    public func selectButtonTouched(index: Int) {
        for carousalView in carouselViews {
            carousalView.selectButton.setImage(UIImage(named:"SelectButton"), for: UIControlState.normal)
        }
        
        delegate?.selectButtonTouched(index: index)
    }
}










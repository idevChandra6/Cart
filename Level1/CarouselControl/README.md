#CarouselControl
CarouselControl is built on top of iCarousel as a dynamic library and provides a simple way to create rotary carousel views with fade in/out effect.

#How to integrate into a project:
1. Drag and drop CarouselControl.framework into the project.
2. Include CarouselControl.framework into the project target’s embedded binaries.
3. Import CarouselControl into the Swift file that acts as a datasource for the carousel.

#How to use it:
1. In your storyboard, subclass a new ViewController as CarouselViewController and set CarouselControl as its module.
2. In prepareForSegue method, call setCarouselViewData method on your CarouselViewController with an array of CarouselViewData structs. Each struct represents one carousel card. Each card requires an image, title, and subtitle.
3. Conform to CarouselViewControllerDelegate protocol to get call backs when user swipes to a new card or taps Select on the a card.

#Requirements:
* iOS 10.0+
* Swift 3.0
* Xcode 8.0

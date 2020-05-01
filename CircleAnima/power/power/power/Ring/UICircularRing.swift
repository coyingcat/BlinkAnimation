

import UIKit

/**

 # UICircularRing

 This is the base class of `UICircularProgressRing` and `UICircularTimerRing`.
 You should not instantiate this class, instead use one of the concrete classes provided
 or subclass and make your own.

 This is the UIView subclass that creates and handles everything
 to do with the circular ring.

 This class has a custom CAShapeLayer (`UICircularRingLayer`) which
 handels the drawing and animating of the view

 ## Author
 Luis Padron

 */
@IBDesignable open class UICircularRing: UIView {


    // MARK: Private / internal

    /**
     Set the ring layer to the default layer, cated as custom layer
     */
    var ringLayer: UICircularRingLayer {
        // swiftlint:disable:next force_cast
        return layer as! UICircularRingLayer
    }

    // MARK: Methods

    /**
     Overrides the default layer with the custom UICircularRingLayer class
     */
    override open class var layerClass: AnyClass {
        return UICircularRingLayer.self
    }

    /**
     Overriden public init to setup() the layer and view
     */
    override public init(frame: CGRect) {
        super.init(frame: frame)
        // Call the internal initializer
        setup()
    }

    /**
     Overriden public init to setup() the layer and view
     */
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        // Call the internal initializer
        setup()
    }

    /**
     This method initializes the custom CALayer to the default values
     */
    func setup(){
        // This view will become the value delegate of the layer, which will call the updateValue method when needed

        // Helps with pixelation and blurriness on retina devices
        ringLayer.contentsScale = UIScreen.main.scale
        ringLayer.shouldRasterize = true
        ringLayer.rasterizationScale = UIScreen.main.scale * 2
        ringLayer.masksToBounds = false

        backgroundColor = UIColor.clear
        ringLayer.backgroundColor = UIColor.clear.cgColor
        ringLayer.value = 0
    }


    // MARK: Internal API

    /**
     These functions are here to allow reuse between subclasses.
     They handle starting, pausing and resetting an animation of the ring.
    */

    func startAnimation() {
 
        ringLayer.timeOffset = 0
        ringLayer.beginTime = 0
        ringLayer.speed = 1
   
        ringLayer.value = 50
    }


}


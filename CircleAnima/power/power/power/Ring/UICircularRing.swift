//
//  UICircularRing.swift
//  UICircularProgressRing
//
//  Copyright (c) 2019 Luis Padron
//
//  Permission is hereby granted, free of charge, to any person obtaining a
//  copy of this software and associated documentation files (the "Software"),
//  to deal in the Software without restriction, including without limitation the
//  rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is furnished
//  to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included
// in all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
//  INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND
//  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE
//  FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT
//  OR OTHERWISE, ARISING FROM, OUT OF OR IN
//  CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

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

     
     @IBInspectable public var value: CGFloat = 0 {
         didSet {
             if value < 0 {
                 #if DEBUG
                 print("Warning in: \(#file):\(#line)")
                 print("Attempted to set a value less than minValue, value has been set to minValue.\n")
                 #endif
                 ringLayer.value = 0
             } else if value > 50 {
                 #if DEBUG
                 print("Warning in: \(#file):\(#line)")
                 print("Attempted to set a value greater than maxValue, value has been set to maxValue.\n")
                 #endif
                 ringLayer.value = 50
             } else {
                 ringLayer.value = value
             }
         }
     }

     /**
      The current value of the progress ring

      This will return the current value of the progress ring,
      if the ring is animating it will be updated in real time.
      If the ring is not currently animating then the value returned
      will be the `value` property of the ring

      ## Author
      Luis Padron
      */
     public var currentValue: CGFloat? {
         return isAnimating ? layer.presentation()?.value(forKey: .value) as? CGFloat : value
     }

  
    
    /**
     A toggle for showing or hiding the value label.
     If false the current value will not be shown.

     ## Important ##
     Default = true

     ## Author
     Luis Padron
     */
    @IBInspectable public var shouldShowValueText: Bool = true {
        didSet { ringLayer.setNeedsDisplay() }
    }



   
    /**
     The start angle for the entire progress ring view.

     Please note that Cocoa Touch uses a clockwise rotating unit circle.
     I.e: 90 degrees is at the bottom and 270 degrees is at the top

     ## Important ##
     Default = 0 (degrees)

     Values should be in degrees (they're converted to radians internally)

     ## Author
     Luis Padron
     */
    @IBInspectable open var startAngle: CGFloat = 0 {
        didSet { ringLayer.setNeedsDisplay() }
    }

    /**
     The end angle for the entire progress ring

     Please note that Cocoa Touch uses a clockwise rotating unit circle.
     I.e: 90 degrees is at the bottom and 270 degrees is at the top

     ## Important ##
     Default = 360 (degrees)

     Values should be in degrees (they're converted to radians internally)

     ## Author
     Luis Padron
     */
    @IBInspectable open var endAngle: CGFloat = 360 {
        didSet { ringLayer.setNeedsDisplay() }
    }


  

 

    /**
     The color of the inner ring for the progres bar

     ## Important ##
     Default = UIColor.blue

     ## Author
     Luis Padron
     */
    @IBInspectable open var innerRingColor: UIColor = UIColor.blue {
        didSet { ringLayer.setNeedsDisplay() }
    }


    /**
     This returns whether or not the ring is currently animating

     ## Important ##
     Get only property

     ## Author
     Luis Padron
     */
    open var isAnimating: Bool {
        return ringLayer.animation(forKey: .value) != nil
    }



    /**
     Typealias for animateProperties(duration:animations:completion:) fucntion completion
     */
    public typealias PropertyAnimationCompletion = (() -> Void)

    // MARK: Private / internal

    /**
     Set the ring layer to the default layer, cated as custom layer
     */
    var ringLayer: UICircularRingLayer {
        // swiftlint:disable:next force_cast
        return layer as! UICircularRingLayer
    }

    /// This variable stores how long remains on the timer when it's paused
    private var pausedTimeRemaining: TimeInterval = 0

    /// Used to determine when the animation was paused
    private var animationPauseTime: CFTimeInterval?


    typealias AnimationCompletion = () -> Void

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
        ringLayer.ring = self

        // Helps with pixelation and blurriness on retina devices
        ringLayer.contentsScale = UIScreen.main.scale
        ringLayer.shouldRasterize = true
        ringLayer.rasterizationScale = UIScreen.main.scale * 2
        ringLayer.masksToBounds = false

        backgroundColor = UIColor.clear
        ringLayer.backgroundColor = UIColor.clear.cgColor
        
        
        
        ringLayer.ring = self
        ringLayer.value = value
   

    }


    // MARK: Internal API

    /**
     These functions are here to allow reuse between subclasses.
     They handle starting, pausing and resetting an animation of the ring.
    */

    func startAnimation() {
        if isAnimating {
            animationPauseTime = nil
        }

        ringLayer.timeOffset = 0
        ringLayer.beginTime = 0
        ringLayer.speed = 1
   
        self.value = 50
    }




    // MARK: API

    /**
     This function allows animation of the animatable properties of the `UICircularRing`.
     These properties include `innerRingColor, innerRingWidth, outerRingColor, outerRingWidth, innerRingSpacing, fontColor`.

     Simply call this function and inside of the animation block change the animatable properties as you would in any `UView`
     animation block.

     The completion block is called when all animations finish.
     */
    open func animateProperties(duration: TimeInterval, animations: () -> Void) {
        animateProperties(duration: duration, animations: animations, completion: nil)
    }

    /**
     This function allows animation of the animatable properties of the `UICircularRing`.
     These properties include `innerRingColor, innerRingWidth, outerRingColor, outerRingWidth, innerRingSpacing, fontColor`.

     Simply call this function and inside of the animation block change the animatable properties as you would in any `UView`
     animation block.

     The completion block is called when all animations finish.
     */
    open func animateProperties(duration: TimeInterval, animations: () -> Void,
                                completion: PropertyAnimationCompletion? = nil) {
        ringLayer.shouldAnimateProperties = true
        ringLayer.propertyAnimationDuration = duration
        CATransaction.begin()
        CATransaction.setCompletionBlock {
            // Reset and call completion
            self.ringLayer.shouldAnimateProperties = false
            self.ringLayer.propertyAnimationDuration = 0.0
            completion?()
        }
        // Commit and perform animations
        animations()
        CATransaction.commit()
    }
}


extension UICircularRing {
    /// Helper enum for animation key
    enum AnimationKeys: String {
        case value
    }
}

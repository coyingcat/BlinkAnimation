//
//  BlinkLayoutBtn.swift
//  SYBlinkAnimationKit
//
//  Created by Shohei Yokoyama on 12/13/2015.
//  Copyright © 2015年 Shohei. All rights reserved.
//

import UIKit

@IBDesignable
public class BlinkLayoutBtn: UIButton, AnimatableComponent{
    public enum AnimationType: Int {
        case border, borderWithShadow, background, ripple, opaque
    }
    
    @IBInspectable public var animationBorderColor = AnimationDefaultColor.border {
        didSet {
            animaLayer.setBorderColor(animationBorderColor)
        }
    }
    @IBInspectable public var animationBackgroundColor = AnimationDefaultColor.background {
        didSet {
            animaLayer.setAnimationBackgroundColor(animationBackgroundColor)
        }
    }
    @IBInspectable public var animationTextColor = AnimationDefaultColor.text {
        didSet {
            animaLayer.setAnimationTextColor(animationTextColor)
        }
    }
    @IBInspectable public var animationRippleColor = AnimationDefaultColor.ripple {
        didSet {
            animaLayer.setRippleColor(animationRippleColor)
        }
    }
    @IBInspectable var animationTimingAdapter: Int {
        get {
            return animationTimingFunction.rawValue
        }
        set(index) {
            animationTimingFunction = SYMediaTimingFunction(rawValue: index) ?? .linear
        }
    }
    @IBInspectable public var animationDuration: CGFloat = 1.5 {
        didSet {
            animaLayer.setAnimationDuration( CFTimeInterval(animationDuration) )
        }
    }
    @IBInspectable var animationAdapter: Int {
        get {
            return animationType.rawValue
        }
        set(index) {
            animationType = AnimationType(rawValue: index) ?? .border
        }
    }
    
    public var animationTimingFunction: SYMediaTimingFunction = .linear {
        didSet {
            animaLayer.setTimingFunction(animationTimingFunction)
        }
    }
    
    
    
    
    public var animationType: AnimationType = .border {
        didSet {
            animaLayer.animationType = {
                switch animationType {
                case .border:
                    return .border
                case .borderWithShadow:
                    return .borderWithShadow
                case .background:
                    return .background
                case .ripple:
                    return .ripple
                case .opaque:
                    return .alpha
                }
            }()
        }
    }
    
    
    
    
    override public var bounds: CGRect {
        didSet {
            animaLayer.resizeSuperLayer()
        }
    }
    override public var frame: CGRect {
        didSet {
            animaLayer.resizeSuperLayer()
        }
    }
    override public var backgroundColor: UIColor? {
        didSet {
            if let backgroundColor = backgroundColor {
                animaLayer.setBackgroundColor(backgroundColor)
            }
        }
    }
    
    public var isAnimating = false
    

 
    fileprivate lazy var animaLayer: AnimaLayer = .init(layer: self.layer)
    

    
    // MARK: - initializer -
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setTitleColor(UIColor.red, for: .normal)

    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

    }
    
   
    // MARK: - Public Methods -
    

    public func startAnimating() {
        isAnimating = true
        animaLayer.startAnimating()
    }
    
    public func stopAnimating() {
        isAnimating = false
        animaLayer.stopAnimating()

    }
}






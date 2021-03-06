//
//  SYLabel.swift
//  SYBlinkAnimationKit
//
//  Created by Shohei Yokoyama on 12/13/2015.
//  Copyright © 2015年 Shohei. All rights reserved.
//

import UIKit

@IBDesignable
public class SYLabel: UILabel, AnimatableComponent, TextConvertible {
    
    public enum AnimationType: Int {
        case border, borderWithShadow, background, ripple, text
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
    @IBInspectable public var animationTimingAdapter: Int {
        get {
            return animationTimingFunction.rawValue
        }
        set(index) {
            animationTimingFunction = SYMediaTimingFunction(rawValue: index) ?? .linear
        }
    }
    @IBInspectable public var animationDuration: CGFloat = 1.5 {
        didSet {
            animaLayer.setAnimationDuration(CFTimeInterval(animationDuration))
        }
    }
    @IBInspectable public var labelTextColor: UIColor = .black {
        didSet {
            textColor = UIColor.clear
            textLayer.foregroundColor = labelTextColor.cgColor
            animaLayer.setTextColor(labelTextColor)
        }
    }
    @IBInspectable public var animationAdapter: Int {
        get {
            return animationType.rawValue
        }
        set(index) {
            animationType = AnimationType(rawValue: index) ?? .border
        }
    }
    
    override public var frame: CGRect {
        didSet {
            animaLayer.resizeSuperLayer()
        }
    }
    override public var bounds: CGRect {
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
    override public var text: String? {
        didSet {
            resetTextLayer()
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
                case .text:
                    return .text
                }
            }()
        }
    }
    
    public var isAnimating = false
    
    var textLayer = CATextLayer()
    public var textAlignmentMode: TextAlignmentMode = .center {
        didSet {
            resetTextLayer()
        }
    }
    
    public var animationTimingFunction: SYMediaTimingFunction = .linear {
        didSet {
            animaLayer.setTimingFunction(animationTimingFunction)
        }
    }
    
    fileprivate lazy var animaLayer: AnimaLayer = .init(layer: self.layer)
    
    // MARK: - initializer -
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    // MARK: - Public Methods -

    public func setFont(name fontName: String = ".SFUIText-Medium", ofSize fontSize: CGFloat) -> Self {
        font = UIFont(name: fontName, size: fontSize)
        resetTextLayer()
        return self
    }
    
    public func startAnimating() {
        isAnimating = true
        animaLayer.startAnimating()
    }
    
    public func stopAnimating() {
        isAnimating = false
        animaLayer.stopAnimating()
    }
}

// MARK: - Fileprivate Methods -

fileprivate extension SYLabel {
    
    func configure() {
        layer.cornerRadius = 1.5
        
        textColor      = .clear
        labelTextColor = .black
        
        animaLayer.animationType = .border
    }
    
    func resetTextLayer() {
        configureTextLayer(text, font: font, textColor: labelTextColor)
        animaLayer.resetTextLayer(textLayer)
    }
}

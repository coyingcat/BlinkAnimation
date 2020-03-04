//
//  BlinkBtn.swift
//  SYBlinkAnimationKit
//
//  Created by Shohei Yokoyama on 12/13/2015.
//  Copyright © 2015年 Shohei. All rights reserved.
//

import UIKit

@IBDesignable
public class BlinkBtn: UIButton, AnimatableComponent, TextConvertible {
    public enum AnimationType: Int {
        case border, borderWithShadow, background, ripple, text, opaque
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
                case .text:
                    return .text
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
    
    var textLayer = CATextLayer()
    
    public var textAlignmentMode: TextAlignmentMode = .center {
        didSet {
            resetTextLayer()
        }
    }
    
    fileprivate lazy var animaLayer: AnimaLayer = .init(layer: self.layer)
    
    fileprivate var textColor: UIColor = .black {
        didSet {
            animaLayer.setTextColor(textColor)
        }
    }
    
    // MARK: - initializer -
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    // MARK: - Override Methods -
    
    override public func setTitle(_ title: String?, for state: UIControl.State) {
        super.setTitle(title ?? "", for: state)
        resetTextLayer()
    }
    
    override public func setTitleColor(_ color: UIColor?, for state: UIControl.State) {
        super.setTitleColor(UIColor.clear, for: state)
        
        if let color = color {
            textLayer.foregroundColor = color.cgColor
            textColor = color
        }
    }
    
    // MARK: - Public Methods -
    
    public func setFont(name fontName: String = ".SFUIText-Medium", ofSize fontSize: CGFloat) -> Self {
        titleLabel?.font = UIFont(name: fontName, size: fontSize)
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






// MARK: - File  private Methods -

fileprivate extension BlinkBtn {
    func configure() {
        layer.cornerRadius = 5
        
        let padding: CGFloat = 5
        contentEdgeInsets = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        
        animaLayer.animationType = .border
        
        setTitleColor(.black, for: .normal)
    }
    
    func resetTextLayer() {
        configureTextLayer(currentTitle, font: titleLabel?.font, textColor: textColor)
        animaLayer.resetTextLayer(textLayer)
    }
}


import UIKit

/**
 The internal subclass for CAShapeLayer.
 This is the class that handles all the drawing and animation.
 This class is not interacted with, instead
 properties are set in UICircularRing

 */
class UICircularRingLayer: CAShapeLayer {

    // MARK: Properties
    @NSManaged var val: CGFloat
    
    let ringWidth: CGFloat = 20
    let startAngle = CGFloat(-90).rads
        
    // MARK: Init

    override init() {
        super.init()
    }

    override init(layer: Any) {
        // copy our properties to this layer which will be used for animation
        guard let layer = layer as? UICircularRingLayer else { fatalError("unable to copy layer") }

        super.init(layer: layer)
    }

    required init?(coder aDecoder: NSCoder) { return nil }

    // MARK: Draw

    /**
     Overriden for custom drawing.
     Draws the outer ring, inner ring and val label.
     */
    override func draw(in ctx: CGContext) {
        super.draw(in: ctx)
        UIGraphicsPushContext(ctx)
        // Draw the rings
        drawRing(in: ctx)
        UIGraphicsPopContext()
    }

    // MARK: Animation methods

    /**
     Watches for changes in the val property, and setNeedsDisplay accordingly
     */
    override class func needsDisplay(forKey key: String) -> Bool {
        if key == "val" {
            //  print(1)
            return true
        } else {
            //  print(2)
            return false
            
            //  return super.needsDisplay(forKey: key)
        }
    }

    /**
     Creates animation when val property is changed
     */
    override func action(forKey event: String) -> CAAction? {
        if event == "val"{
            //  print(3)
            let animation = CABasicAnimation(keyPath: "val")
            animation.fromValue = presentation()?.value(forKey: "val")
            animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
            animation.duration = 2
            return animation
        } else {
            //  print(4)
            //  print(super.action(forKey: event))
            return nil
            // return super.action(forKey: event)
        }
    }

   
    /**
     Draws the inner ring for the view.
     Sets path properties according to how the user has decided to customize the view.
     */
    private func drawRing(in ctx: CGContext) {
      
        let center: CGPoint = CGPoint(x: bounds.midX, y: bounds.midY)

        let radiusIn: CGFloat = (min(bounds.width, bounds.height) - ringWidth)/2
        // Start drawing
        let innerPath: UIBezierPath = UIBezierPath(arcCenter: center,
                                                   radius: radiusIn,
                                                   startAngle: startAngle,
                                                   endAngle: toEndAngle,
                                                   clockwise: true)

        // Draw path
        ctx.setLineWidth(ringWidth)
        ctx.setLineJoin(.round)
        ctx.setLineCap(CGLineCap.round)
        ctx.setStrokeColor(UIColor.red.cgColor)
        ctx.addPath(innerPath.cgPath)
        ctx.drawPath(using: .stroke)

    }

 
    var toEndAngle: CGFloat {
        return (val * 160.0).rads + startAngle
    }


}



/**
 A private extension to CGFloat in order to provide simple
 conversion from degrees to radians, used when drawing the rings.
 */
extension CGFloat {
    var rads: CGFloat { return self * CGFloat.pi / 180 }
}

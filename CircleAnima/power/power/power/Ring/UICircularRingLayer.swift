
import UIKit

/**
 The internal subclass for CAShapeLayer.
 This is the class that handles all the drawing and animation.
 This class is not interacted with, instead
 properties are set in UICircularRing and those are delegated to here.

 */
class UICircularRingLayer: CAShapeLayer {

    // MARK: Properties

    @NSManaged var value: CGFloat


    /// the delegate for the value, is notified when value changes
    @NSManaged weak var ring: UICircularRing!

 
    let startAngle = CGFloat(0).rads
        
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
     Draws the outer ring, inner ring and value label.
     */
    override func draw(in ctx: CGContext) {
        super.draw(in: ctx)
        UIGraphicsPushContext(ctx)
        // Draw the rings
        
        drawRing(in: ctx)

        // Call the delegate and notifiy of updated value
   
        UIGraphicsPopContext()

    }

    // MARK: Animation methods

    /**
     Watches for changes in the value property, and setNeedsDisplay accordingly
     */
    override class func needsDisplay(forKey key: String) -> Bool {
        if key == "value" {
            return true
        } else {
            return super.needsDisplay(forKey: key)
        }
    }

    /**
     Creates animation when value property is changed
     */
    override func action(forKey event: String) -> CAAction? {
        if event == "value"{
            let animation = CABasicAnimation(keyPath: "value")
            animation.fromValue = presentation()?.value(forKey: "value")
            animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
            animation.duration = 2
            return animation
        } else {
            return super.action(forKey: event)
        }
    }

   
    /**
     Draws the inner ring for the view.
     Sets path properties according to how the user has decided to customize the view.
     */
    private func drawRing(in ctx: CGContext) {
      
        let center: CGPoint = CGPoint(x: bounds.midX, y: bounds.midY)

        let innerEndAngle = calculateInnerEndAngle().rads
        let radiusIn: CGFloat = (min(bounds.width, bounds.height) / 2) - 10

        // Start drawing
        let innerPath: UIBezierPath = UIBezierPath(arcCenter: center,
                                                   radius: radiusIn,
                                                   startAngle: startAngle,
                                                   endAngle: innerEndAngle,
                                                   clockwise: true)

        // Draw path
        ctx.setLineWidth(20)
        ctx.setLineJoin(.round)
        ctx.setLineCap(CGLineCap.round)
        ctx.setStrokeColor(ring.innerRingColor.cgColor)
        ctx.addPath(innerPath.cgPath)
        ctx.drawPath(using: .stroke)

    }

 


    /// Returns the end angle of the inner ring
    private func calculateInnerEndAngle() -> CGFloat {
     
        return value/50 * 360.0 + startAngle
    }


}



/**
 A private extension to CGFloat in order to provide simple
 conversion from degrees to radians, used when drawing the rings.
 */
extension CGFloat {
    var rads: CGFloat { return self * CGFloat.pi / 180 }
}

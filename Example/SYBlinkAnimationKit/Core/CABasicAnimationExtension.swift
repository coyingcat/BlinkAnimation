//
//  CABasicAnimationExtension.swift
//  Pods
//
//  Created by Shohei Yokoyama on 2016/07/29.
//
//

import UIKit

enum AnimationKeyType: String {
    case borderColor, borderWidth, shadowOpacity, backgroundColor, foregroundColor, opacity
    
    case transformScale  = "transform.scale"
}




extension CABasicAnimation {
    convenience init(type: AnimationKeyType) {
        self.init(keyPath: type.rawValue)
    }
}

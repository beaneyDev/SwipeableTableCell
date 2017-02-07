//
//  SwipeableConformant.swift
//  SwipeableCell
//
//  Created by Matt Beaney on 07/02/2017.
//  Copyright © 2017 Matt Beaney. All rights reserved.
//

import Foundation
import UIKit

class SwipeableConformant: UITableViewCell, SwipeableCell {
    var panClosure: ((UIPanGestureRecognizer) -> ())!
    var pannableContainer: UIView!
    var left: NSLayoutConstraint!
    var right: NSLayoutConstraint!
    var leftResetPosition: CGFloat = 200.0
    var rightResetPosition: CGFloat = 200.0
    var action1: UIView!
    
    func configurePanGestures() -> UIPanGestureRecognizer {
        let pan: UIPanGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(SwipeableConformant.didPan(sender:)))
        return pan
    }
    
    func didPan(sender: UIPanGestureRecognizer) {
        self.pan(sender: sender)
    }
}

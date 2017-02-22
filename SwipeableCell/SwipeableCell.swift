//
//  SwipeableCell.swift
//  SwipeableCell
//
//  Created by Matt Beaney on 07/02/2017.
//  Copyright © 2017 Matt Beaney. All rights reserved.
//

import Foundation
import UIKit

protocol SwipeableCell: class {
    //Pannable container properties
    var pannableContainer: UIView! { get set }
    var left: NSLayoutConstraint! { get set }
    var right: NSLayoutConstraint! { get set }
    var leftResetPosition: CGFloat { get set }
    var rightResetPosition: CGFloat { get set }
    
    //Action properties
    var action1: UIView! { get set }
    var actionWidth: CGFloat { get set }
    
    func createPannable()
    func layout()
    func forcePan(left: CGFloat, right: CGFloat)
    func configurePanGestures() -> UIPanGestureRecognizer
}

extension SwipeableCell where Self: UITableViewCell {
    func configure() {
        createPannable()
        layout()
        self.pannableContainer.addGestureRecognizer(configurePanGestures())
    }
    
    func createPannable() {
        pannableContainer = UIView()
        pannableContainer.backgroundColor = UIColor.yellow
        pannableContainer.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(pannableContainer)
        
        action1 = UIView()
        action1.backgroundColor = UIColor.red
        action1.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(action1)
    }
    
    func layout() {
        //Layout the pannable.
        let height = NSLayoutConstraint.constraints(withVisualFormat: "V:|[pan]|", options: [], metrics: nil, views: ["pan": pannableContainer])
        left = NSLayoutConstraint(item: pannableContainer, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 0.0)
        right = NSLayoutConstraint(item: pannableContainer, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: 0.0)
        
        self.addConstraints(height)
        self.addConstraints([left, right])
        
        //Layout the actions
        let action1Height = NSLayoutConstraint.constraints(withVisualFormat: "V:|[action]|", options: [], metrics: nil, views: ["action": action1])
        let action1Left = NSLayoutConstraint(item: action1, attribute: .leading, relatedBy: .equal, toItem: pannableContainer, attribute: .trailing, multiplier: 1.0, constant: 0.0)
        let action1Width = NSLayoutConstraint(item: action1, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1.0, constant: actionWidth)
        self.addConstraints(action1Height)
        self.addConstraints([action1Width, action1Left])
    }
    
    func pan(sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: self)
        
        //We need to figure out a resting state.
        if sender.state == .ended {
            let resetLeft = left.constant < leftResetPosition && left.constant > 0
            let resetRight = right.constant > rightResetPosition && right.constant < 0
            let presentOptionsLeft = left.constant > leftResetPosition && left.constant > 0
            let presentOptionsRight = right.constant < rightResetPosition && right.constant < 0
            
            print("RIGHT CONSTRAINT: ", right.constant)
            print("LEFT CONSTRAINT: ", left.constant)
            print("RIGHT RESET POSITION: ", rightResetPosition)
            print("LEFT RESET POSITION: ", leftResetPosition)
            
            if resetLeft {
                forcePan()
                print("HIDING LEFT")
            } else if resetRight {
                forcePan()
                print("HIDING RIGHT")
            } else if presentOptionsLeft {
                forcePan(left: 200.0, right: 200.0)
                print("PRESENTING LEFT")
            } else if presentOptionsRight {
                print("PRESENTING RIGHT")
                forcePan(left: -200.0, right: -200.0)
            }
        }
        
        self.left.constant += translation.x
        self.right.constant += translation.x
        sender.setTranslation(CGPoint.zero, in: self)
    }
    
    func forcePan(left: CGFloat = 0.0, right: CGFloat = 0.0) {
        self.left.constant = left
        self.right.constant = right
        
        UIView.animate(withDuration: 0.4, animations: {
            self.layoutIfNeeded()
        })
    }
}

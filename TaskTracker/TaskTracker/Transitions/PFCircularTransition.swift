//
//  PFCircularTransition.swift
//  TaskTracker
//
//  Created by Valeriy Jefimov on 07.07.17.
//  Copyright © 2017 Perfectorium. All rights reserved.
//

import UIKit


let kStartPoint     = "startPoint"
let kCircleColor    = "circleColor"
let kDuration       = "duration"

enum CircularTransitionMode:Int {
    case present, dismiss, pop
}

class CircularTransition: NSObject {
    
    var circle = UIView()
    var startingPoint = CGPoint.zero {
        didSet {
            circle.center = startingPoint
        }
    }
    var circleColor = UIColor.white
    var duration = 0.3
    var transitionMode:CircularTransitionMode = .present
    var presentedView = UIView()
    
}

extension CircularTransition:UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView

        if transitionMode == .present {
            if let presentedView = transitionContext.view(forKey: UITransitionContextViewKey.to) {
                self.presentedView = presentedView
                let viewCenter = presentedView.center
                let viewSize = presentedView.frame.size
                
                circle = UIView()
                
                circle.frame = frameForCircle(withViewCenter: viewCenter, size: viewSize, startPoint: startingPoint)
                
                circle.layer.cornerRadius = circle.frame.size.height / 2
                circle.center = startingPoint
                circle.backgroundColor = circleColor
                circle.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                containerView.addSubview(circle)
                
                
                presentedView.center = startingPoint
                presentedView.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                presentedView.alpha = 0
                containerView.addSubview(presentedView)

                UIView.animate(withDuration: duration, animations: {
                    self.circle.transform = CGAffineTransform.identity
                    presentedView.transform = CGAffineTransform.identity
                    presentedView.alpha = 1
                    presentedView.center = viewCenter
                    
                }, completion: { (success:Bool) in
                    transitionContext.completeTransition(success)
                })
            }
            
        }
        else
        {
            let transitionModeKey   = (transitionMode == .pop) ? UITransitionContextViewKey.to : UITransitionContextViewKey.from
            
            if let returningView    = transitionContext.view(forKey: transitionModeKey) {
                
                let viewCenter      = returningView.center
                let viewSize        = returningView.frame.size
                
                
                circle.frame                = frameForCircle(withViewCenter: viewCenter,
                                                             size: viewSize,
                                                             startPoint: startingPoint)
                
                circle.layer.cornerRadius   = circle.frame.size.height / 2
                circle.center               = startingPoint

                UIView.animate(withDuration: duration, animations: {
                    self.circle.transform   = CGAffineTransform(scaleX: 0.001,
                                                                y: 0.001)
                    returningView.transform = CGAffineTransform(scaleX: 0.001,
                                                                y: 0.001)
                    returningView.center    = self.startingPoint
                    returningView.alpha     = 0
                    containerView.subviews[0].transform = CGAffineTransform(scaleX: 0.001,
                                                                           y: 0.001)
                    if self.transitionMode == .pop
                    {
                        containerView.insertSubview(returningView,
                                                    belowSubview: returningView)
                        containerView.insertSubview(self.circle,
                                                    belowSubview: returningView)
                    }
                    
                    
                }, completion: { (success:Bool) in
                    returningView.center = viewCenter
                    returningView.removeFromSuperview()
                    self.circle.removeFromSuperview()
                    

                    transitionContext.completeTransition(success)
                    
                })
            }
        }
    }
    
    func frameForCircle (withViewCenter viewCenter:CGPoint,
                         size viewSize:CGSize,
                         startPoint:CGPoint) -> CGRect {
        let xLength         = fmax(startPoint.x,
                                   viewSize.width - startPoint.x)
        let yLength         = fmax(startPoint.y,
                                   viewSize.height - startPoint.y)
        
        let offestVector    = sqrt(xLength * xLength + yLength * yLength) * 10
        let size            = CGSize(width: offestVector,
                                     height: offestVector)
        
        return CGRect(origin: CGPoint.zero, size: size)
        
    }
    
}


class PFTransitionHelper: NSObject {

    class func setCustomOptions(options:[String:Any]) -> CircularTransition {
        let transition          = CircularTransition()
        guard let circleColor   = options[kCircleColor] as? UIColor,
        let startingPoint       = options[kStartPoint] as? CGPoint,
        let duration            = options[kDuration] as? Double
        else {
        print("Error by setting custom options")
           return transition
        }
       
        transition.circleColor      = circleColor
        transition.startingPoint    = startingPoint
        transition.duration         = duration
        return transition
    }
    
    
}








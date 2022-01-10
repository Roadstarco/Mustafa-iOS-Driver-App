//
//  UiViewExtension.swift
//  RoadStarRider
//
//  Created by Faizan Ali  on 2021/5/28.
//  Copyright © 2021 Faizan Ali . All rights reserved.
//

import Foundation
import UIKit

extension UIView{
    //Configured with bitbucket repo

    func addTopBorder(with color: UIColor?, andWidth borderWidth: CGFloat) {
        let border = UIView()
        border.backgroundColor = color
        border.autoresizingMask = [.flexibleWidth, .flexibleBottomMargin]
        border.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: borderWidth)
        addSubview(border)
    }

    func addBottomBorder(with color: UIColor?, andWidth borderWidth: CGFloat) {
        let border = UIView()
        border.backgroundColor = color
        border.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
        border.frame = CGRect(x: 0, y: frame.size.height - borderWidth, width: frame.size.width, height: borderWidth)
        addSubview(border)
    }

    func addLeftBorder(with color: UIColor?, andWidth borderWidth: CGFloat) {
        let border = UIView()
        border.backgroundColor = color
        border.frame = CGRect(x: 0, y: 0, width: borderWidth, height: frame.size.height)
        border.autoresizingMask = [.flexibleHeight, .flexibleRightMargin]
        addSubview(border)
    }

    func addRightBorder(with color: UIColor?, andWidth borderWidth: CGFloat) {
        let border = UIView()
        border.backgroundColor = color
        border.autoresizingMask = [.flexibleHeight, .flexibleLeftMargin]
        border.frame = CGRect(x: frame.size.width - borderWidth, y: 0, width: borderWidth, height: frame.size.height)
        addSubview(border)
    }
    
    
    func roundedCorners2(corners : UIRectCorner, radius : CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
                let mask = CAShapeLayer()
                mask.path = path.cgPath
                layer.mask = mask
    }
    func roundCorners(with CACornerMask: CACornerMask, radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.maskedCorners = [CACornerMask]
    }
    
    
    func borders(for edges:[UIRectEdge], width:CGFloat = 1, color: UIColor = .black) {

            if edges.contains(.all) {
                layer.borderWidth = width
                layer.borderColor = color.cgColor
            } else {
                let allSpecificBorders:[UIRectEdge] = [.top, .bottom, .left, .right]

                for edge in allSpecificBorders {
                    if let v = viewWithTag(Int(edge.rawValue)) {
                        v.removeFromSuperview()
                    }

                    if edges.contains(edge) {
                        let v = UIView()
                        v.tag = Int(edge.rawValue)
                        v.backgroundColor = color
                        v.translatesAutoresizingMaskIntoConstraints = false
                        addSubview(v)

                        var horizontalVisualFormat = "H:"
                        var verticalVisualFormat = "V:"

                        switch edge {
                        case UIRectEdge.bottom:
                            horizontalVisualFormat += "|-(0)-[v]-(0)-|"
                            verticalVisualFormat += "[v(\(width))]-(0)-|"
                        case UIRectEdge.top:
                            horizontalVisualFormat += "|-(0)-[v]-(0)-|"
                            verticalVisualFormat += "|-(0)-[v(\(width))]"
                        case UIRectEdge.left:
                            horizontalVisualFormat += "|-(0)-[v(\(width))]"
                            verticalVisualFormat += "|-(0)-[v]-(0)-|"
                        case UIRectEdge.right:
                            horizontalVisualFormat += "[v(\(width))]-(0)-|"
                            verticalVisualFormat += "|-(0)-[v]-(0)-|"
                        default:
                            break
                        }

                        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: horizontalVisualFormat, options: .directionLeadingToTrailing, metrics: nil, views: ["v": v]))
                        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: verticalVisualFormat, options: .directionLeadingToTrailing, metrics: nil, views: ["v": v]))
                    }
                }
            }
        }

    
}

 
 extension CALayer {

 func addBorder(edge: UIRectEdge, color: UIColor, thickness: CGFloat) {

     let border = CALayer();

     switch edge {
     case UIRectEdge.top:
        border.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: thickness);
         break
     case UIRectEdge.bottom:
        border.frame = CGRect(x: 0, y: self.frame.height - thickness, width: self.frame.width, height: thickness)
         break
     case UIRectEdge.left:
        border.frame = CGRect(x: 0, y: 0, width: thickness, height: self.frame.height)
         break
     case UIRectEdge.right:
        border.frame = CGRect(x: self.frame.width - thickness, y: 0, width: thickness, height: self.frame.height)
         break
     default:
         break
     }

    border.backgroundColor = color.cgColor;

     self.addSublayer(border)
 }

 }
 
//extension UIView{
//    func EmptyAddressView() -> EmptyAddressView {
//        return UINib(nibName: "EmptyAddressView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! EmptyAddressView
//    }
//    func EmptyCartView() -> EmptyCartView {
//        return UINib(nibName: "EmptyCartView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! EmptyCartView
//    }
////    func EmptyCategoryView() -> EmptyCategoryView {
////        return UINib(nibName: "EmptyCategoryView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! EmptyCategoryView
////    }
//
//    func EmptyReviewView() -> EmptyReviewView {
//        return UINib(nibName: "EmptyReviewView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! EmptyReviewView
//    }
//    func EmptyWishlistView() -> EmptyWishlistView {
//        return UINib(nibName: "EmptyWishlistView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! EmptyWishlistView
//    }
//
//    func ServerErrorView() -> ServerErrorView {
//        return UINib(nibName: "ServerErrorView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! ServerErrorView
//    }
//
//}

extension UIView {
    
    func addDashedBorder() {
        let path = UIBezierPath()
        // >> define the pattern & apply it
        let dashPattern: [CGFloat] = [4.0, 4.0]
        path.setLineDash(dashPattern, count: dashPattern.count, phase: 0)
        // <<
        path.lineWidth = 1
        
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: 100, y: 100))
        path.stroke()
    }
    
    func addDashBorder(color:UIColor, cornerRadius: CGFloat) {
        let color = color.cgColor

        let shapeLayer:CAShapeLayer = CAShapeLayer()

        let frameSize = self.frame.size
        let shapeRect = CGRect(x: 0, y: 0, width: frameSize.width, height: frameSize.height)

        shapeLayer.bounds = shapeRect
        shapeLayer.name = "DashBorder"
        shapeLayer.position = CGPoint(x: frameSize.width/2, y: frameSize.height/2)
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = color
        shapeLayer.lineWidth = 1.5
        shapeLayer.lineJoin = .round
        shapeLayer.lineDashPattern = [2,4]
        shapeLayer.path = UIBezierPath(roundedRect: shapeRect, cornerRadius: cornerRadius).cgPath

        self.layer.masksToBounds = true

        self.layer.addSublayer(shapeLayer)
    }
}

extension UIView {
    func addDashedLine(color: UIColor = .lightGray) {
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.lineWidth = 4
        // passing an array with the values [2,3] sets a dash pattern that alternates between a 2-user-space-unit-long painted segment and a 3-user-space-unit-long unpainted segment
        shapeLayer.lineDashPattern = [5,3]
        
        let path = CGMutablePath()
        path.addLines(between: [CGPoint(x: 0, y: 0),
                                CGPoint(x: self.frame.width, y: 0)])
        shapeLayer.path = path
        layer.addSublayer(shapeLayer)
    }
}

extension UIView {
    func shake(){
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = 3
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 5, y: self.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 5, y: self.center.y))
        self.layer.add(animation, forKey: "position")
    }
    
    @IBInspectable var shadow: Bool {
        get {
            return layer.shadowOpacity > 0.0
        }
        set {
            if newValue == true {
                self.addShadow()
            }
        }
    }

    @IBInspectable var theCornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue

            // Don't touch the masksToBound property if a shadow is needed in addition to the cornerRadius
            if shadow == false {
                self.layer.masksToBounds = true
            }
        }
    }
    
    @IBInspectable var TheBorderWidth: CGFloat {
            get {
                return layer.borderWidth
            }
            set {
                layer.borderWidth = newValue
            }
        }

    @IBInspectable var TheBorderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }

    func addShadow(shadowColor: CGColor = UIColor.black.cgColor,
               shadowOffset: CGSize = CGSize(width: 1.0, height: 2.0),
               shadowOpacity: Float = 0.4,
               shadowRadius: CGFloat = 3.0) {
        layer.shadowColor = shadowColor
        layer.shadowOffset = shadowOffset
        layer.shadowOpacity = shadowOpacity
        layer.shadowRadius = shadowRadius
    }
//    enum cornerSide {
//        case left,right,top,bottom
//    }
    func roundCorners(_ corners: CACornerMask, radius: CGFloat, borderColor: UIColor, borderWidth: CGFloat) {
        
           self.layer.maskedCorners = corners
           self.layer.cornerRadius = radius
           self.layer.borderWidth = borderWidth
           self.layer.borderColor = borderColor.cgColor
    }
    
    @IBInspectable var shadowColor: UIColor?{
            set {
                guard let uiColor = newValue else { return }
                layer.shadowColor = uiColor.cgColor
            }
            get{
                guard let color = layer.shadowColor else { return nil }
                return UIColor(cgColor: color)
            }
        }

        @IBInspectable var shadowOpacity: Float{
            set {
                layer.shadowOpacity = newValue
            }
            get{
                return layer.shadowOpacity
            }
        }

        @IBInspectable var shadowOffset: CGSize{
            set {
                layer.shadowOffset = newValue
            }
            get{
                return layer.shadowOffset
            }
        }

        @IBInspectable var shadowRadius: CGFloat{
            set {
                layer.shadowRadius = newValue
            }
            get{
                return layer.shadowRadius
            }
        }
}

 

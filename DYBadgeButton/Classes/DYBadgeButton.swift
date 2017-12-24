//
//  DYBadgeButton.swift
//  Flat Chat
//
//  Created by Dominik Butz on 16.12.17.
//  Copyright © 2017 Duoyun. All rights reserved.
//

import UIKit

extension UIButton {
    
    func alignImageAndTitleVertically(padding: CGFloat = 6.0) {
        
        let imageSize = self.imageView!.frame.size
        self.titleLabel?.sizeToFit()
        self.titleLabel?.textAlignment = .center
        
        let titleSize = self.titleLabel!.frame.size
        let totalHeight = imageSize.height + titleSize.height + padding
        print("image height: \(imageSize.height)")
        print("total height: \(totalHeight)")
        
        self.imageEdgeInsets = UIEdgeInsets(
            top: -(totalHeight - imageSize.height),
            left: 0,
            bottom: 0,
            right: -titleSize.width
        )
        
        self.titleEdgeInsets = UIEdgeInsets(
            top: 0,
            left: -imageSize.width,
            bottom: -(totalHeight - titleSize.height),
            right: 0
        )
    }
}

@IBDesignable public class DYBadgeButton: UIButton {

    var badge: UILabel = UILabel()

    
   @IBInspectable open var badgeString:String? {
        didSet{
            self.badge.text = badgeString
            print("badge string \(badgeString)")
            self.setBadgeSizeAndFrame()

            var transform: CGAffineTransform?
            var shouldHide: Bool?
            
            if self.badge.isHidden && self.badgeHasValue() {
                // is hidden but should appear
                transform = CGAffineTransform.identity
                shouldHide = false
          
            }
            
            else if self.badge.isHidden == false && self.badgeHasValue() == false {
                // should disappear
                transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
                shouldHide = true

            } else {
               
                return
            }
            print("animating badge")
            self.animateBadge(shouldHide: shouldHide!,transform: transform!)

        }
    }
    
   open var badgeFont: UIFont = UIFont(name: "Helvetica Neue", size: 9.0)! {
        didSet {
            self.badge.font = badgeFont
            self.setBadgeSizeAndFrame()
        }
    }
    
   @IBInspectable open var badgeColor: UIColor = UIColor.red {
        didSet {
            self.badge.backgroundColor = badgeColor
        }
    }
    
  @IBInspectable open var badgeTextColor: UIColor = UIColor.white {
        didSet {
            self.badge.textColor = badgeTextColor
        }
    }
    
    @IBInspectable  open var xOffset: CGFloat = 0.0 {
        didSet {
            self.setBadgeSizeAndFrame()
        }
    }
    
    @IBInspectable open var yOffset: CGFloat = 0.0 {
        didSet {
            self.setBadgeSizeAndFrame()
        }
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupBadge()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupBadge()
    }

    public convenience init(frame: CGRect,badgeXoffset: CGFloat?, badgeYoffset: CGFloat?) {
        self.init(frame: frame)

        self.setupBadge()
    }
    
    
   public class func createDYImageTitleButton(image: UIImage, title: String, font: UIFont, frame: CGRect, tintColor: UIColor)->DYBadgeButton {

        let button = DYBadgeButton(frame: frame)
        button.contentMode = .scaleAspectFit
        button.setImage(image, for: .normal)
        button.imageView!.contentMode = .scaleAspectFit
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = font
        button.tintColor =  tintColor
        button.setTitleColor(tintColor, for: .normal)
        button.alignImageAndTitleVertically(padding: 0)
        button.setupBadge()
        
        return button
    }
    
    
    private func setupBadge() {

        self.badge.font = self.badgeFont
        self.badge.textAlignment = .center
     
        self.badge.backgroundColor = self.badgeColor
        self.badge.textColor = self.badgeTextColor
        
        self.setBadgeSizeAndFrame()
        self.badge.clipsToBounds = true
        self.badge.layer.cornerRadius = self.badge.bounds.height / 2.0

        self.badge.isHidden = !self.badgeHasValue()
       // self.badge.transform = self.badgeHasValue() ?  CGAffineTransform.identity : CGAffineTransform(scaleX: 0.01, y: 0.01)
    //    print("setup badge is hidden? \(self.badge.isHidden)")
        self.addSubview(self.badge)

    }
    

    private func setBadgeSizeAndFrame() {
        
        let sizeLabel = UILabel()
        sizeLabel.text = self.badgeHasValue() ? self.badgeString : "XX"
        sizeLabel.font = self.badgeFont
        sizeLabel.sizeToFit()
        let badgeSize = sizeLabel.frame.size
        
        let positionX = self.bounds.size.width
        print("button width \(positionX)")
        let positionY = self.bounds.origin.y
        print("button oriigin y \(positionY)")
        
        self.badge.transform = CGAffineTransform.identity
        
        self.badge.frame = CGRect(x: positionX + self.xOffset, y: positionY + self.yOffset, width: badgeSize.width + 8.0, height: badgeSize.height + 2.0)
        
        
        print("badge width: \(self.badge.frame.size.width)")
        print("badge origin x \(self.badge.frame.origin.x), origin y \(self.badge.frame.origin.y)")

    }
    
    private func badgeHasValue()-> Bool {
        
        return badgeString != nil  && badgeString != "0" && badgeString != ""
    }
    
    private func animateBadge(shouldHide: Bool, transform: CGAffineTransform) {
        print("animating badge")
        let springValue:CGFloat = shouldHide ? 0.4 : 0.0
        


        UIView.animate(withDuration: 0.3, delay: 0.0, usingSpringWithDamping: springValue, initialSpringVelocity: 0.1, options: [], animations: {
            if shouldHide == false {
                
                self.badge.isHidden = false
            }
            self.badge.transform = transform
            
        }) { (completed) in

            if shouldHide {
                self.badge.isHidden = true
            }
        }
    }

}

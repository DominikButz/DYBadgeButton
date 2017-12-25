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

public class DYBadgeButton: UIButton {

    private var badge: UILabel = UILabel()

    /// The text of the badge
    open var badgeString:String? {
        didSet{
            
            let wasNullishBefore = self.isNullish(self.badge.text)
            
            self.badge.text = badgeString

            self.setBadgeSizeAndFrame(animated: !wasNullishBefore)

            var transform: CGAffineTransform?
            var shouldHide: Bool?
            
            if self.badge.isHidden && self.isNullish(badgeString) == false {
                // is hidden but should appear
                self.badge.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
                transform = CGAffineTransform.identity
                shouldHide = false
          
            }
            
            else if self.badge.isHidden == false && self.isNullish(badgeString) {
                // should disappear
                transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
                shouldHide = true

            } else {
             
                return
            }
    
            self.animateBadgeTransform(shouldHide: shouldHide!,transform: transform!)

        }
    }
    /// The font of the badge text
   open var badgeFont: UIFont = UIFont(name: "Helvetica Neue", size: 9.0)! {
        didSet {
            self.badge.font = badgeFont
            self.setBadgeSizeAndFrame(animated: false)
        }
    }
    
    /// The background color of the badge
   open var badgeColor: UIColor = UIColor.red {
        didSet {
            self.badge.backgroundColor = badgeColor
        }
    }
    /// The text color of the badge
  open var badgeTextColor: UIColor = UIColor.white {
        didSet {
            self.badge.textColor = badgeTextColor
        }
    }
    
    /// Position x offset of the badge.
    open var xOffset: CGFloat = 0.0 {
        didSet {
            self.setBadgeSizeAndFrame(animated: false)
        }
    }
    
     /// Position y offset of the badge.
    open var yOffset: CGFloat = 0.0 {
        didSet {
            self.setBadgeSizeAndFrame(animated: false)
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

    /// createDYImageTitleButton - class function to create a DYBadgeButton with image and button title
    ///
    /// - Parameters:
    ///   - image: the button image
    ///   - title: the title of the button title label
    ///   - font: the text font of the button title label
    ///   - frame: the frame of the button image view
    ///   - tintColor: the button tint color (for the image view and the title)
   public class func createDYImageTitleButton(image: UIImage, title: String, font: UIFont, frame: CGRect, tintColor: UIColor?)->DYBadgeButton {

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
        
        self.setBadgeSizeAndFrame(animated: false)

        self.badge.isHidden = self.isNullish(badgeString)

        self.addSubview(self.badge)

    }
    

    private func setBadgeSizeAndFrame(animated: Bool) {
        
        if self.isNullish(badgeString) {
            return
        }
        
        let sizeLabel = UILabel()
        sizeLabel.text = self.badgeString!
        sizeLabel.font = self.badgeFont
        sizeLabel.sizeToFit()
        let badgeSize = sizeLabel.frame.size
    
        let positionX = self.bounds.size.width
        let positionY = self.bounds.origin.y

        self.badge.transform = CGAffineTransform.identity
        
        let frame = CGRect(x: positionX + self.xOffset, y: positionY + self.yOffset, width: badgeSize.width + 8.0, height: badgeSize.height + 2.0)
        
        if animated {
            UIView.animate(withDuration: 0.1) {
                self.badge.frame = frame
                self.badge.layer.cornerRadius = self.badge.bounds.height / 2.0
            }
        } else {
        
            self.badge.frame = frame
            self.badge.layer.cornerRadius = self.badge.bounds.height / 2.0

        }
        
          self.badge.clipsToBounds = true

    }
    
    private func isNullish(_ stringValue: String?)-> Bool {
        
        if stringValue == nil {
            return true
        }
        
        let stringWithoutWhitespaces = stringValue!.components(separatedBy: .whitespaces).joined()
        
        if stringWithoutWhitespaces == "" {
            return true
        }
        
        let intValue = Int(stringWithoutWhitespaces)
        
        if intValue == 0 {
            return true
        }
        
        return false

    }
    
    private func animateBadgeTransform(shouldHide: Bool, transform: CGAffineTransform) {

        let springValue:CGFloat = shouldHide ? 0.0 : 0.4
        
        if shouldHide == false {
        
            self.badge.isHidden = false
  
        }

        UIView.animate(withDuration: 0.3, delay: 0.0, usingSpringWithDamping: springValue, initialSpringVelocity: 0.0, options: [], animations: {
            self.badge.transform = transform
            
        }) { (completed) in

            if shouldHide {
                self.badge.isHidden = true
            }
        }
    }

}

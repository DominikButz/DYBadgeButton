//
//  ViewController.swift
//  DYBadgeButton
//
//  Created by dominikbutz on 12/24/2017.
//  Copyright (c) 2017 dominikbutz. All rights reserved.
//

import UIKit
import DYBadgeButton

class ViewController: UIViewController {
    
    @IBOutlet weak var firstSlider: UISlider!
    @IBOutlet weak var secondSlider: UISlider!
    
    @IBOutlet weak var firstButton: DYBadgeButton!
    
    @IBOutlet weak var secondButtonItem: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.firstSlider.isContinuous = false
        
//        let frame =  CGRect(x: 0, y: 0, width: 25.0, height: 26.0)
//        let font = UIFont(name: "Helvetica Neue", size: 11.0)!
//        let color = self.view.tintColor
//        let filterButton  = DYBadgeButton.createDYImageTitleButton(image: #imageLiteral(resourceName: "filterButton"), title: "Filter", font: font, frame: frame, tintColor: color!)
//        filterButton.badgeColor = color!
//        filterButton.xOffset = -10.0
//        filterButton.yOffset = -5.0
//        self.secondButtonItem.customView = filterButton

        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func sliderValueDidChange(_ sender: UISlider) {
        
        if sender == self.firstSlider {
            self.firstButton!.badgeString = "\(Int(sender.value))"
            
        } else {
            // second slider
            let filterButton = self.secondButtonItem.customView as! DYBadgeButton
            filterButton.badgeString = "\(Int(sender.value))"
            
        }
        
    }

}


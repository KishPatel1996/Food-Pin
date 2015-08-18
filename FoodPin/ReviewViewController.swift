//
//  ReviewViewController.swift
//  FoodPin
//
//  Created by Kishan Patel on 8/14/15.
//  Copyright (c) 2015 Kishan Patel. All rights reserved.
//

import UIKit

class ReviewViewController: UIViewController {

    @IBOutlet weak var backgroundImageView: UIImageView!
    
    @IBOutlet weak var dialogView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        var blurEffect = UIBlurEffect(style: .Dark)
        var blurEffectView = UIVisualEffectView(effect: blurEffect)
        
        blurEffectView.frame = view.bounds
        
        backgroundImageView.addSubview(blurEffectView)
        
        let scale = CGAffineTransformMakeScale(0.0, 0.0)
        let translate = CGAffineTransformMakeTranslation(0.0, 500)
        
        dialogView.transform = CGAffineTransformConcat(scale, translate)
        
    }
    
    override func viewDidAppear(animated: Bool) {
        UIView.animateWithDuration(0.7, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: UIViewAnimationOptions.CurveEaseInOut, animations: { [unowned self] () -> Void in
            let translate = CGAffineTransformMakeTranslation(0.0, 0.0)
            let scale = CGAffineTransformMakeScale(1.0, 1.0)
            self.dialogView.transform = CGAffineTransformConcat(translate, scale)
        }, completion: nil)
    }
}

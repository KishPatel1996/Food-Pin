//
//  ShareViewController.swift
//  FoodPin
//
//  Created by Kishan Patel on 8/14/15.
//  Copyright (c) 2015 Kishan Patel. All rights reserved.
//

import UIKit

class ShareViewController: UIViewController {

    @IBOutlet weak var backgroundImageView: UIImageView!
    
    @IBOutlet weak var facebookShareButton: UIButton!
    @IBOutlet weak var twitterShareButton: UIButton!
    @IBOutlet weak var messageShareButton: UIButton!
    @IBOutlet weak var emailShareButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        facebookShareButton.hidden = true
        twitterShareButton.hidden = true
        messageShareButton.hidden = true
        emailShareButton.hidden = true
        
        let blurEffect = UIBlurEffect(style: .Dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        backgroundImageView.addSubview(blurEffectView)
        
        let translateUp = CGAffineTransformMakeTranslation(0, -500)
        let translateDown = CGAffineTransformMakeTranslation(0, 500)
        
        facebookShareButton.transform = translateDown
        messageShareButton.transform = translateDown
        twitterShareButton.transform = translateUp
        emailShareButton.transform = translateUp
        
        
    }
    
    @IBAction func close(segue: UIStoryboardSegue!) {
        
        
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
        super.viewDidAppear(animated)
        
        
        facebookShareButton.hidden = false
        twitterShareButton.hidden = false
        messageShareButton.hidden = false
        emailShareButton.hidden = false
        
        
        UIView.animateWithDuration(0.6, delay: 0.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { [unowned self] () -> Void in
            self.facebookShareButton.transform = CGAffineTransformMakeTranslation(0, 0)
            }, completion: nil)
        
        UIView.animateWithDuration(0.6, delay: 0.05, options: UIViewAnimationOptions.CurveEaseInOut, animations: { [unowned self] () -> Void in
            self.emailShareButton.transform = CGAffineTransformMakeTranslation(0, 0)
            }, completion: nil)
        
        UIView.animateWithDuration(0.6, delay: 0.15, options: UIViewAnimationOptions.CurveEaseInOut, animations: { [unowned self] () -> Void in
            self.messageShareButton.transform = CGAffineTransformMakeTranslation(0, 0)
            }, completion: nil)
        
        UIView.animateWithDuration(0.6, delay: 0.1, options: UIViewAnimationOptions.CurveEaseInOut, animations: { [unowned self] () -> Void in
            self.twitterShareButton.transform = CGAffineTransformMakeTranslation(0, 0)
            }, completion: nil)
    }
}

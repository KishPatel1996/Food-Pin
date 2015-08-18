//
//  AboutViewController.swift
//  FoodPin
//
//  Created by Kishan Patel on 8/17/15.
//  Copyright (c) 2015 Kishan Patel. All rights reserved.
//

import UIKit
import MessageUI

class AboutViewController: UIViewController, MFMailComposeViewControllerDelegate, UINavigationControllerDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func mailComposeController(controller: MFMailComposeViewController!, didFinishWithResult result: MFMailComposeResult, error: NSError!) {
        switch result.value {
        case MFMailComposeResultCancelled.value:
            println("mail cancelled")
            
        case MFMailComposeResultSaved.value:
            println("mail saved")
            
        case MFMailComposeResultSent.value:
            println("mail sent")
            
        case MFMailComposeResultFailed.value:
            println("Failed to send mail")
            
        default:
            break
        }
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    @IBAction func sendEmail(sender: AnyObject) {
        if MFMailComposeViewController.canSendMail() {
            var composer = MFMailComposeViewController()
            
            composer.mailComposeDelegate = self
            composer.setToRecipients(["support@appcoda.com"])
            composer.navigationBar.tintColor = UIColor.whiteColor()
            
            presentViewController(composer, animated: true, completion: nil)
            
            UIApplication.sharedApplication().setStatusBarStyle(.LightContent, animated: false)
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        UIBarButtonItem.appearance().tintColor = UIColor.whiteColor()
    }

}

//
//  AddTableViewController.swift
//  FoodPin
//
//  Created by Kishan Patel on 8/15/15.
//  Copyright (c) 2015 Kishan Patel. All rights reserved.
//

import UIKit
import CoreData
import CloudKit

class AddTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var noButton: UIButton!
    @IBOutlet weak var yesButton: UIButton!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var typeTextField: UITextField!
    @IBOutlet weak var cancelBarButton: UIBarButtonItem!
    @IBOutlet weak var saveBarButton: UIBarButtonItem!
    @IBOutlet weak var imageView: UIImageView!
    
    var restaurant: Restaurant!
    
    
    
    var beenThere: Bool = true
    
    
    var buttonClickColor: UIColor!
    var buttonNotClickedColor: UIColor!
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 0 {
            if UIImagePickerController.isSourceTypeAvailable(.PhotoLibrary) {
                let imagePicker = UIImagePickerController()
                imagePicker.allowsEditing = true
                imagePicker.sourceType = .PhotoLibrary
                imagePicker.delegate = self
                
                presentViewController(imagePicker, animated: true, completion: nil)
            }
        }
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        imageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        imageView.contentMode = UIViewContentMode.ScaleAspectFill
        imageView.clipsToBounds = true
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    @IBAction func save(sender: UIBarButtonItem) {
        if performCheck() {
            println("Name: \(nameTextField.text)")
            println("Location: \(locationTextField.text)")
            println("Type: \(typeTextField.text)")
            println("Been there: \(beenThere)")
            
            if let manageedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext {
                restaurant = NSEntityDescription.insertNewObjectForEntityForName("Restaurant", inManagedObjectContext: manageedObjectContext) as! Restaurant
                restaurant.name = nameTextField.text
                restaurant.location = locationTextField.text
                restaurant.type = typeTextField.text
                restaurant.image = UIImagePNGRepresentation(imageView.image)
                restaurant.isVisited = beenThere
                saveRecordToTheCloud(restaurant)
                
                var e: NSError?
                if manageedObjectContext.save(&e) != true {
                    println("insert error: \(e!.localizedDescription)")
                    return
                }
            }
            
            performSegueWithIdentifier("unwindToHomeScreen", sender: self)
        }
        
        
    }
    
    func performCheck() -> Bool {
        if nameTextField.text == "" {
            printErrorMessage("restaurant name")
            return false
        } else if typeTextField.text == "" {
            printErrorMessage("restaurant type")
            return false
        } else if locationTextField.text == "" {
            printErrorMessage("restaurant location")
            return false
        } else {
            return true
        }
            
        
        
        
    }
    func printErrorMessage(fieldName: String) {
        
        let alert = UIAlertController(title: "Oops", message: "We can't proceed as you forgot to fill in the \(fieldName). All Field are mandatory", preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
        
        presentViewController(alert, animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cancelBarButton.tintColor = UIColor.whiteColor()
        saveBarButton.tintColor = UIColor.whiteColor()
        
        buttonClickColor = yesButton.backgroundColor!
        buttonNotClickedColor = noButton.backgroundColor!
    }
    @IBAction func yesClicked() {
        beenThere = true
        yesButton.backgroundColor = buttonClickColor
        noButton.backgroundColor = buttonNotClickedColor
    }

    @IBAction func noClicked() {
        
        beenThere = false
        yesButton.backgroundColor = buttonNotClickedColor
        noButton.backgroundColor = buttonClickColor
    }
    
    
    func saveRecordToTheCloud(restaurant: Restaurant!)  {
        var record = CKRecord(recordType: "Restaurant")
        record.setValue(restaurant.name, forKey: "Name")
        record.setValue(restaurant.type, forKey: "type")
        record.setValue(restaurant.location, forKey: "location")
        
        var originalImage = UIImage(data: restaurant.image)
        var scalingFactor = (originalImage!.size.width > 1024) ? 1024 / originalImage!.size.width : 1.0
        var scaledImage = UIImage(data: restaurant.image, scale: scalingFactor)
        let imageFilePath = NSTemporaryDirectory() + restaurant.name
        UIImageJPEGRepresentation(scaledImage, 0.8).writeToFile(imageFilePath, atomically: true)
        
        let imageFileURL = NSURL(fileURLWithPath: imageFilePath)
        var imageAsset = CKAsset(fileURL: imageFileURL!)
        record.setValue(imageAsset, forKey: "image")
        
        let cloudContainer = CKContainer.defaultContainer()
        let publicDatabase = CKContainer.defaultContainer().publicCloudDatabase
        publicDatabase.saveRecord( record, completionHandler: { (record, error) -> Void in
            NSFileManager.defaultManager().removeItemAtPath(imageFilePath, error: nil)
            
            if error != nil {
                println("Failed to save record to the cloud - \(error.description)")
            }
        })
        
    }
}

//
//  ContactedListViewController.swift
//  TextUnsend
//
//  Created by Amaha985 Gmail on 12/14/15.
//  Copyright © 2015 FreeApps. All rights reserved.
//

import UIKit
import Contacts
import ContactsUI

class ContactedListViewController: UIViewController, CNContactPickerDelegate {

    @IBOutlet weak var contactedListTable: UITableView!
    
    
    @IBAction func contactPicked(sender: UIBarButtonItem) {
        
        let contactPickerViewController = CNContactPickerViewController()
        contactPickerViewController.delegate = self

        AppDelegate.getAppDelegate().requestForAccess{ (accessGranted) -> Void in

            if accessGranted{
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    
            self.presentViewController(contactPickerViewController, animated: true, completion: nil)
                    
                    
                })
                
            }
        
        }
    
        
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

             
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
       // MARK: - TAble data delegate
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell =
        tableView.dequeueReusableCellWithIdentifier("Cell",
            forIndexPath: indexPath)
        
        
        cell.textLabel?.text = "MEhhh"
        
        return cell
        
    }
    
        
    
    // MARK: - Seguae
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if let nc = segue.destinationViewController as? TextedListViewController{
            
            
            nc.nameandPhone = " Assaye Assefa"
            
            
        }
    }
         // MARK: - Contact picker delegate
        
        func contactPicker(picker: CNContactPickerViewController, didSelectContact contact: CNContact) {

            
            let firstLast = CNContactFormatter.stringFromContact(contact, style: .FullName)
                
    print ("printing....first and Last," , firstLast)
            
        
        
            for homephone in contact.phoneNumbers{
                
               
                
               print ("printing....," , homephone.label ,".....vs..",CNLabelHome )
                if (homephone.label == CNLabelHome) {
                    
  
                  let  homephoneonr = homephone.value as! CNPhoneNumber
                    
                    print ("printing....temp..," ,homephoneonr.valueForKey("digits")  )

                    
                    
                    
            
                }
            }
            
            
      
            
            
            
        }
        

        
        
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}


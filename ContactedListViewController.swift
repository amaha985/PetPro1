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
import CoreData

class ContactedListViewController: UIViewController, CNContactPickerDelegate, NSFetchedResultsControllerDelegate,UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var contactedListTable: UITableView!
    
    lazy var fetchedResultController: NSFetchedResultsController =
    self.contactfetchedResultController()
    
    
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
        return  fetchedResultController.sections![section].numberOfObjects
    }

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        let cell =
        tableView.dequeueReusableCellWithIdentifier("Cell",
            forIndexPath: indexPath)
        
        
        
        
        
       let contact = fetchedResultController.objectAtIndexPath(indexPath) as! Contacts
      
       cell.textLabel?.text = contact.fullName
      cell.detailTextLabel?.text = contact.phoneNumber
        
        
        
        
        return cell
        
    }
    
//    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
//        
//        
//        
//        
//         let contact = fetchedResultController.objectAtIndexPath(indexPath) as! Contacts
//        
//        
//        
//        performSegueWithIdentifier("pushtoTextedList", sender: indexPath)
//        
//    }
    
    
     func tableView(tableView: UITableView,
        commitEditingStyle editingStyle: UITableViewCellEditingStyle,
        forRowAtIndexPath indexPath: NSIndexPath) {
            
            if editingStyle == .Delete {
                let contactEntry =
                fetchedResultController.objectAtIndexPath(indexPath)
                    as! Contacts
                AppDelegate.getAppDelegate().managedObjectContext.deleteObject(contactEntry)
                AppDelegate.getAppDelegate().saveContext()
            }
    }

    
   
    
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
       return  true
    }
    
    
    
    // MARK: - Seguae
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        
        if segue.identifier == "pushtoTextedList"{
            
            let indexPath = contactedListTable.indexPathForSelectedRow
            let ContactEntry =
            fetchedResultController.objectAtIndexPath(
                indexPath!) as! Contacts
            
        
        if let nc = segue.destinationViewController as? TextedListViewController{
            
            
           // nc.nameandPhone = (ContactEntry.fullName!,ContactEntry.phoneNumber!)
            nc.contact = ContactEntry
            
            }
        }
    }
         // MARK: - Contact picker delegate
        
        func contactPicker(picker: CNContactPickerViewController, didSelectContact contact: CNContact) {

            
            let firstLast = CNContactFormatter.stringFromContact(contact, style: .FullName)
                
    print ("printing....first and Last," , firstLast)
            
            var  contactNumber : String = ""
        
            for homephone in contact.phoneNumbers{
                
               
                
               print ("printing....," , homephone.label ,".....vs..",CNLabelHome )
                if (homephone.label == CNLabelHome) {
                    
  
                  let  homephoneonr = homephone.value as! CNPhoneNumber
                   contactNumber =  homephoneonr.valueForKey("digits") as! String
                    
                  
            
                }
            }
         
            
              print ("printing....first last..," ,firstLast, "printing....phone no..,",contactNumber  )
            
            
            
            let entity = NSEntityDescription.entityForName("Contacts", inManagedObjectContext: AppDelegate.getAppDelegate().managedObjectContext)
            
            let aContact = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: AppDelegate.getAppDelegate().managedObjectContext) as! Contacts
            
            aContact.fullName = firstLast!
            aContact.phoneNumber = contactNumber
            
           AppDelegate.getAppDelegate().saveContext()
            
            contactedListTable.reloadData()
            
            
        }
        

   // MARK: - Core data

    func contactfetchedResultController() -> NSFetchedResultsController{
       
        fetchedResultController =
            NSFetchedResultsController(
                fetchRequest: contactFetchRequest(),
                managedObjectContext: AppDelegate.getAppDelegate().managedObjectContext,
                sectionNameKeyPath: nil,
                cacheName: nil)
        fetchedResultController.delegate = self
        
        do {
            try fetchedResultController.performFetch()
        } catch let error as NSError {
            print("Error: \(error.localizedDescription)")
            abort()
        }
        
        return fetchedResultController

        
        
    }
    
    func contactFetchRequest() -> NSFetchRequest{
        
        let fetchRequest =
        NSFetchRequest(entityName: "Contacts")
        fetchRequest.fetchBatchSize = 20
        
        let sortDescriptor =
        NSSortDescriptor(key: "fullName", ascending: false)
        
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        return fetchRequest
        
        
    }
    
    func controllerDidChangeContent(controller:
        NSFetchedResultsController) {
            
            contactedListTable.reloadData()
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


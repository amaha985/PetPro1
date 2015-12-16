//
//  TextedListViewController.swift
//  TextUnsend
//
//  Created by Amaha985 Gmail on 12/14/15.
//  Copyright © 2015 FreeApps. All rights reserved.
//

import UIKit

class TextedListViewController: UIViewController, UITableViewDelegate,UITableViewDataSource, UITextFieldDelegate {
    @IBOutlet weak var scrollView: UIScrollView!
    var contact : Contacts?
    var textedArrayDisplay : [String]?
    var nameandPhone: (firstLast: String?, phone: String?)
    var nameTextPhoneDate: (name: String?, text: String?, phone:String?, date: String?)
    @IBOutlet weak var textedListTable: UITableView!

 
    @IBAction func textEntry(sender: UITextField) {
       // sender.becomeFirstResponder()
        
      nameTextPhoneDate = (name: contact?.fullName ?? "Name missing", text: sender.text ?? "text missing", phone:contact?.phoneNumber ?? "phone missing" , date: "some date")
        
        let tempString = sender.text!
        
        
        if textedArrayDisplay != nil {
            textedArrayDisplay?.append(tempString)
            
        }else{
            
            textedArrayDisplay = [tempString]
        }
        
        if let entry = contact {
            
            entry.textArray = textedArrayDisplay
           
        }
        
        AppDelegate.getAppDelegate().saveContext()

        
        
        textedListTable.reloadData()
        
        print("printing Array....",textedArrayDisplay)
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = contact?.fullName ?? contact?.phoneNumber ?? ""
       
        if let tempArray = contact?.textArray as? NSArray{
            
            
            
            textedArrayDisplay = tempArray as? [String]
            
        }

      //   Do any additional setup after loading the view.
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
        return textedArrayDisplay?.count ?? 1
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell =
        tableView.dequeueReusableCellWithIdentifier("textedCell",
            forIndexPath: indexPath)
        
        let aText = textedArrayDisplay?[indexPath.row]  ?? "unable to read"
        
        
        cell.textLabel?.text = aText ?? "no text?"// textedArrayDisplay?[indexPath.row] ?? "mehh"
        cell.detailTextLabel?.text = contact!.phoneNumber ?? "ehh"
        
        return cell
        
    }
    
        // MARK: - textfield delegate
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.clearsOnInsertion = true
       textField.resignFirstResponder()
        return true
    }
    
    
    func textFieldDidBeginEditing(textField: UITextField) {
        scrollView.setContentOffset(CGPointMake(0, 250), animated: true)

    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        scrollView.setContentOffset(CGPointMake(0, 0), animated: true)
    }
    
  //func tableview

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

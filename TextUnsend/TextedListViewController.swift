//
//  TextedListViewController.swift
//  TextUnsend
//
//  Created by Amaha985 Gmail on 12/14/15.
//  Copyright © 2015 FreeApps. All rights reserved.
//

import UIKit

class TextedListViewController: UIViewController {
    
    var nameandPhone: String?
    @IBOutlet weak var textedListTable: UITableView!

    
    
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
        tableView.dequeueReusableCellWithIdentifier("textedCell",
            forIndexPath: indexPath)
        
        
        
        
        cell.textLabel?.text = nameandPhone ?? "meahh!"
        
        return cell
        
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

//
//  SWMasterController.swift
//  Watch
//
//  Created by Administrator on 09/09/14.
//  Copyright (c) 2014 IBM. All rights reserved.
//

import Foundation

import UIKit

class MasterViewController: UITableViewController {
    
    var detailViewController: DetailViewController? = nil
    //var objects = NSMutableArray()
    var pizza = Pizza()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.clearsSelectionOnViewWillAppear = false
        self.preferredContentSize = CGSize(width: 320.0, height: 600.0)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.leftBarButtonItem = self.editButtonItem()
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "insertNewObject:")
        self.navigationItem.rightBarButtonItem = addButton
        let controllers = self.splitViewController.viewControllers
        self.detailViewController = controllers[controllers.endIndex-1].topViewController as? DetailViewController
        
        pizza.pizzaPricePerInSq["Pepperoni"] = 9.99
        
        //send the model to the detailItem
        if ((detailViewController) != nil){
            self.detailViewController!.detailItem = pizza
            
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    /*
    func insertNewObject(sender: AnyObject) {
    if objects == nil {
    objects = NSMutableArray()
    }
    objects.insertObject(NSDate.date(), atIndex: 0)
    let indexPath = NSIndexPath(forRow: 0, inSection: 0)
    self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
    }
    */
    // #pragma mark - Segues
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            let indexPath = self.tableView.indexPathForSelectedRow()
            //    let object = objects[indexPath.row] as NSDate
            //((segue.destinationViewController as UINavigationController).topViewController as DetailViewController).detailItem = object
            pizza.pizzaType = pizza.typeList[indexPath.row] //set to the selected pizza
            ((segue.destinationViewController as UINavigationController).topViewController as DetailViewController).detailItem = pizza
        }
    }
    // #pragma mark - Table View
    override func numberOfSectionsInTableView(tableView: UITableView?) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    override func tableView(tableView: UITableView?, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return pizza.pizzaPricePerInSq.count
    }
    
    override func tableView(tableView: UITableView?, cellForRowAtIndexPath indexPath: NSIndexPath?) -> UITableViewCell? {
        //note I did not check for nil values. Something has to be really broken for these to be nil.
        let row = indexPath!.row   //get the array index from the index path
        let cell = tableView!.dequeueReusableCellWithIdentifier("tableCell", forIndexPath: indexPath) as UITableViewCell  //make the cell
        let myRowKey = pizza.typeList[row]  //the dictionary key
        cell.textLabel.text = myRowKey
        let myRowData = pizza.pizzaPricePerInSq[myRowKey]  //the dictionary value
        if cell.detailTextLabel != nil {
        cell.detailTextLabel.text = String(NSString(format:"%f",myRowData!))
        }
        return cell
    }
    
    override func tableView(tableView: UITableView!, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath!) -> CGFloat {
        return 44.0
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return false
    }
    /*
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    if editingStyle == .Delete {
    objects.removeObjectAtIndex(indexPath.row)
    tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
    } else if editingStyle == .Insert {
    // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
    }
    */
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //let object = objects[indexPath.row] as NSDate
        //self.detailViewController!.detailItem = object
        pizza.pizzaType = pizza.typeList[indexPath.row] //set to the selected pizza
        if ((detailViewController) != nil){
            self.detailViewController!.detailItem = pizza //send the model to the detailItem
        }
        
}
}

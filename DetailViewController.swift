//
//  DetailViewController.swift
//  Watch
//
//  Created by Administrator on 09/09/14.
//  Copyright (c) 2014 IBM. All rights reserved.
//

import Foundation
import UIKit

class DetailViewController: UIViewController, UISplitViewControllerDelegate {
    
    @IBOutlet var pizzaSizeLabel: UILabel!
    @IBOutlet var pizzaTypeLabel: UILabel!
    @IBOutlet var pizzaPriceLabel: UILabel!
    @IBOutlet var detailDescriptionLabel: UILabel!
    var pizza = Pizza()
    
    var masterPopoverController: UIPopoverController? = nil
    
    var detailItem: AnyObject? {
        didSet {
            // Update the view.
            self.configureView()
            
            if self.masterPopoverController != nil {
                self.masterPopoverController!.dismissPopoverAnimated(true)
            }
        }
    }
    
    @IBAction func pizzaSizeButton(sender: UIButton) {
        pizza.pizzaDiameter = pizza.diameterFromString(sender.titleLabel.text)
        configureView()
    }
    
    func configureView() {
        // Update the user interface for the detail item.
        if let detail = self.detailItem as? Pizza {     //if we have an object in the detail item
            pizza = detail
            if let label = self.pizzaTypeLabel {
                label.text = detail.pizzaType
            }
            let pizzaSizeString = NSString(format:"%6.1fin Pizza",detail.pizzaDiameter)
            let priceString = NSString(format:"%6.2f sq in at $%6.2f is $%6.2f",detail.pizzaArea(),detail.unitPrice(),detail.pizzaPrice()) //added 6/29/14
            if let label = self.pizzaSizeLabel{
                label.text = pizzaSizeString
            }
            if let label = self.pizzaPriceLabel{
                label.text = priceString //added 6/29/14
            }
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // #pragma mark - Split view
    
    func splitViewController(splitController: UISplitViewController, willHideViewController viewController: UIViewController, withBarButtonItem barButtonItem: UIBarButtonItem, forPopoverController popoverController: UIPopoverController) {
        barButtonItem.title = "Master" // NSLocalizedString(@"Master", @"Master")
        self.navigationItem.setLeftBarButtonItem(barButtonItem, animated: true)
        self.masterPopoverController = popoverController
    }
    
    func splitViewController(splitController: UISplitViewController, willShowViewController viewController: UIViewController, invalidatingBarButtonItem barButtonItem: UIBarButtonItem) {
        // Called when the view is shown again in the split view, invalidating the button and popover controller.
        self.navigationItem.setLeftBarButtonItem(nil, animated: true)
        self.masterPopoverController = nil
}
}
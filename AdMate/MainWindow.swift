//
//  MainWindow.swift
//  AdMate
//
//  Created by Antonin Linossier on 11/5/15.
//  Copyright © 2015 Antonin Linossier. All rights reserved.
//

import Cocoa
import QuartzCore
import AdDataKit2


class MainWindow: NSWindowController {
    
    @IBOutlet var RefreshData: NSToolbarItem!
    
    override func windowDidLoad() {
        super.windowDidLoad()
        
    }
    
    
    
    @IBAction func LoadDatData(sender:AnyObject){
    
    print("Refresh")

        NSNotificationCenter.defaultCenter().postNotificationName("UserDidLogin", object: nil)
    
    }
 
}
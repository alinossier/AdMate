//
//  MainWindow.swift
//  AdMate
//
//  Created by Antonin Linossier on 11/5/15.
//  Copyright © 2015 Antonin Linossier. All rights reserved.
//  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

import Cocoa
import QuartzCore
import AdDataKit2


class MainWindow: NSWindowController {
    
    @IBOutlet var RefreshData: NSToolbarItem!
    @IBOutlet var Login: NSToolbarItem!
    
    
    
    override func windowDidLoad() {
        super.windowDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "SetLogin:", name:"SetLoginIcon", object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "SetLogout:", name:"SetLogoutIcon", object: nil)
        
    }
    
    
    func SetLogout(sender:AnyObject){
    
        print("SetLogout #####")
        Login.image = NSImage(named: "logout")
    
    }
    
    func SetLogin(sender:AnyObject){
        print("SetLogin #####")

        Login.image = NSImage(named: "login")
        
    }
    
    // Refresh button
    
    @IBAction func LoadDatData(sender:AnyObject){
    
        print("Refresh")

        NSNotificationCenter.defaultCenter().postNotificationName("UserDidLogin", object: nil)
    
    }
    
    
    @IBAction func LoginPressed(sender:AnyObject){
        
        print("LoginPressed")
        
        NSNotificationCenter.defaultCenter().postNotificationName("LoginPressed", object: nil)
        
    }
 
}
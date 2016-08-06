//
//  AppDelegate.swift
//  AdMate
//
//  Created by Antonin Linossier on 10/28/15.
//  Copyright © 2015 Antonin Linossier. All rights reserved.
//  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

import Cocoa
import p2_OAuth2
import AdDataKit2




@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {


    
    func application(application: NSApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
            print(url)
           return true
    }


    func applicationWillFinishLaunching(aNotification: NSNotification) {

        let appleEventManager:NSAppleEventManager = NSAppleEventManager.sharedAppleEventManager()
        appleEventManager.setEventHandler(self, andSelector: "handleGetURLEvent:withReplyEvent:", forEventClass: AEEventClass(kInternetEventClass), andEventID: AEEventID(kAEGetURL))
    }

    
    func handleGetURLEvent(event: NSAppleEventDescriptor!, withReplyEvent: NSAppleEventDescriptor!) {
        
        if let urlString = event.paramDescriptorForKeyword(AEKeyword(keyDirectObject))?.stringValue {
            if let url = NSURL(string: urlString) {
                print(url)
                
                // Handling url callback
                
                oauth2.handleRedirectURL(url)
            }
        }
        else {
            NSLog("No valid URL to handle")
        }

    }
    
    
    @IBAction func GoToSupport(sender:AnyObject){
     
        NSWorkspace.sharedWorkspace().openURL(NSURL(string: "http://antonin-linossier.com/changemate/contact/")!)
    
    
    }
    
    
    @IBAction func LogOut(sender:AnyObject){
    
        defaults.setObject(nil, forKey: UserIDDefault)
        defaults.synchronize()
        NSApplication.sharedApplication().terminate(self)

    
    }
    
    
    func applicationDidFinishLaunching(aNotification: NSNotification) {
 
        
        // Insert code here to initialize your application
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
        NSNotificationCenter.defaultCenter().removeObserver("UserDidLogin")
        NSNotificationCenter.defaultCenter().removeObserver("ReValidateUser")

    }
    
    class var sharedInstance: AppDelegate {
        return NSApplication.sharedApplication().delegate as! AppDelegate
    }

    
}


//
//  AppDelegate.swift
//  AdMate
//
//  Created by Antonin Linossier on 10/28/15.
//  Copyright © 2015 Antonin Linossier. All rights reserved.
//

import Cocoa
//import OAuthSwift
import p2_OAuth2
import AdDataKit2




@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {


    
//    // register our app to get notified when launched via URL
//    func applicationWillFinishLaunching(notification: NSNotification) {
//        NSAppleEventManager.sharedAppleEventManager().setEventHandler(
//            self,
//            andSelector: "handleURLEvent:withReply:",
//            forEventClass: AEEventClass(kInternetEventClass),
//            andEventID: AEEventID(kAEGetURL)
//        )
//    }
//    
//    /** Gets called when the App launches/opens via URL. */
//    func handleURLEvent(event: NSAppleEventDescriptor, withReply reply: NSAppleEventDescriptor) {
//        if let urlString = event.paramDescriptorForKeyword(AEKeyword(keyDirectObject))?.stringValue {
//            
//            
//            oauth2.handleRedirectURL(url)
//            print(urlString)
//            if let url = NSURL(string: urlString) where "com.googleusercontent.apps.1079482800287-7njdh0lfjvsnsf50pp00iikquusduuua" == url.scheme && "oauth" == url.host {
////                GitHubLoader.handleRedirectURL(url)
//                //RedditLoader.handleRedirectURL(url)
//                print("Prout")
//                print(url)
//            }
//        }
//        else {
//            NSLog("No valid URL to handle")
//        }
//    }
    
    func application(application: NSApplication,
        openURL url: NSURL,
        sourceApplication: String?,
        annotation: AnyObject) -> Bool {
            // you should probably first check if this is your URL being opened
//            if{
//            }
            print(url)
           return true
    }

    
//    func application(application: NSApplication!, openURL url: NSURL!, sourceApplication: String!, annotation: AnyObject!) -> Bool {
//        if (url.host == "com.googleusercontent.apps.1079482800287-7njdh0lfjvsnsf50pp00iikquusduuua") {
//            if (url.path!.hasPrefix("/twitter")){
//                OAuth1Swift.handleOpenURL(url)
//            }
//            if ( url.path!.hasPrefix("/google" )){
//                OAuth2Swift.handleOpenURL(url)
//            }
//        }
//        return true
//    }
//
//    
//
//    
    func applicationWillFinishLaunching(aNotification: NSNotification) {
        
       

        
        
        
        let appleEventManager:NSAppleEventManager = NSAppleEventManager.sharedAppleEventManager()
        appleEventManager.setEventHandler(self, andSelector: "handleGetURLEvent:withReplyEvent:", forEventClass: AEEventClass(kInternetEventClass), andEventID: AEEventID(kAEGetURL))
    }
//
//    
    func handleGetURLEvent(event: NSAppleEventDescriptor!, withReplyEvent: NSAppleEventDescriptor!) {
        
        if let urlString = event.paramDescriptorForKeyword(AEKeyword(keyDirectObject))?.stringValue {
            if let url = NSURL(string: urlString) {
                print(url)
                
                print("YOOOOOO")
                
                oauth2.handleRedirectURL(url)
                //RedditLoader.handleRedirectURL(url)
            }
        }
        else {
            NSLog("No valid URL to handle")
        }
//
//        if let urlString = event.paramDescriptorForKeyword(AEKeyword(keyDirectObject))?.stringValue {
//            print(urlString)
//            
//            if let url = NSURL(string: urlString) where "com.googleusercontent.apps.1079482800287-7njdh0lfjvsnsf50pp00iikquusduuua" == url.scheme && "state" == url.host {
//                oauth2.handleRedirectURL(url)
//                //RedditLoader.handleRedirectURL(url)
//            } else {
//            
//                print("FAIL")
//            
//            }
//        }
//        else {
//            NSLog("No valid URL to handle")
//        }
    }
    
    
    @IBAction func GoToSupport(sender:AnyObject){
     
        NSWorkspace.sharedWorkspace().openURL(NSURL(string: "http://antonin-linossier.com/changemate/contact/")!)
    
    
    }
    
    
    @IBAction func LogOut(sender:AnyObject){
    
        defaults.setObject(nil, forKey: UserIDDefault)
        defaults.synchronize()
        NSApplication.sharedApplication().terminate(self)

    
    }
    
//        
//        if let urlPassed = NSURL(string: event.paramDescriptorForKeyword(AEKeyword(keyDirectObject))!.stringValue!) where "com.googleusercontent.apps.1079482800287-7njdh0lfjvsnsf50pp00iikquusduuua" == url.scheme && "code" == url.host {
//        print(urlPassed)
//        
//            oauth2.handleRedirectURL(urlPassed)
//            //RedditLoader.handleRedirectURL(url)
//        }
//        
//        print("URL PASSED")
//    }
    
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

//    internal func applicationHandleOpenURL(url: NSURL) {
//        
//        print("YESSSSS")
//        
//        // Google provider is the only one wuth your.bundle.id url schema.
//            OAuth2Swift.handleOpenURL(url)
//        
//    }
}


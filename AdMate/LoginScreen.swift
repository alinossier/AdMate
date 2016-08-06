//
//  ViewController.swift
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
import AdDataKit2
import AdMateOAuth



class LoginScreen: NSViewController {
 
    @IBOutlet var ActionButton: NSButton!
    @IBOutlet var ErrorLine: NSTextField!
    @IBOutlet var ErrorLine2: NSTextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.wantsLayer = true

        // Do any additional setup after loading the view.
    }

    override func awakeFromNib() {
        if self.view.layer != nil {
            let color : CGColorRef = CGColorCreateGenericRGB(250, 250, 250, 250)
            self.view.layer?.backgroundColor = color
        }
        
    }
    
    
    override func viewWillAppear() {
        self.view.window?.backgroundColor = NSColor.whiteColor()
        self.view.window?.titlebarAppearsTransparent = true
        
        let pstyle = NSMutableParagraphStyle()
        pstyle.alignment = .Center
        
        ActionButton.attributedTitle = NSAttributedString(string: "Sign in with your Google account", attributes: [ NSForegroundColorAttributeName : NSColor.whiteColor(), NSParagraphStyleAttributeName : pstyle ])
        ActionButton.layer!.cornerRadius = 9
       // ActionButton.layer!.borderWidth = 0.5
        ActionButton.layer!.borderColor = NSColor.whiteColor().CGColor
        
        
    }
    
    @IBAction func GetData(sender:AnyObject){
        
        print(defaults.objectForKey(UserIDDefault))

        if (defaults.objectForKey(UserIDDefault) == nil){
        // oauth2.authConfig.authorizeEmbedded = false
            oauth2.authorize()
            print(defaults.objectForKey(UserIDDefault))
            oauth2.onAuthorize = { parameters in
            
            print("Did authorize with parameters: \(parameters)")
            
            self.GetUserID(){
                (dict: NSDictionary?, error: NSError?) in
                
            
                if let UnDict = dict {
                
                    if UnDict.count != 0 {
                    
                            print("About to close")
                            NSNotificationCenter.defaultCenter().postNotificationName("UserDidLogin", object: nil)
                            self.dismissController(self)
                            self.CloseModal(self)
                            print("Got user ID")
                            return
                        
                    } else {
                        
                            // Need to standardise those error messages
                        
                            self.ErrorLine.stringValue = "Unexpected error please try again"
                            self.ErrorLine.textColor = NSColor.redColor()
                            self.ErrorLine2.stringValue = "Ouups, that wasn't supposed to happen"
                            self.ErrorLine2.textColor = NSColor.redColor()
                            oauth2.forgetTokens()
                            return
                    
                    }
                    
                } else {
                
                    self.ErrorLine.stringValue = "Could not locate a valid AdMob Account"
                    self.ErrorLine.textColor = NSColor.redColor()
                    self.ErrorLine2.stringValue = "Sign up for AdMob and try again" 
                    self.ErrorLine2.textColor = NSColor.redColor()
                    oauth2.forgetTokens()
                    return
                
                }
                
            }
  
        }
        oauth2.onFailure = { error in  // `error` is nil on cancel
            if nil != error {
                
                self.ErrorLine.stringValue = error.debugDescription
                return
                 // Print Alert message
            }
        }

        }
        // FETCH DATA FROM API
        
//    CloseModal(self)

    }
    
    func Retry (sender:AnyObject){
    
    print("RETRY")
    
    }
    
    func CloseModal (sender:AnyObject){
        
//        let window = NSApp.mainWindow! as NSWindow
//        window.attachedSheet!.close()
        self.view.window?.close()
        
        print("Close")
    }

    
    func GetUserID(callback: ((dict: NSDictionary?, error: NSError?) -> Void)) {
        
        let req = oauth2.request(forURL: NSURL(string: "https://www.googleapis.com/adsense/v1.4/accounts")!)
        
        let session = NSURLSession.sharedSession()
        print("SESSION1")
        
        let task = session.dataTaskWithRequest(req) { data, response, error in
            if nil != error {
                
                dispatch_async(dispatch_get_main_queue()) {
                    callback(dict: nil, error: error)
                    print("SESSION2")
                }

            }
                
            else {
                do {
                    if let dict = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? NSDictionary {
                    
                        if let DictAccount = dict["items"]as? NSArray {
                            
                            print(DictAccount)
                            
                            print("SESSION3")
                            if let UserID = DictAccount[0]["id"] as? String {
                                dispatch_async(dispatch_get_main_queue()) {

                                
                            defaults.setObject(UserID, forKey: UserIDDefault)
                            defaults.synchronize()
                            print("MOST IMPORTANT")
                                print(defaults.objectForKey(UserIDDefault))
//                            FetchDataFromAPI(UserID) {
//                                (result:Bool)   in
                                print("SESSION4")
                                
                                    callback(dict: dict, error: nil)
                                    print("Got the completion handler")

                            }
                            
                        } else {
                            
                                dispatch_async(dispatch_get_main_queue()) {
                                self.ErrorLine.stringValue = "Er1: Could not locate a valid AdMob/AdSense Account"
                                print("Er5.1: Could not locate a valid AdMob/AdSense Account")
                                callback(dict: nil, error: nil)
                                }
                        }
                            
                        } else {
                            
                                dispatch_async(dispatch_get_main_queue()) {
                                self.ErrorLine.stringValue = "Er2: Could not locate a valid AdMob/AdSense Account"
                                print("Er5.2: Could not locate a valid AdMob/AdSense Account")
                                callback(dict: nil, error: nil)
                                }
                            
                        }
                    
                    } else {
                        dispatch_async(dispatch_get_main_queue()) {
                        self.ErrorLine.stringValue = "Er5: Could not locate a valid AdMob/AdSense Account"
                        print("Er5.3: Could not locate a valid AdMob/AdSense Account")
                        callback(dict: nil, error: nil)
                        }
                    
                    }
                
                }
                catch let error {
                    dispatch_async(dispatch_get_main_queue()) {
                        
                        callback(dict: nil, error: error as NSError)
                    }
                }
            }
        }
        task.resume()

    }

    func CreateAdmobAccount(){
        
         NSWorkspace.sharedWorkspace().openURL(NSURL(string: "https://www.google.com/admob/")!)
    
    
    }
    
    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}


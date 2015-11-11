//
//  ViewController.swift
//  AdMate
//
//  Created by Antonin Linossier on 10/28/15.
//  Copyright © 2015 Antonin Linossier. All rights reserved.
//

import Cocoa
import AdDataKit2
import AdMateOAuth



class LoginScreen: NSViewController {
 
    @IBOutlet var ActionButton: NSButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//        let alert:NSAlert = NSAlert();
//        alert.messageText = "Authentification error";
////        alert.informativeText = error;
//        alert.addButtonWithTitle("Retry").target = self
//        alert.addButtonWithTitle("Close").target = self
//        alert.buttons[0].action = "Retry:"
//        alert.buttons[1].action = "CloseModal:"
//        alert.runModal();
        
        
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

        if (defaults.objectForKey(UserIDDefault) == nil){
        // oauth2.authConfig.authorizeEmbedded = false
        oauth2.authorize()
        print("USER IDD NOT NIL")
            print(defaults.objectForKey(UserIDDefault))
        oauth2.onAuthorize = { parameters in
            
            print("Did authorize with parameters: \(parameters)")
            
            self.GetUserID(){
                (dict: NSDictionary?, error: NSError?) in
                
                if dict!.count != 0 {
                
                        print("About to close")
                        NSNotificationCenter.defaultCenter().postNotificationName("UserDidLogin", object: nil)
                        self.dismissController(self)

                        print("Got user ID")
                        return
                    
                } else {
                
                    let alert:NSAlert = NSAlert();
                    alert.messageText = "Authentification error";
                    alert.informativeText = "\(error)";
                    alert.addButtonWithTitle("Retry").target = self
                    alert.buttons[1].action = "Retry:"
                    alert.runModal();
                
                
                }
                
            }
            
            
  
        }
        oauth2.onFailure = { error in  // `error` is nil on cancel
            if nil != error {
                
                let alert:NSAlert = NSAlert();
                alert.messageText = "Authentification error";
                alert.informativeText = error!.localizedDescription;
                alert.runModal();
                
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
        
        let window = NSApp.mainWindow! as NSWindow
        window.attachedSheet!.close()
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
                        }
                            
                        } else {
                        
                        
                        // You do not have an adsense account, please create one
                            
                        
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

    
    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}


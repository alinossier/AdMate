//
//  PopoverInfo.swift
//  AdMate
//
//  Created by Antonin Linossier on 11/11/15.
//  Copyright © 2015 Antonin Linossier. All rights reserved.
//

import Foundation
import Cocoa
import AdDataKit2

class PopOverInfo : NSViewController {
    // a very simple tooltip view controller to be presented by popover controller
    let lineLabel = NSTextField(frame: CGRect(x: 0.0, y: 20.0, width: 130.0, height: 20.0))
    let valueLabel = NSTextField(frame: CGRect(x: 0.0, y: 0.0, width: 130.0, height: 20.0))

    override init?(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        self.view = NSView(frame: CGRect(x: 0.0, y: 0.0, width: 130.00, height: 45.0))
        
        for label in [lineLabel, valueLabel] {
            label.editable = false
            label.selectable = false
            label.bordered = false
            label.alignment = NSTextAlignment.Center
            label.backgroundColor = NSColor.clearColor()
            view.addSubview(label)
        }
        
     

        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var representedObject: AnyObject? {
        didSet {
            
            let formatter = NSDateFormatter()
            formatter.dateStyle = NSDateFormatterStyle.MediumStyle
            formatter.timeStyle = .ShortStyle
            
            
            print("Updating")
            
            if let date = defaults.objectForKey("LastUpdateTimeStamp") as? NSDate {
                
                let dateString = formatter.stringFromDate(date)
                
                print(dateString)
                lineLabel.stringValue = "Last Updated"
                valueLabel.stringValue = dateString as String
                
            }
        }
    }
}

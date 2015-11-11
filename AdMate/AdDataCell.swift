//
//  CellTodayExtension.swift
//  AdMate
//
//  Created by Antonin Linossier on 11/5/15.
//  Copyright © 2015 Antonin Linossier. All rights reserved.
//

import Cocoa

class AdDataCell: NSView {
    
    @IBOutlet var Caption: NSTextField!
    
    @IBOutlet var Value: NSTextField!
    
    @IBOutlet var PrevValue: NSTextField!
    
    @IBOutlet var Indicator: NSImageView!
    
    
    
    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)

        // Drawing code here.
    }
    
}

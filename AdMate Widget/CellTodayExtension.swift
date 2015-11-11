//
//  CellTodayExtension.swift
//  AdMate
//
//  Created by Antonin Linossier on 11/3/15.
//  Copyright © 2015 Antonin Linossier. All rights reserved.
//

import Cocoa

class CellTodayExtension: NSView {

    @IBOutlet var MainLogo: NSImageView!
    
    @IBOutlet var Caption: NSTextField!
    
    @IBOutlet var Value: NSTextField!
    
    @IBOutlet var PrevValue: NSTextField!
    
    @IBOutlet var Indicator: NSImageView!

    @IBOutlet var ShowMoreButton: NSButton!
    
    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)

        // Drawing code here.
    }
    
}

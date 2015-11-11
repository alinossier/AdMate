//
//  MyRowView.swift
//  AdMate
//
//  Created by Antonin Linossier on 11/10/15.
//  Copyright © 2015 Antonin Linossier. All rights reserved.
//

import Foundation
import Cocoa
import SwiftColors



class MyRowView: NSTableRowView {
    
    let secondColor: NSColor = NSColor(hexString: "a9d5fb", alpha: 1)!
    

    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)
        
        if selected == true {
            secondColor.set()
            NSRectFill(dirtyRect)
        }
    }
}
//
//  ViewController.swift
//  SensorTagMac
//
//  Created by Kevin Brewster on 1/12/15.
//  Copyright (c) 2015 KevinBrewster. All rights reserved.
//

import Cocoa

//class DynamicLineChartViewController: NSViewController {
//    var timer: NSTimer?
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        if let lineChart = view.layer as? LineChart {
//            var data: [CGFloat] = [3.0, 4.0, 9.0, 11.0, 13.0, 15.0]
//            lineChart.datasets += [ LineChart.Dataset(label: "My Data", data: data) ]
//        }
//    }
//    func addTestData() {
//        if let lineChart = view.layer as? LineChart {
//            let line = lineChart.datasets.first!
//            let value = arc4random() % 25
//            line.data += [ CGFloat(value) ]
//        }
//    }
//    override func viewDidAppear() {
//        super.viewDidAppear()
//        timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("addTestData"), userInfo: nil, repeats: true)
//    }
//    override func viewDidDisappear() {
//        super.viewDidDisappear()
//        timer!.invalidate()
//    }
//}


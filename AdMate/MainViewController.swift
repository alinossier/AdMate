//
//  MainViewController.swift
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
import NotificationCenter
import AdDataKit2
import AdMateOAuth



// MARK: - NSTableViewDataSource
extension MainViewController: NSTableViewDataSource {
    
    
    func tableView(aTableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return 63
    }
    
    
    
    func numberOfRowsInTableView(aTableView: NSTableView) -> Int {
        
        
        if TodayDataToDisplay.count > 0 {return 7} else {return 0}
        
        
    }
    
    
    func tableView(aTableView: NSTableView, viewForTableColumn tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let cell = tableView.makeViewWithIdentifier("AdDataCell", owner: self) as! AdDataCell
        
        switch row
            
        {
        case 0: // EARNINGS
            
            cell.Caption.stringValue = "Earnings"
            
            
            switch CurrentSelection
            {
                
            case .Today:
                
                cell.Indicator.image = NSImage(named: TodayDataToDisplay[0].EarningsVarImg!)
                cell.Value.stringValue = "\(TodayDataToDisplay[0].Earnings!)" + " " + CurrencySymbol
                cell.PrevValue.stringValue = TodayDataToDisplay[0].EarningsPrev! + " \(CurrencySymbol) Yesterday " + TodayDataToDisplay[0].EarningsVar!
                
            case .ThisWeek:
                
                cell.Indicator.image = NSImage(named: ThisWeekDataToDisplay[0].EarningsVarImg!)
                cell.Value.stringValue = "\(ThisWeekDataToDisplay[0].Earnings!)" + " " + CurrencySymbol
                cell.PrevValue.stringValue = ThisWeekDataToDisplay[0].EarningsPrev! + " \(CurrencySymbol) Last Week " + ThisWeekDataToDisplay[0].EarningsVar!
                
            case .ThisMonth:
                
                cell.Indicator.image = NSImage(named: ThisMonthDataToDisplay[0].EarningsVarImg!)
                cell.Value.stringValue = "\(ThisMonthDataToDisplay[0].Earnings!)" + " " + CurrencySymbol
                cell.PrevValue.stringValue = ThisMonthDataToDisplay[0].EarningsPrev! + " \(CurrencySymbol) Last Month " + ThisMonthDataToDisplay[0].EarningsVar!
                
            }
            
            
            
        case 1: // PAGE VIEWS
            
            cell.Caption.stringValue = "Page Views"
            
            
            switch CurrentSelection
            {
                
            case .Today:
                
                cell.Indicator.image = NSImage(named: TodayDataToDisplay[0].PageViewsVarImg!)
                cell.Value.stringValue = "\(TodayDataToDisplay[0].PageViews!)"
                cell.PrevValue.stringValue = TodayDataToDisplay[0].PageViewsPrev! + " Yesterday " + TodayDataToDisplay[0].PageViewsVar!
                
            case .ThisWeek:
                
                cell.Indicator.image = NSImage(named: ThisWeekDataToDisplay[0].PageViewsVarImg!)
                cell.Value.stringValue = "\(ThisWeekDataToDisplay[0].PageViews!)"
                cell.PrevValue.stringValue = ThisWeekDataToDisplay[0].PageViewsPrev! + " Last Week " + ThisWeekDataToDisplay[0].PageViewsVar!
                
            case .ThisMonth:
                
                cell.Indicator.image = NSImage(named: ThisMonthDataToDisplay[0].PageViewsVarImg!)
                
                cell.Value.stringValue = "\(ThisMonthDataToDisplay[0].PageViews!)"
                cell.PrevValue.stringValue = ThisMonthDataToDisplay[0].PageViewsPrev! + " Last Month " + ThisMonthDataToDisplay[0].PageViewsVar!
                
            }
            
            
            
        case 2: // CLICKS
            
            cell.Caption.stringValue = "Clicks"
            
            
            switch CurrentSelection
            {
                
            case .Today:
                
                cell.Indicator.image = NSImage(named: TodayDataToDisplay[0].AdClicksVarImg!)
                cell.Value.stringValue = "\(TodayDataToDisplay[0].AdClicks!)"
                cell.PrevValue.stringValue = TodayDataToDisplay[0].AdClicksPrev! + " Yesterday " + TodayDataToDisplay[0].AdClicksVar!
                
            case .ThisWeek:
                
                cell.Indicator.image = NSImage(named: ThisWeekDataToDisplay[0].AdClicksVarImg!)
                cell.Value.stringValue = "\(ThisWeekDataToDisplay[0].AdClicks!)"
                cell.PrevValue.stringValue = ThisWeekDataToDisplay[0].AdClicksPrev! + " Last Week " + ThisWeekDataToDisplay[0].AdClicksVar!
                
            case .ThisMonth:
                
                cell.Indicator.image = NSImage(named: ThisMonthDataToDisplay[0].AdClicksVarImg!)
                
                cell.Value.stringValue = "\(ThisMonthDataToDisplay[0].AdClicks!)"
                cell.PrevValue.stringValue = ThisMonthDataToDisplay[0].AdClicksPrev! + " Last Month " + ThisMonthDataToDisplay[0].AdClicksVar!
                
            }
            
            
            
            
            
            
            
        case 3: // PAGE RPM
            
            cell.Caption.stringValue = "Page RPM"
            
            
            
            switch CurrentSelection
            {
                
            case .Today:
                
                cell.Indicator.image = NSImage(named: TodayDataToDisplay[0].PageViewRPMVarImg!)
                cell.Value.stringValue = (rounder(TodayDataToDisplay[0].PageViewRPM!) as String) + " \(CurrencySymbol)"
                cell.PrevValue.stringValue = TodayDataToDisplay[0].PageViewRPMPrev! + " \(CurrencySymbol) Yesterday " + TodayDataToDisplay[0].PageViewRPMVar!
                
            case .ThisWeek:
                
                cell.Indicator.image = NSImage(named: ThisWeekDataToDisplay[0].PageViewRPMVarImg!)
                cell.Value.stringValue = rounder(ThisWeekDataToDisplay[0].PageViewRPM!) + " \(CurrencySymbol)"
                cell.PrevValue.stringValue = ThisWeekDataToDisplay[0].PageViewRPMPrev! + " \(CurrencySymbol) Last Week " + ThisWeekDataToDisplay[0].PageViewRPMVar!
                
            case .ThisMonth:
                
                cell.Indicator.image = NSImage(named: ThisMonthDataToDisplay[0].PageViewRPMVarImg!)
                cell.Value.stringValue = rounder(ThisMonthDataToDisplay[0].PageViewRPM!) + " \(CurrencySymbol)"
                cell.PrevValue.stringValue = ThisMonthDataToDisplay[0].PageViewRPMPrev! + " \(CurrencySymbol) Last Month " + ThisMonthDataToDisplay[0].PageViewRPMVar!
                
            }
            
            
            
        case 4: // COVERAGE
            
            cell.Caption.stringValue = "Coverage"
            
            
            switch CurrentSelection
            {
                
            case .Today:
                
                cell.Indicator.image = NSImage(named: TodayDataToDisplay[0].AdRequestCoverageVarImg!)
                cell.Value.stringValue = rounder(TodayDataToDisplay[0].AdRequestCoverage! * 100) + " %"
                cell.PrevValue.stringValue = TodayDataToDisplay[0].AdRequestCoveragePrev! + "% Yesterday " + TodayDataToDisplay[0].AdRequestCoverageVar!
                
            case .ThisWeek:
                
                cell.Indicator.image = NSImage(named: ThisWeekDataToDisplay[0].AdRequestCoverageVarImg!)
                cell.Value.stringValue = rounder(ThisWeekDataToDisplay[0].AdRequestCoverage! * 100) + " %"
                cell.PrevValue.stringValue = ThisWeekDataToDisplay[0].AdRequestCoveragePrev! + "% Last Week " + ThisWeekDataToDisplay[0].AdRequestCoverageVar!
                
            case .ThisMonth:
                
                cell.Indicator.image = NSImage(named: ThisMonthDataToDisplay[0].AdRequestCoverageVarImg!)
                
                cell.Value.stringValue = rounder(ThisMonthDataToDisplay[0].AdRequestCoverage! * 100) + " %"
                cell.PrevValue.stringValue = ThisMonthDataToDisplay[0].AdRequestCoveragePrev! + "% Last Month " + ThisMonthDataToDisplay[0].AdRequestCoverageVar!
                
            }
            
            
            
            
            //
        case 5: // PAGE CTR
            
            cell.Caption.stringValue = "Page CTR"
            
            switch CurrentSelection
            {
                
            case .Today:
                
                cell.Indicator.image = NSImage(named: TodayDataToDisplay[0].AdRequestCTRVarImg!)
                cell.Value.stringValue = rounder(TodayDataToDisplay[0].AdRequestCTR! * 100) + " %"
                cell.PrevValue.stringValue = TodayDataToDisplay[0].AdRequestCTRPrev! + "% Yesterday " + TodayDataToDisplay[0].AdRequestCTRVar!
                
            case .ThisWeek:
                
                cell.Indicator.image = NSImage(named: ThisWeekDataToDisplay[0].AdRequestCTRVarImg!)
                cell.Value.stringValue = rounder(ThisWeekDataToDisplay[0].AdRequestCTR! * 100) + " %"
                cell.PrevValue.stringValue = ThisWeekDataToDisplay[0].AdRequestCTRPrev! + "% Last Week " + ThisWeekDataToDisplay[0].AdRequestCTRVar!
                
            case .ThisMonth:
                
                cell.Indicator.image = NSImage(named: ThisMonthDataToDisplay[0].AdRequestCTRVarImg!)
                
                cell.Value.stringValue = rounder(ThisMonthDataToDisplay[0].AdRequestCTR! * 100) + " %"
                cell.PrevValue.stringValue = ThisMonthDataToDisplay[0].AdRequestCTRPrev! + "% Last Month " + ThisMonthDataToDisplay[0].AdRequestCTRVar!
                
            }
            
            
            
        case 6: // COST PER CLICK
            
            
            cell.Caption.stringValue = "Cost per click"
            
            switch CurrentSelection
            {
                
            case .Today:
                
                cell.Indicator.image = NSImage(named: TodayDataToDisplay[0].AdCostPerClickVarImg!)
                cell.Value.stringValue = rounder(TodayDataToDisplay[0].AdCostPerClick!) + " \(CurrencySymbol)"
                cell.PrevValue.stringValue = TodayDataToDisplay[0].AdCostPerClickPrev! + " \(CurrencySymbol) Yesterday " + TodayDataToDisplay[0].AdCostPerClickVar!
                
            case .ThisWeek:
                
                cell.Indicator.image = NSImage(named: ThisWeekDataToDisplay[0].AdCostPerClickVarImg!)
                cell.Value.stringValue = rounder(ThisWeekDataToDisplay[0].AdCostPerClick!) + " \(CurrencySymbol)"
                cell.PrevValue.stringValue = ThisWeekDataToDisplay[0].AdCostPerClickPrev! + " \(CurrencySymbol) Last Week " + ThisWeekDataToDisplay[0].AdCostPerClickVar!
                
            case .ThisMonth:
                
                cell.Indicator.image = NSImage(named: ThisMonthDataToDisplay[0].AdCostPerClickVarImg!)
                
                cell.Value.stringValue = rounder(ThisMonthDataToDisplay[0].AdCostPerClick!) + " \(CurrencySymbol)"
                cell.PrevValue.stringValue = ThisMonthDataToDisplay[0].AdCostPerClickPrev! + " \(CurrencySymbol) Last Month " + ThisMonthDataToDisplay[0].AdCostPerClickVar!
                
            }
            
            
            
            
        default:
            print("Something else")
        }
        
        return cell
    }
    
    
    
    
    
    func tableViewSelectionDidChange(notification: NSNotification) {
        
        let myTableViewFromNotification = notification.object as! NSTableView
        
        let index = myTableViewFromNotification.selectedRow as Int
        
        
        switch index
        {
            
        case 0:
            CurrentRowSelected = .Earnings
        
        case 1:
            CurrentRowSelected = .PageViews
            
        case 2:
            CurrentRowSelected = .Clicks
            
        case 3:
            CurrentRowSelected = .PageRPM
            
        case 4:
            CurrentRowSelected = .Coverage
            
        case 5:
            CurrentRowSelected = .CTR
            
        case 6:
            CurrentRowSelected = .CostPerClick
        
        default:
            print("None Selected")
            CurrentRowSelected = .Earnings
        
        }
        
        
        LayoutSubViews()
        
        
    }
    

    
    func tableView(tableView: NSTableView, rowViewForRow row: Int) -> NSTableRowView? {
        let myCustomView = MyRowView()
        return myCustomView
    }
    
    
}

// MARK: - NSTableViewDelegate
extension MainViewController: NSTableViewDelegate {
}

class MainViewController: NSViewController {

    @IBOutlet var LineChartViewLayer: LineChartView!
    @IBOutlet var MainTitle: NSTextField!
    @IBOutlet var tableView: NSTableView!
    @IBOutlet var SegmentedControl: NSSegmentedControl!
    @IBOutlet var DailyAverageThisMonth: NSTextField!
    @IBOutlet var DailyAverageLastMonth: NSTextField!
    @IBOutlet var MaxThisMonth: NSTextField!
    @IBOutlet var MaxLastMonth: NSTextField!
    @IBOutlet var MinThisMonth: NSTextField!
    @IBOutlet var MinLastMonth: NSTextField!
    
    enum DataSetToShow {
        
        case Today
        case ThisWeek
        case ThisMonth
        
    }
    

    // Default enum values for the data to show the the window is loaded
    var CurrentSelection = DataSetToShow.Today
    var CurrentRowSelected = RowSelected.Earnings
    
    // Data from DB
    var DBDataToAnalyse = [AdData]()
    
    @IBOutlet var InfoButton: NSButton!
    
    let PopoverInfoState = Bool(false)
    let popover = NSPopover()
    
    // Array of structs to display data
    var TodayDataToDisplay = [ProcessedData]()
    var ThisWeekDataToDisplay = [ProcessedData]()
    var ThisMonthDataToDisplay = [ProcessedData]()
    
    // The currency symbol to be used
    var CurrencySymbol = String()
    


    
    @objc func widgetMarginInsetsForProposedMarginInsets(defaultMarginInsets: NSEdgeInsets) -> NSEdgeInsets {
        return NSEdgeInsetsZero
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Did load

            //Register custom cell
            let nib = NSNib(nibNamed: "AdDataCell", bundle: nil)
            tableView.registerNib(nib!, forIdentifier: "AdDataCell")
        
        self.view.window?.toolbar?.insertItemWithItemIdentifier("RefreshButton", atIndex: 1)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "LoadView:", name:"UserDidLogin", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "ReAuthUser:", name:"ReValidateUser", object: nil)
        
        LineChartViewLayer.lineChart.legendEnabled = false
        
        if !defaults.boolForKey("FirstTimeOpen"){
            
            copyFile("AdMate.db")

        }
        
        if let UserID = defaults.objectForKey(UserIDDefault) {
            
            print("USER IDD VIEW DID LOAD \(UserID)")
            
            RefreshTheView()
            FetchTheData(UserID as! String)
            NSNotificationCenter.defaultCenter().removeObserver("UserDidLogin")
            
        }
        
    }
    

    
    
    @IBAction func ShowInfo(sender:AnyObject){
    
        
        if popover.shown {
        
            popover.close()
        
        } else {
        
            popover.contentViewController = PopOverInfo.init(nibName: nil, bundle: nil)
            popover.contentViewController!.representedObject = nil
            popover.contentSize = NSSize(width: 130.0, height: 0.0)
            popover.showRelativeToRect(InfoButton.bounds, ofView: InfoButton, preferredEdge: NSRectEdge.MaxX)
        
        
        }
        
    
        
        
    
    
    
    }
    
    func FetchTheData(userID:String){
    
        dispatch_async(dispatch_get_global_queue(Int(QOS_CLASS_USER_INITIATED.rawValue), 0)) { // 1
            print("Fetching from API")
            FetchDataFromAPI(userID ){
                (UpdateStatus:Bool) in
                
                if UpdateStatus {
                    print("Getting data from db")
                    
                    self.RefreshTheView()
                    
                    
                }
                
            }
            
            
        }

    }
    
    
    
    func RefreshTheView(){
    
        GetDataFromDb(){
            (result: [AdData]) in
            
            dispatch_async(dispatch_get_main_queue()) { // 2
                
                if result.count > 60 { // Not Ideal for people whose account is not 60days old yet
                    
                    if defaults.objectForKey("CCYSYMBOL") != nil {
                        self.CurrencySymbol = defaults.objectForKey("CCYSYMBOL") as! String
                    } else {
                        self.CurrencySymbol = "$"
                    }
                    
                    
                    self.DBDataToAnalyse = result
                    self.FormatTodayData(result)
                    self.LayoutSubViews() // Create the chart
                    
                } else {
                    
                    // DATA IS CORRUPTED ALERT MESSAGE
                    print("DATA IS CORRUPTED ALERT MESSAGE")
                    
                }
                
                
            }
            
        }
    
    
    
    }
    

    override func viewWillAppear() {

        self.view.window?.backgroundColor = NSColor.whiteColor()
        self.view.window?.titlebarAppearsTransparent = true

        
        if let UserID = defaults.objectForKey(UserIDDefault) {
        
            print("USER IDD VIEW WILL APPEAR \(UserID)")

        // For debugging
        
       // self.performSegueWithIdentifier("GoToTutorial", sender: self)

        
        }else {
            
            // The user is not loged in -> go to login screen
            self.performSegueWithIdentifier("GoToTutorial", sender: self)

        }
        
    }
    
    func ReAuthUser(sender:AnyObject) {
        
        dispatch_async(dispatch_get_main_queue()) {
            
            self.performSegueWithIdentifier("GoToTutorial", sender: self)

            
        }
    
    }
    
    
    func LayoutSubViews(){
        
        let FrontColor = NSColor(calibratedRed: 102/255, green: 178/255, blue: 255.0/255, alpha: 1.0).CGColor
        let BackColor =  NSColor(calibratedRed: 204.0/255, green: 229.0/255, blue: 255.0/255, alpha: 1.0).CGColor
        
        let formatter = NSDateFormatter()
        formatter.dateFormat = "MMM dd"
        
        var DataSetEarningsOne = [CGFloat]()
        var DataSetEarningsTwo = [CGFloat]()
        var DataLabelArray = [String]()
        var DataLabelArrayTwo = [String]()
        
        
        let calendar = NSCalendar.autoupdatingCurrentCalendar()
    
        let ThisMonthStartDate = calendar.dateByAddingUnit(
            [.Day],
            value: -30,
            toDate: NSDate(),
            options: [])!
        
        
        let LastMonthStartDate = calendar.dateByAddingUnit(
            [.Day],
            value: -60,
            toDate: NSDate(),
            options: [])!
        
        
        var ThisMonth = DBDataToAnalyse.filter({
            $0.Date != nil && ThisMonthStartDate.isLessThanDate($0.Date!)
        })
        
        
        var LastMonth = DBDataToAnalyse.filter({
            $0.Date != nil && ThisMonthStartDate.isGreaterThanDate($0.Date!) && LastMonthStartDate.isLessThanDate($0.Date!)
        })
        
        ThisMonth = ThisMonth.sort({ $0.Date! < $1.Date! })
        LastMonth = LastMonth.sort({ $0.Date! < $1.Date! })

        
    switch CurrentRowSelected
        
    {
    case .Earnings:
        
        MainTitle.stringValue = "Earnings"

        
        for i in 0...ThisMonth.count - 1 {
            
            if let NumberToAppendSerie1 = ThisMonth[i].Earnings {
                // Dataset 1
                DataSetEarningsOne.append(CGFloat(NumberToAppendSerie1))
                DataLabelArray.append(formatter.stringFromDate(ThisMonth[i].Date!))
            }
            
            if let NumberToAppendSerie2 = LastMonth[i].Earnings {
                // Dataset 2
                DataSetEarningsTwo.append(CGFloat(NumberToAppendSerie2))
                DataLabelArrayTwo.append(formatter.stringFromDate(LastMonth[i].Date!))
            }

        }
        
        // Chart Dataset 1
        let dataset1 = LineChart.Dataset(label: "Data 1", data: DataSetEarningsOne, poplabelfrominit: DataLabelArray, indice: CurrencySymbol)
        dataset1.color = FrontColor
        dataset1.fillColor = nil
        dataset1.curve = .Bezier(0.3)
        
        // Chart Dataset 2
        let dataset21 = LineChart.Dataset(label: "Data 1", data: DataSetEarningsTwo, poplabelfrominit: DataLabelArrayTwo, indice: CurrencySymbol)
        dataset21.color = BackColor
        dataset21.curve = .Bezier(0.3)
        dataset21.fillColor = nil
        
        // Clearing previous sets and adding new ones
        LineChartViewLayer.lineChart.datasets = []
        LineChartViewLayer.lineChart.datasets += [dataset21, dataset1]
        
        // Convenience vars to calculare the average
        let t = ThisMonth.reduce(0) {$0 + $1.Earnings!}
        let l = LastMonth.reduce(0) {$0 + $1.Earnings!}
        let c = ThisMonth.count
        let d = LastMonth.count
        
        // Unwrap optionals and display values
        if let maxtm = ThisMonth.maxElement({ $0.Earnings < $1.Earnings } )?.Earnings{
            MaxThisMonth.stringValue = "\(maxtm)" + " " + CurrencySymbol
        }
        if let maxlm = LastMonth.maxElement({ $0.Earnings < $1.Earnings } )?.Earnings{
            MaxLastMonth.stringValue = "\(maxlm)" + " " + CurrencySymbol
        }
        if let mintm = ThisMonth.minElement({ $0.Earnings < $1.Earnings } )?.Earnings{
            MinThisMonth.stringValue = "\(mintm)" + " " + CurrencySymbol
        }
        if let minlm = LastMonth.minElement({ $0.Earnings < $1.Earnings } )?.Earnings{
            MinLastMonth.stringValue = "\(minlm)" + " " + CurrencySymbol
        }
        
        // No need to unwrap optionals here
        DailyAverageThisMonth.stringValue = "\(rounder(t / Float(c)) )" + " " + CurrencySymbol
        DailyAverageLastMonth.stringValue = "\(rounder(l / Float(d)) )" + " " + CurrencySymbol
        
    
    case .PageViews:
        
        MainTitle.stringValue = "Page Views"
        
        for i in 0...ThisMonth.count - 1 {
            
            if let NumberToAppendSerie1 = ThisMonth[i].PageViews {
                // Dataset 1
                DataSetEarningsOne.append(CGFloat(NumberToAppendSerie1))
                DataLabelArray.append(formatter.stringFromDate(ThisMonth[i].Date!))
            }
            
            if let NumberToAppendSerie2 = LastMonth[i].PageViews {
                // Dataset 2
                DataSetEarningsTwo.append(CGFloat(NumberToAppendSerie2))
                DataLabelArrayTwo.append(formatter.stringFromDate(LastMonth[i].Date!))
            }
            
        }
        
        // Chart Dataset 1
        let dataset1 = LineChart.Dataset(label: "Data 1", data: DataSetEarningsOne, poplabelfrominit: DataLabelArray, indice: "")
        dataset1.color = FrontColor
        dataset1.fillColor = nil
        dataset1.curve = .Bezier(0.3)
        
        // Chart Dataset 2
        let dataset21 = LineChart.Dataset(label: "Data 1", data: DataSetEarningsTwo, poplabelfrominit: DataLabelArrayTwo, indice: "")
        dataset21.color = BackColor
        dataset21.curve = .Bezier(0.3)
        dataset21.fillColor = nil
        
        // Clearing previous sets and adding new ones
        LineChartViewLayer.lineChart.datasets = []
        LineChartViewLayer.lineChart.datasets += [dataset21, dataset1]
        
        // Convenience vars to calculare the average
        let t = ThisMonth.reduce(0) {$0 + $1.PageViews!}
        let l = LastMonth.reduce(0) {$0 + $1.PageViews!}
        let c = ThisMonth.count
        let d = LastMonth.count
        
        // Unwrap optionals and display values
        if let maxtm = ThisMonth.maxElement({ $0.PageViews < $1.PageViews } )?.PageViews{
            MaxThisMonth.stringValue = "\(maxtm)"
        }
        if let maxlm = LastMonth.maxElement({ $0.PageViews < $1.PageViews } )?.PageViews{
            MaxLastMonth.stringValue = "\(maxlm)"
        }
        if let mintm = ThisMonth.minElement({ $0.PageViews < $1.PageViews } )?.PageViews{
            MinThisMonth.stringValue = "\(mintm)"
        }
        if let minlm = LastMonth.minElement({ $0.PageViews < $1.PageViews } )?.PageViews{
            MinLastMonth.stringValue = "\(minlm)"
        }
        
        // No need to unwrap optionals here
        DailyAverageThisMonth.stringValue = "\(rounder(Float(t) / Float(c)) )"
        DailyAverageLastMonth.stringValue = "\(rounder(Float(l) / Float(d)) )"
        
        
        
    case .Clicks:
        
        MainTitle.stringValue = "Clicks"
        
        for i in 0...ThisMonth.count - 1 {
            
            if let NumberToAppendSerie1 = ThisMonth[i].AdClicks {
                // Dataset 1
                DataSetEarningsOne.append(CGFloat(NumberToAppendSerie1))
                DataLabelArray.append(formatter.stringFromDate(ThisMonth[i].Date!))
            }
            
            if let NumberToAppendSerie2 = LastMonth[i].AdClicks {
                // Dataset 2
                DataSetEarningsTwo.append(CGFloat(NumberToAppendSerie2))
                DataLabelArrayTwo.append(formatter.stringFromDate(LastMonth[i].Date!))
            }
            
        }
        
        // Chart Dataset 1
        let dataset1 = LineChart.Dataset(label: "Data 1", data: DataSetEarningsOne, poplabelfrominit: DataLabelArray, indice: "")
        dataset1.color = FrontColor
        dataset1.fillColor = nil
        dataset1.curve = .Bezier(0.3)
        
        // Chart Dataset 2
        let dataset21 = LineChart.Dataset(label: "Data 1", data: DataSetEarningsTwo, poplabelfrominit: DataLabelArrayTwo, indice: "")
        dataset21.color = BackColor
        dataset21.curve = .Bezier(0.3)
        dataset21.fillColor = nil
        
        // Clearing previous sets and adding new ones
        LineChartViewLayer.lineChart.datasets = []
        LineChartViewLayer.lineChart.datasets += [dataset21, dataset1]
        
        // Convenience vars to calculare the average
        let t = ThisMonth.reduce(0) {$0 + $1.AdClicks!}
        let l = LastMonth.reduce(0) {$0 + $1.AdClicks!}
        let c = ThisMonth.count
        let d = LastMonth.count
        
        // Unwrap optionals and display values
        if let maxtm = ThisMonth.maxElement({ $0.AdClicks < $1.AdClicks } )?.AdClicks{
            MaxThisMonth.stringValue = "\(maxtm)"
        }
        if let maxlm = LastMonth.maxElement({ $0.AdClicks < $1.AdClicks } )?.AdClicks{
            MaxLastMonth.stringValue = "\(maxlm)"
        }
        if let mintm = ThisMonth.minElement({ $0.AdClicks < $1.AdClicks } )?.AdClicks{
            MinThisMonth.stringValue = "\(mintm)"
        }
        if let minlm = LastMonth.minElement({ $0.AdClicks < $1.AdClicks } )?.AdClicks{
            MinLastMonth.stringValue = "\(minlm)"
        }
        
        // No need to unwrap optionals here
        DailyAverageThisMonth.stringValue = "\(rounder(Float(t) / Float(c)) )"
        DailyAverageLastMonth.stringValue = "\(rounder(Float(l) / Float(d)) )"

        
    case .PageRPM:
        
        MainTitle.stringValue = "RPM"
        
        
        for i in 0...ThisMonth.count - 1 {
            
            if let NumberToAppendSerie1 = ThisMonth[i].AdRequestRPM {
                // Dataset 1
                DataSetEarningsOne.append(CGFloat(NumberToAppendSerie1))
                DataLabelArray.append(formatter.stringFromDate(ThisMonth[i].Date!))
            }
            
            if let NumberToAppendSerie2 = LastMonth[i].AdRequestRPM {
                // Dataset 2
                DataSetEarningsTwo.append(CGFloat(NumberToAppendSerie2))
                DataLabelArrayTwo.append(formatter.stringFromDate(LastMonth[i].Date!))
            }
            
        }
        
        // Chart Dataset 1
        let dataset1 = LineChart.Dataset(label: "Data 1", data: DataSetEarningsOne, poplabelfrominit: DataLabelArray, indice: CurrencySymbol)
        dataset1.color = FrontColor
        dataset1.fillColor = nil
        dataset1.curve = .Bezier(0.3)
        
        // Chart Dataset 2
        let dataset21 = LineChart.Dataset(label: "Data 1", data: DataSetEarningsTwo, poplabelfrominit: DataLabelArrayTwo, indice: CurrencySymbol)
        dataset21.color = BackColor
        dataset21.curve = .Bezier(0.3)
        dataset21.fillColor = nil
        
        // Clearing previous sets and adding new ones
        LineChartViewLayer.lineChart.datasets = []
        LineChartViewLayer.lineChart.datasets += [dataset21, dataset1]
        
        // Convenience vars to calculare the average
        let t = ThisMonth.reduce(0) {$0 + $1.AdRequestRPM!}
        let l = LastMonth.reduce(0) {$0 + $1.AdRequestRPM!}
        let c = ThisMonth.count
        let d = LastMonth.count
        
        // Unwrap optionals and display values
        if let maxtm = ThisMonth.maxElement({ $0.AdRequestRPM < $1.AdRequestRPM } )?.AdRequestRPM{
            MaxThisMonth.stringValue = "\(maxtm)" + " " + CurrencySymbol
        }
        if let maxlm = LastMonth.maxElement({ $0.AdRequestRPM < $1.AdRequestRPM } )?.AdRequestRPM{
            MaxLastMonth.stringValue = "\(maxlm)" + " " + CurrencySymbol
        }
        if let mintm = ThisMonth.minElement({ $0.AdRequestRPM < $1.AdRequestRPM } )?.AdRequestRPM{
            MinThisMonth.stringValue = "\(mintm)" + " " + CurrencySymbol
        }
        if let minlm = LastMonth.minElement({ $0.AdRequestRPM < $1.AdRequestRPM } )?.AdRequestRPM{
            MinLastMonth.stringValue = "\(minlm)" + " " + CurrencySymbol
        }
        
        // No need to unwrap optionals here
        DailyAverageThisMonth.stringValue = "\(rounder(t / Float(c)) )" + " " + CurrencySymbol
        DailyAverageLastMonth.stringValue = "\(rounder(l / Float(d)) )" + " " + CurrencySymbol
        
        
        
    case .Coverage:
        
        MainTitle.stringValue = "Coverage"
        
        for i in 0...ThisMonth.count - 1 {
            
            if let NumberToAppendSerie1 = ThisMonth[i].AdRequestCoverage {
                // Dataset 1
                DataSetEarningsOne.append(CGFloat(NumberToAppendSerie1))
                DataLabelArray.append(formatter.stringFromDate(ThisMonth[i].Date!))
            }
            
            if let NumberToAppendSerie2 = LastMonth[i].AdRequestCoverage {
                // Dataset 2
                DataSetEarningsTwo.append(CGFloat(NumberToAppendSerie2))
                DataLabelArrayTwo.append(formatter.stringFromDate(LastMonth[i].Date!))
            }
            
        }
        
        // Chart Dataset 1
        let dataset1 = LineChart.Dataset(label: "Data 1", data: DataSetEarningsOne, poplabelfrominit: DataLabelArray, indice: "%")
        dataset1.color = FrontColor
        dataset1.fillColor = nil
        dataset1.curve = .Bezier(0.3)
        
        // Chart Dataset 2
        let dataset21 = LineChart.Dataset(label: "Data 1", data: DataSetEarningsTwo, poplabelfrominit: DataLabelArrayTwo, indice: "%")
        dataset21.color = BackColor
        dataset21.curve = .Bezier(0.3)
        dataset21.fillColor = nil
        
        // Clearing previous sets and adding new ones
        LineChartViewLayer.lineChart.datasets = []
        LineChartViewLayer.lineChart.datasets += [dataset21, dataset1]
        
        // Convenience vars to calculare the average
        let t = ThisMonth.reduce(0) {$0 + $1.AdRequestCoverage!}
        let l = LastMonth.reduce(0) {$0 + $1.AdRequestCoverage!}
        let c = ThisMonth.count
        let d = LastMonth.count
        
        // Unwrap optionals and display values
        if let maxtm = ThisMonth.maxElement({ $0.AdRequestCoverage < $1.AdRequestCoverage } )?.AdRequestCoverage{
            MaxThisMonth.stringValue = "\(ConvertPercentage(maxtm))" + " %"
        }
        if let maxlm = LastMonth.maxElement({ $0.AdRequestCoverage < $1.AdRequestCoverage } )?.AdRequestCoverage{
            MaxLastMonth.stringValue = "\(ConvertPercentage(maxlm))" + " %"
        }
        if let mintm = ThisMonth.minElement({ $0.AdRequestCoverage < $1.AdRequestCoverage } )?.AdRequestCoverage{
            MinThisMonth.stringValue = "\(ConvertPercentage(mintm))" + " %"
        }
        if let minlm = LastMonth.minElement({ $0.AdRequestCoverage < $1.AdRequestCoverage } )?.AdRequestCoverage{
            MinLastMonth.stringValue = "\(ConvertPercentage(minlm))" + " %"
        }
        
        // No need to unwrap optionals here
        DailyAverageThisMonth.stringValue = "\(ConvertPercentage(Float(t) / Float(c)) )" + " %"
        DailyAverageLastMonth.stringValue = "\(ConvertPercentage(Float(l) / Float(d)) )" + " %"
        
    case .CTR:
        
        MainTitle.stringValue = "Click-through rate"
        
        for i in 0...ThisMonth.count - 1 {
            
            if let NumberToAppendSerie1 = ThisMonth[i].AdRequestCTR {
                // Dataset 1
                DataSetEarningsOne.append(CGFloat(NumberToAppendSerie1))
                DataLabelArray.append(formatter.stringFromDate(ThisMonth[i].Date!))
            }
            
            if let NumberToAppendSerie2 = LastMonth[i].AdRequestCTR {
                // Dataset 2
                DataSetEarningsTwo.append(CGFloat(NumberToAppendSerie2))
                DataLabelArrayTwo.append(formatter.stringFromDate(LastMonth[i].Date!))
            }
            
        }
        
        // Chart Dataset 1
        let dataset1 = LineChart.Dataset(label: "Data 1", data: DataSetEarningsOne, poplabelfrominit: DataLabelArray, indice: "%")
        dataset1.color = FrontColor
        dataset1.fillColor = nil
        dataset1.curve = .Bezier(0.3)
        
        // Chart Dataset 2
        let dataset21 = LineChart.Dataset(label: "Data 1", data: DataSetEarningsTwo, poplabelfrominit: DataLabelArrayTwo, indice: "%")
        dataset21.color = BackColor
        dataset21.curve = .Bezier(0.3)
        dataset21.fillColor = nil
        
        // Clearing previous sets and adding new ones
        LineChartViewLayer.lineChart.datasets = []
        LineChartViewLayer.lineChart.datasets += [dataset21, dataset1]
        
        // Convenience vars to calculare the average
        let t = ThisMonth.reduce(0) {$0 + $1.AdRequestCTR!}
        let l = LastMonth.reduce(0) {$0 + $1.AdRequestCTR!}
        let c = ThisMonth.count
        let d = LastMonth.count
        
        // Unwrap optionals and display values
        if let maxtm = ThisMonth.maxElement({ $0.AdRequestCTR < $1.AdRequestCTR } )?.AdRequestCTR{
            MaxThisMonth.stringValue = "\(ConvertPercentage(maxtm))" + " %"
        }
        if let maxlm = LastMonth.maxElement({ $0.AdRequestCTR < $1.AdRequestCTR } )?.AdRequestCTR{
            MaxLastMonth.stringValue = "\(ConvertPercentage(maxlm))" + " %"
        }
        if let mintm = ThisMonth.minElement({ $0.AdRequestCTR < $1.AdRequestCTR } )?.AdRequestCTR{
            MinThisMonth.stringValue = "\(ConvertPercentage(mintm))" + " %"
        }
        if let minlm = LastMonth.minElement({ $0.AdRequestCTR < $1.AdRequestCTR } )?.AdRequestCTR{
            MinLastMonth.stringValue = "\(ConvertPercentage(minlm))" + " %"
        }
        
        // No need to unwrap optionals here
        DailyAverageThisMonth.stringValue = "\(ConvertPercentage(Float(t) / Float(c)) )" + " %"
        DailyAverageLastMonth.stringValue = "\(ConvertPercentage(Float(l) / Float(d)) )" + " %"
        
        
        
    case .CostPerClick:
        
        MainTitle.stringValue = "Cost per click"
        
        for i in 0...ThisMonth.count - 1 {
            
            if let NumberToAppendSerie1 = ThisMonth[i].AdCostPerClick {
                // Dataset 1
                DataSetEarningsOne.append(CGFloat(NumberToAppendSerie1))
                DataLabelArray.append(formatter.stringFromDate(ThisMonth[i].Date!))
            }
            
            if let NumberToAppendSerie2 = LastMonth[i].AdCostPerClick {
                // Dataset 2
                DataSetEarningsTwo.append(CGFloat(NumberToAppendSerie2))
                DataLabelArrayTwo.append(formatter.stringFromDate(LastMonth[i].Date!))
            }
            
        }
        
        // Chart Dataset 1
        let dataset1 = LineChart.Dataset(label: "Data 1", data: DataSetEarningsOne, poplabelfrominit: DataLabelArray, indice: CurrencySymbol)
        dataset1.color = FrontColor
        dataset1.fillColor = nil
        dataset1.curve = .Bezier(0.3)
        
        // Chart Dataset 2
        let dataset21 = LineChart.Dataset(label: "Data 1", data: DataSetEarningsTwo, poplabelfrominit: DataLabelArrayTwo, indice: CurrencySymbol)
        dataset21.color = BackColor
        dataset21.curve = .Bezier(0.3)
        dataset21.fillColor = nil
        
        // Clearing previous sets and adding new ones
        LineChartViewLayer.lineChart.datasets = []
        LineChartViewLayer.lineChart.datasets += [dataset21, dataset1]
        
        // Convenience vars to calculare the average
        let t = ThisMonth.reduce(0) {$0 + $1.AdCostPerClick!}
        let l = LastMonth.reduce(0) {$0 + $1.AdCostPerClick!}
        let c = ThisMonth.count
        let d = LastMonth.count
        
        // Unwrap optionals and display values
        if let maxtm = ThisMonth.maxElement({ $0.AdCostPerClick < $1.AdCostPerClick } )?.AdCostPerClick{
            MaxThisMonth.stringValue = "\(maxtm)" + " " + CurrencySymbol
        }
        if let maxlm = LastMonth.maxElement({ $0.AdCostPerClick < $1.AdCostPerClick } )?.AdCostPerClick{
            MaxLastMonth.stringValue = "\(maxlm)" + " " + CurrencySymbol
        }
        if let mintm = ThisMonth.minElement({ $0.AdCostPerClick < $1.AdCostPerClick } )?.AdCostPerClick{
            MinThisMonth.stringValue = "\(mintm)" + " " + CurrencySymbol
        }
        if let minlm = LastMonth.minElement({ $0.AdCostPerClick < $1.AdCostPerClick } )?.AdCostPerClick{
            MinLastMonth.stringValue = "\(minlm)" + " " + CurrencySymbol
        }
        
        // No need to unwrap optionals here
        DailyAverageThisMonth.stringValue = "\(rounder(t / Float(c)) )" + " " + CurrencySymbol
        DailyAverageLastMonth.stringValue = "\(rounder(l / Float(d)) )" + " " + CurrencySymbol
    }
    
    
    
    
    
    
    
    }
    
    func FormatTodayData(RawDataFromDb: [AdData]){
        
        // HERE CHANGE TO MAX DATE IN ARRAY - 1 TO FIND YESTERDAY AND TODAY
        
        
        let calendar = NSCalendar.autoupdatingCurrentCalendar()
        
        let TodayData = RawDataFromDb.filter({
            $0.Date != nil && calendar.isDateInToday($0.Date!)
        })
        
        print(TodayData)
        
        if TodayData.count == 0 {
            
            let TodayData = RawDataFromDb.filter({
                $0.Date != nil && calendar.isDateInYesterday($0.Date!)
        })
            
            
            
        let TwoDaysAgo = calendar.dateByAddingUnit(
                [.Day],
                value: -2,
                toDate: NSDate(),
                options: [])!
            
            
            let YesterdayData = RawDataFromDb.filter({
                $0.Date != nil && calendar.isDate($0.Date!, inSameDayAsDate: TwoDaysAgo)
            })
            
            // Here crash array index out of range
            
            TodayDataToDisplay.append(ProcessedData(AdRequest: TodayData[0].AdRequest!, AdRequestCoverage: TodayData[0].AdRequestCoverage!, AdRequestCTR: TodayData[0].AdRequestCTR!, AdRequestRPM: TodayData[0].AdRequestRPM!, AdClicks: TodayData[0].AdClicks!, AdCostPerClick: TodayData[0].AdCostPerClick!, Earnings: TodayData[0].Earnings!, PageViews: TodayData[0].PageViews!, PageViewRPM: TodayData[0].PageViewRPM!, MatchedAdRequest: TodayData[0].MatchedAdRequest!, AdRequestPrev: YesterdayData[0].AdRequest!, AdRequestCoveragePrev: YesterdayData[0].AdRequestCoverage!, AdRequestCTRPrev: YesterdayData[0].AdRequestCTR!, AdRequestRPMPrev: YesterdayData[0].AdRequestRPM!, AdClicksPrev: YesterdayData[0].AdClicks!, AdCostPerClickPrev: YesterdayData[0].AdCostPerClick!, EarningsPrev: YesterdayData[0].Earnings!, PageViewsPrev: YesterdayData[0].PageViews!, PageViewRPMPrev: YesterdayData[0].PageViewRPM!, MatchedAdRequestPrev: YesterdayData[0].MatchedAdRequest!))
            
            
            
            
        } else {
            
            let YesterdayData = RawDataFromDb.filter({
                $0.Date != nil && calendar.isDateInYesterday($0.Date!)
            })
            
            
            TodayDataToDisplay.append(ProcessedData(AdRequest: TodayData[0].AdRequest!, AdRequestCoverage: TodayData[0].AdRequestCoverage!, AdRequestCTR: TodayData[0].AdRequestCTR!, AdRequestRPM: TodayData[0].AdRequestRPM!, AdClicks: TodayData[0].AdClicks!, AdCostPerClick: TodayData[0].AdCostPerClick!, Earnings: TodayData[0].Earnings!, PageViews: TodayData[0].PageViews!, PageViewRPM: TodayData[0].PageViewRPM!, MatchedAdRequest: TodayData[0].MatchedAdRequest!, AdRequestPrev: YesterdayData[0].AdRequest!, AdRequestCoveragePrev: YesterdayData[0].AdRequestCoverage!, AdRequestCTRPrev: YesterdayData[0].AdRequestCTR!, AdRequestRPMPrev: YesterdayData[0].AdRequestRPM!, AdClicksPrev: YesterdayData[0].AdClicks!, AdCostPerClickPrev: YesterdayData[0].AdCostPerClick!, EarningsPrev: YesterdayData[0].Earnings!, PageViewsPrev: YesterdayData[0].PageViews!, PageViewRPMPrev: YesterdayData[0].PageViewRPM!, MatchedAdRequestPrev: YesterdayData[0].MatchedAdRequest!))
            
            
        }
        

        let ThisMonthStartDate = calendar.dateByAddingUnit(
            [.Day],
            value: -30,
            toDate: NSDate(),
            options: [])!
        
        
        let LastMonthStartDate = calendar.dateByAddingUnit(
            [.Day],
            value: -60,
            toDate: NSDate(),
            options: [])!
        
        
        
        let ThisWeekStartDate = calendar.dateByAddingUnit(
            [.Day],
            value: -7,
            toDate: NSDate(),
            options: [])!
        
        
        let LastWeekStartDate = calendar.dateByAddingUnit(
            [.Day],
            value: -14,
            toDate: NSDate(),
            options: [])!
        
        
        
        let ThisMonth = RawDataFromDb.filter({
            $0.Date != nil && ThisMonthStartDate.isLessThanDate($0.Date!)
        })
        

        
        let LastMonth = RawDataFromDb.filter({
            $0.Date != nil && ThisMonthStartDate.isGreaterThanDate($0.Date!) && LastMonthStartDate.isLessThanDate($0.Date!)
        })
        
        
        
        let ThisWeek = RawDataFromDb.filter({
            $0.Date != nil && ThisWeekStartDate.isLessThanDate($0.Date!)
        })
        
        
        let LastWeek = RawDataFromDb.filter({
            $0.Date != nil && ThisWeekStartDate.isGreaterThanDate($0.Date!) && LastWeekStartDate.isLessThanDate($0.Date!)
        })
        
        let Temp1 = MultiplyStruct(ThisWeek, TheStructsTwo: LastWeek)
        let Temp2 = MultiplyStruct(ThisMonth, TheStructsTwo: LastMonth)
        
        ThisWeekDataToDisplay.append(Temp1[0])
        ThisMonthDataToDisplay.append(Temp2[0])
        
        
        self.tableView.reloadData()
        self.preferredContentSize = CGSizeMake(CGFloat(0), CGFloat((tableView.bounds.height)) + CGFloat(30))
    }
    
    
    func MultiplyStruct(TheStructs: [AdData], TheStructsTwo: [AdData])->[ProcessedData]{
        
        var AdRequestADD = Int(0)
        var AdRequestCoverageADD = Float(0)
        var AdRequestCTRADD = Float(0)
        var AdRequestRPMADD = Float(0)
        var AdClicksADD = Int(0)
        var AdCostPerClickADD = Float(0)
        var EarningsADD = Float(0)
        var PageViewsADD = Int(0)
        var PageViewRPMADD = Float(0)
        var MatchedAdRequestADD = Int(0)
        
        
        
        for i in 0...TheStructs.count - 1 {
            
            
            AdRequestADD = AdRequestADD + TheStructs[i].AdRequest!
            AdRequestCoverageADD = AdRequestCoverageADD + TheStructs[i].AdRequestCoverage!
            AdRequestCTRADD = AdRequestCTRADD + TheStructs[i].AdRequestCTR!
            AdRequestRPMADD = AdRequestRPMADD + TheStructs[i].AdRequestRPM!
            AdClicksADD = AdClicksADD + TheStructs[i].AdClicks!
            AdCostPerClickADD = AdCostPerClickADD + TheStructs[i].AdCostPerClick!
            EarningsADD = EarningsADD + TheStructs[i].Earnings!
            PageViewsADD = PageViewsADD + TheStructs[i].PageViews!
            PageViewRPMADD = PageViewRPMADD + TheStructs[i].PageViewRPM!
            MatchedAdRequestADD = MatchedAdRequestADD + TheStructs[i].MatchedAdRequest!
            
            
            
            
            
        }
        
        
        var AdRequestADDTWO = Int(0)
        var AdRequestCoverageADDTWO = Float(0)
        var AdRequestCTRADDTWO = Float(0)
        var AdRequestRPMADDTWO = Float()
        var AdClicksADDTWO = Int(0)
        var AdCostPerClickADDTWO = Float(0)
        var EarningsADDTWO = Float(0)
        var PageViewsADDTWO = Int(0)
        var PageViewRPMADDTWO = Float(0)
        var MatchedAdRequestADDTWO = Int(0)
        
        
        for i in 0...TheStructsTwo.count - 1 {
            
            
            AdRequestADDTWO = AdRequestADDTWO + TheStructsTwo[i].AdRequest!
            AdRequestCoverageADDTWO = AdRequestCoverageADDTWO + TheStructsTwo[i].AdRequestCoverage!
            AdRequestCTRADDTWO = AdRequestCTRADDTWO + TheStructsTwo[i].AdRequestCTR!
            AdRequestRPMADDTWO = AdRequestRPMADDTWO + TheStructsTwo[i].AdRequestRPM!
            AdClicksADDTWO = AdClicksADDTWO + TheStructsTwo[i].AdClicks!
            AdCostPerClickADDTWO = AdCostPerClickADDTWO + TheStructsTwo[i].AdCostPerClick!
            EarningsADDTWO = EarningsADDTWO + TheStructsTwo[i].Earnings!
            PageViewsADDTWO = PageViewsADDTWO + TheStructsTwo[i].PageViews!
            PageViewRPMADDTWO = PageViewRPMADDTWO + TheStructsTwo[i].PageViewRPM!
            MatchedAdRequestADDTWO = MatchedAdRequestADDTWO + TheStructsTwo[i].MatchedAdRequest!
            
            
        }
        
        
        var ArrayOfStruct = [ProcessedData]()
        
        ArrayOfStruct.append(ProcessedData.init(AdRequest: AdRequestADD, AdRequestCoverage: (AdRequestCoverageADD / Float(TheStructs.count)), AdRequestCTR: (AdRequestCTRADD / Float(TheStructs.count)), AdRequestRPM: (AdRequestRPMADD / Float(TheStructs.count)), AdClicks: AdClicksADD, AdCostPerClick: (AdCostPerClickADD / Float(TheStructs.count)), Earnings: EarningsADD, PageViews: PageViewsADD, PageViewRPM: (PageViewRPMADD / Float(TheStructs.count)), MatchedAdRequest: MatchedAdRequestADD, AdRequestPrev: AdRequestADDTWO, AdRequestCoveragePrev: (AdRequestCoverageADDTWO / Float(TheStructsTwo.count)), AdRequestCTRPrev: (AdRequestCTRADDTWO / Float(TheStructsTwo.count)), AdRequestRPMPrev: (AdRequestRPMADDTWO / Float(TheStructsTwo.count)), AdClicksPrev: AdClicksADDTWO, AdCostPerClickPrev: (AdCostPerClickADDTWO / Float(TheStructsTwo.count)), EarningsPrev: EarningsADDTWO, PageViewsPrev: PageViewsADDTWO, PageViewRPMPrev: (PageViewRPMADDTWO / Float(TheStructsTwo.count)), MatchedAdRequestPrev: MatchedAdRequestADDTWO))
        
        
        return ArrayOfStruct
        
        
    }
    
    
    
    @IBAction func indexChanged(sender:NSSegmentedControl)
        
    {
        switch SegmentedControl.selectedSegment
        {
        case 0:
            CurrentSelection = DataSetToShow.Today
        case 1:
            CurrentSelection = DataSetToShow.ThisWeek
        case 2:
            CurrentSelection = DataSetToShow.ThisMonth
        default:
            break;
        }
        
        
        tableView.reloadData()
        
    }

    
    override func awakeFromNib() {
        if self.view.layer != nil {
            let color : CGColorRef = CGColorCreateGenericRGB(250, 250, 250, 250)
            self.view.layer?.backgroundColor = color
        }
        
        
        self.view.window?.title = "AdMate"
        
        
    }
    


    func LoadView(sender:AnyObject) {
        
        print("LoadView")
        
        if let UserID = defaults.objectForKey(UserIDDefault) {
            
            FetchTheData(UserID as! String)
//            NSNotificationCenter.defaultCenter().removeObserver("UserDidLogin")
            
        }
        
//         NSNotificationCenter.defaultCenter().removeObserver("UserDidLogin")
   
    }
    

    
}

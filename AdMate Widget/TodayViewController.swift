//
//  TodayViewController.swift
//  AdMate Widget
//
//  Created by Antonin Linossier on 11/2/15.
//  Copyright © 2015 Antonin Linossier. All rights reserved.
//

import Cocoa
import NotificationCenter
import AdDataKit2
import AdMateOAuth



// MARK: - NSTableViewDataSource
extension TodayViewController: NSTableViewDataSource {
    
    
    func tableView(aTableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return 63
    }

    
    func numberOfRowsInTableView(aTableView: NSTableView) -> Int {
        
        
        if !ShowMore {
        
            if TodayDataToDisplay.count > 0 {return 4} else {return 0}
        
        } else {
        
            if TodayDataToDisplay.count > 0 {return 8} else {return 0}
        
        }
  
        
    }

    
    func tableView(aTableView: NSTableView, viewForTableColumn tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let cell = tableView.makeViewWithIdentifier("CellTodayExtension", owner: self) as! CellTodayExtension
        cell.MainLogo.image = NSImage(named: "EARNINGS")
   
        switch row
            
        {
        case 0: // EARNINGS
            
            cell.Caption.stringValue = "Earnings"
            cell.MainLogo.image = NSImage(named: "EARNINGS")
            cell.ShowMoreButton.hidden = true
            
            
            switch CurrentSelection
            {
                
            case .Today:
                
                cell.Indicator.image = NSImage(named: TodayDataToDisplay[0].EarningsVarImg!)
                cell.Value.stringValue = "\(TodayDataToDisplay[0].Earnings!)" + " \(CurrencySymbol)"
                cell.PrevValue.stringValue = TodayDataToDisplay[0].EarningsPrev! + " \(CurrencySymbol) Yesterday " + TodayDataToDisplay[0].EarningsVar!
            
            case .ThisWeek:
                
                cell.Indicator.image = NSImage(named: ThisWeekDataToDisplay[0].EarningsVarImg!)
                cell.Value.stringValue = "\(ThisWeekDataToDisplay[0].Earnings!)" + " \(CurrencySymbol)"
                cell.PrevValue.stringValue = ThisWeekDataToDisplay[0].EarningsPrev! + " \(CurrencySymbol) Last Week " + ThisWeekDataToDisplay[0].EarningsVar!
                
            case .ThisMonth:
                
                cell.Indicator.image = NSImage(named: ThisMonthDataToDisplay[0].EarningsVarImg!)
                cell.Value.stringValue = "\(ThisMonthDataToDisplay[0].Earnings!)" + " \(CurrencySymbol)"
                cell.PrevValue.stringValue = ThisMonthDataToDisplay[0].EarningsPrev! + " \(CurrencySymbol) Last Month " + ThisMonthDataToDisplay[0].EarningsVar!
                
            }
            


        case 1: // PAGE VIEWS
            
            cell.Caption.stringValue = "Page Views"
            cell.MainLogo.image = NSImage(named: "VIEWS")
            cell.ShowMoreButton.hidden = true
            
            
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
            cell.MainLogo.image = NSImage(named: "CLICK")
            cell.ShowMoreButton.hidden = true
            
            
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
            
            
            
            if !ShowMore {
                
                cell.Caption.hidden = true
                cell.MainLogo.hidden = true
                cell.Indicator.hidden = true
                cell.Value.hidden = true
                cell.PrevValue.hidden = true
                cell.ShowMoreButton.title = "Show more"
                cell.ShowMoreButton.hidden = false
                cell.ShowMoreButton.target = self
                cell.ShowMoreButton.action = Selector("ToogleTable:")
            
            
            } else {
            
            
                cell.Caption.stringValue = "Page RPM"
                cell.MainLogo.image = NSImage(named: "PAGERPM")
                cell.ShowMoreButton.hidden = true
                cell.Caption.hidden = false
                cell.MainLogo.hidden = false
                cell.Indicator.hidden = false
                cell.Value.hidden = false
                cell.PrevValue.hidden = false

                
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
            
            
            
            }
            
            
         
            
          

        case 4: // COVERAGE
            
            cell.Caption.stringValue = "Coverage"
            cell.MainLogo.image = NSImage(named: "COVERAGE")
            cell.ShowMoreButton.hidden = true
            
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
            cell.MainLogo.image = NSImage(named: "PAGECTR")
            cell.ShowMoreButton.hidden = true
            
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
            cell.MainLogo.image = NSImage(named: "COSTPERCLICK")
            cell.ShowMoreButton.hidden = true
            
            
            switch CurrentSelection
            {
                
            case .Today:
                
                cell.Indicator.image = NSImage(named: TodayDataToDisplay[0].AdCostPerClickVarImg!)
                cell.Value.stringValue = rounder(TodayDataToDisplay[0].AdCostPerClick!) + " $"
                cell.PrevValue.stringValue = TodayDataToDisplay[0].AdCostPerClickPrev! + " $ Yesterday " + TodayDataToDisplay[0].AdCostPerClickVar!
                
            case .ThisWeek:
                
                cell.Indicator.image = NSImage(named: ThisWeekDataToDisplay[0].AdCostPerClickVarImg!)
                cell.Value.stringValue = rounder(ThisWeekDataToDisplay[0].AdCostPerClick!) + " $"
                cell.PrevValue.stringValue = ThisWeekDataToDisplay[0].AdCostPerClickPrev! + " $ Last Week " + ThisWeekDataToDisplay[0].AdCostPerClickVar!
                
            case .ThisMonth:
                
                cell.Indicator.image = NSImage(named: ThisMonthDataToDisplay[0].AdCostPerClickVarImg!)
                
                cell.Value.stringValue = rounder(ThisMonthDataToDisplay[0].AdCostPerClick!) + " $"
                cell.PrevValue.stringValue = ThisMonthDataToDisplay[0].AdCostPerClickPrev! + " $ Last Month " + ThisMonthDataToDisplay[0].AdCostPerClickVar!
                
            }
            
            
        case 7: // FOOTER
            
            print("FOOTER")
            
            cell.Caption.hidden = true
            cell.MainLogo.hidden = true
            cell.Indicator.hidden = true
            cell.Value.hidden = true
            cell.PrevValue.hidden = true
            
            cell.ShowMoreButton.hidden = false
            cell.ShowMoreButton.target = self
            cell.ShowMoreButton.action = Selector("ToogleTable:")
            cell.ShowMoreButton.title = "Show less"
            
           
        default:
            print("Something else")
        }
        
        cell.MainLogo.hidden = true
        return cell
    }
    
    
    
    
    
    func tableViewSelectionDidChange(notification: NSNotification) {

        
    }
    
    
    
}

// MARK: - NSTableViewDelegate
extension TodayViewController: NSTableViewDelegate {
}


class TodayViewController: NSViewController, NCWidgetProviding {
    
    @IBOutlet var tableView: NSTableView!
    
    @IBOutlet var SegmentedControl: NSSegmentedControl!
    
    
    var CurrentSelection = DataSetToShow.Today
    
    
    
    
    enum DataSetToShow {
    
        case Today
        case ThisWeek
        case ThisMonth

    }
    
    
    

//    var RawDataFromDb = [AdData]()
    var TodayDataToDisplay = [ProcessedData]()
    var ThisWeekDataToDisplay = [ProcessedData]()
    var ThisMonthDataToDisplay = [ProcessedData]()
    var ShowMore = Bool(false)
    
    var CurrencySymbol = String()

    override var nibName: String? {
        return "TodayViewController"
    }
    
    @objc func widgetMarginInsetsForProposedMarginInsets(defaultMarginInsets: NSEdgeInsets) -> NSEdgeInsets {
        return NSEdgeInsetsZero
    }
    
    
    override func viewDidLoad() {
        // Did load
        
        //Register custom cell
        let nib = NSNib(nibNamed: "CellTodayExtension", bundle: nil)
        tableView.registerNib(nib, forIdentifier: "CellTodayExtension")
        
        self.preferredContentSize = CGSizeMake(CGFloat(0), CGFloat(295))
        
    }
    
    override func viewWillAppear() {
        

        
        
            GetDataFromDb(){
                (result: [AdData]) in
                
                if result.count > 60 {
                
                    if defaults.objectForKey("CCYSYMBOL") != nil {
                        self.CurrencySymbol = defaults.objectForKey("CCYSYMBOL") as! String
                    } else {
                        self.CurrencySymbol = "$"
                    }
                    
                    self.FormatTodayData(result)
                    
                } else {
                
                    // DATA IS CORRUPTED ALERT MESSAGE
                
                }
                
            }
    

            if let UserID = defaults.objectForKey("UserID") {
                
                oauth2.authorize()
                
                dispatch_async(dispatch_get_global_queue(Int(QOS_CLASS_USER_INITIATED.rawValue), 0)) { // 1
                    
                    FetchDataFromAPI(UserID as! String){
                        (UpdateStatus:Bool) in
                        
                        if UpdateStatus {
                            
                            GetDataFromDb(){
                                (result: [AdData]) in
                                                                
                                    dispatch_async(dispatch_get_main_queue()) { // 2
                                    
                                        if result.count > 60 {
                                            
                                            self.FormatTodayData(result)
                                            
                                        } else {
                                            
                                            // DATA IS CORRUPTED ALERT MESSAGE
                                            
                                        }

                                    
                                    }
                                
                            }
                            
                            
                        }
                        
                    }
                    
                    
                }
  
        }
  
 
    }
    
    
    
    
    func ToogleTable(sender:AnyObject){
    
        if ShowMore {
            
            ShowMore = false
            tableView.reloadData()
            self.preferredContentSize = CGSizeMake(CGFloat(0), CGFloat(295))
        
        } else {
            ShowMore = true
            tableView.reloadData()
            self.preferredContentSize = CGSizeMake(CGFloat(0), CGFloat(555))
        
        }
        
    
    
    }
    
    
    
    func FormatTodayData(RawDataFromDb: [AdData]){
    
        // HERE CHANGE TO MAX DATE IN ARRAY - 1 TO FIND YESTERDAY AND TODAY
        
        
        let calendar = NSCalendar.autoupdatingCurrentCalendar()
        
        let TodayData = RawDataFromDb.filter({
            $0.Date != nil && calendar.isDateInToday($0.Date!)
        })
        
        
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

        tableView.reloadData()

        
        if ShowMore {
            self.preferredContentSize = CGSizeMake(CGFloat(0), CGFloat(555))
        } else {
            self.preferredContentSize = CGSizeMake(CGFloat(0), CGFloat(295))

        }
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

        print(PageViewsADD)
        print(PageViewsADDTWO)
        
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
    

    func widgetPerformUpdateWithCompletionHandler(completionHandler: ((NCUpdateResult) -> Void)!) {
        // Update your data and prepare for a snapshot. Call completion handler when you are done
        // with NoData if nothing has changed or NewData if there is new data since the last
        // time we called you
        completionHandler(.NoData)
    }

}

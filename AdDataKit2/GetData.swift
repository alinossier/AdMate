//
//  GetData.swift
//  AdMate
//
//  Created by Antonin Linossier on 11/2/15.
//  Copyright © 2015 Antonin Linossier. All rights reserved.
//

import Foundation
import SQLite
import Cocoa
//import OAuthSwift
import p2_OAuth2
import AdMateOAuth

public let settings = [
    "client_id": "1079482800287-7njdh0lfjvsnsf50pp00iikquusduuua.apps.googleusercontent.com",
    "client_secret": "",
    "authorize_uri": "https://accounts.google.com/o/oauth2/auth",
    "token_uri": "https://accounts.google.com/o/oauth2/token",
    "scope": "https://www.googleapis.com/auth/adsense",
    "redirect_uris": ["com.googleusercontent.apps.1079482800287-7njdh0lfjvsnsf50pp00iikquusduuua:/"],
    "title": "AdMate",
    "response_type": "token",
    "verbose": true,
    "approval_prompt" : "auto" // TO BE CHANGED TO AUTO
    // optional title to show in views
    ] as OAuth2JSON

public let oauth2 = OAuth2CodeGrant(settings: settings)

public func GetDataFromDb(completion: (Done: [AdData]) -> Void){
    
    
    
        var RetrievedData = [AdData]()
    
        let calendar = NSCalendar.autoupdatingCurrentCalendar()
    
        let MyFormatter = NSDateFormatter()
        MyFormatter.dateFormat = "yyyy-MM-dd"

        let DbPath = getPath("AdMate.db").absoluteString
            
            
            
            print("DBPATH READ")
            print(DbPath)
        let db = try! Connection(DbPath)
            
            for i in 0...70 { // Insert some dummy data to fill blanks so we don't have to worry about nil values.
                
                let Date = calendar.dateByAddingUnit(
                    [.Day],
                    value: -i,
                    toDate: NSDate(),
                    options: [])!
                
                let formatedDate = MyFormatter.stringFromDate(Date)
                
                
                let insert = AdDataTable.insert(AdRequestData <- "\(0)", AdRequestCoverageData <- "\(0)", AdRequestCTRData <- "\(0)", AdRequestRPMData <- "\(0)", ClicksData <- "\(0)", CostPerClickData <- "\(0)", EarningsData <- "\(0)", PageViewRPMData <- "\(0)", PageViewsData <- "\(0)", MatchedAdREquestData <- "\(0)", DateData <- "\(formatedDate)")
                
                
                do {
                    
                    try db.run(insert)
                    
                } catch _ {
                    
                 //   print("Data does exist for date \(formatedDate)")
                    
                }
                
            }
            
            // Maybe add closure to make sure the dummy data gets inserted before reading it

    
    do {
        
        for AdDB in try db.prepare(AdDataTable) {
            
            // need to unwarp here
            
            RetrievedData.append(AdData(AdRequest: AdDB[AdRequestData], AdRequestCoverage: AdDB[AdRequestCoverageData], AdRequestCTR: AdDB[AdRequestCTRData], AdRequestRPM: AdDB[AdRequestRPMData], AdClicks: AdDB[ClicksData], AdCostPerClick: AdDB[CostPerClickData], Earnings: AdDB[EarningsData], PageViews: AdDB[PageViewsData], PageViewRPM: AdDB[PageViewRPMData], MatchedAdRequest: AdDB[MatchedAdREquestData], Date: AdDB[DateData]))

            }
        
        } catch _ {
        
        //   print("Data does exist for date \(formatedDate)")
        
    }
    
        completion(Done: RetrievedData)
    
//        } else {
//    
//            print("could not get DB path")
//
//    
//    }
    
    
    
    
//                completion(UpdateStatus: false)

    }






public func FetchDataFromAPI(AccountID:String, completion: (UpdateStatus: Bool) -> Void){
    
    
        let url = "https://www.googleapis.com/adsense/v1.4/reports"
        
        let calendar = NSCalendar.autoupdatingCurrentCalendar()
        
        let TodayDate = NSDate()
        let MyFormatter = NSDateFormatter()
        MyFormatter.dateFormat = "yyyy-MM-dd"
        
        let EndDate = calendar.dateByAddingUnit(
            [.Day],
            value: -70,
            toDate: NSDate(),
            options: [])!
        
        
        let EndDateString = MyFormatter.stringFromDate(EndDate)
        
        let TodayDateString = MyFormatter.stringFromDate(TodayDate)
        
        print(TodayDateString)
        print("HERE")
    
        let params = ["endDate": TodayDateString, "startDate": EndDateString,
            "metric": "AD_REQUESTS", "accountId": AccountID] as Dictionary<String, String>
        
        //  Calls basic parameters such as start and end date + User ID + One parameter
        
        //  The number of ad units that requested ads (for content ads) or search queries (for search ads). An ad request may result in zero, one, or multiple individual ad impressions depending on the size of the ad unit and whether any ads were available.
        
        
        let AdRequestConverage = ["metric": "AD_REQUESTS_COVERAGE"] as Dictionary<String, String>
        
        // The ratio of requested ad units or queries to the number returned to the site.
        
        let Ctr = ["metric": "AD_REQUESTS_CTR"] as Dictionary<String, String>
        
        // The ratio of ad requests that resulted in a click.
        
        let AdRequestRpm = ["metric": "AD_REQUESTS_RPM"] as Dictionary<String, String>
        
        //  The revenue per thousand ad requests. This is calculated by dividing estimated revenue by the number of ad requests multiplied by 1000.
        
        let Clicks = ["metric": "CLICKS"] as Dictionary<String, String>
        
        // The number of times a user clicked on a standard content ad.
        
        let CostPerClick = ["metric": "COST_PER_CLICK"] as Dictionary<String, String>
        
        // The amount you earn each time a user clicks on your ad. CPC is calculated by dividing the estimated revenue by the number of clicks received.
        
        
        let Earnings = ["metric": "EARNINGS"] as Dictionary<String, String>
        
        //  The estimated earnings of the publisher. Note that earnings up to yesterday are accurate, more recent earnings are estimated due to the possibility of spam, or exchange rate fluctuations.
        
        
        let PageViews = ["metric": "PAGE_VIEWS"] as Dictionary<String, String>
        
        // The number of page views.
        
        let PageViewsRPM = ["metric": "PAGE_VIEWS_RPM"] as Dictionary<String, String>
        
        // The revenue per thousand page views. This is calculated by dividing your estimated revenue by the number of page views multiplied by 1000.
        
        let MatchedAdRequest = ["metric": "MATCHED_AD_REQUESTS"] as Dictionary<String, String>
        
        // The number of ad units (for content ads) or search queries (for search ads) that showed ads. A matched ad request is counted for each ad request that returns at least one ad to the site.
        
        
        let DateDimension = ["dimension": "DATE"] as Dictionary<String, String>
        
        // Dimensions
        
        
        
        let parameterString = params.stringFromHttpParameters() + "&" + AdRequestConverage.stringFromHttpParameters() + "&" + Ctr.stringFromHttpParameters() + "&" + AdRequestRpm.stringFromHttpParameters() + "&" + Clicks.stringFromHttpParameters() + "&" + CostPerClick.stringFromHttpParameters() + "&" + Earnings.stringFromHttpParameters() + "&" + PageViews.stringFromHttpParameters() + "&" + PageViewsRPM.stringFromHttpParameters() + "&" + PageViews.stringFromHttpParameters() + "&" + DateDimension.stringFromHttpParameters() + "&" + MatchedAdRequest.stringFromHttpParameters()
        
        
        let requestURL = NSURL(string:"\(url)?\(parameterString)")!
        
        let req = oauth2.request(forURL: requestURL)
    
        print(req)
        
        
        let session = NSURLSession.sharedSession()
        
        let task = session.dataTaskWithRequest(req) { data, response, error in
            if nil != error {
                dispatch_async(dispatch_get_main_queue()) {
                    
                    print(error?.localizedDescription)
                    
                }
            }
                
            else {
                do {
                    if let dict = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? NSDictionary {
                    
                    print("Got headers")
                        print(dict)
                        
                    if let  HeaderDict = dict["headers"] {
                    
                        let DbPath = getPath("AdMate.db").absoluteString
                        
                        print("DBPATH INSERT")
                        print(DbPath)

                        let db = try! Connection(DbPath)
                        
                        // Crash here

                        var headerdict = [String:Int]()
                        
                        var CurrencyDict = [String:String]()

                        
                        for i in 0...11 { // Getting the headers names
                            
                            if HeaderDict[i]["name"] != nil{
                                
                                if let dimention = (dict["headers"]![i]["name"] as? String) {
                                
                                    print(dimention)
                                    headerdict[dimention] = i
                                    
                                } else {
                                
                                    print("Error Getting Headers")
                                
                                }
                            }
                            
                            if let currency = (dict["headers"]![i]["currency"] as? String) {
                                
                                CurrencyDict["currency"] = currency // Getting the currency symbol
                            }
                            
                            
                            
                        }
                        
                        
                        // Saving the currency symbol after getting the $
                        
                        if CurrencyDict["currency"] != nil {
                            
                            let Symbol = GetCurrencySymbol(CurrencyDict["currency"]!)
                            
                            defaults.setObject(Symbol, forKey: "CCYSYMBOL")
                            defaults.synchronize()
                        
                        }
                        
                        
                        
                        if let RowData = dict["rows"] {
                            
                            if RowData.count != 0 {
                                
                                print(RowData)
                                
                                try db.run(AdDataTable.delete())
                                
                                print("Deleting ...")
                                
                                for i in 0...RowData.count - 1 { // Parsing the data
                                    

                                    let CurrentRow = dict["rows"]![i] as! [AnyObject]
                                    
//                                    print(CurrentRow[headerdict["DATE"]!])

                                     let insert = AdDataTable.insert(AdRequestData <- "\(CurrentRow[headerdict["AD_REQUESTS"]!])", AdRequestCoverageData <- "\(CurrentRow[headerdict["AD_REQUESTS_COVERAGE"]!])", AdRequestCTRData <- "\(CurrentRow[headerdict["AD_REQUESTS_CTR"]!])", AdRequestRPMData <- "\(CurrentRow[headerdict["AD_REQUESTS_RPM"]!])", ClicksData <- "\(CurrentRow[headerdict["CLICKS"]!])", CostPerClickData <- "\(CurrentRow[headerdict["COST_PER_CLICK"]!])", EarningsData <- "\(CurrentRow[headerdict["EARNINGS"]!])", PageViewRPMData <- "\(CurrentRow[headerdict["PAGE_VIEWS_RPM"]!])", PageViewsData <- "\(CurrentRow[headerdict["PAGE_VIEWS"]!])", MatchedAdREquestData <- "\(CurrentRow[headerdict["MATCHED_AD_REQUESTS"]!])", DateData <- "\(CurrentRow[headerdict["DATE"]!])")

                                        
                                        
                                        do {
                                            
                                            try db.run(insert)
                                            
                                        } catch _ {
                                            
                                            print("Insert Failed")
                                            
                                        }

                                    
                                }
                                
                                dispatch_async(dispatch_get_main_queue()) {
                                    
                                    defaults.setObject(NSDate(), forKey: "LastUpdateTimeStamp")
                                    defaults.synchronize()
                                    
                                    completion(UpdateStatus: true)
                                    // Main Queue
                                    
                                    
                                }
                              

                                
                            }
                        }

                        
                    } else {
                        
                            print("Could not get headers")
                        
                        }
                    }
                }
                    catch let error {
                        dispatch_async(dispatch_get_main_queue()) {
                            
                            print(error)
                            
                            completion(UpdateStatus: false)

                        }
                    }
                }
            
        }
        task.resume()
    
    
    }
    

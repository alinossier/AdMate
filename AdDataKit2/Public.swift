//
//  Public.swift
//  AdMate
//
//  Created by Antonin Linossier on 10/29/15.
//  Copyright © 2015 Antonin Linossier. All rights reserved.
//

import Foundation
import SQLite
import Cocoa
import SwiftyJSON
import AdMateOAuth

//import p2_OAuth2



public enum RowSelected {
    
    case Earnings
    case PageViews
    case Clicks
    case PageRPM
    case Coverage
    case CTR
    case CostPerClick
    
}







public struct AdData {

    public var AdRequest = Int?()
    public var AdRequestCoverage = Float?()
    public var AdRequestCTR = Float?()
    public var AdRequestRPM = Float?()
    public var AdClicks = Int?()
    public var AdCostPerClick = Float?()
    public var Earnings = Float?()
    public var PageViews = Int?()
    public var PageViewRPM = Float?()
    public var MatchedAdRequest = Int?()
    public var Date = NSDate?()

       public init(AdRequest: String, AdRequestCoverage: String, AdRequestCTR: String, AdRequestRPM: String, AdClicks: String, AdCostPerClick: String, Earnings: String, PageViews: String, PageViewRPM: String, MatchedAdRequest: String, Date: String)
        {
            
            self.AdRequest = ValidateDataFromDb(AdRequest, Type: "Int") as? Int
            self.AdRequestCoverage = ValidateDataFromDb(AdRequestCoverage, Type: "Float") as? Float
            self.AdRequestCTR = ValidateDataFromDb(AdRequestCTR, Type: "Float") as? Float
            self.AdRequestRPM = ValidateDataFromDb(AdRequestRPM, Type: "Float") as? Float
            self.AdClicks = ValidateDataFromDb(AdClicks, Type: "Int") as? Int
            self.AdCostPerClick = ValidateDataFromDb(AdCostPerClick, Type: "Float") as? Float
            self.Earnings = ValidateDataFromDb(Earnings, Type: "Float") as? Float
            self.PageViews = ValidateDataFromDb(PageViews, Type: "Int") as? Int
            self.PageViewRPM = ValidateDataFromDb(PageViewRPM, Type: "Float") as? Float
            self.MatchedAdRequest = ValidateDataFromDb(MatchedAdRequest, Type: "Int") as? Int
            self.Date = ValidateDataFromDb(Date, Type: "Date") as? NSDate
            
            
        }


}





func ValidateDataFromDb(Data:String, Type: String) -> AnyObject{
    
    
    switch Type
    {
    case "Date":
        
        if Data != "<null>" && Data != "0"{
            
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.dateFromString(Data)

        return date!
            
        } else {
        
            return NSDate()
            
        }
        
    case "Float":
        
        
        if Data != "<null>" && Data != "0"{
            
            return Data.floatValue
            
        } else {
            
            return Float(0)
            
        }
        
    case "Int":
        
        if Data != "<null>" && Data != "0"{
            
            
            return Int(Data)!
            
            
        } else {
            
            return Int(0)
            
        }
        
    default:
        
        
        
        return 0
        
        
    }
    
    
    
}


public extension String {
    var floatValue: Float {
        return (self as NSString).floatValue
    }
}




public extension String {
    
    /// Percent escape value to be added to a URL query value as specified in RFC 3986
    ///
    /// This percent-escapes all characters besize the alphanumeric character set and "-", ".", "_", and "~".
    ///
    /// http://www.ietf.org/rfc/rfc3986.txt
    ///
    /// :returns: Return precent escaped string.
    
    func stringByAddingPercentEncodingForURLQueryValue() -> String? {
        let characterSet = NSMutableCharacterSet.alphanumericCharacterSet()
        characterSet.addCharactersInString("-._~")
        
        return self.stringByAddingPercentEncodingWithAllowedCharacters(characterSet)
    }
    
}


public let UserIDDefault = String("UD29")

//public var documentsFolder = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]

public var documentsFolder = NSFileManager.defaultManager().containerURLForSecurityApplicationGroupIdentifier("4K3EUCP99P.AdMate")

public let defaults: NSUserDefaults = NSUserDefaults(suiteName: "4K3EUCP99P.AdMate")!

public var dbpath = (documentsFolder)?.URLByAppendingPathComponent("AdMate.db")

public func copyFile(fileName: NSString) {
    let dbPath = getPath(fileName as String)
    print("copyFile fileName=\(fileName) to path=\(dbPath)")
    let fileManager = NSFileManager.defaultManager()
    let fromPath = (NSBundle.mainBundle().resourceURL)!.URLByAppendingPathComponent(fileName as String)
    if !fileManager.fileExistsAtPath(dbPath.path!) {
        print("dB not found in document directory filemanager will copy this file from this path=\(fromPath.path) :::TO::: path=\(dbPath.path)")
        
        
            defaults.setObject(dbPath.path, forKey: "DBPath")
            defaults.synchronize()
        
        do {
            try fileManager.copyItemAtPath(fromPath.path!, toPath: dbPath.path!)
        } catch _ {
        }
    } else {
        print("DID-NOT copy dB file, file allready exists at path:\(dbPath)")
    }
}


public func getPath(fileName: String) -> NSURL {
    
    let documentsFolder = NSFileManager.defaultManager().containerURLForSecurityApplicationGroupIdentifier("4K3EUCP99P.AdMate")
    return documentsFolder!.URLByAppendingPathComponent(fileName)
    
    
}

public func ==(lhs: NSDate, rhs: NSDate) -> Bool {
    return lhs.isEqualToDate(rhs)
}


public func <(lhs: NSDate, rhs: NSDate) -> Bool {
    return lhs.compare(rhs) == .OrderedAscending
}

//extension NSDate: Comparable { }

public let AdDataTable = Table("AdData")

public let AdRequestData = Expression<String>("AD_REQUESTS")
public let AdRequestCoverageData = Expression<String>("AD_REQUESTS_COVERAGE")
public let AdRequestCTRData = Expression<String>("AD_REQUESTS_CTR")
public let AdRequestRPMData = Expression<String>("AD_REQUESTS_RPM")
public let ClicksData = Expression<String>("CLICKS")
public let CostPerClickData = Expression<String>("COST_PER_CLICK")
public let EarningsData = Expression<String>("EARNINGS")
public let PageViewRPMData = Expression<String>("PAGE_VIEWS_RPM")
public let PageViewsData = Expression<String>("PAGE_VIEWS")
public let MatchedAdREquestData = Expression<String>("MATCHED_AD_REQUESTS")
public let DateData = Expression<String>("DATE")

public extension Dictionary {
    
    /// Build string representation of HTTP parameter dictionary of keys and objects
    ///
    /// This percent escapes in compliance with RFC 3986
    ///
    /// http://www.ietf.org/rfc/rfc3986.txt
    ///
    /// :returns: String representation in the form of key1=value1&key2=value2 where the keys and values are percent escaped
    
    func stringFromHttpParameters() -> String {
        let parameterArray = self.map { (key, value) -> String in
            let percentEscapedKey = (key as! String).stringByAddingPercentEncodingForURLQueryValue()!
            let percentEscapedValue = (value as! String).stringByAddingPercentEncodingForURLQueryValue()!
            return "\(percentEscapedKey)=\(percentEscapedValue)"
        }
        
        return parameterArray.joinWithSeparator("&")
    }
    
}

public extension NSDate
{
    func isGreaterThanDate(dateToCompare : NSDate) -> Bool
    {
        //Declare Variables
        var isGreater = false
        
        //Compare Values
        if self.compare(dateToCompare) == NSComparisonResult.OrderedDescending
        {
            isGreater = true
        }
        
        //Return Result
        return isGreater
    }
    
    
    func isLessThanDate(dateToCompare : NSDate) -> Bool
    {
        //Declare Variables
        var isLess = false
        
        //Compare Values
        if self.compare(dateToCompare) == NSComparisonResult.OrderedAscending
        {
            isLess = true
        }
        
        //Return Result
        return isLess
    }
    
    
//    func isEqualToDate(dateToCompare : NSDate) -> Bool
//    {
//        //Declare Variables
//        var isEqualTo = false
//        
//        //Compare Values
//        if self.compare(dateToCompare) == NSComparisonResult.OrderedSame
//        {
//            isEqualTo = true
//        }
//        
//        //Return Result
//        return isEqualTo
//    }
    
    public func rounder (numbertoround: Float) -> NSString {
        
        let rounded: NSString
        
        if (numbertoround > 10){
            
            rounded = NSString(format: "%.02f", numbertoround)
            
        } else if (numbertoround < 1){
            
            rounded = NSString(format: "%.02f", numbertoround)
            
        } else {
            
            rounded = NSString(format: "%.02f", numbertoround)
            
        }
        return rounded
        
    }
    
    func addDays(daysToAdd : Int) -> NSDate
    {
        let secondsInDays : NSTimeInterval = Double(daysToAdd) * 60 * 60 * 24
        let dateWithDaysAdded : NSDate = self.dateByAddingTimeInterval(secondsInDays)
        
        //Return Result
        return dateWithDaysAdded
    }
    
    
    func addHours(hoursToAdd : Int) -> NSDate
    {
        let secondsInHours : NSTimeInterval = Double(hoursToAdd) * 60 * 60
        let dateWithHoursAdded : NSDate = self.dateByAddingTimeInterval(secondsInHours)
        
        //Return Result
        return dateWithHoursAdded
    }
}



public func GetCurrencySymbol(Code: String)-> String{

    if let path = NSBundle.mainBundle().pathForResource("Common-Currency", ofType: "json") {
        do {
            let data = try NSData(contentsOfURL: NSURL(fileURLWithPath: path), options: NSDataReadingOptions.DataReadingMappedIfSafe)
            let jsonObj = JSON(data: data)
            if jsonObj != JSON.null {
                
                if let currencycode = jsonObj[Code]["symbol"].string{
                
                return currencycode
                
                } else {
                
                    return "$"
                
                }
 
                
            } else {
                print("could not get json from file, make sure that file contains valid json.")
                return "$"
            }
        } catch let error as NSError {
            print(error.localizedDescription)
            return "$"
        }
    } else {
        print("Invalid filename/path.")
        return "$"
    }

}




public func ConvertPercentage(Percentage: Float)-> String{
    
    let Compromised = Percentage * 100
    
    return rounder(Float(Compromised))
    
}







//
//  ProcessingData.swift
//  AdMate
//
//  Created by Antonin Linossier on 11/4/15.
//  Copyright © 2015 Antonin Linossier. All rights reserved.
//

import Foundation
import Cocoa


public func rounder (numbertoround: Float) -> String {
    
    let rounded: NSString
    
    if (numbertoround > 10){
        
        rounded = NSString(format: "%.02f", numbertoround)
        
    } else if (numbertoround < 1){
        
        rounded = NSString(format: "%.02f", numbertoround)
        
    } else {
        
        rounded = NSString(format: "%.02f", numbertoround)
        
    }
    return rounded as String
    
}



public struct ProcessedData {
    
    public var AdRequest = Int?()
    public var AdRequestVar = String?()
    public var AdRequestPrev = String?()
    public var AdRequestVarImg = String?()
    
    public var AdRequestCoverage = Float?()
    public var AdRequestCoverageVar = String?()
    public var AdRequestCoveragePrev = String?()
    public var AdRequestCoverageVarImg = String?()
    
    public var AdRequestCTR = Float?()
    public var AdRequestCTRVar = String?()
    public var AdRequestCTRPrev = String?()
    public var AdRequestCTRVarImg = String?()
    
    public var AdRequestRPM = Float?()
    public var AdRequestRPMVar = String?()
    public var AdRequestRPMPrev = String?()
    public var AdRequestRPMVarImg = String?()
    
    public var AdClicks = Int?()
    public var AdClicksVar = String?()
    public var AdClicksPrev = String?()
    public var AdClicksVarImg = String?()
    
    public var AdCostPerClick = Float?()
    public var AdCostPerClickVar = String?()
    public var AdCostPerClickPrev = String?()
    public var AdCostPerClickVarImg = String?()
    
    public var Earnings = Float?()
    public var EarningsVar = String?()
    public var EarningsPrev = String?()
    public var EarningsVarImg = String?()
    
    public var PageViews = Int?()
    public var PageViewsVar = String?()
    public var PageViewsPrev = String?()
    public var PageViewsVarImg = String?()
    
    public var PageViewRPM = Float?()
    public var PageViewRPMVar = String?()
    public var PageViewRPMPrev = String?()
    public var PageViewRPMVarImg = String?()
    
    public var MatchedAdRequest = Int?()
    public var MatchedAdRequestVar = String?()
    public var MatchedAdRequestPrev = String?()
    public var MatchedAdRequestVarImg = String?()
    
    
    
    public init(AdRequest: Int, AdRequestCoverage: Float, AdRequestCTR: Float, AdRequestRPM: Float, AdClicks: Int, AdCostPerClick: Float, Earnings: Float, PageViews: Int, PageViewRPM: Float, MatchedAdRequest: Int, AdRequestPrev: Int, AdRequestCoveragePrev: Float, AdRequestCTRPrev: Float, AdRequestRPMPrev: Float, AdClicksPrev: Int, AdCostPerClickPrev: Float, EarningsPrev: Float, PageViewsPrev: Int, PageViewRPMPrev: Float, MatchedAdRequestPrev: Int)
    {
        
        
        
        func CalculatePercentageBetweenTwoInt(Integer1:AnyObject, Integer2: AnyObject)->String{
            
            
            // UNWRAP HERE YO
            
            let Difference: Float = Float(Integer1 as! NSNumber) - Float(Integer2 as! NSNumber)
            let Ratio = Difference / Float(Integer1 as! NSNumber)
            let Percentage = Ratio * 100
            let Rounded = rounder(Percentage)
            
            
            if Percentage > 0 {
                
                if Percentage > 500 {
                
                    return "(>500%)"
                
                } else {
                
                    return "(+ "+"\(Rounded)" + " %)"
                
                }
 
                
            } else {
                
                
                if Percentage < -500 {
                    
                    return "(> -500%)"
                    
                } else {
                    
                    return "("+"\(Rounded)" + " %)"
                    
                }
     
                
            }
            
            
        }
        
        
        
        
        
        self.AdRequest = AdRequest
        self.AdRequestVar = CalculatePercentageBetweenTwoInt(AdRequest, Integer2: AdRequestPrev)
        self.AdRequestPrev = String(AdRequestPrev)
        if AdRequest >= AdRequestPrev { self.AdRequestVarImg = "UP"} else { self.AdRequestVarImg = "DOWN"}
        
        self.AdRequestCoverage = AdRequestCoverage
        self.AdRequestCoverageVar = CalculatePercentageBetweenTwoInt(AdRequestCoverage, Integer2: AdRequestCoveragePrev)
        self.AdRequestCoveragePrev = rounder(AdRequestCoveragePrev * 100)
        if AdRequestCoverage >= AdRequestCoveragePrev { self.AdRequestCoverageVarImg = "UP"} else { self.AdRequestCoverageVarImg = "DOWN"}
        
        self.AdRequestCTR = AdRequestCTR
        self.AdRequestCTRVar = CalculatePercentageBetweenTwoInt(AdRequestCTR, Integer2: AdRequestCTRPrev)
        self.AdRequestCTRPrev = rounder(AdRequestCTRPrev)
        if AdRequestCTR >= AdRequestCTRPrev { self.AdRequestCTRVarImg = "UP"} else { self.AdRequestCTRVarImg = "DOWN"}
        
        self.AdRequestRPM = AdRequestRPM
        self.AdRequestRPMVar = CalculatePercentageBetweenTwoInt(AdRequestRPM, Integer2: AdRequestRPMPrev)
        self.AdRequestRPMPrev = rounder(AdRequestRPMPrev)
        if AdRequestRPM >= AdRequestRPMPrev { self.AdRequestRPMVarImg = "UP"} else { self.AdRequestRPMVarImg = "DOWN"}
        
        self.AdClicks = AdClicks
        self.AdClicksVar = CalculatePercentageBetweenTwoInt(AdClicks, Integer2: AdClicksPrev)
        self.AdClicksPrev = String(AdClicksPrev)
        if AdClicks >= AdClicksPrev { self.AdClicksVarImg = "UP"} else { self.AdClicksVarImg = "DOWN"}
        
        self.AdCostPerClick = AdCostPerClick
        self.AdCostPerClickVar = CalculatePercentageBetweenTwoInt(AdCostPerClick, Integer2: AdCostPerClickPrev)
        self.AdCostPerClickPrev = rounder(AdCostPerClickPrev)
        if AdCostPerClick >= AdCostPerClickPrev { self.AdCostPerClickVarImg = "UP"} else { self.AdCostPerClickVarImg = "DOWN"}
        
        self.Earnings = Earnings
        self.EarningsVar = CalculatePercentageBetweenTwoInt(Earnings, Integer2: EarningsPrev)
        self.EarningsPrev = String(EarningsPrev)
        if Earnings >= EarningsPrev { self.EarningsVarImg = "UP"} else { self.EarningsVarImg = "DOWN"}
        
        self.PageViews = PageViews
        self.PageViewsVar = CalculatePercentageBetweenTwoInt(PageViews, Integer2: PageViewsPrev)
        self.PageViewsPrev = String(PageViewsPrev)
        if Float(PageViews) >= Float(PageViewsPrev) { self.PageViewsVarImg = "UP"
        } else { self.PageViewsVarImg = "DOWN"}

        
        self.PageViewRPM = PageViewRPM
        self.PageViewRPMVar = CalculatePercentageBetweenTwoInt(PageViewRPM, Integer2: PageViewRPMPrev)
        self.PageViewRPMPrev = rounder(PageViewRPMPrev)
        if PageViewRPM >= PageViewRPMPrev { self.PageViewRPMVarImg = "UP"} else { self.PageViewRPMVarImg = "DOWN"}
        
        self.MatchedAdRequest = MatchedAdRequest
        self.MatchedAdRequestVar = CalculatePercentageBetweenTwoInt(MatchedAdRequest, Integer2: MatchedAdRequestPrev)
        self.MatchedAdRequestPrev = String(MatchedAdRequestPrev)
        if MatchedAdRequest >= MatchedAdRequestPrev { self.MatchedAdRequestPrev = "UP"} else { self.MatchedAdRequestPrev = "DOWN"}
        
        
        
        
        
    }
}
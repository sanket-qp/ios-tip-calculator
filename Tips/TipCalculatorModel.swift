//
//  TipCalculatorModel.swift
//  Tips
//
//  Created by Sanket Patel on 8/15/14.
//  Copyright (c) 2014 Sanket Patel. All rights reserved.
//

//
//  TipCalculatorModel.swift
//  TipCalculator
//
//  Created by Main Account on 7/7/14.
//  Copyright (c) 2014 Razeware LLC. All rights reserved.
//
import Foundation

class TipCalculatorModel {

    let tipPercentages = [0.18, 0.20, 0.25]
    let usualTips = [
        
        "18%": 0.18,
        "20%": 0.20,
        "25%": 0.25
    ]
    
    func getPossibleTips() -> [String] {
    
        //TODO :: not efficient for large collections
        var tips = Array(usualTips.keys)
        sort(&tips)
        return tips
    }
    
    func getTipPercentageFromString(tip: String) -> Double {
    
        return usualTips[tip]!
        
    }
    
    func getTipIndexFromValue(tipString: String) -> Int {
    
        let tips = getPossibleTips();
        var index = find(tips, tipString)
        if index == nil {
            
            index = 0
        }
        return index!
    }
    
    func getTipValueForIndex(index: Int) -> String {
    
        var tips = getPossibleTips()
        return tips[index]
    }
    
    func getTipPercentageForIndex(index: Int) -> Double {
    
        let tips = getPossibleTips()
        let chosen = tips[index]
        return usualTips[chosen]!
    }
    
    func calculateTip(billAmount: Double, tipPercentage: Double) -> (tip: Double, total: Double) {
    
        var tip = billAmount * tipPercentage
        return (tip, billAmount + tip)
    }
    
    
    //TODO :: cache keys should be set as constants in a central file
    func getPreferredTip() -> String {
    
        var defaults = NSUserDefaults.standardUserDefaults()
        var preferredTip: AnyObject! = defaults.objectForKey("preferredTip")
        
        if preferredTip == nil {
        
            preferredTip = "0.18"
        }
    
        return preferredTip as String
    }
    
    func setPreferredTip(preferredTip: String) {
    
        //TODO :: better error checking
        var defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(preferredTip, forKey: "preferredTip")

    }
    
    func getIndexOfPreferredTip() -> Int {
    
        let preferredTip = getPreferredTip()
        return getTipIndexFromValue(preferredTip)
    }
    
    func setLastBillAmount(billAmount: String) {
    
        var defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(billAmount, forKey: "billAmount")
    }
    
    func getLastBillAmount() -> String {
    
        var defaults = NSUserDefaults.standardUserDefaults()
        var billAmount: AnyObject! = defaults.objectForKey("billAmount")
        
        if billAmount == nil {
            
            billAmount = ""
        }
        
        return billAmount as String
    }
    
    func clearLastBillAmount() {
    
        var defaults = NSUserDefaults.standardUserDefaults()
        println("hello : \(getLastBillAmount())")
        defaults.removeObjectForKey("billAmount")
    }
    
    func setLastUsed(t: Double) {
        
        var defaults = NSUserDefaults.standardUserDefaults()
        defaults.setDouble(t, forKey: "lastUsed")
    }
    
    func getLastUsed() -> Double {
    
        var defaults = NSUserDefaults.standardUserDefaults()
        var lastUsed = defaults.doubleForKey("lastUsed")
        
        if lastUsed == nil {
        
            lastUsed = CFAbsoluteTimeGetCurrent()
        }
        
        return lastUsed
    }
    
}

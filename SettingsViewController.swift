//
//  SettingsViewController.swift
//  Tips
//
//  Created by Sanket Patel on 8/15/14.
//  Copyright (c) 2014 Sanket Patel. All rights reserved.
//
import UIKit

class SettingsViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var tipPercentagePicker: UIPickerView!
    let calculator = TipCalculatorModel()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        tipPercentagePicker.dataSource = self
        tipPercentagePicker.delegate = self
    
    }

    override func viewWillAppear(animated: Bool) {
        
        let preferredTip = calculator.getPreferredTip()
        let index = calculator.getIndexOfPreferredTip()
        tipPercentagePicker.selectRow(index, inComponent: 0, animated: animated)

    }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView!) -> Int {
        
        return 1
    }
    
    func pickerView(pickerView: UIPickerView!, numberOfRowsInComponent component: Int) -> Int {
    
        return calculator.usualTips.count
    }
    
    func pickerView(pickerView: UIPickerView!, titleForRow row: Int, forComponent component: Int) -> String {
    
        return calculator.getTipValueForIndex(row)
    }
    
    func pickerView(pickerView: UIPickerView!, didSelectRow row: Int, inComponent component: Int) {
     
        var preferredTipString = calculator.getPossibleTips()[row]
        calculator.setPreferredTip(preferredTipString)
    }
}

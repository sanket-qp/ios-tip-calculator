//
//  ViewController.swift
//  Tips
//
//  Created by Sanket Patel on 8/15/14.
//  Copyright (c) 2014 Sanket Patel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
                            
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var settingsButton: UIBarButtonItem!
    @IBOutlet weak var numOfPeopleSlider: UISlider!
    @IBOutlet weak var numOfPeopleLabel: UILabel!
    @IBOutlet weak var perPersonLabel: UILabel!
    
    let calculator = TipCalculatorModel()

    override func viewDidLoad() {
        
        super.viewDidLoad()
        setupUI()
    }

    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
    }


    @IBAction func onEditingChanged(sender: AnyObject) {
        
        calculate()

    }
    @IBAction func onSettingsClicked(sender: AnyObject) {
        
    }
    
    @IBAction func onTipPctChanged(sender: AnyObject) {
        
        calculate()
    }
    
    @IBAction func onTap(sender: AnyObject) {
        
        view.endEditing(true)
    }
    
    @IBAction func numOfPeopleChanged(sender: AnyObject) {
        
        numOfPeopleLabel.text = "\(Int(numOfPeopleSlider.value))"
        calculate()
    }
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
        billField.text = calculator.getLastBillAmount()
        calculate()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        
    }
    
    func setupUI() {
    
        tipLabel.text = "$0.00"
        totalLabel.text = "$0.00"
        
        // populate tipControl
        let possibleTips = calculator.getPossibleTips()
        for (index, tipValue) in enumerate(possibleTips) {
            
            tipControl.setTitle(tipValue, forSegmentAtIndex: index)
        }
        
        // highlight segment of preferred Tip if any
        let index = calculator.getIndexOfPreferredTip()
        tipControl.selectedSegmentIndex = index
        
        // number of people
        numOfPeopleLabel.text = "\(Int(numOfPeopleSlider.value))"
    }
    
    func calculate() {

        // calculate tip and set the labels
        let chosenTip = calculator.getTipPercentageForIndex(tipControl.selectedSegmentIndex)
        var billAmount = Double((billField.text as NSString).doubleValue)
        let (tip, total) = calculator.calculateTip(billAmount, tipPercentage: chosenTip)
        
        let numOfPeople = Int(numOfPeopleSlider.value)
        let perPerson = total/Double(numOfPeople)
        
        tipLabel.text = String(format: "$%0.2f", tip)
        totalLabel.text = String(format: "$%0.2f", total)
        perPersonLabel.text = String(format: "$%0.2f", perPerson)
        calculator.setLastBillAmount(billField.text)
    }
}


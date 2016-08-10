//
//  ViewController.swift
//  Tip.ly
//
//  Created by Michael Huh on 7/14/16.
//  Copyright © 2016 Michael Huh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    /** VARIABLES _______________________________________________________________ **/
    
    @IBOutlet weak var percentageLabel: UILabel! // References the percentage text.
    @IBOutlet weak var tipLabel: UILabel! // References the tip amount text.
    @IBOutlet weak var totalLabel: UILabel! // References the total amount text.
    @IBOutlet weak var tipControl: UISegmentedControl! // References the tip controls.
    @IBOutlet weak var customTipSlider: UISlider! // References the custom tip slider.
    @IBOutlet weak var billField: UITextField! // References the bill input field.
    
    let defaults = NSUserDefaults.standardUserDefaults() // References the user defaults object.
    let KEY_BILL_OPTION = "key_bill_option" // Constant that references the key name for the default bill option.
    let KEY_BILL_VALUE = "key_bill_value" // Constant that references the key name for the default bill value.
    let KEY_PERCENT_OPTION = "key_percent_option" // Constant that references the key name for the default percent option.
    let KEY_PERCENT_VALUE = "key_percent_value" // Constant that references the key name for the default percent value.
    
    var currentTipPercentage = Float(0.15); // Stores the current percentage value.
    
    /** VIEW CONTROLLER METHODS _________________________________________________ **/
    
    // viewDidLoad(): Runs after the view has loaded. Do any additional setup after 
    // loading the view, typically from a nib. Equivalent to onCreate() for Android.
    override func viewDidLoad() {
        super.viewDidLoad()
        presetLabels() // Sets the initial values for the bill field and tip percentage label text.
        calculateTip(NSNull) // Calculates the tip and total value based on the bill value.
        print("viewDidLoad() called.")
    }
    
    // viewWillAppear(): Runs after viewDidLoad(). Equivalent to onStart() and 
    // onResume() for Android.
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear() called.")
    }
    
    // viewDidAppear(): Runs after viewWillAppear().
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        print("viewDidAppear() called.")
    }
    
    // viewWillDisappear(): Runs when the view begins to disappear. Equivalent to
    // onPause() and onStop() for Android.
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        print("viewWillDisappear() called.")
    }
    
    // viewDidDisappear(): Runs after viewWillDisappear(), when the view has fully disappeared.
    // Equivalent to 
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        print("viewDidDisappear() called.")
    }
    
    // didReceiveMemoryWarning(): Dispose of any resources that can be recreated.
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /** LABEL METHODS ___________________________________________________________ **/
    
    // presetLabels(): Presets the field and label text.
    func presetLabels() {
        
        let retainBillOption = defaults.boolForKey(KEY_BILL_OPTION) // Retrieves the retain bill option from user defaults.
        let retainBillValue = defaults.doubleForKey(KEY_BILL_VALUE) // Retrieves the retain bill value from user defaults.
        let retainPercentOption = defaults.boolForKey(KEY_PERCENT_OPTION) // Retrieves the percent tip option from user defaults.
        let retainPercentValue = defaults.floatForKey(KEY_PERCENT_VALUE) // Retrieves the percent tip value from user defaults.
    
        // RETAIN BILL VALUE:
        if (retainBillOption) {
            billField.text = String(format: "%.2f", retainBillValue)
        } else {
            billField.text = String(format: "%.2f", 0)
        }
        
        // RETAIN TIP PERCENTAGE VALUE:
        if (retainPercentOption) {
            currentTipPercentage = retainPercentValue // Sets the retained percent value to currentTipPercentage.
        }
        
        percentageLabel.text = String(format: "%.2f", currentTipPercentage * 100) + "%" // Sets the percentage label text value.
        customTipSlider.setValue(currentTipPercentage, animated: false) // Sets the current tip percentage value to the slider.
    }

    /** TOUCH METHODS ___________________________________________________________ **/
    
    // onTap(): Runs when screen is tapped.
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true) // Dismisses the keyboard on tap.
    }
    
    /** CALCULATE METHODS _______________________________________________________ **/
    
    // calculateTip(): Calculates the tip value when the user enters a value in the bill field.
    @IBAction func calculateTip(sender: AnyObject) {
        
        currentTipPercentage = customTipSlider.value // Gets the current percentage value.
        
        // Constant variable that converts the value in the bill field to a double. Sets the 
        // value to 0 if value could not be converted to Double.
        let bill = Double(billField.text!) ?? 0
        
        let tip = bill * Double(currentTipPercentage) // Value for the tip text.
        let total = bill + tip // Value for the total text.
        
        percentageLabel.text = String(format: "%.2f", currentTipPercentage * 100) + "%" // Sets the percentage label text value.
        tipLabel.text = String(format: "$%.2f", tip) // Sets the tip label text value.
        totalLabel.text = String(format: "$%.2f", total) // Sets the total label text value.
        
        saveUserDefaultValues(bill) // Saves the tip and percentage values into user defaults.
    }
    
    /** USER DEFAULTS METHODS ______________________________________________________ **/
    
    // saveUserDefaultValues(): Saves the bill and tip percentage values into user defaults.
    func saveUserDefaultValues(bill: Double) {
        
        let retainBillOption = defaults.boolForKey(KEY_BILL_OPTION) // Retrieves the retain bill option from user defaults.
        let retainPercentOption = defaults.boolForKey(KEY_PERCENT_OPTION) // Retrieves the percent tip option from user defaults.
        
        if (retainBillOption) {
            defaults.setDouble(bill, forKey: KEY_BILL_VALUE) // Sets the current bill value.
        }
        
        if (retainPercentOption) {
            defaults.setFloat(currentTipPercentage, forKey: KEY_PERCENT_VALUE) // Sets the current percent value.
        }
        
        defaults.synchronize() // Saves the changed value to user defaults.
    }
}


//
//  ViewController.swift
//  Tip.ly
//
//  Created by Michael Huh on 7/14/16.
//  Copyright © 2016 Michael Huh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    /** VARIABLES _________________________________________ **/
    
    @IBOutlet weak var tipLabel: UILabel! // References the tip amount label.
    
    @IBOutlet weak var totalLabel: UILabel! // References the total amount label.
    @IBOutlet weak var billField: UITextField! // References the bill input field.
    @IBOutlet weak var tipControl: UISegmentedControl! // References the tip controls.
    
    /** METHODS ___________________________________________ **/
    
    // viewDidLoad(): Runs after the view has loaded.
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    // didReceiveMemoryWarning()
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // onTap(): Runs when screen is tapped.
    @IBAction func onTap(sender: AnyObject) {
        
        view.endEditing(true) // Dismisses the keyboard on tap.
    }
    
    // calculateTip(): Calculates the tip value when the user enters a value in the bill field.
    @IBAction func calculateTip(sender: AnyObject) {
        
        let tipPercentages = [0.15, 0.18, 0.2]
        
        // Constant variable that converts the value in the bill field to a double. Sets the value to 0 if value could not be converted to Double.
        let bill = Double(billField.text!) ?? 0
        
        let tip = bill * tipPercentages[tipControl.selectedSegmentIndex] // Value for the tip text.
        let total = bill + tip // Value for the total text.
        
        tipLabel.text = String(format: "$%.2f", tip) // Sets the tip label text value.
        totalLabel.text = String(format: "$%.2f", total) // Sets the total label text value.
    }
}


//
//  ConfigurationViewController.swift
//  remoteControl
//
//  Created by Julio on 2/27/19.
//  Copyright © 2019 Julio Lama. All rights reserved.
//

import UIKit

class ConfigurationViewController: UIViewController {

    @IBOutlet weak var channelsSegmentedCtrl: UISegmentedControl!
    @IBOutlet weak var channelLabel: UILabel!
    @IBOutlet weak var channelRangeChanger: UIStepper!
    
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    @IBOutlet weak var labelTextField: UITextField!
    
    
    // the current channel value as a string.
    var currentChannel: String = "1"
    
    
    // thew new button name & segmentIndex.
    var newBtnName: String = ""
    var segmentIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        defaultValues()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    /**
     Sets default values.
    */
    private func defaultValues() {
        self.channelLabel.text = "1"
        self.channelRangeChanger.value = Double(currentChannel)!
        self.segmentIndex = -1
        self.newBtnName = ""
    }
    
    /**
        Function for segment control
    */
    @IBAction func channelSelector(_ sender: UISegmentedControl) {
        var segmentVals: [Int: String] = [:]
        let size = sender.numberOfSegments
        var index = 0
        while (index < size) {
            segmentVals.updateValue(sender.titleForSegment(at: index)!, forKey: index)
            index += 1
        }
        self.currentChannel = segmentVals[sender.selectedSegmentIndex]!
        
        self.channelLabel.text = self.currentChannel
        self.channelRangeChanger.value = Double(self.currentChannel)!
        
    }
    
    
    
    /**
      The Stepper
    */
    @IBAction func channelChanged(_ sender: UIStepper) {
        sender.minimumValue = 1
        sender.maximumValue = 99
        self.channelLabel.text = String(Int(sender.value))
    }
    
    
    /**
      When the user hits return after entering the new button name, the data is passed to the
      object TVData.swift
    */
    @IBAction func editingEnded(_ sender: UITextField) {
        let minSize = 4
        let okayAction = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
        
        var message = ""
        var alertCtrl: UIAlertController;
        
        if let textFieldSize = sender.text?.count {
            if textFieldSize > minSize {
                message = "Maximum size for the new button's name is 4."
                alertCtrl = UIAlertController(title: "Settings", message: message, preferredStyle: .alert)
                
                alertCtrl.addAction(okayAction)
                present(alertCtrl, animated: true, completion: nil)
            }
            else if textFieldSize <= 1 {
                message = "Button's new name is too short."
                alertCtrl = UIAlertController(title: "Settings", message: message, preferredStyle: .alert)
                
                alertCtrl.addAction(okayAction)
                present(alertCtrl, animated: true, completion: nil)
            }
        }
    }
    
    

    /**
      Dismisses the keyboard when the label is not touched and when it receives a "return".
    */
    @IBAction func textFieldNotTouched(_ sender: UITextField) {
        sender.resignFirstResponder()
        self.view.endEditing(true)
    }
    
    
    /**
     Helper function for "editingDidEnd" function.
    */
    private func setNewButtonName(_ textField: UITextField) {
        if self.channelLabel.text == "1" {
            self.segmentIndex = 0
        }
        else if self.channelLabel.text == "2" {
            self.segmentIndex = 1
        }
        else if self.channelLabel.text == "3" {
            self.segmentIndex = 2
        }
        else if self.channelLabel.text == "4" {
            self.segmentIndex = 3
        }
        else if self.channelLabel.text != "1" || self.channelLabel.text != "2" || self.channelLabel.text != "3" || self.channelLabel.text != "4" {
            return
        }
        self.newBtnName = textField.text!
        TVData.sharedInstance.setButtonName(self.newBtnName, self.segmentIndex)
    }
    
    /**
        Saves the configuration to the TVData.swift object.
    */
    @IBAction func saveConfiguration(_ sender: UIButton) {
        if self.labelTextField.text == "" {
            return
        }
        setNewButtonName(self.labelTextField)
    }
    
    
    /**
        Cancels the action.
    */
    @IBAction func cancel(_ sender: UIButton) {
        self.labelTextField.text = ""
    }
    
    
    
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
}

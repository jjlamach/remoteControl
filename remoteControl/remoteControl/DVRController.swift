//
//  DVRController.swift
//  remoteControl
//
//  Created by Julio on 2/19/19.
//  Copyright © 2019 Julio Lama. All rights reserved.
//

import UIKit

class DVRController: UIViewController {

    @IBOutlet weak var dvrPowerState: UILabel!
    
    
    @IBOutlet weak var dvrOnOffState: UILabel!
    
    
    @IBOutlet var dvrButtons: [UIButton]!
    
    
    @IBOutlet weak var dvrCtrlState: UILabel!
    
    
    @IBOutlet weak var onOffButton: UISwitch!
    
    // Enum for DVR control states.
    enum DvrControlStates: String, CaseIterable {
        case Off = ""
        case Stopped = "Stopped"
        case Playing = "Playing"
        case Paused = "Paused"
        case FastForwarding = "Fast Forwarding"
        case FastRewinding = "Fast rewinding"
        case Recording = "Recording"
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.onOffButton.isOn = false
        self.dvrOnOffState.text = "Off"
        enableOrDisableButtons(dvrButtons, onOffButton)
    }
    
    /*
        Segue to go back to the TV controller.
    */
    @IBAction func switchToTV(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }

    
    /*
        On/Off action button.
    */
    @IBAction func dvrOnOffBtnAction(_ sender: UISwitch) {
        if sender.isOn {
           dvrOnOffState.text = "On"
            dvrCtrlState.text = DvrControlStates.Stopped.rawValue
            enableOrDisableButtons(dvrButtons, sender)
        }
        else {
            dvrOnOffState.text = "Off"
            dvrCtrlState.text = DvrControlStates.Off.rawValue
            enableOrDisableButtons(dvrButtons, sender)
        }
    }
    
    /*
        Disables all buttons when the power is "Off".
    */
    private func enableOrDisableButtons(_ buttons: [UIButton], _ dvrState: UISwitch) -> Void {
        if !dvrState.isOn {
            for button in buttons {
                let currentBtn = button
                if currentBtn.isEnabled {
                    currentBtn.isEnabled = false
                }
            }
        }
        else if dvrState.isOn {
            for button in buttons {
                let currentBtn = button
                if !currentBtn.isEnabled {
                    currentBtn.isEnabled = true
                }
            }
        }
    }
    
    
    /*
        Alerts that the DVR controler is off.
    */
    private func generalAlertMessage(message: String) -> Void {
        let alertCtrl: UIAlertController = UIAlertController()
        let message = message
        
        let alertAction: UIAlertAction = UIAlertAction(title: message, style: .default, handler: nil)
        
        alertCtrl.addAction(alertAction)
        present(alertCtrl, animated: true, completion: nil)
    }
    
    
    
    /*
     Gives the action to change state.
    */
    private func changeCurrentState(button: UIButton)-> Void {
        let title = "Change Current State?"
        let message = "You have selected state: \(button.currentTitle!)"
        
        // alert controller.
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
    
        // get the button
        let theButton = getButton(button.currentTitle!, buttons: dvrButtons)
        
        
        let okayAction = UIAlertAction(
            title: "Proceed to \(theButton.currentTitle!)",
            style: .default,
            handler:
            {
                (action: UIAlertAction!)
                    in
                self.dvrCtrlState.text = self.getDVRstate(theButton)
            }
        )
        
        // the cancel action.
        let cancelAction = UIAlertAction(
            title: "Cancel Current DVR State",
            style: .destructive,
            handler: {
                (action: UIAlertAction!)
                in
               return
            }
        )
        
        
        
        alertController.addAction(cancelAction)
        alertController.addAction(okayAction)
        present(alertController, animated: true, completion: nil)
    }
    
    /*
        Gets the current DVRState from the button that has been pressed.
    */
    private func getDVRstate(_ pressedBtn: UIButton) -> String {
        var result: String = ""
        var tempStr:String = ""
        for button in dvrButtons {
            if button == pressedBtn {
                tempStr = button.currentTitle!
            }
        }
        if tempStr == "Play" {
            result = DvrControlStates.Playing.rawValue
        }
        else if tempStr == "Stop" {
            result = DvrControlStates.Stopped.rawValue
        }
        else if tempStr == "Pause" {
            result = DvrControlStates.Paused.rawValue
        }
        else if tempStr == "Fast Forward" {
            result = DvrControlStates.FastForwarding.rawValue
        }
        else if tempStr == "Fast Rewind" {
            result = DvrControlStates.FastRewinding.rawValue
        }
        else if tempStr == "Record" {
            result = DvrControlStates.Recording.rawValue
        }
        return result
    }
    
    

    /*
     Gets a button from the buttons collection.
    */
    private func getButton(_ buttonName: String,
                           buttons: [UIButton]) -> UIButton {
        var result: UIButton? = nil
        for button in buttons {
            if button.currentTitle == buttonName {
                result = button
                break
            }
        }
        return result!
    }
    
    
    /*
        Stop button action.
    */
    @IBAction func stop(_ sender: UIButton) {
        dvrCtrlState.text = DvrControlStates.Stopped.rawValue
    }
    
    
    
    /*
        The record button action.
    */
    @IBAction func record(_ sender: UIButton) {
        if dvrCtrlState.text != "Stopped" {
            changeCurrentState(button: sender)
        }
        else if dvrCtrlState.text == "Stopped" {
            dvrCtrlState.text = DvrControlStates.Recording.rawValue
        }
    }
    
    
    @IBAction func play(_ sender: UIButton) {
        if self.dvrCtrlState.text == "Recording" {
            changeCurrentState(button: sender)
        }
        else {
            self.dvrCtrlState.text = DvrControlStates.Playing.rawValue
        }
    }
    
    @IBAction func pause(_ sender: UIButton) {
        if self.dvrCtrlState.text == "Recording" {
            changeCurrentState(button: sender)
        }
        else if self.dvrCtrlState.text == "Playing" {
            self.dvrCtrlState.text = DvrControlStates.Paused.rawValue
        }
        else if self.dvrCtrlState.text != "Playing" {
            generalAlertMessage(message: "Must be in Playing state.")
        }
    }
    
    @IBAction func fastForwarding(_ sender: UIButton) {
        if self.dvrCtrlState.text == "Recording" {
            changeCurrentState(button: sender)
        }
        else if self.dvrCtrlState.text == "Playing" {
            self.dvrCtrlState.text = DvrControlStates.FastForwarding.rawValue
        }
        else if self.dvrCtrlState.text != "Playing" {
            generalAlertMessage(message: "Must be in Playing state.")
        }
    }
    
    @IBAction func fastRewinding(_ sender: UIButton) {
        if self.dvrCtrlState.text == "Recording" {
            changeCurrentState(button: sender)
        }
        else if self.dvrCtrlState.text == "Playing" {
            self.dvrCtrlState.text = DvrControlStates.FastRewinding.rawValue
        }
        else if self.dvrCtrlState.text != "Playing" {
            generalAlertMessage(message: "Must be in Playing state.")
        }
    }
}

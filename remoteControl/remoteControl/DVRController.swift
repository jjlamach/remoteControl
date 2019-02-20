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
    enum DvrControlStates: String {
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
        // Do any additional setup after loading the view.
        onOffButton.isOn = false
        dvrOnOffState.text = "Off"
        disableAllButtons(dvrButtons)
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
            enableAllButtons(dvrButtons)
            dvrCtrlState.text = DvrControlStates.Stopped.rawValue
        }
        else {
            dvrOnOffState.text = "Off"
            dvrCtrlState.text = DvrControlStates.Off.rawValue
            disableAllButtons(dvrButtons)
        }
    }
    
    /*
        Function that disables all buttons.
    */
    func disableAllButtons(_ buttons: [UIButton]) -> Void {
        for button in buttons {
            if button.isEnabled {
                button.isEnabled = false
            }
        }
    }
    
    /*
     Function that enables all buttons.
    */
    func enableAllButtons(_ buttons: [UIButton]) -> Void {
        for button in buttons {
            if !button.isEnabled {
                button.isEnabled = true
            }
        }
    }
    
    
    /*
     The“Play” button will start or resume normal playing.Pausing,fastforwarding
     or rewinding is only possible when the DVR is in the Playing state.
    */
    @IBAction func play(_ sender: UIButton) {
        verifyIfButtonIsAvailable(sender)
        if sender.isEnabled && self.onOffButton.isOn {
            ctrlInPlayingState()
        }
    }
    
    // helper function for the "Play" button.
    private func ctrlInPlayingState()-> Void {
        let buttonNames: [String] = [
            "Pause", "Fast Forward", "Fast Rewind",
            "Play", "Stop"
        ]
        for button in dvrButtons {
            if buttonNames.contains(button.currentTitle!) {
                button.isEnabled = true
            }
            if !buttonNames.contains(button.currentTitle!) {
                button.isEnabled = false
            }
        }
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
        verifyIfButtonIsAvailable(sender)
        enableAllButtons(dvrButtons)
    }
    
    /*
        Detects the current state of the DVR controller.
    */
    @IBAction func dvrCtrlStateIdentifier(_ sender: UIButton) {
        verifyIfButtonIsAvailable(sender)
        if sender.isEnabled {
            let currentBtnName = sender.currentTitle!
            if currentBtnName == "Play" {
                dvrCtrlState.text = DvrControlStates.Playing.rawValue
            }
            else if currentBtnName == "Stop" {
                dvrCtrlState.text = DvrControlStates.Stopped.rawValue
            }
            else if currentBtnName == "Pause" {
                dvrCtrlState.text = DvrControlStates.Paused.rawValue
            }
            else if currentBtnName == "Fast Forward" {
                dvrCtrlState.text = DvrControlStates.FastForwarding.rawValue
            }
            else if currentBtnName == "Fast Rewind" {
                dvrCtrlState.text = DvrControlStates.FastRewinding.rawValue
            }
            else if currentBtnName == "Record" {
                dvrCtrlState.text = DvrControlStates.Recording.rawValue
            }
        }
    }
    
    /*
        The record button action.
    */
    @IBAction func record(_ sender: UIButton) {
        verifyIfButtonIsAvailable(sender)
        let buttonNames: [String] = [
            "Play", "Pause", "Fast Forward",
            "Fast Rewind"
        ]
        if sender.isEnabled && onOffButton.isOn {
            for button in dvrButtons {
                let currentButton = button
                if buttonNames.contains(currentButton.currentTitle!) {
                    currentButton.isEnabled = false
                }
            }
        }
    }
    
    /*
        If the passed UIButton is enabled a Pop-up alert will be shown.
    */
    private func verifyIfButtonIsAvailable(_ button: UIButton) -> Void {
        if button.isEnabled {
            return
        }
        else if !button.isEnabled {
            let title = "Canceling Current DVR Controler Action"
            let notEnabledBtn: UIAlertController = UIAlertController( title: title, message: "", preferredStyle: .alert)
            
            let cancelAction = UIAlertAction(title: "Canceling current DVR Operation", style: .cancel, handler: nil)
            
            let okayAction = UIAlertAction(title: "Confirm", style: .default, handler: nil)
            
            notEnabledBtn.addAction(cancelAction)
            notEnabledBtn.addAction(okayAction)
            present(notEnabledBtn, animated: true, completion: nil)
        }
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

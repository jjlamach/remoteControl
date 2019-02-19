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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func switchToTV(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }


    
    @IBAction func dvrStateRecognizer(_ sender: UIButton) {
        
    }
    
    
    @IBAction func dvrOnOffBtnAction(_ sender: UISwitch) {
        if sender.isOn {
           dvrOnOffState.text = "On"
            for button in dvrButtons {
                let current = button
                if !current.isEnabled {
                    current.isEnabled = true
                }
            }
        }
        else {
            dvrOnOffState.text = "Off"
            for button in dvrButtons {
                let current = button
                if current.isEnabled {
                    current.isEnabled = false
                }
            }
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

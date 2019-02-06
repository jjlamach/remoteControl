//
//  ViewController.swift
//  remoteControl
//
//  Created by Julio on 2/5/19.
//  Copyright © 2019 Julio Lama. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // channels
    @IBOutlet weak var Channels: UISegmentedControl!
    
   /* On/Off button */
    @IBOutlet weak var power: UISwitch!
    
    /* Slider. */
    @IBOutlet weak var volumeSlider: UISlider!
    
    /* Channel buttons. */
    @IBOutlet weak var zero: UIButton!
    @IBOutlet weak var one: UIButton!
    @IBOutlet weak var two: UIButton!
    @IBOutlet weak var three: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


}


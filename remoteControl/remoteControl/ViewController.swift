//
//  ViewController.swift
//  remoteControl
//
//  Created by Julio on 2/5/19.
//  Copyright © 2019 Julio Lama. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    /* Channels */
    @IBOutlet weak var Channels: UISegmentedControl!
    
   /* On/Off button */
    @IBOutlet weak var power: UISwitch!
    
    /* Slider. */
    @IBOutlet weak var volumeSlider: UISlider!
    
    /* Warnings and messages */
    let messageTVisOff = "Your TV is off. Turn it on"
    var watching = ""
    
    
    /* Channel buttons. */
    @IBOutlet weak var zero: UIButton!
    @IBOutlet weak var one: UIButton!
    @IBOutlet weak var two: UIButton!
    @IBOutlet weak var three: UIButton!
    @IBOutlet weak var four: UIButton!
    @IBOutlet weak var five: UIButton!
    @IBOutlet weak var six: UIButton!
    @IBOutlet weak var seven: UIButton!
    @IBOutlet weak var eight: UIButton!
    @IBOutlet weak var nine: UIButton!
    
    /* Channels buttons +/- */
    @IBOutlet weak var chUp: UIButton!
    @IBOutlet weak var chDown: UIButton!
    
    
    /* Values. */
    @IBOutlet weak var powerValue: UILabel!
    
    @IBOutlet weak var volumeValue: UILabel!
    
    /* Channel selected */
    @IBOutlet weak var channelValue: UILabel!
    
    
    /*
        Array to hold two digits (0 - 99) channels.
    */
    var array:[Int] = []
    var digits:[Int] = []
    
    
    
    /*
        Favorite channels images.
    */
    @IBOutlet weak var channelImage: UIImageView!
    
    /*
        Turn on/off
    */
    @IBAction func power(_ sender: UISwitch) {
        self.power = sender
        if self.power.isOn {
            self.powerValue.text = "On"
            selectedChannel(Channels)
        } else {
            resetValues()
        }
    }
    
    /*
        Sets up the volume.
    */
    @IBAction func volume(_ sender: UISlider) {
        if self.power.isOn {
            self.volumeSlider = sender
            let volumeVal = Int(self.volumeSlider.value)
            self.volumeValue.text = String(volumeVal)
        }
        else {
            self.volumeSlider.value = 0
        }
    }
    
    /*
        Changes the channel.
    */
    @IBAction func channelChanger(_ sender: UIButton) {
        if !self.power.isOn {
            return
        }
        let currentDigit = Int(sender.currentTitle!)
        if let value = currentDigit {
            self.array.append(value)
        }
        /*
            This block prevents the array to hold just 2 digits.
            So that we can select a channel between 0 - 99.
        */
        if self.array.count > 2 {
            for _ in 0...1 {
                let current = self.array.removeFirst()
                /*
                    we append the first digits to another array
                    So we can build a number using them.
                */
                self.digits.append(current)
            }
        }
        
        
        /*
            We clean the digits array so that later it can work
            with other digits.
        */
        if self.digits.count > 2 {
            self.digits.removeAll()
        }
        // Pass the current value to the screen's tv.
        self.channelValue.text = String(buildChannel())
    }
    
    /* builds the integer as a string. */
    func buildChannel() -> Int {
        var temp = ""
        for  number in self.array {
            temp += String(number)
        }
        
        let result = Int(temp)!
        return result
    }
    
    
    
    
    /* Function that resets values based on the state of the TV.*/
    func resetValues() -> Void {
        self.volumeValue.text = ""
        self.channelValue.text = "1"
        self.volumeSlider.value = 0
        self.powerValue.text = "Off"
        self.channelImage.image = UIImage(named: "tvoff")
    }
    
    
    
    /* Function for Ch+ and Ch- */
    @IBAction func upDownBtn(_ sender: UIButton) {
        if !self.power.isOn {
            return
        }
        if sender.currentTitle == "Ch+" {
            if let currentText = self.channelValue.text {
                var temporaryValue:Int = Int(currentText)!
                temporaryValue = temporaryValue + 1
                if temporaryValue > 100 {
                    temporaryValue = temporaryValue - 1
                }
                self.channelValue.text = String(temporaryValue)
            }
        }
        else {
            if let currentText = self.channelValue.text {
                var temporaryValue:Int = Int(currentText)!
                temporaryValue = temporaryValue - 1
                if temporaryValue < 0 {
                    temporaryValue = temporaryValue + 1
                }
                self.channelValue.text = String(temporaryValue)
            }
        }
    }
    
    /* Segmented control */
    @IBAction func selectedChannel(_ sender: UISegmentedControl) {
        if !self.power.isOn {
            return
        }
        if sender.selectedSegmentIndex == 0 {
            channelImage.image = UIImage(named: "Image")
        }
        else if sender.selectedSegmentIndex == 2 {
            self.channelImage.image = UIImage(named: "cbs-news-logo")
        }
        else if sender.selectedSegmentIndex == 1 {
            self.channelImage.image = UIImage(named: "nbc")
        }
        else if sender.selectedSegmentIndex == 3 {
            self.channelImage.image = UIImage(named: "fox-news")
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}


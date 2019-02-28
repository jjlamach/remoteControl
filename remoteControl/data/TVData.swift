//
//  TVData.swift
//  remoteControl
//
//  Created by Julio on 2/27/19.
//  Copyright © 2019 Julio Lama. All rights reserved.
//

import Foundation
import UIKit
/**
    A data model for TV configuration.
 */
final class TVData {
    static let sharedInstance = TVData()
    private struct Data {
        static var buttonName: String = ""
        static var atSegmentIndex: Int = 0
        private init() {}
    }
    private init() {}
    
    func getButtonName() -> String {
        return Data.buttonName
    }
    func setButtonName(_ newButtonName: String, _ segmentIndex: Int) {
        Data.buttonName = newButtonName
        Data.atSegmentIndex = segmentIndex
    }
    
    func getSegmentIndex() -> Int {
        return Data.atSegmentIndex
    }
}

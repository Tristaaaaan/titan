//
//  VideoScale.swift
//  titan
//
//  Created by Tristan on 8/20/26.
//

import SwiftUI

/// Scale video as per selected value
enum VideoScale: Int, CaseIterable {
    case normal = 1
    case high = 2
    
    var stringValue: String {
        switch self {
        case .normal:
            return "1X"
        case .high:
            return "2X"
        }
    }
}

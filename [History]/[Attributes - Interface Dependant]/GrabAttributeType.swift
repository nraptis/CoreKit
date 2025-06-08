//
//  GrabAttributeType.swift
//  HistoryKit
//
//  Created by Nicholas Raptis on 5/16/25.
//

import Foundation

@frozen public enum GrabAttributeType: UInt8 {
    case grabDragPower
    case grabSpeed
    case grabStiffness
    case grabGyroPower
}

extension GrabAttributeType {
    
    
    func getTopMenuType() -> HistoryWorldConfiguration.ExpandedType {
        if let interfaceTopMenu = interfaceTopMenu() {
            if interfaceTopMenu {
                return .forceEnter
            }
        }
        return .dontCare
    }
    
    private func interfaceTopMenu() -> Bool? {
        switch self {
        
        case .grabDragPower:
            return true
        case .grabSpeed:
            return true
        case .grabStiffness:
            return true
        case .grabGyroPower:
            return true
        }
    }
    
}

//
//  DocumentMode.swift
//  TypeKit
//
//  Created by Nicholas Raptis on 5/9/25.
//

import Foundation

@frozen public enum DocumentMode: UInt8 {
    
    case view
    case edit
    
    public var isView: Bool {
        switch self {
        case .view:
            return true
        default:
            return false
        }
    }
    
    public var isEdit: Bool {
        switch self {
        case .edit:
            return true
        default:
            return false
        }
    }
    
    public func isRightOf(documentMode: DocumentMode) -> Bool {
        switch self {
        case .view:
            return false
        case .edit:
            switch documentMode {
            case .view:
                return true
            case .edit:
                return false
            }
        }
    }
    
}

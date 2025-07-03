//
//  GrabAttributeTypeWithData.swift
//  HistoryKit
//
//  Created by Nicholas Raptis on 5/16/25.
//

import Foundation

@frozen public enum GrabAttributeTypeWithData {
    case all(GrabAttributeDataUserAll)
    case grabDragPower(Float)
    case grabSpeed(Float)
    case grabStiffness(Float)
    case grabGyroPower(Float)
}

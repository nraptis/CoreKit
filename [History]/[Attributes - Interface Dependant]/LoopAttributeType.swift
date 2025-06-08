//
//  LoopAttributeType.swift
//  Jiggle3
//
//  Created by Nicholas Raptis on 5/16/25.
//

import Foundation

@frozen public enum LoopAttributeType: UInt8 {
    
    case timeLineDuration
    case timeLineFrameOffset
    
    case timeLineSwatchX
    case timeLineSwatchY
    case timeLineSwatchScale
    case timeLineSwatchRotation
    
    case timeLine
}

extension LoopAttributeType {
    func getTimeLineType() -> HistoryWorldConfiguration.TimeLineType {
        let interfaceTimeline = interfaceTimeline()
        if interfaceTimeline {
            return .forceEnter
        } else {
            return .forceLeave
        }
    }
    
    func getPageType() -> HistoryWorldConfiguration.ThreePageType {
        if let interfacePage = interfacePage() {
            if interfacePage == 1 {
                return .forcePage1
            } else if interfacePage == 2 {
                return .forcePage2
            } else if interfacePage == 3 {
                return .forcePage3
            }
        }
        return .dontCare
    }
    
    func getTopMenuType() -> HistoryWorldConfiguration.ExpandedType {
        let interfaceTopMenu = interfaceTopMenu()
        if interfaceTopMenu {
            return .forceEnter
        }
        
        return .dontCare
    }
    
    private func interfaceTopMenu() -> Bool {
        switch self {
        case .timeLineDuration:
            return false
        case .timeLineFrameOffset:
            return false
        case .timeLineSwatchX:
            return true
        case .timeLineSwatchY:
            return true
        case .timeLineSwatchScale:
            return true
        case .timeLineSwatchRotation:
            return true
        case .timeLine:
            return true
        }
    }
    
    private func interfacePage() -> Int? {
        switch self {
        case .timeLineDuration:
            break
        case .timeLineFrameOffset:
            return 2
        case .timeLineSwatchX:
            break
        case .timeLineSwatchY:
            break
        case .timeLineSwatchScale:
            break
        case .timeLineSwatchRotation:
            break
        case .timeLine:
            break
        }
        return nil
    }
    
    private func interfaceTimeline() -> Bool {
        switch self {
        case .timeLineDuration:
            return false
        case .timeLineFrameOffset:
            return true
        case .timeLineSwatchX:
            return true
        case .timeLineSwatchY:
            return true
        case .timeLineSwatchScale:
            return true
        case .timeLineSwatchRotation:
            return true
        case .timeLine:
            return true
        }
    }
    
}

//
//  HistoryState.swift
//  HistoryKit
//
//  Created by Nicholas Raptis on 5/16/25.
//

import Foundation

open class HistoryState {
    
    public let historyStateType: HistoryStateType
    public init(_ historyStateType: HistoryStateType) {
        self.historyStateType = historyStateType
    }
    
    open func getWorldConfiguration() -> HistoryWorldConfiguration {
        fatalError("This should always be overridden")
    }
    
}

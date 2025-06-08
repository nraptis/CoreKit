//
//  HistoryControllerConforming.swift
//  HistoryKit
//
//  Created by Nicholas Raptis on 5/18/25.
//

import Foundation

public protocol HistoryControllerConforming: AnyObject {
    @MainActor func historyStackDidChange()
    @MainActor func enterHistoryUndo(_ historyState: HistoryState)
    @MainActor func enterHistoryRedo(_ historyState: HistoryState)
}

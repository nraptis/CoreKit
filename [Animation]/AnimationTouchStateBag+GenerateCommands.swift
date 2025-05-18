//
//  AnimationTouchStateBag+GenerateCommands.swift
//  Yo Mamma Be Ugly
//
//  Created by Nick Raptis on 12/18/24.
//

import Foundation

extension AnimationTouchStateBag {
    
    func generateAppropriateCommands() {
        
        // Recycle the commands, start with empty commands.
        for commandIndex in 0..<stateCommandCount {
            let command = stateCommands[commandIndex]
            AnimationPartsFactory.shared.depositAnimationTouchStateCommand(command)
        }
        stateCommandCount = 0
        
        generateAppropriateCommands_Remove()
        generateAppropriateCommands_Move()
        generateAppropriateCommands_Add()
    }
    
    private func generateAppropriateCommands_Remove() {
        var isRemoveCommandNeeded = false
        for beforeStateIndex in 0..<beforeStateCount {
            let beforeState = beforeStates[beforeStateIndex]
            if afterStatesContains(touchID: beforeState.touchID) == false {
                isRemoveCommandNeeded = true
                break
            }
        }
        
        if isRemoveCommandNeeded == false {
            return
        }
        
        let newCommand = AnimationPartsFactory.shared.withdrawAnimationTouchStateCommand()
        newCommand.chunkCount = 0
        newCommand.type = .remove
        addStateCommandUnique(stateCommand: newCommand)
        
        for beforeStateIndex in 0..<beforeStateCount {
            let beforeState = beforeStates[beforeStateIndex]
            if afterStatesContains(touchID: beforeState.touchID) == false {
                let chunk = AnimationTouchStateCommandChunk.remove(beforeState.touchID)
                newCommand.addChunk(chunk: chunk)
            }
        }
    }
    
    private func generateAppropriateCommands_Move() {
        var isMoveCommandNeeded = false
        for beforeStateIndex in 0..<beforeStateCount {
            let beforeState = beforeStates[beforeStateIndex]
            var isMoved = false
            for afterStateIndex in 0..<afterStateCount {
                let afterState = afterStates[afterStateIndex]
                if beforeState.touchID == afterState.touchID {
                    if beforeState.x != afterState.x || beforeState.y != afterState.y {
                        isMoved = true
                    }
                }
            }
            if isMoved {
                isMoveCommandNeeded = true
                break
            }
        }
        
        if isMoveCommandNeeded == false {
            return
        }
        
        let newCommand = AnimationPartsFactory.shared.withdrawAnimationTouchStateCommand()
        newCommand.chunkCount = 0
        newCommand.type = .move
        addStateCommandUnique(stateCommand: newCommand)
        for beforeStateIndex in 0..<beforeStateCount {
            var afterX = Float(0.0)
            var afterY = Float(0.0)
            let beforeState = beforeStates[beforeStateIndex]
            var isMoved = false
            for afterStateIndex in 0..<afterStateCount {
                let afterState = afterStates[afterStateIndex]
                if beforeState.touchID == afterState.touchID {
                    if beforeState.x != afterState.x || beforeState.y != afterState.y {
                        isMoved = true
                        afterX = afterState.x
                        afterY = afterState.y
                    }
                }
            }
            if isMoved {
                let chunk = AnimationTouchStateCommandChunk.move(beforeState.touchID,
                                                                 afterX,
                                                                 afterY)
                newCommand.addChunk(chunk: chunk)
            }
        }
    }
    
    private func generateAppropriateCommands_Add() {
        var isAddCommandNeeded = false
        for afterStateIndex in 0..<afterStateCount {
            let afterState = afterStates[afterStateIndex]
            if !beforeStatesContains(touchID: afterState.touchID) {
                isAddCommandNeeded = true
                break
            }
        }
        
        if isAddCommandNeeded == false {
            return
        }
        
        let newCommand = AnimationPartsFactory.shared.withdrawAnimationTouchStateCommand()
        newCommand.chunkCount = 0
        newCommand.type = .add
        addStateCommandUnique(stateCommand: newCommand)
        
        for afterStateIndex in 0..<afterStateCount {
            let afterState = afterStates[afterStateIndex]
            if !beforeStatesContains(touchID: afterState.touchID) {
                let chunk = AnimationTouchStateCommandChunk.add(afterState.touchID,
                                                                afterState.x,
                                                                afterState.y)
                newCommand.addChunk(chunk: chunk)
            }
        }
    }
}

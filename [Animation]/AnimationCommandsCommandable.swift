//
//  AnimationCommandsCommandable.swift
//  Yo Mamma Be Ugly
//
//  Created by Nick Raptis on 12/20/24.
//

import Foundation

protocol AnimationCommandsCommandable {
    var pointerBag: AnimationTouchPointerBag { get }
    var stateBag: AnimationTouchStateBag { get }
}

extension AnimationCommandsCommandable {
    @MainActor func performStateCommands(jiggle: Jiggle,
                                         jiggleDocument: AnimationControllerJiggleDocument,
                                         animationTouches: [AnimationTouch],
                                         animationTouchCount: Int) {
        for commandIndex in 0..<stateBag.stateCommandCount {
            let command = stateBag.stateCommands[commandIndex]
            
            pointerBag.sync(jiggle: jiggle,
                            animationTouches: animationTouches,
                            animationTouchCount: animationTouchCount,
                            command: command,
                            stateBag: stateBag)
            
            switch command.type {
            case .add:
                pointerBag.captureStart(animationWad: jiggle.animationWad)
            case .remove:
                pointerBag.captureStart(animationWad: jiggle.animationWad)
            case .move:
                pointerBag.captureTrack(animationWad: jiggle.animationWad,
                                        jiggleDocument: jiggleDocument)
            }
        }
    }
}

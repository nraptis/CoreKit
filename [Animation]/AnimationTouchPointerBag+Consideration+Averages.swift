//
//  AnimationTouchPointerBag+Consideration.swift
//  Yo Mamma Be Ugly
//
//  Created by Nick Raptis on 12/19/24.
//

import Foundation

extension AnimationTouchPointerBag {
    
    func calculateConsiderTouchPointersAndGetAverages() -> AnimationTouchPointerAveragesResponse {
        
        calculateConsiderTouchPointers()

        var validTouchPointerCount = 0
        for touchPointerIndex in 0..<touchPointerCount {
            let touchPointer = touchPointers[touchPointerIndex]
            if touchPointer.isConsidered {
                validTouchPointerCount += 1
            }
        }
        
        if validTouchPointerCount <= 0 {
            // There were no valid touches.
            // The average of 0 items is nonsense.
            return AnimationTouchPointerAveragesResponse.invalid
        } else {
            // We sum up the values and
            // divide by the count.
            var averageX = Float(0.0)
            var averageY = Float(0.0)
            for touchPointerIndex in 0..<touchPointerCount {
                let touchPointer = touchPointers[touchPointerIndex]
                if touchPointer.isConsidered {
                    averageX += touchPointer.x
                    averageY += touchPointer.y
                }
            }
            let validTouchPointerCountf = Float(validTouchPointerCount)
            averageX /= validTouchPointerCountf
            averageY /= validTouchPointerCountf
            return AnimationTouchPointerAveragesResponse.valid(Math.Point(x: averageX, y: averageY))
        }
    }
    
    private func calculateConsiderTouchPointers() {
        for touchPointerIndex in 0..<touchPointerCount {
            let touchPointer = touchPointers[touchPointerIndex]
            switch touchPointer.actionType {
            case .detached:
                touchPointer.isConsidered = false
            case .retained(let x, let y):
                touchPointer.isConsidered = true
                touchPointer.x = x
                touchPointer.y = y
            case .add(let x, let y):
                touchPointer.isConsidered = true
                touchPointer.x = x
                touchPointer.y = y
            case .remove:
                touchPointer.isConsidered = false
            case .move(let x, let y):
                touchPointer.isConsidered = true
                touchPointer.x = x
                touchPointer.y = y
            }
        }
    }
}

//
//  AnimationTouchPointerBag+HouseKeeping.swift
//  Yo Mamma Be Ugly
//
//  Created by Nick Raptis on 12/19/24.
//

import Foundation

extension AnimationTouchPointerBag {
    func touchPointersAddUnique(_ pointer: AnimationTouchPointer) {
        for pointerIndex in 0..<touchPointerCount {
            if touchPointers[pointerIndex] === pointer {
                return
            }
        }
        
        while touchPointers.count <= touchPointerCount {
            touchPointers.append(pointer)
        }
        touchPointers[touchPointerCount] = pointer
        touchPointerCount += 1
    }
    
    func touchPointersFind(touchID: ObjectIdentifier) -> AnimationTouchPointer? {
        for pointerIndex in 0..<touchPointerCount {
            if touchPointers[pointerIndex].touchID == touchID {
                return touchPointers[pointerIndex]
            }
        }
        return nil
    }
    
    func touchPointersRemove(_ pointer: AnimationTouchPointer) {
        var numberRemoved = 0
        var removeLoopIndex = 0
        while removeLoopIndex < touchPointerCount {
            if touchPointers[removeLoopIndex] === pointer {
                break
            } else {
                removeLoopIndex += 1
            }
        }
        while removeLoopIndex < touchPointerCount {
            if touchPointers[removeLoopIndex] === pointer {
                numberRemoved += 1
            } else {
                touchPointers[removeLoopIndex - numberRemoved] = touchPointers[removeLoopIndex]
            }
            removeLoopIndex += 1
        }
        touchPointerCount -= numberRemoved
        AnimationPartsFactory.shared.depositAnimationTouchPointer(pointer)
    }
    
    func touchPointersRemoveExpired() {
        // Add expired pointers to the temp list...
        tempTouchPointerCount = 0
        for pointerIndex in 0..<touchPointerCount {
            let pointer = touchPointers[pointerIndex]
            if pointer.isExpired {
                tempTouchPointersAddUnique(pointer)
            }
        }
        
        // Remove all pointers from the temp list...
        for pointerIndex in 0..<tempTouchPointerCount {
            let pointer = tempTouchPointers[pointerIndex]
            touchPointersRemove(pointer)
        }
    }
    
    func tempTouchPointersAddUnique(_ pointer: AnimationTouchPointer) {
        for pointerIndex in 0..<tempTouchPointerCount {
            if tempTouchPointers[pointerIndex] === pointer {
                return
            }
        }
        while tempTouchPointers.count <= tempTouchPointerCount {
            tempTouchPointers.append(pointer)
        }
        tempTouchPointers[tempTouchPointerCount] = pointer
        tempTouchPointerCount += 1
    }
}

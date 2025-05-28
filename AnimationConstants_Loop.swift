//
//  AnimationConstants_Loop.swift
//  Jiggle3
//
//  Created by Nicholas Raptis on 5/24/25.
//

import Foundation

public struct AnimationConstants_Loop {
    
    
    
    
    nonisolated(unsafe) public static let duration = AnimationConstantLane(user_lo: 0.0,
                                                                           user_default: 60.0,
                                                                           user_zero: 50.0,
                                                                           user_hi: 100.0,
                                                                           value_lo: 0.32,
                                                                           value_hi: 1.95)
    
    nonisolated(unsafe) public static let frameOffset = AnimationConstantLane(user_lo: 0.0,
                                                                              user_default: 0.0,
                                                                              user_zero: 0.0,
                                                                              user_hi: 100.0,
                                                                              value_lo: 0.0,
                                                                              value_hi: 1.0)
    
}

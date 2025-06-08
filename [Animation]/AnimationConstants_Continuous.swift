//
//  AnimationConstants_Continuous.swift
//  Jiggle3
//
//  Created by Nicholas Raptis on 5/24/25.
//

import Foundation

public struct AnimationConstants_Continuous {
    
    nonisolated(unsafe) public static let duration = AnimationConstantLane(user_lo: 0.0,
                                                                           user_default: 65.0,
                                                                           user_zero: 25.0,
                                                                           user_hi: 100.0,
                                                                           value_lo: 0.20,
                                                                           value_hi: 1.86)
    
    nonisolated(unsafe) public static let angle = AnimationConstantLane(user_lo: -90.0,
                                                                        user_default: 0.0,
                                                                        user_zero: 0.0,
                                                                        user_hi: 90.0,
                                                                        value_lo: 0.0,
                                                                        value_hi: Math.pi2)
    
    nonisolated(unsafe) public static let swoop = AnimationConstantLane(user_lo: -100.0,
                                                                        user_default: 0.0,
                                                                        user_zero: 0.0,
                                                                        user_hi: 100.0,
                                                                        value_lo: 0.0,
                                                                        value_hi: 1.0)
    
    nonisolated(unsafe) public static let wiggle = AnimationConstantLane(user_lo: -100.0,
                                                                         user_default: 0.0,
                                                                         user_zero: 0.0,
                                                                         user_hi: 100.0,
                                                                         value_lo: -1.0,
                                                                         value_hi: 1.0)
    
    nonisolated(unsafe) public static let power = AnimationConstantLane(user_lo: 0.0,
                                                                           user_default: 30.0,
                                                                           user_zero: 0.0,
                                                                           user_hi: 100.0,
                                                                        value_lo: 0.0,
                                                                        value_hi: 1.0)
    
    nonisolated(unsafe) public static let frameOffset = AnimationConstantLane(user_lo: 0.0,
                                                                              user_default: 0.0,
                                                                              user_zero: 0.0,
                                                                              user_hi: 100.0,
                                                                              value_lo: 0.0,
                                                                              value_hi: 1.0)
    
    nonisolated(unsafe) public static let startScale = AnimationConstantLane(user_lo: -100.0,
                                                                              user_default: 0.0,
                                                                              user_zero: 0.0,
                                                                              user_hi: 100.0,
                                                                              value_lo: 0.0,
                                                                              value_hi: 1.0)
    
    nonisolated(unsafe) public static let endScale = AnimationConstantLane(user_lo: -100.0,
                                                                              user_default: 0.0,
                                                                              user_zero: 0.0,
                                                                              user_hi: 100.0,
                                                                              value_lo: 0.0,
                                                                              value_hi: 1.0)
    
    nonisolated(unsafe) public static let startRotation = AnimationConstantLane(user_lo: -90.0,
                                                                              user_default: 0.0,
                                                                              user_zero: 0.0,
                                                                              user_hi: 90.0,
                                                                              value_lo: 0.0,
                                                                              value_hi: 1.0)
    
    nonisolated(unsafe) public static let endRotation = AnimationConstantLane(user_lo: -90.0,
                                                                              user_default: 0.0,
                                                                              user_zero: 0.0,
                                                                              user_hi: 90.0,
                                                                              value_lo: 0.0,
                                                                              value_hi: 1.0)
    
}

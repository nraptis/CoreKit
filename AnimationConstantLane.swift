//
//  AnimationConstantLane.swift
//  Jiggle3
//
//  Created by Nicholas Raptis on 5/24/25.
//

import Foundation

public class AnimationConstantLane {
    
    
    public let user_lo: Float
    public let user_default: Float
    public let user_zero: Float
    public let user_hi: Float
    public let user_quarter: Float
    public let value_lo: Float
    public let value_hi: Float
    
    public init(user_lo: Float, user_default: Float, user_zero: Float, user_hi: Float, value_lo: Float, value_hi: Float) {
        self.user_lo = user_lo
        self.user_default = user_default
        self.user_zero = user_zero
        self.user_quarter = user_lo + (user_hi - user_lo) * 0.25
        self.user_hi = user_hi
        self.value_lo = value_lo
        self.value_hi = value_hi
    }
    
    /*
    public func rand() -> Float {
        
        if (rand_zero_shelf > 0) || (rand_default_shelf > 0) {
            let number1 = Int.random(in: 0..<100)
            if number1 < rand_zero_shelf {
                
                
                let number2 = Int.random(in: 0..<100)
                if number2 < rand_default_shelf {
                    // If we are below the [zero_shelf, default_shelf], it could be either.
                    if Bool.random() {
                        return user_zero
                    } else {
                        return user_default
                    }
                    
                } else {
                    // If we are below the [zero_shelf], it could be zero.
                    return user_zero
                }
            } else {
                // If we are below the [default_shelf], it could be default.
                let number2 = Int.random(in: 0..<100)
                if number2 < rand_default_shelf {
                    return user_default
                }
            }
        }
        
        if rand_lo >= rand_hi {
            return rand_lo
        } else {
            let value = Float.random(in: rand_lo...rand_hi)
            if rand_inv {
                if Bool.random() {
                    return -value
                } else {
                    return value
                }
            } else {
                return value
            }
        }
    }
    */
    
    public func getPercent(userValue: Float) -> Float {
        var percent_linear: Float
        let user_delta = (user_hi - user_lo)
        if user_delta > Math.epsilon {
            percent_linear = ((userValue - user_lo) / user_delta)
            if percent_linear < 0.0 { percent_linear = 0.0 }
            if percent_linear > 1.0 { percent_linear = 1.0 }
        } else {
            percent_linear = 0.0
        }
        return percent_linear
    }
    
    public func getUserValueFromPercent(_ percent: Float) -> Float {
        var result = user_lo + (user_hi - user_lo) * percent
        if result < user_lo { result = user_lo }
        if result > user_hi { result = user_hi }
        return result
    }

    public func getValue(userValue: Float) -> Float {
        let percent_linear: Float
        let user_delta = (user_hi - user_lo)
        if user_delta > Math.epsilon {
            percent_linear = ((userValue - user_lo) / user_delta)
        } else {
            percent_linear = 0.0
        }
        
        var result = value_lo + (value_hi - value_lo) * percent_linear
        if result < value_lo { result = value_lo }
        if result > value_hi { result = value_hi }
        return result
    }
    
    public func getValueFromPercent(_ percent: Float) -> Float {
        
        var result = value_lo + (value_hi - value_lo) * percent
        if result < value_lo { result = value_lo }
        if result > value_hi { result = value_hi }
        return result
    }
    
}

//
//  TanFactorStore.swift
//  CoreKit
//
//  Created by Nicholas Raptis on 6/8/25.
//

import Foundation

public struct TanFactorStore {
    
    public static let tanFactorJigglePoint = Float(Device.isPad ? 0.41 : 0.3)
    public static let tanFactorGuidePoint = Float(Device.isPad ? 0.41 : 0.3)
    
    public static let tanFactorWeightCurve = Float(0.325)
    public static let tanFactorTimeLine = Float(0.325)
    
    public static let tanFactorWeightCurveAutoMidde7 = Float(0.26)
    public static let tanFactorWeightCurveAutoMidde6 = Float(0.27)
    public static let tanFactorWeightCurveAutoMidde5 = Float(0.28)
    public static let tanFactorWeightCurveAutoMidde4 = Float(0.29)
    public static let tanFactorWeightCurveAutoMidde3 = Float(0.30)
    
    public static func tanFactorWeightCurveAuto(count: Int) -> Float {
        if count >= 7 {
            return TanFactorStore.tanFactorWeightCurveAutoMidde7
        } else if count == 6 {
            return TanFactorStore.tanFactorWeightCurveAutoMidde6
        } else if count == 5 {
            return TanFactorStore.tanFactorWeightCurveAutoMidde5
        } else if count == 4 {
            return TanFactorStore.tanFactorWeightCurveAutoMidde4
        } else {
            return tanFactorWeightCurveAutoMidde3
        }
    }
    
}

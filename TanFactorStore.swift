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
    
    //public static let tanFactorWeightCurveAutoMidde7 = Float(0.26)
    //public static let tanFactorWeightCurveAutoMidde6 = Float(0.27)
    //public static let tanFactorWeightCurveAutoMidde5 = Float(0.28)
    //public static let tanFactorWeightCurveAutoMidde4 = Float(0.29)
    public static let tanFactorWeightCurveAutoMidde3 = Float(0.30)
    
    public static func tanFactorWeightCurveAuto() -> Float {
        return tanFactorWeightCurveAutoMidde3
    }
    
}

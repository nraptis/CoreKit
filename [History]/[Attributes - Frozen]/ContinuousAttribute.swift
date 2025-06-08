//
//  ContinuousAttribute.swift
//  HistoryKit
//
//  Created by Nicholas Raptis on 5/16/25.
//

import Foundation

public struct ContinuousAttribute {
    
    struct ContinuousAttributeDatum {
        let page: Int
        let value: Float
    }
    
    public let jiggleIndex: Int
    public let continuousAttributeType: ContinuousAttributeType
    public let continuousAttributeTypeWithData: ContinuousAttributeTypeWithData
    public init(jiggleIndex: Int, continuousAttributeType: ContinuousAttributeType, continuousAttributeTypeWithData: ContinuousAttributeTypeWithData) {
        self.jiggleIndex = jiggleIndex
        self.continuousAttributeType = continuousAttributeType
        self.continuousAttributeTypeWithData = continuousAttributeTypeWithData
    }
    
    func getDatums() -> [ContinuousAttributeDatum] {
        switch continuousAttributeTypeWithData {
        case .continuousAll(let data):
            
            let duration = ContinuousAttributeDatum(page: 1, value: data.duration)
            let power = ContinuousAttributeDatum(page: 1, value: data.power)
            
            let angle = ContinuousAttributeDatum(page: 2, value: data.angle)
            let swoop = ContinuousAttributeDatum(page: 2, value: data.swoop)
            
            let startRotation = ContinuousAttributeDatum(page: 3, value: data.startRotation)
            let endRotation = ContinuousAttributeDatum(page: 3, value: data.endRotation)
            
            let startScale = ContinuousAttributeDatum(page: 4, value: data.startScale)
            let endScale = ContinuousAttributeDatum(page: 4, value: data.endScale)
            
            let frameOffset = ContinuousAttributeDatum(page: 5, value: data.frameOffset)
            let wiggle = ContinuousAttributeDatum(page: 5, value: data.wiggle)

            return [duration, power, angle, swoop, startRotation, endRotation, startScale, endScale, frameOffset, wiggle]
            
        case .continuousGroup1(let data):
            let duration = ContinuousAttributeDatum(page: 1, value: data.duration)
            let power = ContinuousAttributeDatum(page: 1, value: data.power)
            return [duration, power]
            
        case .continuousGroup2(let data):
            let angle = ContinuousAttributeDatum(page: 2, value: data.angle)
            let swoop = ContinuousAttributeDatum(page: 2, value: data.swoop)
            return [angle, swoop]
            
        case .continuousGroup3(let data):
            let startRotation = ContinuousAttributeDatum(page: 3, value: data.startRotation)
            let endRotation = ContinuousAttributeDatum(page: 3, value: data.endRotation)
            return [startRotation, endRotation]
            
        case .continuousGroup4(let data):
            let startScale = ContinuousAttributeDatum(page: 4, value: data.startScale)
            let endScale = ContinuousAttributeDatum(page: 4, value: data.endScale)
            return [startScale, endScale]
            
        case .continuousGroup5(let data):
            let frameOffset = ContinuousAttributeDatum(page: 5, value: data.frameOffset)
            let wiggle = ContinuousAttributeDatum(page: 5, value: data.wiggle)
            return [frameOffset, wiggle]
            
        case .continuousDuration(let value):
            let duration = ContinuousAttributeDatum(page: 1, value: value)
            return [duration]
            
        case .continuousPower(let value):
            let power = ContinuousAttributeDatum(page: 1, value: value)
            return [power]
            
        case .continuousAngle(let value):
            let angle = ContinuousAttributeDatum(page: 2, value: value)
            return [angle]
            
        case .continuousSwoop(let value):
            let swoop = ContinuousAttributeDatum(page: 2, value: value)
            return [swoop]
            
        case .continuousStartRotation(let value):
            let startRotation = ContinuousAttributeDatum(page: 3, value: value)
            return [startRotation]
            
        case .continuousEndRotation(let value):
            let endRotation = ContinuousAttributeDatum(page: 3, value: value)
            return [endRotation]
            
        case .continuousStartScale(let value):
            let startScale = ContinuousAttributeDatum(page: 4, value: value)
            return [startScale]
            
        case .continuousEndScale(let value):
            let endScale = ContinuousAttributeDatum(page: 4, value: value)
            return [endScale]
            
        case .continuousFrameOffset(let value):
            let frameOffset = ContinuousAttributeDatum(page: 5, value: value)
            return [frameOffset]
        
        case .continuousWiggle(let value):
            let wiggle = ContinuousAttributeDatum(page: 5, value: value)
            return [wiggle]
        }
    }
    
}

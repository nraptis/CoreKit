//
//  TimeLineSmoother.swift
//  Yo Mamma Be Ugly
//
//  Created by Nick Raptis on 9/16/24.
//

import Foundation

class TimeLineSmoother {
    
    static let SCALE = Float(4096.0)
    
    // The x and y as they are added in, with no modifications.
    private(set) var baseCount = 0
    private var _baseCapacity = 0
    private var _baseDistance = [Float]()
    private var _baseValue = [Float]()
    
    func scrape(percent: Float) -> Float {
        scrape(distance: percent * Self.SCALE)
    }
    
    func scrape(distance: Float) -> Float {
        
        if baseCount <= 0 {
            return 0.5
        }
        if baseCount <= 1 {
            return _baseValue[0] / TimeLineSmoother.SCALE
        }
        
        let baseCount1 = (baseCount - 1)
        if distance >= _baseDistance[baseCount1] {
            return _baseValue[baseCount1] / TimeLineSmoother.SCALE
        }
        
        let upperBound = upperBound(distance: distance)
        
        if upperBound <= 0 {
            return _baseValue[0] / TimeLineSmoother.SCALE
        }
        
        let upperBound1 = upperBound - 1
        let distanceLo = _baseDistance[upperBound1]
        let distanceHi = _baseDistance[upperBound]
        let deltaDistance = (distanceHi - distanceLo)
        let percent = (distance - distanceLo) / deltaDistance

        var value = _baseValue[upperBound1] + (_baseValue[upperBound] - _baseValue[upperBound1]) * percent
        
        if value < 0.0 { value = 0.0 }
        if value > TimeLineSmoother.SCALE { value = TimeLineSmoother.SCALE }
        
        return value
    }
    
    private func upperBound(distance: Float) -> Int {
        var start = 0
        var end = baseCount
        while start != end {
            let mid = (start + end) >> 1
            if distance >= _baseDistance[mid] {
                start = mid + 1
            } else {
                end = mid
            }
        }
        return start
    }
    
    func addPoint(distance: Float, value: Float) {
        if (baseCount + 1) >= _baseCapacity {
            reserveCapacity(minimumCapacity: baseCount + (baseCount >> 1) + 2)
        }
        _baseDistance[baseCount] = distance
        _baseValue[baseCount] = value
        baseCount += 1
    }
    
    private func reserveCapacity(minimumCapacity: Int) {
        if minimumCapacity > _baseCapacity {
            _baseDistance.reserveCapacity(minimumCapacity)
            _baseValue.reserveCapacity(minimumCapacity)
            while _baseDistance.count < minimumCapacity { _baseDistance.append(0.0) }
            while _baseValue.count < minimumCapacity { _baseValue.append(0.0) }
            _baseCapacity = minimumCapacity
        }
    }
    
    func removeAll(keepingCapacity: Bool) {
        removeAllBase(keepingCapacity: keepingCapacity)
    }
    
    private func removeAllBase(keepingCapacity: Bool) {
        if keepingCapacity == false {
            _baseDistance.removeAll(keepingCapacity: false)
            _baseValue.removeAll(keepingCapacity: false)
            _baseCapacity = 0
        }
        baseCount = 0
    }
    
}

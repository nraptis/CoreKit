//
//  Guide.swift
//  Yo Mamma Be Ugly
//
//  Created by Nick Raptis on 2/28/24.
//
//  Verified on 11/9/2024 by Nick Raptis
//

import Foundation

public protocol SelectedGuidePointListeningConforming {
    func realizeRecentSelectionChange_GuidePoint()
}

public class Guide {
    
    public init() {
        
    }
    
    public func dispose() {
        
        guidePoints.removeAll(keepingCapacity: false)
        guidePointCount = 0
        
        processPoints.removeAll(keepingCapacity: false)
        processPointCount = 0
        
        guideWeightPoints.removeAll(keepingCapacity: false)
        guideWeightPointCount = 0
        
        guideWeightSegments.removeAll(keepingCapacity: false)
        guideWeightSegmentCount = 0
        
        outlineGuideWeightSegments.removeAll(keepingCapacity: false)
        outlineGuideWeightSegmentCount = 0
        
        outlineGuideWeightPoints.removeAll(keepingCapacity: false)
        outlineGuideWeightPointCount = 0
        
        tempPrecomputedLineSegments.removeAll(keepingCapacity: false)
        tempPrecomputedLineSegmentCount = 0
        
        tempIntegers.removeAll(keepingCapacity: false)
        tempIntegerCount = 0
    }
    
    public static let maxPointCount = 256
    public static let minPointCount = 3
    
    public var selectionPriorityNumber = 0
    
    public var originalIndex = -1
    
    public var totalSplineLength = Float(0.0)
    
    public var processPoints = [DirectedWeightPoint]()
    public var processPointCount = 0
    public func addProcessPoint(_ point: DirectedWeightPoint) {
        while processPoints.count <= processPointCount {
            processPoints.append(point)
        }
        processPoints[processPointCount] = point
        processPointCount += 1
    }
    
    public func purgeProcessPoints() {
        for processPointIndex in 0..<processPointCount {
            GuidePartsFactory.shared.depositDirectedWeightPoint(processPoints[processPointIndex])
        }
        processPointCount = 0
    }
    
    public var currentHashSpline = SplineHash()
    public var currentHashOutline = OutlineHashGuide()
    public var currentHashSolidLineBufferStandard = SolidLineBufferGuideHash()
    public var currentHashSolidLineBufferPrecise = SolidLineBufferGuideHash()
    
    public var isFrozen = false
    public var isCandidate = false
    
    public var renderSelected = false
    public var renderFrozen = false
    
    public typealias Point = Math.Point
    public typealias Vector = Math.Vector
    
    public let solidLineBufferRegularBloom = SolidLineBuffer<Shape3DVertex, UniformsShapeVertex, UniformsShapeFragment>(sentinelNode: .init())
    public let solidLineBufferRegularStroke = SolidLineBuffer<Shape2DVertex, UniformsShapeVertex, UniformsShapeFragment>(sentinelNode: .init())
    public let solidLineBufferRegularFill = SolidLineBuffer<Shape2DVertex, UniformsShapeVertex, UniformsShapeFragment>(sentinelNode: .init())
    
    public let solidLineBufferPreciseBloom = SolidLineBuffer<Shape3DVertex, UniformsShapeVertex, UniformsShapeFragment>(sentinelNode: .init())
    public let solidLineBufferPreciseStroke = SolidLineBuffer<Shape2DVertex, UniformsShapeVertex, UniformsShapeFragment>(sentinelNode: .init())
    public let solidLineBufferPreciseFill = SolidLineBuffer<Shape2DVertex, UniformsShapeVertex, UniformsShapeFragment>(sentinelNode: .init())
    
    public let weightCurvePoint = WeightCurvePoint()
    
    public var percent = Float(0.0)
    
    public var isBroken = false
    public var isGuideClockwise = false
    
    var spline = FancySpline()
    let borderTool = BorderTool()
    
    public let guideWeightSegmentBucket = GuideWeightSegmentBucket()
    public let guideWeightPointInsidePolygonBucket = GuideWeightPointInsidePolygonBucket()
    
    public var minX = Float(0.0)
    public var maxX = Float(0.0)
    public var minY = Float(0.0)
    public var maxY = Float(0.0)
    public var rangeX = Float(0.0)
    public var rangeY = Float(0.0)
    public var bigness = Float(0.0)
    
    public var renderer: AnyObject!
    
    public func calculateBigness() {
        if guideWeightPointCount <= 2 {
            minX = 0.0
            maxX = 0.0
            minY = 0.0
            maxY = 0.0
            rangeX = 0.0
            rangeY = 0.0
            bigness = 0.0
            return
        }
        
        minX = guideWeightPoints[0].x
        maxX = guideWeightPoints[0].x
        minY = guideWeightPoints[0].y
        maxY = guideWeightPoints[0].y
        
        for guideWeightPointIndex in 1..<guideWeightPointCount {
            let guideWeightPoint = guideWeightPoints[guideWeightPointIndex]
            minX = min(minX, guideWeightPoint.x)
            maxX = max(maxX, guideWeightPoint.x)
            minY = min(minY, guideWeightPoint.y)
            maxY = max(maxY, guideWeightPoint.y)
        }
        
        rangeX = maxX - minX
        rangeY = maxY - minY
        bigness = rangeX + rangeY
    }
    
    public var selectedGuidePointIndex = -1
    public func getSelectedGuidePoint() -> GuidePoint? {
        if selectedGuidePointIndex >= 0 && selectedGuidePointIndex < guidePointCount {
            return guidePoints[selectedGuidePointIndex]
        }
        return nil
    }
    
    public func containsGuidePoint(_ guidePoint: GuidePoint) -> Bool {
        for guidePointIndex in 0..<guidePointCount {
            if guidePoints[guidePointIndex] === guidePoint {
                return true
            }
        }
        return false
    }
    
    public var guidePoints = [GuidePoint]()
    public var guidePointCount = 0
    @MainActor public func addGuidePoint(x: Float,
                                                y: Float,
                                                jiggleDocument: some SelectedGuidePointListeningConforming,
                                                ignoreRealize: Bool) {
        let guidePoint = GuidePartsFactory.shared.withdrawGuidePoint()
        guidePoint.x = x
        guidePoint.y = y
        addGuidePoint(guidePoint: guidePoint,
                             jiggleDocument: jiggleDocument,
                             ignoreRealize: ignoreRealize)
    }
    
    @MainActor public func addGuidePoint(directedWeightPoint: DirectedWeightPoint,
                                                jiggleDocument: some SelectedGuidePointListeningConforming,
                                                ignoreRealize: Bool) {
        let guidePoint = GuidePartsFactory.shared.withdrawGuidePoint()
        guidePoint.x = directedWeightPoint.x
        guidePoint.y = directedWeightPoint.y
        
        guidePoint.isManualTanHandleEnabledIn = directedWeightPoint.isManualTanHandleEnabledIn
        guidePoint.isManualTanHandleEnabledOut = directedWeightPoint.isManualTanHandleEnabledOut
        
        if directedWeightPoint.isManualTanHandleEnabledIn {
            guidePoint.tanDirectionIn = directedWeightPoint.tanDirectionIn
            guidePoint.tanMagnitudeIn = directedWeightPoint.tanMagnitudeIn
        }
        
        if directedWeightPoint.isManualTanHandleEnabledOut {
            guidePoint.tanDirectionOut = directedWeightPoint.tanDirectionOut
            guidePoint.tanMagnitudeOut = directedWeightPoint.tanMagnitudeOut
        }
        
        addGuidePoint(guidePoint: guidePoint,
                             jiggleDocument: jiggleDocument,
                             ignoreRealize: ignoreRealize)
    }
    
    @MainActor public func addGuidePoint(guidePoint: GuidePoint,
                                                jiggleDocument: some SelectedGuidePointListeningConforming,
                                                ignoreRealize: Bool) {
        while guidePoints.count <= guidePointCount {
            guidePoints.append(guidePoint)
        }
        let newSelectedGuidePointIndex = guidePointCount
        switchSelectedGuidePoint(newSelectedGuidePointIndex: newSelectedGuidePointIndex,
                                        selectedTanType: .none,
                                        jiggleDocument: jiggleDocument,
                                        ignoreRealize: ignoreRealize)
        
        guidePoints[guidePointCount] = guidePoint
        guidePointCount += 1
    }
    
    @MainActor public func switchSelectedGuidePoint(newSelectedGuidePointIndex: Int,
                                                           selectedTanType: TanTypeOrNone,
                                                           jiggleDocument: some SelectedGuidePointListeningConforming,
                                                           ignoreRealize: Bool) {
        selectedGuidePointIndex = newSelectedGuidePointIndex
        if newSelectedGuidePointIndex >= 0 &&
            newSelectedGuidePointIndex < guidePointCount {
            guidePoints[newSelectedGuidePointIndex].selectedTanType = selectedTanType
        }
        if !ignoreRealize {
            jiggleDocument.realizeRecentSelectionChange_GuidePoint()
        }
    }
    
    @MainActor public func insertGuidePoint(x: Float,
                                                   y: Float,
                                                   index: Int,
                                                   jiggleDocument: some SelectedGuidePointListeningConforming,
                                                   ignoreRealize: Bool) -> GuidePoint {
        let guidePoint = GuidePartsFactory.shared.withdrawGuidePoint()
        guidePoint.x = x
        guidePoint.y = y
        insertGuidePoint(newGuidePoint: guidePoint,
                                index: index,
                                jiggleDocument: jiggleDocument,
                                ignoreRealize: ignoreRealize)
        return guidePoint
    }
    
    @MainActor public func insertGuidePoint(data: ControlPointData,
                                                   
                                                   index: Int,
                                                   jiggleDocument: some SelectedGuidePointListeningConforming,
                                                   ignoreRealize: Bool) -> GuidePoint {
        let guidePoint = GuidePartsFactory.shared.withdrawGuidePoint()
        guidePoint.setData(data)
        insertGuidePoint(newGuidePoint: guidePoint,
                                index: index,
                                jiggleDocument: jiggleDocument,
                                ignoreRealize: ignoreRealize)
        return guidePoint
    }
    
    @MainActor public func insertGuidePoint(newGuidePoint: GuidePoint,
                                                   index: Int,
                                                   jiggleDocument: some SelectedGuidePointListeningConforming,
                                                   ignoreRealize: Bool) {
        while guidePoints.count <= guidePointCount {
            guidePoints.append(newGuidePoint)
        }
        var guidePointIndex = guidePointCount
        while guidePointIndex > index {
            guidePoints[guidePointIndex] = guidePoints[guidePointIndex - 1]
            guidePointIndex -= 1
        }
        
        guidePoints[index] = newGuidePoint
        guidePointCount += 1
        
        switchSelectedGuidePoint(newSelectedGuidePointIndex: index,
                                        selectedTanType: .none,
                                        jiggleDocument: jiggleDocument,
                                        ignoreRealize: ignoreRealize)
    }
    
    @MainActor public func deleteGuidePoint(guidePoint: GuidePoint,
                                                   jiggleDocument: some SelectedGuidePointListeningConforming,
                                                   ignoreRealize: Bool) -> Bool {
        for checkIndex in 0..<guidePointCount {
            if guidePoints[checkIndex] === guidePoint {
                if deleteGuidePoint(index: checkIndex,
                                           jiggleDocument: jiggleDocument,
                                           ignoreRealize: ignoreRealize) {
                    return true
                }
            }
        }
        return false
    }
    
    public func purgeGuidePoints() {
        for guidePointIndex in 0..<guidePointCount {
            let guidePoint = guidePoints[guidePointIndex]
            GuidePartsFactory.shared.depositGuidePoint(guidePoint)
        }
        guidePointCount = 0
    }
    
    @discardableResult
    @MainActor
    public func deleteGuidePoint(index: Int,
                                        jiggleDocument: some SelectedGuidePointListeningConforming,
                                        ignoreRealize: Bool) -> Bool {
        if index >= 0 && index < guidePointCount {
            let guidePoint = guidePoints[index]
            GuidePartsFactory.shared.depositGuidePoint(guidePoint)
            let guidePointCount1 = guidePointCount - 1
            var guidePointIndex = index
            while guidePointIndex < guidePointCount1 {
                guidePoints[guidePointIndex] = guidePoints[guidePointIndex + 1]
                guidePointIndex += 1
            }
            guidePointCount -= 1
            
            var newSelectedGuidePointIndex = selectedGuidePointIndex
            if newSelectedGuidePointIndex >= guidePointCount {
                newSelectedGuidePointIndex = guidePointCount - 1
            }
            switchSelectedGuidePoint(newSelectedGuidePointIndex: newSelectedGuidePointIndex,
                                            selectedTanType: .none,
                                            jiggleDocument: jiggleDocument,
                                            ignoreRealize: ignoreRealize)
            return true
        }
        return false
    }
    
    public var guideWeightPoints = [GuideWeightPoint]()
    public var guideWeightPointCount = 0
    public func addGuideWeightPoint(_ guideWeightPoint: GuideWeightPoint) {
        while guideWeightPoints.count <= guideWeightPointCount {
            guideWeightPoints.append(guideWeightPoint)
        }
        guideWeightPoints[guideWeightPointCount] = guideWeightPoint
        guideWeightPointCount += 1
    }
    public func purgeGuideWeightPoints() {
        for guideWeightPointIndex in 0..<guideWeightPointCount {
            GuidePartsFactory.shared.depositGuideWeightPoint(guideWeightPoints[guideWeightPointIndex])
        }
        guideWeightPointCount = 0
    }
    
    public var guideWeightSegments = [GuideWeightSegment]()
    public var guideWeightSegmentCount = 0
    public func addGuideWeightSegment(_ guideWeightSegment: GuideWeightSegment) {
        while guideWeightSegments.count <= guideWeightSegmentCount {
            guideWeightSegments.append(guideWeightSegment)
        }
        guideWeightSegments[guideWeightSegmentCount] = guideWeightSegment
        guideWeightSegmentCount += 1
    }
    //func resetGuideWeightSegments() {
    //    guideWeightSegmentCount = 0
    //}
    public func purgeGuideWeightSegments() {
        for guideWeightSegmentsIndex in 0..<guideWeightSegmentCount {
            GuidePartsFactory.shared.depositGuideWeightSegment(guideWeightSegments[guideWeightSegmentsIndex])
        }
        guideWeightSegmentCount = 0
    }
    
    public var outlineGuideWeightSegments = [GuideWeightSegment]()
    public var outlineGuideWeightSegmentCount = 0
    public func addOutlineGuideWeightSegment(_ guideWeightSegment: GuideWeightSegment) {
        while outlineGuideWeightSegments.count <= outlineGuideWeightSegmentCount {
            outlineGuideWeightSegments.append(guideWeightSegment)
        }
        outlineGuideWeightSegments[outlineGuideWeightSegmentCount] = guideWeightSegment
        outlineGuideWeightSegmentCount += 1
    }
    
    public func purgeOutlineGuideWeightSegments() {
        for guideWeightSegmentsIndex in 0..<outlineGuideWeightSegmentCount {
            GuidePartsFactory.shared.depositGuideWeightSegment(outlineGuideWeightSegments[guideWeightSegmentsIndex])
        }
        outlineGuideWeightSegmentCount = 0
    }
    
    public var outlineGuideWeightPoints = [GuideWeightPoint]()
    public var outlineGuideWeightPointCount = 0
    public func addOutlineGuideWeightPoint(_ guideWeightPoint: GuideWeightPoint) {
        while outlineGuideWeightPoints.count <= outlineGuideWeightPointCount {
            outlineGuideWeightPoints.append(guideWeightPoint)
        }
        outlineGuideWeightPoints[outlineGuideWeightPointCount] = guideWeightPoint
        outlineGuideWeightPointCount += 1
    }
    
    public func purgeOutlineGuideWeightPoints() {
        for guideWeightPointsIndex in 0..<outlineGuideWeightPointCount {
            GuidePartsFactory.shared.depositGuideWeightPoint(outlineGuideWeightPoints[guideWeightPointsIndex])
        }
        outlineGuideWeightPointCount = 0
    }
    
    public var tempPrecomputedLineSegments = [AnyPrecomputedLineSegment]()
    public var tempPrecomputedLineSegmentCount = 0
    public func addTempPrecomputedLineSegment(x1: Float, y1: Float, x2: Float, y2: Float) {
        let precomputedLineSegment = GuidePartsFactory.shared.withdrawPrecomputedLineSegment()
        precomputedLineSegment.x1 = x1
        precomputedLineSegment.y1 = y1
        precomputedLineSegment.x2 = x2
        precomputedLineSegment.y2 = y2
        addTempPrecomputedLineSegment(precomputedLineSegment)
    }
    
    public func addTempPrecomputedLineSegment(_ precomputedLineSegment: AnyPrecomputedLineSegment) {
        while tempPrecomputedLineSegments.count <= tempPrecomputedLineSegmentCount {
            tempPrecomputedLineSegments.append(precomputedLineSegment)
        }
        tempPrecomputedLineSegments[tempPrecomputedLineSegmentCount] = precomputedLineSegment
        tempPrecomputedLineSegmentCount += 1
        
        precomputedLineSegment.precompute()
    }
    
    public func purgeTempPrecomputedLineSegments() {
        for precomputedLineSegmentIndex in 0..<tempPrecomputedLineSegmentCount {
            let precomputedLineSegment = tempPrecomputedLineSegments[precomputedLineSegmentIndex]
            GuidePartsFactory.shared.depositPrecomputedLineSegment(precomputedLineSegment)
        }
        tempPrecomputedLineSegmentCount = 0
    }
    
    var tempIntegers = [Int]()
    var tempIntegerCount = 0
    func addTempInteger(_ integer: Int) {
        while tempIntegers.count <= tempIntegerCount {
            tempIntegers.append(integer)
        }
        tempIntegers[tempIntegerCount] = integer
        tempIntegerCount += 1
    }
    
    func purgeTempIntegers() {
        tempIntegerCount = 0
    }
    
    public func purge() {
        weightCurvePoint.isManualHeightEnabled = false
        weightCurvePoint.isManualTanHandleEnabled = false
        
        purgeOutlineGuideWeightSegments()
        purgeOutlineGuideWeightPoints()
        
        purgeGuideWeightPoints()
        purgeGuideWeightSegments()
        
        purgeGuidePoints()
    }
    
    public var center = Point.zero
    public var scale = Float(1.0)
    public var rotation = Float(0.0)
    
    public var centerTemp = Point.zero
    
    public func outlineContainsPoint(_ point: Point) -> Bool {
        var end = outlineGuideWeightPointCount - 1
        var start = 0
        var result = false
        while start < outlineGuideWeightPointCount {
            let point1 = outlineGuideWeightPoints[start]
            let point2 = outlineGuideWeightPoints[end]
            let x1: Float
            let y1: Float
            let x2: Float
            let y2: Float
            if point1.x < point2.x {
                x1 = point1.x
                y1 = point1.y
                x2 = point2.x
                y2 = point2.y
            } else {
                x1 = point2.x
                y1 = point2.y
                x2 = point1.x
                y2 = point1.y
            }
            if point.x > x1 && point.x <= x2 {
                if (point.x - x1) * (y2 - y1) - (point.y - y1) * (x2 - x1) < 0.0 {
                    result = !result
                }
            }
            end = start
            start += 1
        }
        return result
    }
    
    public func outlineDistanceSquaredToPoint(_ point: Point) -> Float {
        var result = Float(100_000_000.0)
        for outlineGuideWeightSegmentIndex in 0..<outlineGuideWeightSegmentCount {
            let outlineGuideWeightSegment = outlineGuideWeightSegments[outlineGuideWeightSegmentIndex]
            let distanceSquared = outlineGuideWeightSegment.distanceSquaredToPoint(point)
            if distanceSquared < result {
                result = distanceSquared
            }
        }
        return result
    }
    
    public func getControlPointCenter() -> Point {
        var sumX = Float(0.0)
        var sumY = Float(0.0)
        for guidePointIndex in 0..<guidePointCount {
            let guidePoint = guidePoints[guidePointIndex]
            sumX += guidePoint.x
            sumY += guidePoint.y
        }
        if guidePointCount > 0 {
            let centerX = sumX / Float(guidePointCount)
            let centerY = sumY / Float(guidePointCount)
            return Point(x: centerX + center.x,
                         y: centerY + center.y)
        }
        return Point(x: center.x,
                     y: center.y)
    }
    
}

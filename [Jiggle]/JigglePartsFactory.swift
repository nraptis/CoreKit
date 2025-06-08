//
//  JigglePartsFactory.swift
//  Yo Mamma Be Ugly
//
//  Created by Nick Raptis on 2/17/24.
//

import Foundation

public class JigglePartsFactory {
    
    public nonisolated(unsafe) static let shared = JigglePartsFactory()
    
    private init() {
        
    }
    
    @MainActor public func dispose() {
        guides.removeAll(keepingCapacity: false)
        guideCount = 0
        
        jigglePoints.removeAll(keepingCapacity: false)
        jigglePointCount = 0
        
        jiggleWeightPoints.removeAll(keepingCapacity: false)
        jiggleWeightPointCount = 0
        
        jiggleWeightSegments.removeAll(keepingCapacity: false)
        jiggleWeightSegmentCount = 0
        
        precomputedLineSegments.removeAll(keepingCapacity: false)
        precomputedLineSegmentCount = 0
    }
    
    ////////////////
    ///
    ///
    private var jiggles = [Jiggle]()
    var jiggleCount = 0
    public func depositJiggle(_ jiggle: Jiggle) {
        
        
        
        depositJiggleContent(jiggle)
        
        while jiggles.count <= jiggleCount {
            jiggles.append(jiggle)
        }
        
        jiggles[jiggleCount] = jiggle
        jiggleCount += 1
    }
    
    public func depositJiggleContent(_ jiggle: Jiggle) {
        jiggle.resetAll_Unsafe()
    }
    
    public func withdrawJiggle(circleSpriteFactory: CircleSpriteFactory,
                               universeScaleInverse: Float) -> Jiggle {
        if jiggleCount > 0 {
            jiggleCount -= 1
            let result = jiggles[jiggleCount]
            result.weightCurvePointStart.reset()
            result.weightCurvePointEnd.reset()
            let jiggleRenderer = (result.renderer as! JiggleRenderer)
            jiggleRenderer.refreshPoints(circleSpriteFactory: circleSpriteFactory)
            jiggleRenderer.refreshLines(universeScaleInverse: universeScaleInverse)
            
            return result
        }
        let renderer = JiggleRenderer()
        let result = Jiggle()
        result.weightCurvePointStart.reset()
        result.weightCurvePointEnd.reset()
        result.renderer = renderer
        renderer.refreshPoints(circleSpriteFactory: circleSpriteFactory)
        renderer.refreshLines(universeScaleInverse: universeScaleInverse)
        return result
    }
    ///
    ///
    ////////////////
    
    
    ////////////////
    ///
    ///
    private var guides = [Guide]()
    var guideCount = 0
    public func depositGuide(_ guide: Guide) {
        guide.purge()
        
        while guides.count <= guideCount {
            guides.append(guide)
        }
        
        guide.selectedGuidePointIndex = -1
        guide.center.x = 0.0
        guide.center.y = 0.0
        guide.scale = 1.0
        guide.rotation = 0.0
        guide.isFrozen = false
        guide.isClockwise = true
        guide.isBroken = false
        
        guide.currentHashSpline.invalidate()
        guide.currentHashOutline.invalidate()
        guide.currentHashSolidLineBufferStandard.invalidate()
        guide.currentHashSolidLineBufferPrecise.invalidate()
        
        //guide.weightCurvePoint.reset()
        
        //guide.weightCurvePoint.isManualHeightEnabled = false
        //guide.weightCurvePoint.isManualTanHandleEnabled = false

        
        guides[guideCount] = guide
        guideCount += 1
    }
    
    public func withdrawGuide() -> Guide {
        if guideCount > 0 {
            guideCount -= 1
            let result = guides[guideCount]
            
            return result
        }
        
        let renderer = GuideRenderer()
        let result = Guide()
        result.renderer = renderer
        return result
    }
    ///
    ///
    ////////////////
    
    ////////////////
    ///
    ///
    private var jigglePoints = [JigglePoint]()
    var jigglePointCount = 0
    public func depositJigglePoint(_ jigglePoint: JigglePoint) {
        while jigglePoints.count <= jigglePointCount {
            jigglePoints.append(jigglePoint)
        }
        
        jigglePoint.isManualTanHandleEnabledIn = false
        jigglePoint.isManualTanHandleEnabledOut = false
        jigglePoint.isTanHandleModified = false
        //jigglePoint.selectedTanType = .none
        
        jigglePoints[jigglePointCount] = jigglePoint
        jigglePointCount += 1
    }
    
    public func withdrawJigglePoint() -> JigglePoint {
        if jigglePointCount > 0 {
            jigglePointCount -= 1
            let result = jigglePoints[jigglePointCount]
            
            return result
        }
        return JigglePoint()
    }
    ///
    ///
    ////////////////
    
    
    
    ////////////////
    ///
    ///
    private var jiggleWeightPoints = [JiggleWeightPoint]()
    var jiggleWeightPointCount = 0
    public func depositJiggleWeightPoint(_ jiggleWeightPoint: JiggleWeightPoint) {
        while jiggleWeightPoints.count <= jiggleWeightPointCount {
            jiggleWeightPoints.append(jiggleWeightPoint)
        }
        jiggleWeightPoints[jiggleWeightPointCount] = jiggleWeightPoint
        jiggleWeightPointCount += 1
    }
    public func withdrawJiggleWeightPoint() -> JiggleWeightPoint {
        if jiggleWeightPointCount > 0 {
            jiggleWeightPointCount -= 1
            return jiggleWeightPoints[jiggleWeightPointCount]
        }
        return JiggleWeightPoint()
    }
    ///
    ///
    ////////////////
    
    
    ////////////////
    ///
    ///
    private var jiggleWeightSegments = [JiggleWeightSegment]()
    var jiggleWeightSegmentCount = 0
    public func depositJiggleWeightSegment(_ jiggleWeightSegment: JiggleWeightSegment) {
        jiggleWeightSegment.isIllegal = false
        jiggleWeightSegment.isBucketed = false // This may well have been the midding nugget
        
        while jiggleWeightSegments.count <= jiggleWeightSegmentCount {
            jiggleWeightSegments.append(jiggleWeightSegment)
        }
        jiggleWeightSegments[jiggleWeightSegmentCount] = jiggleWeightSegment
        jiggleWeightSegmentCount += 1
    }
    public func withdrawJiggleWeightSegment() -> JiggleWeightSegment {
        if jiggleWeightSegmentCount > 0 {
            jiggleWeightSegmentCount -= 1
            return jiggleWeightSegments[jiggleWeightSegmentCount]
        }
        return JiggleWeightSegment()
    }
    ///
    ///
    ////////////////
    
    
    ////////////////
    ///
    ///
    private var precomputedLineSegments = [AnyPrecomputedLineSegment]()
    var precomputedLineSegmentCount = 0
    public func depositPrecomputedLineSegment(_ precomputedLineSegment: AnyPrecomputedLineSegment) {
        while precomputedLineSegments.count <= precomputedLineSegmentCount {
            precomputedLineSegments.append(precomputedLineSegment)
        }
        precomputedLineSegments[precomputedLineSegmentCount] = precomputedLineSegment
        precomputedLineSegmentCount += 1
    }
    public func withdrawPrecomputedLineSegment() -> AnyPrecomputedLineSegment {
        if precomputedLineSegmentCount > 0 {
            precomputedLineSegmentCount -= 1
            return precomputedLineSegments[precomputedLineSegmentCount]
        }
        return AnyPrecomputedLineSegment()
    }
    ///
    ///
    ////////////////

    
    
}

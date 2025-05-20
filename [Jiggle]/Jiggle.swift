//
//  Jiggle.swift
//  Yo Mamma Be Ugly
//
//  Created by Nick Raptis on 11/6/23.
//
//  Verified on 11/9/2024 by Nick Raptis
//

import Foundation
import UIKit
import Combine

public protocol SelectedJigglePointListeningConforming {
    func realizeRecentSelectionChange_Jiggle()
    func realizeRecentSelectionChange_JigglePoint()
    func realizeRecentSelectionChange_Guide()
}

public class Jiggle {
    
    public func saveVideoFrame() -> SavedVideoFrameJiggleData {
        SavedVideoFrameJiggleData(animationCursorX: animationWad.animationCursorX,
                                  animationCursorY: animationWad.animationCursorY,
                                  animationCursorScale: animationWad.animationCursorScale,
                                  animationCursorRotation: animationWad.animationCursorRotation)
    }
    
    static let animationTruuShiftMin = Float(320.0 * AnimationWad.measuredSizeRatioInverse)
    static let animationTruuShiftMax = Float(320.0)
    
    @MainActor public func dispose() {
        
        for guideIndex in 0..<guideCount {
            let guide = guides[guideIndex]
            guide.dispose()
        }
        
        guides.removeAll(keepingCapacity: false)
        guideCount = 0
        
        guidesTemp.removeAll(keepingCapacity: false)
        guideTempCount = 0
        
        selectionPriorityGuides.removeAll(keepingCapacity: false)
        selectionPriorityGuideCount = 0
        
        jigglePoints.removeAll(keepingCapacity: false)
        jigglePointCount = 0
        
        tempIntegers.removeAll(keepingCapacity: false)
        tempIntegerCount = 0
        
        outlineJiggleWeightSegments.removeAll(keepingCapacity: false)
        outlineJiggleWeightSegmentCount = 0
    }
    
    static let selectionPriorityGuideRollOverCeiling = 64
    
    public var selectionPriorityNumber = 0
    
    var guidesTemp = [Guide]()
    var guideTempCount = 0
    
    func addGuideTemp(guide: Guide) {
        while guidesTemp.count <= guideTempCount {
            guidesTemp.append(guide)
        }
        guidesTemp[guideTempCount] = guide
        guideTempCount += 1
    }
    
    func markGuideAsFrontMostGuide(_ guide: Guide?) {
        if let guide = guide {
            selectionPriorityGuideNumber += 1
            guide.selectionPriorityNumber = selectionPriorityGuideNumber
            if selectionPriorityGuideNumber >= Self.selectionPriorityGuideRollOverCeiling {
                selectionPriorityGuidesDownShift()
            } else {
                selectionPriorityGuidesImplant_FrozenLowestPriority()
            }
        } else {
            selectionPriorityGuidesImplant_FrozenLowestPriority()
        }
    }
    
    public var selectionPriorityGuides = [Guide]()
    public var selectionPriorityGuideCount = 0
    public var selectionPriorityGuideNumber = 0
    
    public static let maxPointCount = 256
    public static let minPointCount = 3
    public static let maxGuideCount = 5
    
    public func getRadius(defaultRadius: Float, epsilon: Float) -> Float {
        
        if borderTool.borderCount <= 1 {
            return defaultRadius
        }
        
        var minX = borderTool.borderX[0]
        var maxX = borderTool.borderX[0]
        var minY = borderTool.borderY[0]
        var maxY = borderTool.borderY[0]
        
        for borderIndex in 0..<borderTool.borderCount {
            let x = borderTool.borderX[borderIndex]
            let y = borderTool.borderY[borderIndex]
            minX = min(x, minX)
            maxX = max(x, maxX)
            minY = min(y, minY)
            maxY = max(y, maxY)
        }
        
        let choiceA = (maxX - minX)
        let choiceB = (maxY - minY)
        let choice = min(choiceA, choiceB) * 0.5
        
        if choice > epsilon {
            return choice
        } else {
            return defaultRadius
        }
    }
    
    public var cameraScale = Float(1.0)
    public var cameraRotation = Float(0.0)
    public var cameraOffsetX = Float(0.0)
    public var cameraOffsetY = Float(0.0)
    
    public static let triangulationFastFixTime = Float(0.042)
    
    public var isFrozen = false
    
    public var animationWad = AnimationWad()
    
    var didUpdate = false
    
    public var isReadyEditStandard: Bool {
        return (currentHashTrianglesStandard.polyHash == currentHashPoly)
    }
    public var isReadyEditWeights: Bool {
        return (currentHashTrianglesWeights.polyHash == currentHashPoly)
    }
    public var isReadyViewStandard: Bool {
        return (currentHashTrianglesViewStandard.polyHash == currentHashPoly)
    }
    public var isReadyViewStereoscopic: Bool {
        return (currentHashTrianglesViewStereoscopic.polyHash == currentHashPoly)
    }
    public var isReadySwivel: Bool {
        return (currentHashTrianglesSwivel.polyHash == currentHashPoly)
    }
    
    public var currentHashSpline = SplineHash()
    public var currentHashPoly = PolyHash()
    public var currentHashMeshStandard = MeshStandardHash()
    public var currentHashMeshWeights = MeshWeightsHash()
    public var currentHashOutline = OutlineHash()
    public var currentHashSolidLineBufferStandard = SolidLineBufferJiggleHash()
    public var currentHashSolidLineBufferPrecise = SolidLineBufferJiggleHash()
    public var currentHashWeightCurve = WeightCurveHash()
    public var currentHashTrianglesStandard = TriangleBufferHash()
    public var currentHashTrianglesWeights = TriangleBufferHash()
    public var currentHashTrianglesSwivel = TriangleBufferHash()
    public var currentHashTrianglesViewStandard = TriangleBufferHash()
    public var currentHashTrianglesViewStereoscopic = TriangleBufferHash()
    
    public var triangulationFastTimer = Float(0.0)
    
    public let renderInfo = JiggleRenderInfo()
    public func lockShowingState() {
        renderInfo.lockShowingState()
    }
    public func unlockShowingState() {
        renderInfo.unlockShowingState()
    }
    
    public var guideCenterSpinnerRotation = Float(0.0)
    
    public typealias Point = Math.Point
    public typealias Vector = Math.Vector
    
    public let weightCurvePointStart = WeightCurvePoint()
    public let weightCurvePointEnd = WeightCurvePoint()
    public var weightCurve = WeightCurve()
    public let polyMesh = PolyMesh()
    public let jiggleMesh = JiggleMesh()
    public var renderer: AnyObject!
    
    init() {
        
    }
    
    public var center = Point.zero
    
    public var guideCenter = Point.zero
    public var offsetCenter = Point.zero
    
    public var scale = Float(1.0)
    public var rotation = Float(0.0)
    
    public var spline = FancySpline()
    public let borderTool = BorderTool()
    
    public let solidLineBufferRegularBloom = SolidLineBuffer<Shape3DVertex, UniformsShapeVertex, UniformsShapeFragment>(sentinelNode: .init())
    public let solidLineBufferRegularStroke = SolidLineBuffer<Shape2DVertex, UniformsShapeVertex, UniformsShapeFragment>(sentinelNode: .init())
    public let solidLineBufferRegularFill = SolidLineBuffer<Shape2DVertex, UniformsShapeVertex, UniformsShapeFragment>(sentinelNode: .init())
    
    public let solidLineBufferPreciseBloom = SolidLineBuffer<Shape3DVertex, UniformsShapeVertex, UniformsShapeFragment>(sentinelNode: .init())
    public let solidLineBufferPreciseStroke = SolidLineBuffer<Shape2DVertex, UniformsShapeVertex, UniformsShapeFragment>(sentinelNode: .init())
    public let solidLineBufferPreciseFill = SolidLineBuffer<Shape2DVertex, UniformsShapeVertex, UniformsShapeFragment>(sentinelNode: .init())
    
    // Needs to be INT for undo / redo...
    public var selectedJigglePointIndex = -1
    public func getSelectedJigglePoint() -> JigglePoint? {
        if selectedJigglePointIndex >= 0 && selectedJigglePointIndex < jigglePointCount {
            return jigglePoints[selectedJigglePointIndex]
        }
        return nil
    }
    
    public func getJigglePointIndex(jigglePoint: JigglePoint) -> Int? {
        for jigglePointIndex in 0..<jigglePointCount {
            if jigglePoints[jigglePointIndex] === jigglePoint {
                return jigglePointIndex
            }
        }
        return nil
    }
    
    // Needs to be INT for undo / redo...
    //var selectedGuideIndex = -1
    public func getSelectedGuide() -> Guide? {
        let selectedGuideIndex = (selectedWeightCurveIndex - 1)
        if selectedGuideIndex >= 0 && selectedGuideIndex < guideCount {
            if guides[selectedGuideIndex].isFrozen == false {
                return guides[selectedGuideIndex]
            }
        }
        return nil
    }
    
    // Needs to be INT for undo / redo...
    public var selectedWeightCurveIndex = -1
    public var selectedWeightCurveGraphIndex = -1
    public func getSelectedWeightCurvePointBasedOnGraphIndex() -> WeightCurvePoint? {
        if selectedWeightCurveGraphIndex >= 0 && selectedWeightCurveGraphIndex < weightCurve.weightCurvePointCount {
            return weightCurve.weightCurvePoints[selectedWeightCurveGraphIndex]
        }
        return nil
    }
    
    public func getSelectedWeightCurvePoint() -> WeightCurvePoint? {
        if selectedWeightCurveIndex >= 0 && selectedWeightCurveIndex < weightCurve.weightCurvePointCount {
            return weightCurve.weightCurvePoints[selectedWeightCurveIndex]
        }
        return nil
    }
    
    public func getWeightCurvePoint(weightCurveIndex: Int) -> WeightCurvePoint? {
        if weightCurveIndex < 0 {
            return nil
        } else if weightCurveIndex == 0 {
            return weightCurvePointStart
        } else if weightCurveIndex <= (guideCount) {
            return guides[weightCurveIndex - 1].weightCurvePoint
        } else {
            return weightCurvePointEnd
        }
    }
    
    public func getWeightCurvePoint(isFirstControlPoint: Bool,
                             isLastControlPoint: Bool,
                             guideIndex: Int) -> WeightCurvePoint? {
        if isFirstControlPoint {
            return weightCurvePointStart
        } else if isLastControlPoint {
            return weightCurvePointEnd
        } else {
            if guideIndex >= 0 && guideIndex < guideCount {
                return guides[guideIndex].weightCurvePoint
            } else {
                return nil
            }
        }
    }
    
    public func getWeightCurveIndex(isFirstControlPoint: Bool,
                             isLastControlPoint: Bool,
                             guideIndex: Int) -> Int {
        if isFirstControlPoint {
            return 0
        } else if isLastControlPoint {
            return guideCount + 1
        } else {
            if guideIndex >= 0 && guideIndex < guideCount {
                return guideIndex + 1
            } else {
                return -1
            }
        }
    }
    
    public func getWeightCurvePoint(_ index: Int) -> WeightCurvePoint? {
        if index >= 0 && index < weightCurve.weightCurvePointCount {
            return weightCurve.weightCurvePoints[index]
        }
        return nil
    }
    
    public var jigglePoints = [JigglePoint]()
    public var jigglePointCount = 0
    @MainActor public func addJigglePoint(x: Float,
                                   y: Float,
                                   jiggleDocument: SelectedJigglePointListeningConforming,
                                   ignoreRealize: Bool) {
        let jigglePoint = JigglePartsFactory.shared.withdrawJigglePoint()
        jigglePoint.x = x
        jigglePoint.y = y
        addJigglePoint(newJigglePoint: jigglePoint,
                       jiggleDocument: jiggleDocument,
                       ignoreRealize: ignoreRealize)
    }
    
    @MainActor public func addJigglePoint(directedWeightPoint: DirectedWeightPoint,
                                   jiggleDocument: SelectedJigglePointListeningConforming,
                                   ignoreRealize: Bool) {
        let jigglePoint = JigglePartsFactory.shared.withdrawJigglePoint()
        jigglePoint.x = directedWeightPoint.x
        jigglePoint.y = directedWeightPoint.y
        
        jigglePoint.isManualTanHandleEnabledIn = directedWeightPoint.isManualTanHandleEnabledIn
        jigglePoint.isManualTanHandleEnabledOut = directedWeightPoint.isManualTanHandleEnabledOut
        
        if directedWeightPoint.isManualTanHandleEnabledIn {
            jigglePoint.tanDirectionIn = directedWeightPoint.tanDirectionIn
            jigglePoint.tanMagnitudeIn = directedWeightPoint.tanMagnitudeIn
        }
        if directedWeightPoint.isManualTanHandleEnabledOut {
            jigglePoint.tanDirectionOut = directedWeightPoint.tanDirectionOut
            jigglePoint.tanMagnitudeOut = directedWeightPoint.tanMagnitudeOut
        }
        
        addJigglePoint(newJigglePoint: jigglePoint,
                       jiggleDocument: jiggleDocument,
                       ignoreRealize: ignoreRealize)
    }
    
    @MainActor public func addJigglePoint(newJigglePoint: JigglePoint,
                                   jiggleDocument: SelectedJigglePointListeningConforming,
                                   ignoreRealize: Bool) {
        while jigglePoints.count <= jigglePointCount {
            jigglePoints.append(newJigglePoint)
        }
        
        let newSelectedJigglePointIndex = jigglePointCount
        switchSelectedJigglePoint(newSelectedJigglePointIndex: newSelectedJigglePointIndex,
                                  selectedTanType: .none,
                                  jiggleDocument: jiggleDocument,
                                  ignoreRealize: ignoreRealize)
        
        jigglePoints[jigglePointCount] = newJigglePoint
        jigglePointCount += 1
    }
    
    @MainActor public func insertJigglePoint(x: Float,
                                      y: Float,
                                      index: Int,
                                      jiggleDocument: SelectedJigglePointListeningConforming,
                                      ignoreRealize: Bool) {
        let jigglePoint = JigglePartsFactory.shared.withdrawJigglePoint()
        jigglePoint.x = x
        jigglePoint.y = y
        insertJigglePoint(newJigglePoint: jigglePoint,
                          index: index,
                          jiggleDocument: jiggleDocument,
                          ignoreRealize: ignoreRealize)
    }
    
    @MainActor public func insertJigglePoint(data: ControlPointData,
                                      index: Int,
                                      jiggleDocument: SelectedJigglePointListeningConforming,
                                      ignoreRealize: Bool) {
        let jigglePoint = JigglePartsFactory.shared.withdrawJigglePoint()
        jigglePoint.setData(data)
        insertJigglePoint(newJigglePoint: jigglePoint,
                          index: index,
                          jiggleDocument: jiggleDocument,
                          ignoreRealize: ignoreRealize)
    }
    
    @MainActor public func insertJigglePoint(newJigglePoint: JigglePoint,
                                      index: Int,
                                      jiggleDocument: SelectedJigglePointListeningConforming,
                                      ignoreRealize: Bool) {
        while jigglePoints.count <= jigglePointCount {
            jigglePoints.append(newJigglePoint)
        }
        var jigglePointIndex = jigglePointCount
        while jigglePointIndex > index {
            jigglePoints[jigglePointIndex] = jigglePoints[jigglePointIndex - 1]
            jigglePointIndex -= 1
        }
        
        jigglePoints[index] = newJigglePoint
        
        switchSelectedJigglePoint(newSelectedJigglePointIndex: index,
                                  selectedTanType: .none,
                                  jiggleDocument: jiggleDocument,
                                  ignoreRealize: ignoreRealize)
        
        jigglePointCount += 1
    }
    
    @MainActor public func switchSelectedJigglePoint(newSelectedJigglePointIndex: Int,
                                              selectedTanType: TanTypeOrNone,
                                              jiggleDocument: SelectedJigglePointListeningConforming,
                                              ignoreRealize: Bool) {
        
        selectedJigglePointIndex = newSelectedJigglePointIndex
        
        if newSelectedJigglePointIndex >= 0 && newSelectedJigglePointIndex < jigglePointCount {
            jigglePoints[newSelectedJigglePointIndex].selectedTanType = selectedTanType
        }
        
        if !ignoreRealize {
            jiggleDocument.realizeRecentSelectionChange_JigglePoint()
        }
    }
    
    public func getJigglePoint(_ index: Int) -> JigglePoint? {
        if index >= 0 && index < jigglePointCount {
            return jigglePoints[index]
        }
        return nil
    }
    
    @MainActor public func deleteJigglePoint(jigglePoint: JigglePoint,
                                      jiggleDocument: SelectedJigglePointListeningConforming,
                                      ignoreRealize: Bool) -> Bool {
        for checkIndex in 0..<jigglePointCount {
            if jigglePoints[checkIndex] === jigglePoint {
                if deleteJigglePoint(index: checkIndex,
                                     jiggleDocument: jiggleDocument,
                                     ignoreRealize: ignoreRealize) {
                    return true
                }
            }
        }
        return false
    }
    
    @discardableResult @MainActor public func deleteJigglePoint(index: Int,
                                                         jiggleDocument: SelectedJigglePointListeningConforming,
                                                         ignoreRealize: Bool) -> Bool {
        if index >= 0 && index < jigglePointCount {
            let jigglePoint = jigglePoints[index]
            JigglePartsFactory.shared.depositJigglePoint(jigglePoint)
            let jigglePointCount1 = jigglePointCount - 1
            var jigglePointIndex = index
            while jigglePointIndex < jigglePointCount1 {
                jigglePoints[jigglePointIndex] = jigglePoints[jigglePointIndex + 1]
                jigglePointIndex += 1
            }
            jigglePointCount -= 1
            var newSelectedJigglePointIndex = selectedJigglePointIndex
            if newSelectedJigglePointIndex >= jigglePointCount {
                newSelectedJigglePointIndex = jigglePointCount - 1
            }
            switchSelectedJigglePoint(newSelectedJigglePointIndex: newSelectedJigglePointIndex,
                                      selectedTanType: .none,
                                      jiggleDocument: jiggleDocument,
                                      ignoreRealize: ignoreRealize)
            return true
        }
        return false
    }
    
    public func purgeJigglePoints() {
        for jigglePointIndex in 0..<jigglePointCount {
            let jigglePoint = jigglePoints[jigglePointIndex]
            JigglePartsFactory.shared.depositJigglePoint(jigglePoint)
        }
        jigglePointCount = 0
        selectedJigglePointIndex = -1
    }
    
    public var guides = [Guide]()
    public var guideCount = 0
    public func getGraphIndex(weightCurveIndex: Int) -> Int {
        if weightCurveIndex <= 0 {
            return 0
        }
        if weightCurveIndex >= (guideCount + 1) {
            return guideCount + 1
        }
        
        let guideIndex = (weightCurveIndex - 1)
        if guideIndex >= 0 && guideIndex < guideCount {
            let guide = guides[guideIndex]
            for graphIndex in 0..<weightCurve.weightCurvePointCount {
                if weightCurve.weightCurvePoints[graphIndex] === guide.weightCurvePoint {
                    return graphIndex
                }
            }
        }
        return -1
    }
    
    public func getWeightCurveIndex(graphIndex: Int) -> Int {
        if graphIndex <= 0 {
            return 0
        }
        if graphIndex >= (guideCount + 1) {
            return guideCount + 1
        }
        
        if graphIndex >= 0 && graphIndex < weightCurve.weightCurvePointCount {
            let weightCurvePoint = weightCurve.weightCurvePoints[graphIndex]
            for guideIndex in 0..<guideCount {
                let guide = guides[guideIndex]
                if guide.weightCurvePoint === weightCurvePoint {
                    return guideIndex + 1
                }
            }
        }
        
        return -1
    }
    
    public func getWeightDepthIndex(guideIndex: Int) -> Int? {
        if guideIndex >= 0 && guideIndex < guideCount {
            return getWeightDepthIndex(guide: guides[guideIndex])
        }
        return nil
    }
    
    public func getWeightDepthIndex(guide: Guide) -> Int? {
        for weightDepthIndex in 0..<sortedGuideCount {
            if sortedGuides[weightDepthIndex] === guide {
                return weightDepthIndex
            }
        }
        for guideIndex in 0..<guideCount {
            if guides[guideIndex] === guide {
                return guideIndex
            }
        }
        return nil
    }
    
    public func getWeightCurveIndex(weightCurvePoint: WeightCurvePoint) -> Int? {
        if weightCurvePoint === weightCurvePointStart {
            return 0
        }
        if weightCurvePoint === weightCurvePointEnd {
            return guideCount + 1
        }
        for guideIndex in 0..<guideCount {
            let guide = guides[guideIndex]
            if guide.weightCurvePoint === weightCurvePoint {
                return (guideIndex + 1)
            }
        }
        return nil
    }
    
    public func getSelectedWeightCurveGraphIndexIsFirstControlPoint() -> Bool {
        if selectedWeightCurveGraphIndex <= 0 {
            return true
        }
        return false
    }
    
    public func getSelectedWeightCurveGraphIndexIsLastControlPoint() -> Bool {
        if selectedWeightCurveGraphIndex >= (guideCount + 1) {
            return true
        }
        return false
    }
    
    public func getSelectedWeightCurveGraphIndexWeightCurveIndex() -> Int? {
        if selectedWeightCurveGraphIndex == 0 {
            return 0
        }
        if selectedWeightCurveGraphIndex >= 0 && selectedWeightCurveGraphIndex < weightCurve.weightCurvePointCount {
            let weightCurvePoint = weightCurve.weightCurvePoints[selectedWeightCurveGraphIndex]
            for guideIndex in 0..<guideCount {
                let guide = guides[guideIndex]
                if guide.weightCurvePoint === weightCurvePoint {
                    return guideIndex + 1
                }
            }
        }
        if selectedWeightCurveGraphIndex > 0 {
            return guideCount + 1
        }
        return nil
    }
    
    public func getSelectedGuideIndex() -> Int {
        (selectedWeightCurveIndex - 1)
    }
    
    @MainActor public func addGuideNotFromLoad(_ guide: Guide,
                                        jiggleDocument: SelectedJigglePointListeningConforming,
                                        ignoreRealize: Bool) {
        addGuide(guide)
        let currentSelectedWeightCurveIndex = guideCount
        switchSelectedWeightCurveIndex(index: currentSelectedWeightCurveIndex,
                                       jiggleDocument: jiggleDocument,
                                       ignoreRealize: ignoreRealize)
        //jiggleMesh.readAndSortValidGuides(jiggle: self)
        readAndSortValidGuides()
    }
    
    @MainActor public func addGuide(_ guide: Guide) {
        while guides.count <= guideCount {
            guides.append(guide)
        }
        guides[guideCount] = guide
        guideCount += 1
    }
    
    @MainActor public func insertGuide(_ newGuide: Guide,
                                at index: Int,
                                jiggleDocument: SelectedJigglePointListeningConforming,
                                ignoreRealize: Bool) {
        while guides.count <= guideCount {
            guides.append(newGuide)
        }
        var guideIndex = guideCount
        while guideIndex > index {
            guides[guideIndex] = guides[guideIndex - 1]
            guideIndex -= 1
        }
        guides[index] = newGuide
        guideCount += 1
        
        let currentSelectedWeightCurveIndex = index + 1
        switchSelectedWeightCurveIndex(index: currentSelectedWeightCurveIndex,
                                       jiggleDocument: jiggleDocument,
                                       ignoreRealize: ignoreRealize)
    }
    
    public func containsJigglePoint(_ jigglePoint: JigglePoint) -> Bool {
        for jigglePointIndex in 0..<jigglePointCount {
            if jigglePoints[jigglePointIndex] === jigglePoint {
                return true
            }
        }
        return false
    }
    
    public func containsGuide(_ guide: Guide) -> Bool {
        for checkIndex in 0..<guideCount {
            if guides[checkIndex] === guide {
                return true
            }
        }
        return false
    }
    
    public func isGuideSelected(_ guide: Guide) -> Bool {
        let selectedGuideIndex = (selectedWeightCurveIndex - 1)
        if selectedGuideIndex >= 0 && selectedGuideIndex < guideCount {
            if guides[selectedGuideIndex] === guide {
                return true
            } else {
                return false
            }
        } else {
            return false
        }
    }
    
    public func getGuideIndex(_ guide: Guide) -> Int? {
        for checkIndex in 0..<guideCount {
            if guides[checkIndex] === guide {
                return checkIndex
            }
        }
        return nil
    }
    
    public func getGuideIndex_SelectionPriority(_ guide: Guide) -> Int? {
        for checkIndex in 0..<selectionPriorityGuideCount {
            if selectionPriorityGuides[checkIndex] === guide {
                return checkIndex
            }
        }
        return nil
    }
    
    @MainActor public func deleteGuide(_ guide: Guide,
                                jiggleIndex: Int,
                                jiggleDocument: SelectedJigglePointListeningConforming,
                                ignoreRealize: Bool) -> Bool {
        for checkIndex in 0..<guideCount {
            if guides[checkIndex] === guide {
                deleteGuide(checkIndex,
                            jiggleIndex: jiggleIndex,
                            jiggleDocument: jiggleDocument,
                            ignoreRealize: ignoreRealize)
                return true
            }
        }
        return false
    }
    
    @discardableResult @MainActor public func deleteGuide(_ index: Int,
                                                   jiggleIndex: Int,
                                                   jiggleDocument: SelectedJigglePointListeningConforming,
                                                   ignoreRealize: Bool) -> Bool {
        
        if index >= 0 && index < guideCount {
            let guide = guides[index]
            let removedGuideBigness = guide.bigness
            JigglePartsFactory.shared.depositGuide(guide)
            let guideCount1 = guideCount - 1
            var guideIndex = index
            while guideIndex < guideCount1 {
                guides[guideIndex] = guides[guideIndex + 1]
                guideIndex += 1
            }
            
            guideCount -= 1
            
            if guideCount > 0 {
                
                readAndSortValidGuides()
                
                var newSelectedGuide: Guide?
                var bestBignessDifference = Float(100_000_000.0)
                for guideIndex in 0..<sortedGuideCount {
                    let guide = sortedGuides[guideIndex]
                    if guide.isFrozen == false {
                        let bignessDifference = fabsf(removedGuideBigness - guide.bigness)
                        if bignessDifference < bestBignessDifference {
                            bestBignessDifference = bignessDifference
                            newSelectedGuide = guide
                        }
                    }
                }
                
                if let newSelectedGuide = newSelectedGuide,
                   let newSelectedGuideIndex = getGuideIndex(newSelectedGuide) {
                    switchSelectedWeightCurveIndex(index: newSelectedGuideIndex + 1,
                                                   jiggleDocument: jiggleDocument,
                                                   ignoreRealize: ignoreRealize)
                    
                    
                } else {
                    switchSelectedWeightCurveIndex(index: 0,
                                                   jiggleDocument: jiggleDocument,
                                                   ignoreRealize: ignoreRealize)
                    
                }
            } else {
                switchSelectedWeightCurveIndex(index: 0,
                                               jiggleDocument: jiggleDocument,
                                               ignoreRealize: ignoreRealize)
            }
            return true
        }
        return false
    }
    
    public func getGuide(guideIndex: Int) -> Guide? {
        if guideIndex >= 0 && guideIndex < guideCount {
            return guides[guideIndex]
        }
        return nil
    }
    
    public func getGuide(weightCurveIndex: Int) -> Guide? {
        if weightCurveIndex >= 1 && weightCurveIndex <= guideCount {
            return guides[weightCurveIndex - 1]
        }
        return nil
    }
    
    public func purgeGuides() {
        for guideIndex in 0..<guideCount {
            let guide = guides[guideIndex]
            JigglePartsFactory.shared.depositGuide(guide)
        }
        guideCount = 0
    }
    
    var tempPrecomputedLineSegments = [AnyPrecomputedLineSegment]()
    var tempPrecomputedLineSegmentCount = 0
    func addTempPrecomputedLineSegment(x1: Float,
                                       y1: Float,
                                       x2: Float,
                                       y2: Float) {
        let precomputedLineSegment = JigglePartsFactory.shared.withdrawPrecomputedLineSegment()
        precomputedLineSegment.x1 = x1
        precomputedLineSegment.y1 = y1
        precomputedLineSegment.x2 = x2
        precomputedLineSegment.y2 = y2
        addTempPrecomputedLineSegment(precomputedLineSegment)
    }
    
    func addTempPrecomputedLineSegment(_ precomputedLineSegment: AnyPrecomputedLineSegment) {
        while tempPrecomputedLineSegments.count <= tempPrecomputedLineSegmentCount {
            tempPrecomputedLineSegments.append(precomputedLineSegment)
        }
        tempPrecomputedLineSegments[tempPrecomputedLineSegmentCount] = precomputedLineSegment
        tempPrecomputedLineSegmentCount += 1
        
        precomputedLineSegment.precompute()
    }
    
    func purgeTempPrecomputedLineSegments() {
        for precomputedLineSegmentIndex in 0..<tempPrecomputedLineSegmentCount {
            let precomputedLineSegment = tempPrecomputedLineSegments[precomputedLineSegmentIndex]
            JigglePartsFactory.shared.depositPrecomputedLineSegment(precomputedLineSegment)
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
    
    public var outlineJiggleWeightSegments = [JiggleWeightSegment]()
    public var outlineJiggleWeightSegmentCount = 0
    public func addOutlineJiggleWeightSegment(_ jiggleWeightSegment: JiggleWeightSegment) {
        while outlineJiggleWeightSegments.count <= outlineJiggleWeightSegmentCount {
            outlineJiggleWeightSegments.append(jiggleWeightSegment)
        }
        outlineJiggleWeightSegments[outlineJiggleWeightSegmentCount] = jiggleWeightSegment
        outlineJiggleWeightSegmentCount += 1
    }
    
    public func purgeOutlineJiggleWeightSegments() {
        for jiggleWeightSegmentsIndex in 0..<outlineJiggleWeightSegmentCount {
            JigglePartsFactory.shared.depositJiggleWeightSegment(outlineJiggleWeightSegments[jiggleWeightSegmentsIndex])
        }
        outlineJiggleWeightSegmentCount = 0
    }
    
    public var outlineJiggleWeightPoints = [JiggleWeightPoint]()
    public var outlineJiggleWeightPointCount = 0
    public func addOutlineJiggleWeightPoint(_ jiggleWeightPoint: JiggleWeightPoint) {
        while outlineJiggleWeightPoints.count <= outlineJiggleWeightPointCount {
            outlineJiggleWeightPoints.append(jiggleWeightPoint)
        }
        outlineJiggleWeightPoints[outlineJiggleWeightPointCount] = jiggleWeightPoint
        outlineJiggleWeightPointCount += 1
    }
    
    public func purgeOutlineJiggleWeightPoints() {
        for jiggleWeightPointsIndex in 0..<outlineJiggleWeightPointCount {
            JigglePartsFactory.shared.depositJiggleWeightPoint(outlineJiggleWeightPoints[jiggleWeightPointsIndex])
        }
        outlineJiggleWeightPointCount = 0
    }
    
    @MainActor public func updateVideoFrame(isStereoscopicEnabled: Bool,
                                     stereoSpreadBase: Float,
                                     stereoSpreadMax: Float) {
        
        let measurePercentLinear = AnimationWad.getMeasurePercentLinear(measuredSize: animationWad.measuredSize)
        
        let radiusLow = AnimationWad.animationCursorFalloffDistance_R2_Min
        let radiusDelta = (AnimationWad.animationCursorFalloffDistance_R2_Max - AnimationWad.animationCursorFalloffDistance_R2_Min)
        let radius = radiusLow + radiusDelta * measurePercentLinear
        
        let percentX = animationWad.animationCursorX / radius
        let percentY = animationWad.animationCursorY / radius
        
        let truuShiftLow = Jiggle.animationTruuShiftMin
        let truuShiftDelta = (Jiggle.animationTruuShiftMax - Jiggle.animationTruuShiftMin)
        let truuShift = truuShiftLow + truuShiftDelta * measurePercentLinear
        
        let amountX = percentX * truuShift
        let amountY = percentY * truuShift
        
        var rotationFactor = Float(0.0)
        
        if animationWad.animationCursorRotation != 0.0 {
            rotationFactor = animationWad.animationCursorRotation / AnimationWad.animationCursorFalloffRotation_D2
            if rotationFactor > 1.0 { rotationFactor = 1.0 }
            if rotationFactor < -1.0 { rotationFactor = -1.0 }
        }
        
        var scaleFactor = Float(0.0)
        if animationWad.animationCursorScale > 1.0 {
            scaleFactor = (animationWad.animationCursorScale - 1.0) / (AnimationWad.animationCursorFalloffScale_U2 - 1.0)
            if scaleFactor > 1.0 { scaleFactor = 1.0 }
            if scaleFactor < -1.0 { scaleFactor = -1.0 }
        } else if animationWad.animationCursorScale < 1.0 {
            scaleFactor = -(1.0 - animationWad.animationCursorScale) / (1.0 - AnimationWad.animationCursorFalloffScale_D2)
            if scaleFactor > 1.0 { scaleFactor = 1.0 }
            if scaleFactor < -1.0 { scaleFactor = -1.0 }
        }
        
        let transformedOffsetCenter = transformPointScaleAndRotationOnly(offsetCenter.x, offsetCenter.y)
        
        jiggleMesh.updateActive(amountX: amountX,
                                amountY: amountY,
                                guideCenterX: guideCenter.x,
                                guideCenterY: guideCenter.y,
                                jiggleCenterX: center.x + transformedOffsetCenter.x,
                                jiggleCenterY: center.y + transformedOffsetCenter.y,
                                rotationFactor: rotationFactor,
                                scaleFactor: scaleFactor)
        
        if isStereoscopicEnabled {
            refreshTriangleBuffersViewStereoscopic(stereoSpreadBase: stereoSpreadBase,
                                                   stereoSpreadMax: stereoSpreadMax)
        } else {
            refreshTriangleBuffersViewStandard()
        }
        
    }
    
    @MainActor public func update(deltaTime: Float,
                           documentMode: DocumentMode,
                           displayMode: DisplayMode,
                           weightMode: WeightMode,
                           creatorMode: CreatorMode,
                           isSelected: Bool,
                           isStereoscopicEnabled: Bool,
                           isViewMode: Bool,
                           isJigglesMode: Bool,
                           isPointsMode: Bool,
                           isGuidesMode: Bool,
                           isPrecisePointsMode: Bool,
                           isGuideInsetMarkersEnabled: Bool,
                           pointSelectionMode: PointSelectionModality,
                           stereoSpreadBase: Float,
                           stereoSpreadMax: Float) {
        
        guideCenterSpinnerRotation += deltaTime * 1.25
        if guideCenterSpinnerRotation >= Math.pi2 {
            guideCenterSpinnerRotation -= Math.pi2
        }
        
        if isViewMode {
            updateVideoFrame(isStereoscopicEnabled: isStereoscopicEnabled,
                             stereoSpreadBase: stereoSpreadBase,
                             stereoSpreadMax: stereoSpreadMax)
        } else {
            jiggleMesh.updateInactive()
        }
        
        if renderInfo.isShowingLocked == false {
            
            let isGuideCentersMode = (creatorMode == .moveGuideCenter)
            let isJiggleCentersMode = (creatorMode == .moveJiggleCenter)
            
            renderInfo.isShowingMeshEditStandard = false
            renderInfo.isShowingMeshEditWeights = false
            renderInfo.isShowingMeshViewStandard = false
            renderInfo.isShowingMeshViewStereoscopic = false
            renderInfo.isShowingMeshSwivel = false
            
            renderInfo.isShowingCenterMarker = false
            renderInfo.isShowingCenterMarkerBloom = false
            
            renderInfo.isShowingJiggleBorderRings = false
            renderInfo.isShowingJiggleBorderRingsBloom = false
            renderInfo.isShowingJigglePoints = false
            renderInfo.isShowingJigglePointsBloom = false
            
            renderInfo.isShowingWeightCenterMarker = false
            renderInfo.isShowingWeightCenterMarkerBloom = false
            
            renderInfo.isShowingGuideBorderRings = false
            renderInfo.isShowingGuideBorderRingsBloom = false
            renderInfo.isShowingGuidePoints = false
            renderInfo.isShowingGuidePointsBloom = false
            
            renderInfo.isShowingJigglePointTanHandles = false
            renderInfo.isShowingGuidePointTanHandles = false
            
            renderInfo.isShowingJigglePointTanHandlesBloom = false
            renderInfo.isShowingGuidePointTanHandlesBloom = false
            
            var _isShowingJiggleBorderRingsBloom = isSelected && !isFrozen
            if isGuidesMode {
                if getSelectedGuide() !== nil {
                    if isGuideCentersMode == false {
                        _isShowingJiggleBorderRingsBloom = false
                    }
                }
            }
            
            let _isShowingJigglePointsBloom = isSelected && !isFrozen
            let _isShowingGuideBorderRingsBloom = isSelected && !isFrozen && !isJiggleCentersMode && !isGuideCentersMode
            let _isShowingCenterMarkerBloom = (isSelected) && !isFrozen
            let _isShowingWeightCenterMarkerBloom = (isSelected) && !isFrozen
            
            let _isShowingGuidePoints: Bool
            let _isShowingGuidePointsBloom: Bool
            switch weightMode {
            case .guides:
                _isShowingGuidePoints = false
                _isShowingGuidePointsBloom = false
            case .points:
                _isShowingGuidePoints = true
                _isShowingGuidePointsBloom = isSelected && !isFrozen
                //&& !isJiggleCentersMode && !isGuideCentersMode
            }
            
            if isJigglesMode {
                if (isReadyEditWeights == true && isReadyEditStandard == false) {
                    renderInfo.isShowingMeshEditWeights = true
                    renderInfo.isShowingJiggleBorderRings = true
                    renderInfo.isShowingJiggleBorderRingsBloom = _isShowingJiggleBorderRingsBloom
                    renderInfo.isShowingGuideBorderRings = true
                    renderInfo.isShowingGuideBorderRingsBloom = _isShowingGuideBorderRingsBloom
                    renderInfo.isShowingWeightCenterMarker = true
                    renderInfo.isShowingWeightCenterMarkerBloom = _isShowingWeightCenterMarkerBloom
                    renderInfo.isShowingDarkMode = currentHashTrianglesWeights.isDarkMode
                    renderInfo.isShowingGuidePoints = _isShowingGuidePoints
                    renderInfo.isShowingGuidePointsBloom = _isShowingGuidePointsBloom
                } else {
                    renderInfo.isShowingMeshEditStandard = true
                    renderInfo.isShowingJiggleBorderRings = true
                    renderInfo.isShowingJiggleBorderRingsBloom = _isShowingJiggleBorderRingsBloom
                    renderInfo.isShowingCenterMarker = true
                    renderInfo.isShowingDarkMode = currentHashTrianglesStandard.isDarkMode
                    renderInfo.isShowingCenterMarkerBloom = _isShowingCenterMarkerBloom
                }
            } else if isPointsMode {
                if (isReadyEditWeights == true && isReadyEditStandard == false) {
                    renderInfo.isShowingMeshEditWeights = true
                    renderInfo.isShowingJiggleBorderRings = true
                    renderInfo.isShowingJiggleBorderRingsBloom = _isShowingJiggleBorderRingsBloom
                    renderInfo.isShowingGuideBorderRings = true
                    renderInfo.isShowingGuideBorderRingsBloom = _isShowingGuideBorderRingsBloom
                    renderInfo.isShowingWeightCenterMarker = !isFrozen
                    renderInfo.isShowingWeightCenterMarkerBloom = _isShowingWeightCenterMarkerBloom
                    renderInfo.isShowingGuidePoints = _isShowingGuidePoints
                    renderInfo.isShowingGuidePointsBloom = _isShowingGuidePointsBloom
                    renderInfo.isShowingDarkMode = currentHashTrianglesWeights.isDarkMode
                } else {
                    renderInfo.isShowingMeshEditStandard = true
                    renderInfo.isShowingJiggleBorderRings = true
                    renderInfo.isShowingJiggleBorderRingsBloom = _isShowingJiggleBorderRingsBloom
                    renderInfo.isShowingJigglePoints = true
                    renderInfo.isShowingJigglePointsBloom = _isShowingJigglePointsBloom
                    renderInfo.isShowingCenterMarker = true
                    renderInfo.isShowingCenterMarkerBloom = _isShowingCenterMarkerBloom
                    renderInfo.isShowingDarkMode = currentHashTrianglesStandard.isDarkMode
                }
            } else if isGuidesMode {
                if (isReadyEditWeights == false && isReadyEditStandard == true) {
                    renderInfo.isShowingMeshEditStandard = true
                    renderInfo.isShowingJiggleBorderRings = true
                    renderInfo.isShowingJiggleBorderRingsBloom = _isShowingJiggleBorderRingsBloom
                    renderInfo.isShowingDarkMode = currentHashTrianglesStandard.isDarkMode
                } else {
                    renderInfo.isShowingMeshEditWeights = true
                    renderInfo.isShowingJiggleBorderRings = true
                    renderInfo.isShowingJiggleBorderRingsBloom = _isShowingJiggleBorderRingsBloom
                    renderInfo.isShowingGuideBorderRings = true
                    renderInfo.isShowingGuideBorderRingsBloom = _isShowingGuideBorderRingsBloom
                    renderInfo.isShowingWeightCenterMarker = true
                    renderInfo.isShowingWeightCenterMarkerBloom = _isShowingWeightCenterMarkerBloom
                    renderInfo.isShowingDarkMode = currentHashTrianglesWeights.isDarkMode
                    renderInfo.isShowingGuidePoints = _isShowingGuidePoints
                    renderInfo.isShowingGuidePointsBloom = _isShowingGuidePointsBloom
                }
                
                switch displayMode {
                case .swivel:
                    if isReadySwivel {
                        renderInfo.isShowingMeshSwivel = true
                    }
                default:
                    break
                }
            } else { // View Mode...
                if isStereoscopicEnabled {
                    if (isReadyViewStereoscopic == false && isReadyViewStandard == true) {
                        renderInfo.isShowingMeshViewStandard = true
                        renderInfo.isShowingDarkMode = currentHashTrianglesViewStandard.isDarkMode
                    } else {
                        renderInfo.isShowingMeshViewStereoscopic = true
                        renderInfo.isShowingDarkMode = currentHashTrianglesViewStereoscopic.isDarkMode
                    }
                } else {
                    if (isReadyViewStereoscopic == true && isReadyViewStandard == false) {
                        renderInfo.isShowingMeshViewStereoscopic = true
                        renderInfo.isShowingDarkMode = currentHashTrianglesViewStereoscopic.isDarkMode
                    } else {
                        renderInfo.isShowingMeshViewStandard = true
                        renderInfo.isShowingDarkMode = currentHashTrianglesViewStandard.isDarkMode
                    }
                }
            }
            
            if renderInfo.isShowingJigglePoints {
                
                var isCapableOfShowingJiggleTans = false
                switch creatorMode {
                case .none:
                    isCapableOfShowingJiggleTans = true
                default:
                    break
                }
                
                if isCapableOfShowingJiggleTans {
                    switch pointSelectionMode {
                    case .points:
                        break
                    case .tans:
                        renderInfo.isShowingJigglePointTanHandles = true
                        if isSelected && !isFrozen {
                            renderInfo.isShowingJigglePointTanHandlesBloom = true
                        }
                    case .both:
                        renderInfo.isShowingJigglePointTanHandles = true
                        if isSelected && !isFrozen {
                            renderInfo.isShowingJigglePointTanHandlesBloom = true
                        }
                    }
                }
            }
            
            if renderInfo.isShowingGuidePoints {
                var isCapableOfShowingGuideTans = false
                switch creatorMode {
                case .none:
                    isCapableOfShowingGuideTans = true
                default:
                    break
                }
                
                if isCapableOfShowingGuideTans {
                    
                    switch pointSelectionMode {
                    case .points:
                        break
                    case .tans:
                        renderInfo.isShowingGuidePointTanHandles = true
                        if isSelected && !isFrozen {
                            renderInfo.isShowingGuidePointTanHandlesBloom = true
                        }
                    case .both:
                        renderInfo.isShowingGuidePointTanHandles = true
                        if isSelected && !isFrozen {
                            renderInfo.isShowingGuidePointTanHandlesBloom = true
                        }
                    }
                }
            }
        } else {
            if isPointsMode || isJigglesMode || isGuidesMode {
                if renderInfo.isShowingMeshEditStandard {
                    renderInfo.isShowingDarkMode = currentHashTrianglesStandard.isDarkMode
                } else {
                    renderInfo.isShowingDarkMode = currentHashTrianglesWeights.isDarkMode
                }
            }
        }
    }
    
    public func refreshWeightCurve(graphWidth: Float,
                            graphHeight: Float,
                            graphPaddingH: Float,
                            graphPaddingV: Float,
                            tanFactorWeightCurve: Float,
                            factorWeightCurveAuto: Float) {
        
        
        
        weightCurve.buildSplineFromCurve(frameWidth: graphWidth,
                                         frameHeight: graphHeight,
                                         paddingH: graphPaddingH,
                                         paddingV: graphPaddingV,
                                         tanFactorWeightCurve: tanFactorWeightCurve,
                                         tanFactorWeightCurveAuto: factorWeightCurveAuto,
                                         weightCurvePointStart: weightCurvePointStart,
                                         owningList: guides,
                                         owningListCount: guideCount,
                                         weightCurvePointEnd: weightCurvePointEnd)
        
        weightCurve.refreshSpline(frameWidth: graphWidth,
                                  frameHeight: graphHeight,
                                  paddingH: graphPaddingH,
                                  paddingV: graphPaddingV,
                                  tanFactorWeightCurve: tanFactorWeightCurve)
        
        currentHashWeightCurve.change(frameWidth: graphWidth,
                                      frameHeight: graphHeight,
                                      paddingH: graphPaddingH,
                                      paddingV: graphPaddingV,
                                      weightCurvePointStart: weightCurvePointStart,
                                      owningList: guides,
                                      owningListCount: guideCount,
                                      weightCurvePointEnd: weightCurvePointEnd)
        
        currentHashTrianglesSwivel.invalidate()
        currentHashTrianglesWeights.invalidate()
        currentHashTrianglesViewStandard.invalidate()
        currentHashTrianglesViewStereoscopic.invalidate()
    }
    
    @MainActor public func resetWeightGraph(resetType: WeightCurveResetType) {
        weightCurve.resetType = resetType
        weightCurvePointStart.isManualHeightEnabled = false
        weightCurvePointStart.isManualTanHandleEnabled = false
        weightCurvePointEnd.isManualHeightEnabled = false
        weightCurvePointEnd.isManualTanHandleEnabled = false
        for guideIndex in 0..<guideCount {
            let guide = guides[guideIndex]
            let weightCurvePoint = guide.weightCurvePoint
            weightCurvePoint.isManualHeightEnabled = false
            weightCurvePoint.isManualTanHandleEnabled = false
        }
    }
    
    @MainActor public func refreshTimeLine(timeLineWidth: Float,
                                    timeLineHeight: Float,
                                    timeLinePaddingH: Float,
                                    timeLinePaddingV: Float,
                                    selectedSwatch: TimeLineSwatch,
                                    tanFactorTimeLine: Float) {
        animationWad.timeLine.refreshFrame(frameWidth: timeLineWidth,
                                           frameHeight: timeLineHeight,
                                           paddingH: timeLinePaddingH,
                                           paddingV: timeLinePaddingV)
        let selectedChannel = selectedSwatch.selectedChannel
        selectedChannel.buildSplineFromCurve(frameWidth: timeLineWidth,
                                             frameHeight: timeLineHeight,
                                             paddingH: timeLinePaddingH,
                                             paddingV: timeLinePaddingV,
                                             tanFactorTimeLine: tanFactorTimeLine)
        selectedChannel.refreshSpline(frameWidth: timeLineWidth,
                                      frameHeight: timeLineHeight,
                                      paddingH: timeLinePaddingH,
                                      paddingV: timeLinePaddingV,
                                      tanFactorTimeLine: tanFactorTimeLine)
    }
    
    public typealias SelectedWeightCurveDataUpdatePublisher = PassthroughSubject<Void, Never>
    public func switchSelectedWeightCurveIndexToDefault(isSelected: Bool,
                                                 jiggleDocument: SelectedJigglePointListeningConforming,
                                                 ignoreRealize: Bool) {
        if guideCount > 0 {
            switchSelectedWeightCurveIndex(index: guideCount,
                                           jiggleDocument: jiggleDocument,
                                           ignoreRealize: ignoreRealize)
        } else {
            switchSelectedWeightCurveIndex(index: 0,
                                           jiggleDocument: jiggleDocument,
                                           ignoreRealize: ignoreRealize)
        }
    }
    
    public func switchSelectedWeightCurveIndex(index: Int,
                                        jiggleDocument: SelectedJigglePointListeningConforming,
                                        ignoreRealize: Bool) {
        selectedWeightCurveIndex = index
        
        selectedWeightCurveGraphIndex = getGraphIndex(weightCurveIndex: selectedWeightCurveIndex)
        
        markGuideAsFrontMostGuide(getSelectedGuide())
        
        if !ignoreRealize {
            jiggleDocument.realizeRecentSelectionChange_Guide()
        }
    }
    
    public func switchSelectedTimeLineControlIndex(index: Int, currentSwatch: Swatch) {
        let selectedSwatch = animationWad.timeLine.getSelectedSwatch(swatch: currentSwatch)
        let selectedChannel = selectedSwatch.selectedChannel
        selectedChannel.switchSelectedControlIndex(index: index)
    }
    
    public func refreshOutline(lineThicknessType: RenderLineThicknessType) {
        
        purgeOutlineJiggleWeightPoints()
        purgeOutlineJiggleWeightSegments()
        
        if jiggleMesh.guideWeightPointCount > 0 && (polyMesh.ring.isBroken == false) {
            for jiggleWeightPointIndex in 0..<jiggleMesh.guideWeightPointCount {
                let jiggleWeightPoint = jiggleMesh.guideWeightPoints[jiggleWeightPointIndex]
                let outlineJiggleWeightPoint = JigglePartsFactory.shared.withdrawJiggleWeightPoint()
                let point = transformPoint(jiggleWeightPoint.x, jiggleWeightPoint.y)
                outlineJiggleWeightPoint.x = point.x
                outlineJiggleWeightPoint.y = point.y
                outlineJiggleWeightPoint.controlIndex = jiggleWeightPoint.controlIndex
                addOutlineJiggleWeightPoint(outlineJiggleWeightPoint)
            }
        } else if borderTool.borderCount > 0 {
            for borderIndex in 0..<borderTool.borderCount {
                let x = borderTool.borderX[borderIndex]
                let y = borderTool.borderY[borderIndex]
                let controlIndex = borderTool.borderIndex[borderIndex]
                let point = transformPoint(x, y)
                let outlineJiggleWeightPoint = JigglePartsFactory.shared.withdrawJiggleWeightPoint()
                outlineJiggleWeightPoint.x = point.x
                outlineJiggleWeightPoint.y = point.y
                outlineJiggleWeightPoint.controlIndex = controlIndex
                addOutlineJiggleWeightPoint(outlineJiggleWeightPoint)
            }
        }
        
        if outlineJiggleWeightPointCount > 0 {
            var minX = outlineJiggleWeightPoints[0].x
            var maxX = outlineJiggleWeightPoints[0].x
            var minY = outlineJiggleWeightPoints[0].y
            var maxY = outlineJiggleWeightPoints[0].y
            for outlineWeightPointIndex in 0..<outlineJiggleWeightPointCount {
                let x = outlineJiggleWeightPoints[outlineWeightPointIndex].x
                let y = outlineJiggleWeightPoints[outlineWeightPointIndex].y
                minX = min(x, minX)
                maxX = max(x, maxX)
                minY = min(y, minY)
                maxY = max(y, maxY)
            }
            let spanX = (maxX - minX)
            let spanY = (maxY - minY)
            let jiggleSize = max(spanX, spanY)
            
            animationWad.measuredSize = jiggleSize
            if animationWad.measuredSize < AnimationWad.minMeasuredSize { animationWad.measuredSize = AnimationWad.minMeasuredSize }
            if animationWad.measuredSize > AnimationWad.maxMeasuredSize { animationWad.measuredSize = AnimationWad.maxMeasuredSize }
        }
        
        var jiggleWeightPointIndex1 = outlineJiggleWeightPointCount - 1
        var jiggleWeightPointIndex2 = 0
        while jiggleWeightPointIndex2 < outlineJiggleWeightPointCount {
            let jiggleWeightPoint1 = outlineJiggleWeightPoints[jiggleWeightPointIndex1]
            let jiggleWeightPoint2 = outlineJiggleWeightPoints[jiggleWeightPointIndex2]
            let outjiggleWeightSegment = JigglePartsFactory.shared.withdrawJiggleWeightSegment()
            
            outjiggleWeightSegment.x1 = jiggleWeightPoint1.x
            outjiggleWeightSegment.y1 = jiggleWeightPoint1.y
            outjiggleWeightSegment.x2 = jiggleWeightPoint2.x
            outjiggleWeightSegment.y2 = jiggleWeightPoint2.y
            
            outjiggleWeightSegment.controlIndex1 = jiggleWeightPoint1.controlIndex
            outjiggleWeightSegment.controlIndex2 = jiggleWeightPoint2.controlIndex
            
            outjiggleWeightSegment.precompute()
            
            addOutlineJiggleWeightSegment(outjiggleWeightSegment)
            
            jiggleWeightPointIndex1 = jiggleWeightPointIndex2
            jiggleWeightPointIndex2 += 1
        }
        
        currentHashOutline.change(splineHash: currentHashSpline,
                                  centerX: center.x,
                                  centerY: center.y,
                                  scale: scale,
                                  rotation: rotation,
                                  lineThicknessType: lineThicknessType)
        
    }
    
    public func outlineContainsPoint(_ point: Point) -> Bool {
        var end = outlineJiggleWeightPointCount - 1
        var start = 0
        var result = false
        while start < outlineJiggleWeightPointCount {
            let point1 = outlineJiggleWeightPoints[start]
            let point2 = outlineJiggleWeightPoints[end]
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
        for outlineJiggleWeightSegmentIndex in 0..<outlineJiggleWeightSegmentCount {
            let outlineJiggleWeightSegment = outlineJiggleWeightSegments[outlineJiggleWeightSegmentIndex]
            let distanceSquared = outlineJiggleWeightSegment.distanceSquaredToPoint(point)
            if distanceSquared < result {
                result = distanceSquared
            }
        }
        return result
    }
    
    public func closestWeightSegment(_ point: Point) -> ClosestWeightSegmentResult {
        var bestDistanceSquared = Float(100_000_000.0)
        var bestWeightSegment: JiggleWeightSegment?
        for outlineJiggleWeightSegmentIndex in 0..<outlineJiggleWeightSegmentCount {
            let outlineJiggleWeightSegment = outlineJiggleWeightSegments[outlineJiggleWeightSegmentIndex]
            let distanceSquared = outlineJiggleWeightSegment.distanceSquaredToPoint(point)
            if distanceSquared < bestDistanceSquared {
                bestWeightSegment = outlineJiggleWeightSegment
                bestDistanceSquared = distanceSquared
            }
        }
        if let bestWeightSegment = bestWeightSegment {
            return ClosestWeightSegmentResult.valid(bestWeightSegment, bestDistanceSquared)
        } else {
            return ClosestWeightSegmentResult.none
        }
    }
    
    public func guideCenterDistanceSquaredToPoint(_ point: Point) -> Float {
        let guideCenterTransformed = transformPoint(point: guideCenter)
        let diffX = guideCenterTransformed.x - point.x
        let diffY = guideCenterTransformed.y - point.y
        let result = diffX * diffX + diffY * diffY
        return result
    }
    
    public func offsetCenterDistanceSquaredToPoint(_ point: Point) -> Float {
        let offsetCenterTransformed = transformPoint(point: offsetCenter)
        let diffX = offsetCenterTransformed.x - point.x
        let diffY = offsetCenterTransformed.y - point.y
        let result = diffX * diffX + diffY * diffY
        return result
    }
    
    public var sortedGuides = [Guide]()
    public var sortedGuideCount = 0
    public func addSortedGuide(_ guide: Guide) {
        while sortedGuides.count <= sortedGuideCount {
            sortedGuides.append(guide)
        }
        sortedGuides[sortedGuideCount] = guide
        sortedGuideCount += 1
    }
    public func resetSortedGuides() {
        sortedGuideCount = 0
    }
    
    public func readAndSortValidGuides() {
        
        resetSortedGuides()
        for sortedGuideIndex in 0..<guideCount {
            let guide = guides[sortedGuideIndex]
            guide.originalIndex = sortedGuideIndex
            guide.calculateBigness()
            addSortedGuide(guide)
        }
        
        var i = 1
        while i < sortedGuideCount {
            let holdGuide = sortedGuides[i]
            var j = i - 1
            while j >= 0, sortedGuides[j].bigness < holdGuide.bigness {
                sortedGuides[j + 1] = sortedGuides[j]
                j -= 1
            }
            sortedGuides[j + 1] = holdGuide
            i += 1
        }
        
        // Now we Sort one more time, to make the original index factor in...
        let sameBignessEpsilon = Float(1.0)
        var outerLoopIndex = 0
        while outerLoopIndex < (sortedGuideCount - 1) {
            let currentGuide = sortedGuides[outerLoopIndex]
            var nextGuideIndex = outerLoopIndex + 1
            while (nextGuideIndex < sortedGuideCount) &&
                    ((currentGuide.bigness - sortedGuides[nextGuideIndex].bigness) < sameBignessEpsilon) {
                
                nextGuideIndex += 1
            }
            
            i = outerLoopIndex + 1
            while i < nextGuideIndex {
                let holdGuide = sortedGuides[i]
                var j = i - 1
                while j >= outerLoopIndex, sortedGuides[j].originalIndex < holdGuide.originalIndex {
                    sortedGuides[j + 1] = sortedGuides[j]
                    j -= 1
                }
                sortedGuides[j + 1] = holdGuide
                i += 1
            }
            outerLoopIndex = nextGuideIndex
        }
    }
    
}

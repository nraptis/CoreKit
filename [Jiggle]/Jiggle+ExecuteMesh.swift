//
//  Jiggle+ExecuteMesh.swift
//  Yo Mamma Be Ugly
//
//  Created by Nick Raptis on 11/9/24.
//
//  Verified on 11/9/2024 by Nick Raptis
//

import Foundation

public extension Jiggle {
    
    func execute(meshCommand: JiggleMeshCommand,
                 landscape: Bool,
                 worldScaleStandard: Float,
                 worldScalePrecise: Float,
                 creatorMode: CreatorMode,
                 editMode: EditMode,
                 weightMode: WeightMode,
                 isGuidesMode: Bool,
                 isDarkModeEnabled: Bool,
                 isIpad: Bool,
                 isJiggleSelected: Bool,
                 isJiggleFrozen: Bool,
                 guideCommand: GuideCommand,
                 forceGuideCommand: Bool,
                 selectedGuideIndex: Int,
                 lineThicknessType: RenderLineThicknessType,
                 graphFrame: GraphFrame,
                 tanFactorWeightCurve: Float,
                 factorWeightCurveAuto: Float,
                 opacityPercent: Float,
                 universeScaleInverse: Float,
                 tanFactorJigglePoint: Float) {
        
        execute_part_001(meshCommand: meshCommand,
                         graphFrame: graphFrame,
                         tanFactorWeightCurve: tanFactorWeightCurve,
                         factorWeightCurveAuto: factorWeightCurveAuto)
        
        let isGuideCommandNeeded: Bool
        if forceGuideCommand {
            isGuideCommandNeeded = true
        } else {
            switch meshCommand.meshType {
            case .weightsForced, .weightsIfNeeded, .weightsOnly:
                //
                // Weight ring commands need to be before mesh weights...
                //
                isGuideCommandNeeded = true
            default:
                if guideCommand.spline {
                    isGuideCommandNeeded = true
                } else {
                    isGuideCommandNeeded = false
                }
            }
        }
        //
        //
        //
        if isGuideCommandNeeded {
            for guideIndex in 0..<guideCount {
                let guide = guides[guideIndex]
                if let weightDepthIndex = getWeightDepthIndex(guide: guide) {
                    let isGuideSelected = (guideIndex == selectedGuideIndex)
                    let isGuideFrozen = guide.isFrozen
                    let lineThicknessStroke = LinePointSizes.getLineThicknessStroke(lineThicknessType: lineThicknessType,
                                                                                    isPad: Device.isPad)
                                                                                    //universeScaleInverse: universeScaleInverse)
                    let lineThicknessFill = LinePointSizes.getLineThicknessFill(lineThicknessType: lineThicknessType,
                                                                                isPad: Device.isPad)
                                                                                //universeScaleInverse: universeScaleInverse)
                    
                    guide.execute(guideCommand: guideCommand,
                                  worldScaleStandard: worldScaleStandard,
                                  worldScalePrecise: worldScalePrecise,
                                  creatorMode: creatorMode,
                                  weightMode: weightMode,
                                  isDarkModeEnabled: isDarkModeEnabled,
                                  isJiggleSelected: isJiggleSelected,
                                  isJiggleFrozen: isJiggleFrozen,
                                  jiggleCenter: center,
                                  jiggleScale: scale,
                                  jiggleRotation: rotation,
                                  isGuideSelected: isGuideSelected,
                                  isGuideFrozen: isGuideFrozen,
                                  weightDepthIndex: weightDepthIndex,
                                  guideCount: guideCount,
                                  lineThicknessType: lineThicknessType,
                                  lineThicknessStroke: lineThicknessStroke,
                                  lineThicknessFill: lineThicknessFill,
                                  tanFactor: tanFactorJigglePoint)
                }
            }
        }
        
        execute_part_003(meshCommand: meshCommand,
                         landscape: landscape,
                         worldScaleStandard: worldScaleStandard,
                         worldScalePrecise: worldScalePrecise,
                         creatorMode: creatorMode,
                         editMode: editMode,
                         isGuidesMode: isGuidesMode,
                         isDarkModeEnabled: isDarkModeEnabled,
                         isIpad: isIpad,
                         isJiggleSelected: isJiggleSelected,
                         isJiggleFrozen: isJiggleFrozen,
                         lineThicknessType: lineThicknessType,
                         opacityPercent: opacityPercent,
                         tanFactor: tanFactorJigglePoint,
                         universeScaleInverse: universeScaleInverse)
        
    }
    
    func execute(meshCommand: JiggleMeshCommand,
                 landscape: Bool,
                 worldScaleStandard: Float,
                 worldScalePrecise: Float,
                 creatorMode: CreatorMode,
                 editMode: EditMode,
                 weightMode: WeightMode,
                 isGuidesMode: Bool,
                 isDarkModeEnabled: Bool,
                 isIpad: Bool,
                 isJiggleSelected: Bool,
                 isJiggleFrozen: Bool,
                 targetGuide: Guide,
                 guideCommandForTarget: GuideCommand,
                 guideCommandForOthers: GuideCommand,
                 selectedGuideIndex: Int,
                 lineThicknessType: RenderLineThicknessType,
                 graphFrame: GraphFrame,
                 tanFactorWeightCurve: Float,
                 factorWeightCurveAuto: Float,
                 opacityPercent: Float,
                 universeScaleInverse: Float,
                 tanFactorJigglePoint: Float) {
        
        execute_part_001(meshCommand: meshCommand,
                         graphFrame: graphFrame,
                         tanFactorWeightCurve: tanFactorWeightCurve,
                         factorWeightCurveAuto: factorWeightCurveAuto)
        
        for guideIndex in 0..<guideCount {
            let guide = guides[guideIndex]
            if let weightDepthIndex = getWeightDepthIndex(guide: guide) {
                let isGuideSelected = (guideIndex == selectedGuideIndex)
                let isGuideFrozen = guide.isFrozen
                let lineThicknessStroke = LinePointSizes.getLineThicknessStroke(lineThicknessType: lineThicknessType,
                                                                                isPad: Device.isPad)
                                                                                //universeScaleInverse: universeScaleInverse)
                let lineThicknessFill = LinePointSizes.getLineThicknessFill(lineThicknessType: lineThicknessType,
                                                                            isPad: Device.isPad)
                                                                            //universeScaleInverse: universeScaleInverse)
                if guide === targetGuide {
                    guide.execute(guideCommand: guideCommandForTarget,
                                  worldScaleStandard: worldScaleStandard,
                                  worldScalePrecise: worldScalePrecise,
                                  creatorMode: creatorMode,
                                  weightMode: weightMode,
                                  isDarkModeEnabled: isDarkModeEnabled,
                                  isJiggleSelected: isJiggleSelected,
                                  isJiggleFrozen: isJiggleFrozen,
                                  jiggleCenter: center,
                                  jiggleScale: scale,
                                  jiggleRotation: rotation,
                                  isGuideSelected: isGuideSelected,
                                  isGuideFrozen: isGuideFrozen,
                                  weightDepthIndex: weightDepthIndex,
                                  guideCount: guideCount,
                                  lineThicknessType: lineThicknessType,
                                  lineThicknessStroke: lineThicknessStroke,
                                  lineThicknessFill: lineThicknessFill,
                                  tanFactor: tanFactorJigglePoint)
                    
                } else {
                    guide.execute(guideCommand: guideCommandForOthers,
                                  worldScaleStandard: worldScaleStandard,
                                  worldScalePrecise: worldScalePrecise,
                                  creatorMode: creatorMode,
                                  weightMode: weightMode,
                                  isDarkModeEnabled: isDarkModeEnabled,
                                  isJiggleSelected: isJiggleSelected,
                                  isJiggleFrozen: isJiggleFrozen,
                                  jiggleCenter: center,
                                  jiggleScale: scale,
                                  jiggleRotation: rotation,
                                  isGuideSelected: isGuideSelected,
                                  isGuideFrozen: isGuideFrozen,
                                  weightDepthIndex: weightDepthIndex,
                                  guideCount: guideCount,
                                  lineThicknessType: lineThicknessType,
                                  lineThicknessStroke: lineThicknessStroke,
                                  lineThicknessFill: lineThicknessFill,
                                  tanFactor: tanFactorJigglePoint)
                }
            }
        }
        
        execute_part_003(meshCommand: meshCommand,
                         landscape: landscape,
                         worldScaleStandard: worldScaleStandard,
                         worldScalePrecise: worldScalePrecise,
                         creatorMode: creatorMode,
                         editMode: editMode,
                         isGuidesMode: isGuidesMode,
                         isDarkModeEnabled: isDarkModeEnabled,
                         isIpad: isIpad,
                         isJiggleSelected: isJiggleSelected,
                         isJiggleFrozen: isJiggleFrozen,
                         lineThicknessType: lineThicknessType,
                         opacityPercent: opacityPercent,
                         tanFactor: tanFactorJigglePoint,
                         universeScaleInverse: universeScaleInverse)
    }
    
    private func execute_part_001(meshCommand: JiggleMeshCommand,
                                  graphFrame: GraphFrame,
                                  tanFactorWeightCurve: Float,
                                  factorWeightCurveAuto: Float) {
        
        switch meshCommand.weightCurveType {
        case .none:
            break
        case .forced:
            refreshWeightCurve(graphFrame: graphFrame,
                               tanFactorWeightCurve: tanFactorWeightCurve,
                               factorWeightCurveAuto: factorWeightCurveAuto)
        case .ifNeeded:
            var checkWeightCurveHash = WeightCurveHash()
            checkWeightCurveHash.change(graphFrame: graphFrame,
                                        weightCurvePointStart: weightCurvePointStart,
                                        weightCurvePointMiddle: weightCurvePointMiddle,
                                        weightCurvePointEnd: weightCurvePointEnd)
            if checkWeightCurveHash != currentHashWeightCurve {
                refreshWeightCurve(graphFrame: graphFrame,
                                   tanFactorWeightCurve: tanFactorWeightCurve,
                                   factorWeightCurveAuto: factorWeightCurveAuto)
            }
        }
    }
    
    private func execute_part_003(meshCommand: JiggleMeshCommand,
                                  landscape: Bool,
                                  worldScaleStandard: Float,
                                  worldScalePrecise: Float,
                                  creatorMode: CreatorMode,
                                  editMode: EditMode,
                                  isGuidesMode: Bool,
                                  isDarkModeEnabled: Bool,
                                  isIpad: Bool,
                                  isJiggleSelected: Bool,
                                  isJiggleFrozen: Bool,
                                  lineThicknessType: RenderLineThicknessType,
                                  opacityPercent: Float,
                                  tanFactor: Float,
                                  universeScaleInverse: Float) {
        
        //
        //
        //
        if meshCommand.spline {
            calculateSpline(tanFactor: tanFactor)
        }
        //
        //
        //
        var checkHashPoly = PolyHash()
        checkHashPoly.change(splineHash: currentHashSpline, triangulationType: meshCommand.triangulationType)
        if checkHashPoly != currentHashPoly {
            calculatePolyMesh(triangulationType: meshCommand.triangulationType)
        }
        
        //
        //
        //
        switch meshCommand.meshType {
        case .none:
            break
        case .standardForced:
            refreshMeshStandard(isDarkModeEnabled: isDarkModeEnabled)
        case .standardIfNeeded:
            var checkHashMeshStandard = MeshStandardHash()
            checkHashMeshStandard.change(polyHash: currentHashPoly, isDarkModeEnabled: isDarkModeEnabled)
            if checkHashMeshStandard != currentHashMeshStandard {
                refreshMeshStandard(isDarkModeEnabled: isDarkModeEnabled)
            }
        case .weightsForced:
            refreshMeshWeights(landscape: landscape, isDarkModeEnabled: isDarkModeEnabled, isIpad: isIpad)
        case .weightsIfNeeded:
            var guideOutlineHashes = [OutlineHashGuide]()
            for guideIndex in 0..<guideCount {
                let guide = guides[guideIndex]
                guideOutlineHashes.append(guide.currentHashOutline)
            }
            var checkHashMeshWeights = MeshWeightsHash()
            checkHashMeshWeights.change(polyHash: currentHashPoly,
                                        guideOutlineHashes: guideOutlineHashes,
                                        guideCenterX: guideCenter.x,
                                        guideCenterY: guideCenter.y,
                                        isDarkModeEnabled: isDarkModeEnabled)
            if checkHashMeshWeights != currentHashMeshWeights {
                
                refreshMeshWeights(landscape: landscape, isDarkModeEnabled: isDarkModeEnabled, isIpad: isIpad)
            }
        case .affineOnlyStandard, .affineOnlyWeights:
            refreshMeshAffine()
        case .weightsOnly:
            refreshMeshWeightsOnly()
        }
        
        switch meshCommand.outlineType {
        case .forced:
            refreshOutline(lineThicknessType: lineThicknessType)
            refreshSolidLineBuffersStandard(worldScaleStandard: worldScaleStandard,
                                            creatorMode: creatorMode,
                                            editMode: editMode,
                                            isGuidesMode: isGuidesMode,
                                            isDarkModeEnabled: isDarkModeEnabled,
                                            isJiggleSelected: isJiggleSelected,
                                            isJiggleFrozen: isJiggleFrozen,
                                            lineThicknessType: lineThicknessType,
                                            universeScaleInverse: universeScaleInverse)
            
            refreshSolidLineBuffersPrecise(worldScalePrecise: worldScalePrecise,
                                           creatorMode: creatorMode,
                                           editMode: editMode,
                                           isGuidesMode: isGuidesMode,
                                           isDarkModeEnabled: isDarkModeEnabled,
                                           isJiggleSelected: isJiggleSelected,
                                           isJiggleFrozen: isJiggleFrozen,
                                           lineThicknessType: lineThicknessType)
            
        case .ifNeeded:
            var checkHashOutline = OutlineHash()
            checkHashOutline.change(splineHash: currentHashSpline,
                                    centerX: center.x,
                                    centerY: center.y,
                                    scale: scale,
                                    rotation: rotation,
                                    lineThicknessType: lineThicknessType)
            
            if checkHashOutline != currentHashOutline {
                refreshOutline(lineThicknessType: lineThicknessType)
                
            }
            
            var checkHashSolidLineBufferStandard = SolidLineBufferJiggleHash()
            checkHashSolidLineBufferStandard.change(splineHash: currentHashSpline,
                                                    worldScale: worldScaleStandard,
                                                    creatorMode: creatorMode,
                                                    editMode: editMode,
                                                    isGuidesMode: isGuidesMode,
                                                    centerX: center.x,
                                                    centerY: center.y,
                                                    scale: scale,
                                                    rotation: rotation,
                                                    isJiggleSelected: isJiggleSelected,
                                                    isJiggleFrozen: isJiggleFrozen,
                                                    isDarkModeEnabled: isDarkModeEnabled,
                                                    lineThicknessType: lineThicknessType)
            
            if checkHashSolidLineBufferStandard != currentHashSolidLineBufferStandard {
                refreshSolidLineBuffersStandard(worldScaleStandard: worldScaleStandard,
                                                creatorMode: creatorMode,
                                                editMode: editMode,
                                                isGuidesMode: isGuidesMode,
                                                isDarkModeEnabled: isDarkModeEnabled,
                                                isJiggleSelected: isJiggleSelected,
                                                isJiggleFrozen: isJiggleFrozen,
                                                lineThicknessType: lineThicknessType,
                                                universeScaleInverse: universeScaleInverse)
            }
            
            var checkHashSolidLineBufferPrecise = SolidLineBufferJiggleHash()
            checkHashSolidLineBufferPrecise.change(splineHash: currentHashSpline,
                                                   worldScale: worldScalePrecise,
                                                   creatorMode: creatorMode,
                                                   editMode: editMode,
                                                   isGuidesMode: isGuidesMode,
                                                   centerX: center.x,
                                                   centerY: center.y,
                                                   scale: scale,
                                                   rotation: rotation,
                                                   isJiggleSelected: isJiggleSelected,
                                                   isJiggleFrozen: isJiggleFrozen,
                                                   isDarkModeEnabled: isDarkModeEnabled,
                                                   lineThicknessType: lineThicknessType)
            
            if checkHashSolidLineBufferPrecise != currentHashSolidLineBufferPrecise {
                refreshSolidLineBuffersPrecise(worldScalePrecise: worldScalePrecise,
                                               creatorMode: creatorMode,
                                               editMode: editMode,
                                               isGuidesMode: isGuidesMode,
                                               isDarkModeEnabled: isDarkModeEnabled,
                                               isJiggleSelected: isJiggleSelected,
                                               isJiggleFrozen: isJiggleFrozen,
                                               lineThicknessType: lineThicknessType)
            }
        }
        
        switch meshCommand.meshType {
        case .none:
            break
        case .standardForced, .standardIfNeeded, .affineOnlyStandard:
            var checkHashTrianglesStandard = TriangleBufferHash()
            checkHashTrianglesStandard.change(polyHash: currentHashPoly,
                                              isSelected: isJiggleSelected,
                                              isFrozen: isJiggleFrozen,
                                              isDarkModeEnabled: isDarkModeEnabled,
                                              centerX: center.x,
                                              centerY: center.y,
                                              scale: scale,
                                              rotation: rotation)
            if checkHashTrianglesStandard != currentHashTrianglesStandard {
                refreshTriangleBufferEditStandard(isDarkModeEnabled: isDarkModeEnabled,
                                                  isJiggleSelected: isJiggleSelected,
                                                  isJiggleFrozen: isJiggleFrozen,
                                                  opacityPercent: opacityPercent)
            }
            
        case .weightsForced, .weightsIfNeeded, .weightsOnly, .affineOnlyWeights:
            var checkHashTrianglesWeights = TriangleBufferHash()
            checkHashTrianglesWeights.change(polyHash: currentHashPoly,
                                             isSelected: isJiggleSelected,
                                             isFrozen: isJiggleFrozen,
                                             isDarkModeEnabled: isDarkModeEnabled,
                                             centerX: center.x,
                                             centerY: center.y,
                                             scale: scale,
                                             rotation: rotation)
            if checkHashTrianglesWeights != currentHashTrianglesWeights {
                refreshTriangleBufferEditWeights(isDarkModeEnabled: isDarkModeEnabled,
                                                 isJiggleSelected: isJiggleSelected,
                                                 isJiggleFrozen: isJiggleFrozen,
                                                 opacityPercent: opacityPercent)
            }
            
        }
        
        switch meshCommand.swivelType {
        case .none:
            break
        case .forced:
            refreshTriangleBuffersSwivel(isDarkModeEnabled: isDarkModeEnabled)
        case .ifNeeded:
            var checkHashTrianglesSwivel = TriangleBufferHash()
            checkHashTrianglesSwivel.change(polyHash: currentHashPoly,
                                            isSelected: true,
                                            isFrozen: isJiggleFrozen,
                                            isDarkModeEnabled: isDarkModeEnabled,
                                            centerX: center.x,
                                            centerY: center.y,
                                            scale: scale,
                                            rotation: rotation)
            if checkHashTrianglesSwivel != currentHashTrianglesSwivel {
                refreshTriangleBuffersSwivel(isDarkModeEnabled: isDarkModeEnabled)
            }
        }
        
    }
    
    private func calculateSpline(tanFactor: Float) {
        spline.removeAll(keepingCapacity: true)
        for jigglePointIndex in 0..<jigglePointCount {
            let jigglePoint = jigglePoints[jigglePointIndex]
            spline.addControlPoint(jigglePoint.x, jigglePoint.y)
            
            
            if jigglePoint.isManualTanHandleEnabledIn {
                let magnitudeIn = jigglePoint.tanMagnitudeIn / tanFactor
                let inDirX = sinf(jigglePoint.tanDirectionIn)
                let inDirY = -cosf(jigglePoint.tanDirectionIn)
                spline.enableManualControlTanIn(at: jigglePointIndex,
                                                inTanX: -inDirX * magnitudeIn,
                                                inTanY: -inDirY * magnitudeIn)
                
            } else {
                spline.disableManualControlTanIn(at: jigglePointIndex)
            }
            
            if jigglePoint.isManualTanHandleEnabledOut {
                let magnitudeOut = jigglePoint.tanMagnitudeOut / tanFactor
                let outDirX = sinf(jigglePoint.tanDirectionOut)
                let outDirY = -cosf(jigglePoint.tanDirectionOut)
                spline.enableManualControlTanOut(at: jigglePointIndex,
                                                 outTanX: outDirX * magnitudeOut,
                                                 outTanY: outDirY * magnitudeOut)
            } else {
                spline.disableManualControlTanOut(at: jigglePointIndex)
            }
            
            
            
        }
        spline.solve(closed: true)
        
        isClockwise = spline.isClockwise()
        

        for jigglePointIndex in 0..<jigglePointCount {
            let jigglePoint = jigglePoints[jigglePointIndex]
            jigglePoint.attemptAngleFromTansUnknown(inTanX: spline.inTanX[jigglePointIndex],
                                                               inTanY: spline.inTanY[jigglePointIndex],
                                                               outTanX: spline.outTanX[jigglePointIndex],
                                                               outTanY: spline.outTanY[jigglePointIndex],
                                                               tanFactor: tanFactor)
        }

        borderTool.build(spline: spline,
                         preferredStepSize: PolyMeshConstants.borderPreferredStepSize,
                         skipInterpolationDistance: PolyMeshConstants.borderSkipInterpolationDistance,
                         lowFiSampleDistance: PolyMeshConstants.borderLowFiSampleDistance,
                         medFiSampleDistance: PolyMeshConstants.borderMedFiSampleDistance)
        
        currentHashSpline.change()
        
        currentHashTrianglesStandard.invalidate()
        currentHashTrianglesSwivel.invalidate()
        currentHashTrianglesWeights.invalidate()
        currentHashTrianglesViewStandard.invalidate()
        currentHashTrianglesViewStereoscopic.invalidate()
    }
    
    func calculatePolyMesh(triangulationType: TriangulationType) {
        
        polyMesh.addPointsBegin()
        
        for borderIndex in 0..<borderTool.borderCount {
            let x = borderTool.borderX[borderIndex]
            let y = borderTool.borderY[borderIndex]
            let controlIndex = borderTool.borderIndex[borderIndex]
            polyMesh.addPoint(x: x, y: y, controlIndex: controlIndex)
        }
        
        switch triangulationType {
        case .beautiful:
            polyMesh.addPointsCommit(jiggleMesh: jiggleMesh,
                                     isFast: false,
                                     ignoreDuplicates: true)
            currentHashPoly.change(splineHash: currentHashSpline,
                                   triangulationType: .beautiful)
        case .fast:
            polyMesh.addPointsCommit(jiggleMesh: jiggleMesh,
                                     isFast: true,
                                     ignoreDuplicates: true)
            currentHashPoly.change(splineHash: currentHashSpline,
                                   triangulationType: .fast)
        case .none:
            currentHashPoly.change(splineHash: currentHashSpline,
                                   triangulationType: .none)
        }
        
        currentHashTrianglesStandard.invalidate()
        currentHashTrianglesSwivel.invalidate()
        currentHashTrianglesWeights.invalidate()
        currentHashTrianglesViewStandard.invalidate()
        currentHashTrianglesViewStereoscopic.invalidate()
    }
    
    private func refreshMeshStandard(isDarkModeEnabled: Bool) {
        jiggleMesh.refreshMeshStandard(triangleData: polyMesh.triangleData,
                                       jiggleCenter: center,
                                       jiggleScale: scale,
                                       jiggleRotation: rotation)
        
        currentHashMeshStandard.change(polyHash: currentHashPoly,
                                       isDarkModeEnabled: isDarkModeEnabled)
        
        currentHashTrianglesStandard.invalidate()
        currentHashTrianglesSwivel.invalidate()
        currentHashTrianglesWeights.invalidate()
        currentHashTrianglesViewStandard.invalidate()
        currentHashTrianglesViewStereoscopic.invalidate()
    }
    
    private func refreshMeshWeights(landscape: Bool,
                                    isDarkModeEnabled: Bool,
                                    isIpad: Bool) {
        
        readAndSortValidGuides()
        jiggleMesh.refreshMeshWeights(triangleData: polyMesh.triangleData,
                                      jiggleCenter: center,
                                      jiggleScale: scale,
                                      jiggleRotation: rotation,
                                      weightCurveMapperNodes: weightCurve.mapper.weightCurveMapperNodes,
                                      weightCurveMapperNodeCount: weightCurve.mapper.weightCurveMapperNodeCount,
                                      sortedGuides: sortedGuides,
                                      sortedGuideCount: sortedGuideCount,
                                      landscape: landscape,
                                      scale: scale,
                                      isIpad: isIpad,
                                      guideCenterX: guideCenter.x,
                                      guideCenterY: guideCenter.y)
        
        var guideOutlineHashes = [OutlineHashGuide]()
        for guideIndex in 0..<guideCount {
            let guide = guides[guideIndex]
            guideOutlineHashes.append(guide.currentHashOutline)
        }
        
        currentHashMeshWeights.change(polyHash: currentHashPoly,
                                      guideOutlineHashes: guideOutlineHashes,
                                      guideCenterX: guideCenter.x,
                                      guideCenterY: guideCenter.y,
                                      isDarkModeEnabled: isDarkModeEnabled)
        
        // The "standard" mesh can use the exact same stuff.
        currentHashMeshStandard.change(polyHash: currentHashPoly,
                                       isDarkModeEnabled: isDarkModeEnabled)
        
        
        currentHashTrianglesStandard.invalidate()
        currentHashTrianglesSwivel.invalidate()
        currentHashTrianglesWeights.invalidate()
        currentHashTrianglesViewStandard.invalidate()
        currentHashTrianglesViewStereoscopic.invalidate()
    }
    
    private func refreshMeshWeightsOnly() {
        jiggleMesh.refreshMeshWeightsOnly(weightCurveMapperNodes: weightCurve.mapper.weightCurveMapperNodes,
                                          weightCurveMapperNodeCount: weightCurve.mapper.weightCurveMapperNodeCount,
                                          guideCount: guideCount)
        currentHashTrianglesStandard.invalidate()
        currentHashTrianglesSwivel.invalidate()
        currentHashTrianglesWeights.invalidate()
        currentHashTrianglesViewStandard.invalidate()
        currentHashTrianglesViewStereoscopic.invalidate()
    }
    
    private func refreshMeshAffine() {
        readAndSortValidGuides()
        jiggleMesh.refreshMeshAffine(jiggleCenter: center, jiggleScale: scale, jiggleRotation: rotation)
        currentHashTrianglesStandard.invalidate()
        currentHashTrianglesSwivel.invalidate()
        currentHashTrianglesWeights.invalidate()
        currentHashTrianglesViewStandard.invalidate()
        currentHashTrianglesViewStereoscopic.invalidate()
    }
    
    func refreshSolidLineBuffersStandard(worldScaleStandard: Float,
                                         creatorMode: CreatorMode,
                                         editMode: EditMode,
                                         isGuidesMode: Bool,
                                         isDarkModeEnabled: Bool,
                                         isJiggleSelected: Bool,
                                         isJiggleFrozen: Bool,
                                         lineThicknessType: RenderLineThicknessType,
                                         universeScaleInverse: Float) {
        
        if isJiggleFrozen {
            solidLineBufferRegularStroke.rgba = RTJ.strokeDis(isDarkModeEnabled: isDarkModeEnabled)
            solidLineBufferRegularFill.rgba = RTJ.fillDis(isDarkModeEnabled: isDarkModeEnabled)
        } else {
            
            let creatorModeFormat: BorderCreatorModeFormat
            if isGuidesMode {
                creatorModeFormat = .alternative
            } else {
                switch creatorMode {
                case .none:
                    creatorModeFormat = .regular
                case .makeJiggle:
                    creatorModeFormat = .regular
                case .drawJiggle:
                    creatorModeFormat = .regular
                case .addJigglePoint:
                    if isJiggleSelected {
                        creatorModeFormat = .regular
                    } else {
                        creatorModeFormat = .alternative
                    }
                case .deleteJigglePoint:
                    creatorModeFormat = .regular
                case .makeGuide:
                    creatorModeFormat = .alternative
                case .drawGuide:
                    creatorModeFormat = .alternative
                case .addGuidePoint:
                    creatorModeFormat = .alternative
                case .deleteGuidePoint:
                    creatorModeFormat = .alternative
                case .moveJiggleCenter:
                    creatorModeFormat = .alternative
                case .moveGuideCenter:
                    creatorModeFormat = .alternative
                }
            }
            
            solidLineBufferRegularBloom.rgba = RTJ.bloom(isDarkModeEnabled: isDarkModeEnabled)
            switch creatorModeFormat {
            case .regular:
                if isJiggleSelected {
                    solidLineBufferRegularStroke.rgba = RTJ.strokeRegSel(isDarkModeEnabled: isDarkModeEnabled)
                    switch editMode {
                    case .jiggles:
                        solidLineBufferRegularFill.rgba = RTJ.fillGrb(isDarkModeEnabled: isDarkModeEnabled)
                    case .points:
                        solidLineBufferRegularFill.rgba = RTJ.fillRegSelUnm(isDarkModeEnabled: isDarkModeEnabled)
                    }
                } else {
                    solidLineBufferRegularStroke.rgba = RTJ.strokeRegUns(isDarkModeEnabled: isDarkModeEnabled)
                    solidLineBufferRegularFill.rgba = RTJ.fillRegUnsUnm(isDarkModeEnabled: isDarkModeEnabled)
                }
            case .alternative:
                if isJiggleSelected {
                    solidLineBufferRegularStroke.rgba = RTJ.strokeAltSel(isDarkModeEnabled: isDarkModeEnabled)
                    solidLineBufferRegularFill.rgba = RTJ.fillAltSelUnm(isDarkModeEnabled: isDarkModeEnabled)
                } else {
                    solidLineBufferRegularStroke.rgba = RTJ.strokeAltUns(isDarkModeEnabled: isDarkModeEnabled)
                    solidLineBufferRegularFill.rgba = RTJ.fillAltUnsUnm(isDarkModeEnabled: isDarkModeEnabled)
                }
            }
        }
        
        solidLineBufferRegularBloom.removeAll(keepingCapacity: true)
        solidLineBufferRegularBloom.thickness = LinePointSizes.getLineThicknessStroke(lineThicknessType: lineThicknessType,
                                                                                      isPad: Device.isPad)
        
        solidLineBufferRegularStroke.removeAll(keepingCapacity: true)
        solidLineBufferRegularStroke.thickness = LinePointSizes.getLineThicknessStroke(lineThicknessType: lineThicknessType,
                                                                                       isPad: Device.isPad)
        
        solidLineBufferRegularFill.removeAll(keepingCapacity: true)
        solidLineBufferRegularFill.thickness = LinePointSizes.getLineThicknessFill(lineThicknessType: lineThicknessType,
                                                                                   isPad: Device.isPad)
        
        for outlineJiggleWeightPointIndex in 0..<outlineJiggleWeightPointCount {
            let outlineJiggleWeightPoint = outlineJiggleWeightPoints[outlineJiggleWeightPointIndex]
            let pointX = outlineJiggleWeightPoint.x
            let pointY = outlineJiggleWeightPoint.y
            solidLineBufferRegularBloom.addPoint(pointX, pointY)
            solidLineBufferRegularStroke.addPoint(pointX, pointY)
            solidLineBufferRegularFill.addPoint(pointX, pointY)
        }
        
        solidLineBufferRegularBloom.generate(scale: worldScaleStandard)
        solidLineBufferRegularStroke.generate(scale: worldScaleStandard)
        solidLineBufferRegularFill.generate(scale: worldScaleStandard)
        
        currentHashSolidLineBufferStandard.change(splineHash: currentHashSpline,
                                                  worldScale: worldScaleStandard,
                                                  creatorMode: creatorMode,
                                                  editMode: editMode,
                                                  isGuidesMode: isGuidesMode,
                                                  centerX: center.x,
                                                  centerY: center.y,
                                                  scale: scale,
                                                  rotation: rotation,
                                                  isJiggleSelected: isJiggleSelected,
                                                  isJiggleFrozen: isJiggleFrozen,
                                                  isDarkModeEnabled: isDarkModeEnabled,
                                                  lineThicknessType: lineThicknessType)
        
    }
    
    func refreshSolidLineBuffersPrecise(worldScalePrecise: Float,
                                        creatorMode: CreatorMode,
                                        editMode: EditMode,
                                        isGuidesMode: Bool,
                                        isDarkModeEnabled: Bool,
                                        isJiggleSelected: Bool,
                                        isJiggleFrozen: Bool,
                                        lineThicknessType: RenderLineThicknessType) {
        
        solidLineBufferPreciseBloom.removeAll(keepingCapacity: true)
        solidLineBufferPreciseBloom.thickness = solidLineBufferRegularBloom.thickness
        solidLineBufferPreciseBloom.rgba = solidLineBufferRegularBloom.rgba
        
        solidLineBufferPreciseStroke.removeAll(keepingCapacity: true)
        solidLineBufferPreciseStroke.thickness = solidLineBufferRegularStroke.thickness
        solidLineBufferPreciseStroke.rgba = solidLineBufferRegularStroke.rgba
        
        solidLineBufferPreciseFill.removeAll(keepingCapacity: true)
        solidLineBufferPreciseFill.thickness = solidLineBufferRegularFill.thickness
        solidLineBufferPreciseFill.rgba = solidLineBufferRegularFill.rgba
        
        for outlineJiggleWeightPointIndex in 0..<outlineJiggleWeightPointCount {
            let outlineJiggleWeightPoint = outlineJiggleWeightPoints[outlineJiggleWeightPointIndex]
            let pointX = outlineJiggleWeightPoint.x
            let pointY = outlineJiggleWeightPoint.y
            solidLineBufferPreciseBloom.addPoint(pointX, pointY)
            solidLineBufferPreciseStroke.addPoint(pointX, pointY)
            solidLineBufferPreciseFill.addPoint(pointX, pointY)
        }
        
        solidLineBufferPreciseBloom.generate(scale: worldScalePrecise)
        solidLineBufferPreciseStroke.generate(scale: worldScalePrecise)
        solidLineBufferPreciseFill.generate(scale: worldScalePrecise)
        
        currentHashSolidLineBufferPrecise.change(splineHash: currentHashSpline,
                                                 worldScale: worldScalePrecise,
                                                 creatorMode: creatorMode,
                                                 editMode: editMode,
                                                 isGuidesMode: isGuidesMode,
                                                 centerX: center.x,
                                                 centerY: center.y,
                                                 scale: scale,
                                                 rotation: rotation,
                                                 isJiggleSelected: isJiggleSelected,
                                                 isJiggleFrozen: isJiggleFrozen,
                                                 isDarkModeEnabled: isDarkModeEnabled,
                                                 lineThicknessType: lineThicknessType)
    }
    
}

//
//  JiggleMesh.swift
//  Yo Mamma Be Ugly
//
//  Created by Nick Raptis on 2/17/24.
//

import Foundation
import Metal

public class JiggleMesh {
    
    public private(set) var widthNaturalized = Float(1024.0)
    public private(set) var heightNaturalized = Float(1024.0)
    
    public private(set) var meshMinX = Float(0.0)
    public private(set) var meshMaxX = Float(0.0)
    public private(set) var meshMinY = Float(0.0)
    public private(set) var meshMaxY = Float(0.0)
    
    var baseMinX = Float(0.0)
    var baseMaxX = Float(0.0)
    var baseMinY = Float(0.0)
    var baseMaxY = Float(0.0)
    
    public var editBufferStandardRegular = IndexedShapeBuffer2DColored()
    public var editBufferWeightsRegular = IndexedShapeBuffer2DColored()
    public var editBufferStandardPrecise = IndexedShapeBuffer2DColored()
    public var editBufferWeightsPrecise = IndexedShapeBuffer2DColored()
    public let swivelBuffer = IndexedSpriteBuffer<Sprite3DLightedColoredVertex,
                                                  UniformsLightsVertex,
                                                  UniformsPhongFragment>()
    public let swivelBloomBuffer = IndexedShapeBuffer3D()
    public var viewBuffer = IndexedSpriteBuffer3D()
    public var viewBufferStereoscopic = IndexedSpriteBuffer3DStereoscopic()
    
    public private(set) var indices = [UInt32]()
    public private(set) var indexCount = 0
    
    var heightMaximum = Float(256.0)
    
    public static let heightFactorPhonePortrait = Float(0.80)
    public static let heightFactorPhoneLandscape = Float(0.65)
    public static let heightFactorPad = Float(0.85)
    
    public init() {
        
    }
    
    public var jiggleMeshPoints = [JiggleMeshPoint]()
    public var jiggleMeshPointCount = 0
    public func addJiggleMeshPoint(_ jiggleMeshPoint: JiggleMeshPoint) {
        while jiggleMeshPoints.count <= jiggleMeshPointCount {
            jiggleMeshPoints.append(jiggleMeshPoint)
        }
        jiggleMeshPoints[jiggleMeshPointCount] = jiggleMeshPoint
        jiggleMeshPointCount += 1
    }
    
    public func purgeJiggleMeshPoints() {
        for jiggleMeshPointIndex in 0..<jiggleMeshPointCount {
            JiggleMeshPartsFactory.shared.depositJiggleMeshPoint(jiggleMeshPoints[jiggleMeshPointIndex])
        }
        jiggleMeshPointCount = 0
    }
    
    var level_0_MeshPoints = [JiggleMeshPoint]()
    var level_0_MeshPointCount = 0
    func addLevel_0_MeshPoint(_ jiggleMeshPoint: JiggleMeshPoint) {
        while level_0_MeshPoints.count <= level_0_MeshPointCount {
            level_0_MeshPoints.append(jiggleMeshPoint)
        }
        level_0_MeshPoints[level_0_MeshPointCount] = jiggleMeshPoint
        level_0_MeshPointCount += 1
    }
    func purgeLevel_0_MeshPoints() {
        level_0_MeshPointCount = 0
    }
    
    var level_1_MeshPoints = [JiggleMeshPoint]()
    var level_1_MeshPointCount = 0
    func addLevel_1_MeshPoint(_ jiggleMeshPoint: JiggleMeshPoint) {
        while level_1_MeshPoints.count <= level_1_MeshPointCount {
            level_1_MeshPoints.append(jiggleMeshPoint)
        }
        level_1_MeshPoints[level_1_MeshPointCount] = jiggleMeshPoint
        level_1_MeshPointCount += 1
    }
    func purgeLevel_1_MeshPoints() {
        level_1_MeshPointCount = 0
    }
    
    var level_2_MeshPoints = [JiggleMeshPoint]()
    var level_2_MeshPointCount = 0
    func addLevel_2_MeshPoint(_ jiggleMeshPoint: JiggleMeshPoint) {
        while level_2_MeshPoints.count <= level_2_MeshPointCount {
            level_2_MeshPoints.append(jiggleMeshPoint)
        }
        level_2_MeshPoints[level_2_MeshPointCount] = jiggleMeshPoint
        level_2_MeshPointCount += 1
    }
    func purgeLevel_2_MeshPoints() {
        level_2_MeshPointCount = 0
    }
    
    var level_3_MeshPoints = [JiggleMeshPoint]()
    var level_3_MeshPointCount = 0
    func addLevel_3_MeshPoint(_ jiggleMeshPoint: JiggleMeshPoint) {
        while level_3_MeshPoints.count <= level_3_MeshPointCount {
            level_3_MeshPoints.append(jiggleMeshPoint)
        }
        level_3_MeshPoints[level_3_MeshPointCount] = jiggleMeshPoint
        level_3_MeshPointCount += 1
    }
    func purgeLevel_3_MeshPoints() {
        level_3_MeshPointCount = 0
    }
    
    var level_4_MeshPoints = [JiggleMeshPoint]()
    var level_4_MeshPointCount = 0
    func addLevel_4_MeshPoint(_ jiggleMeshPoint: JiggleMeshPoint) {
        while level_4_MeshPoints.count <= level_4_MeshPointCount {
            level_4_MeshPoints.append(jiggleMeshPoint)
        }
        level_4_MeshPoints[level_4_MeshPointCount] = jiggleMeshPoint
        level_4_MeshPointCount += 1
    }
    func purgeLevel_4_MeshPoints() {
        level_4_MeshPointCount = 0
    }
    
    var level_5_MeshPoints = [JiggleMeshPoint]()
    var level_5_MeshPointCount = 0
    func addLevel_5_MeshPoint(_ jiggleMeshPoint: JiggleMeshPoint) {
        while level_5_MeshPoints.count <= level_5_MeshPointCount {
            level_5_MeshPoints.append(jiggleMeshPoint)
        }
        level_5_MeshPoints[level_5_MeshPointCount] = jiggleMeshPoint
        level_5_MeshPointCount += 1
    }
    func purgeLevel_5_MeshPoints() {
        level_5_MeshPointCount = 0
    }
    
    public var cameraCalibrationPoints = [JiggleMeshPoint]()
    public var cameraCalibrationPointCount = 0
    public func addCameraCalibrationPoint(_ cameraCalibrationPoint: JiggleMeshPoint) {
        while cameraCalibrationPoints.count <= cameraCalibrationPointCount {
            cameraCalibrationPoints.append(cameraCalibrationPoint)
        }
        cameraCalibrationPoints[cameraCalibrationPointCount] = cameraCalibrationPoint
        cameraCalibrationPointCount += 1
    }
    func purgeCameraCalibrationPoints() {
        for cameraCalibrationPointIndex in 0..<cameraCalibrationPointCount {
            JiggleMeshPartsFactory.shared.depositJiggleMeshPoint(cameraCalibrationPoints[cameraCalibrationPointIndex])
        }
        cameraCalibrationPointCount = 0
    }
    
    let guideWeightSegmentBucket = GuideWeightSegmentBucket()
    var guideWeightSegments = [GuideWeightSegment]()
    var guideWeightSegmentCount = 0
    func addGuideWeightSegment(_ guideWeightSegment: GuideWeightSegment) {
        while guideWeightSegments.count <= guideWeightSegmentCount {
            guideWeightSegments.append(guideWeightSegment)
        }
        guideWeightSegments[guideWeightSegmentCount] = guideWeightSegment
        guideWeightSegmentCount += 1
    }
    
    func purgeGuideWeightSegments() {
        for guideWeightSegmentsIndex in 0..<guideWeightSegmentCount {
            GuidePartsFactory.shared.depositGuideWeightSegment(guideWeightSegments[guideWeightSegmentsIndex])
        }
        guideWeightSegmentCount = 0
    }
    
    public var guideWeightPoints = [GuideWeightPoint]()
    public var guideWeightPointCount = 0
    func addGuideWeightPoint(_ guideWeightPoint: GuideWeightPoint) {
        while guideWeightPoints.count <= guideWeightPointCount {
            guideWeightPoints.append(guideWeightPoint)
        }
        guideWeightPoints[guideWeightPointCount] = guideWeightPoint
        guideWeightPointCount += 1
    }
    
    func purgeGuideWeightPoints() {
        for guideWeightPointIndex in 0..<guideWeightPointCount {
            GuidePartsFactory.shared.depositGuideWeightPoint(guideWeightPoints[guideWeightPointIndex])
        }
        guideWeightPointCount = 0
    }
    
    public func handleShapeUpdate(ringLineSegments: [RingLineSegment],
                                  ringLineSegmentCount: Int,
                                  ringPoints: [RingPoint],
                                  ringPointCount: Int) {
        purgeGuideWeightSegments()
        for ringLineSegmentIndex in 0..<ringLineSegmentCount {
            let ringLineSegment = ringLineSegments[ringLineSegmentIndex]
            let guideWeightSegment = GuidePartsFactory.shared.withdrawGuideWeightSegment()
            guideWeightSegment.readFrom(ringLineSegment)
            addGuideWeightSegment(guideWeightSegment)
        }
        
        purgeGuideWeightPoints()
        for ringPointIndex in 0..<ringPointCount {
            let ringPoint = ringPoints[ringPointIndex]
            let guideWeightPoint = GuidePartsFactory.shared.withdrawGuideWeightPoint()
            guideWeightPoint.x = ringPoint.x
            guideWeightPoint.y = ringPoint.y
            guideWeightPoint.controlIndex = ringPoint.controlIndex
            addGuideWeightPoint(guideWeightPoint)
        }
    }
    
    func distanceFromEdge(x: Float, y: Float) -> Float {
        var bestDistanceSquared = Float(100_000_000.0)
        for guideWeightSegmentsIndex in 0..<guideWeightSegmentCount {
            let guideWeightSegment = guideWeightSegments[guideWeightSegmentsIndex]
            let distanceSquared = guideWeightSegment.distanceSquaredToClosestPoint(x, y)
            if distanceSquared < bestDistanceSquared {
                bestDistanceSquared = distanceSquared
            }
        }
        if bestDistanceSquared > Math.epsilon {
            return sqrtf(bestDistanceSquared)
        } else {
            return 0.0
        }
    }
    
    public func load(graphics: Graphics,
                     backgroundSprite: Sprite,
                     widthNaturalized: Float,
                     heightNaturalized: Float) {
        self.widthNaturalized = widthNaturalized
        self.heightNaturalized = heightNaturalized
        
        editBufferStandardRegular.load_t_n(graphics: graphics)
        editBufferWeightsRegular.load_t_n(graphics: graphics)
        
        editBufferStandardPrecise.load_t_n(graphics: graphics)
        editBufferWeightsPrecise.load_t_n(graphics: graphics)
        
        swivelBuffer.load(graphics: graphics, sprite: backgroundSprite)
        swivelBuffer.primitiveType = .triangle
        swivelBuffer.cullMode = .none
        
        swivelBloomBuffer.load(graphics: graphics)
        swivelBloomBuffer.primitiveType = .triangle
        swivelBloomBuffer.cullMode = .none
        
        viewBuffer.load(graphics: graphics, sprite: backgroundSprite)
        viewBuffer.primitiveType = .triangle
        viewBuffer.cullMode = .none
        
        viewBufferStereoscopic.load(graphics: graphics, sprite: backgroundSprite)
        viewBufferStereoscopic.primitiveType = .triangle
        viewBufferStereoscopic.cullMode = .none
    }
    
    public func updateActive(amountX: Float,
                             amountY: Float,
                             guideCenterX: Float,
                             guideCenterY: Float,
                             jiggleCenterX: Float,
                             jiggleCenterY: Float,
                             rotationFactor: Float,
                             scaleFactor: Float) {
        
        for jiggleMeshPointIndex in 0..<jiggleMeshPointCount {
            jiggleMeshPoints[jiggleMeshPointIndex].updateActive(amountX: amountX,
                                                                amountY: amountY,
                                                                guideCenterX: guideCenterX,
                                                                guideCenterY: guideCenterY,
                                                                jiggleCenterX: jiggleCenterX,
                                                                jiggleCenterY: jiggleCenterY,
                                                                rotationFactor: rotationFactor,
                                                                scaleFactor: scaleFactor)
        }
    }
    
    public func updateInactive() {
        for jiggleMeshPointIndex in 0..<jiggleMeshPointCount {
            jiggleMeshPoints[jiggleMeshPointIndex].updateInactive()
        }
    }
    
    public func refreshMeshStandard(triangleData: PolyMeshTriangleData,
                                    jiggleCenter: Math.Point,
                                    jiggleScale: Float,
                                    jiggleRotation: Float) {
        refreshMesh(triangleData: triangleData,
                    jiggleCenter: jiggleCenter,
                    jiggleScale: jiggleScale,
                    jiggleRotation: jiggleRotation)
        refreshUpdateAllInactive()
    }
    
    public func refreshMeshWeights(triangleData: PolyMeshTriangleData,
                                   jiggleCenter: Math.Point,
                                   jiggleScale: Float,
                                   jiggleRotation: Float,
                                   weightCurveMapperNodes: [WeightCurveMapperNode],
                                   weightCurveMapperNodeCount: Int,
                                   sortedGuides: [Guide],
                                   sortedGuideCount: Int,
                                   landscape: Bool,
                                   scale: Float,
                                   isIpad: Bool,
                                   guideCenterX: Float,
                                   guideCenterY: Float) {
        
        refreshMesh(triangleData: triangleData,
                    jiggleCenter: jiggleCenter,
                    jiggleScale: jiggleScale,
                    jiggleRotation: jiggleRotation)
        
        calculateMeshPointLevels(sortedGuides: sortedGuides,
                                 sortedGuideCount: sortedGuideCount)
        
        calculateGuideBuckets(sortedGuides: sortedGuides,
                              sortedGuideCount: sortedGuideCount)
        
        calculateMeshPointOuterPercents(sortedGuides: sortedGuides,
                                        sortedGuideCount: sortedGuideCount,
                                        landscape: landscape,
                                        scale: scale,
                                        isPad: isIpad,
                                        guideCenterX: guideCenterX,
                                        guideCenterY: guideCenterY)
        calculateHeights(weightCurveMapperNodes: weightCurveMapperNodes,
                         weightCurveMapperNodeCount: weightCurveMapperNodeCount,
                         guideCount: sortedGuideCount)
        calculateMovePercents()
        calculateZ()
        calculateCameraCalibrationPoints()
        refreshUpdateAllInactive()
        
    }
    
    private func calculateCameraCalibrationPoints() {
        
        let spanX = (meshMaxX - meshMinX)
        let spanY = (meshMaxY - meshMinY)
        
        let radius = max(spanX, spanY) * 0.5
        
        for i in 0..<12 {
            
            let percent = Float(i) / Float(12.0)
            
            let dirX = sinf(percent * Math.pi2)
            let dirY = -cosf(percent * Math.pi2)
            
            addCameraCalibrationPoint(x: dirX * radius,
                                      y: dirY * radius,
                                      z: 0.0)
        }
        
        let height33 = sinf(0.333333 * Math.pi_2) * heightMaximum
        let radius66 = radius * 0.666667
        for i in 0..<8 {
            
            let percent = Float(i) / Float(8.0)
            
            let dirX = sinf(percent * Math.pi2)
            let dirY = -cosf(percent * Math.pi2)
            
            addCameraCalibrationPoint(x: dirX * radius66,
                                      y: dirY * radius66,
                                      z: -height33)
        }
        
        let height66 = sinf(0.666667 * Math.pi_2) * heightMaximum
        let radius33 = radius * 0.333333
        for i in 0..<4 {
            
            let percent = Float(i) / Float(4.0)
            
            let dirX = sinf(percent * Math.pi2)
            let dirY = -cosf(percent * Math.pi2)
            
            addCameraCalibrationPoint(x: dirX * radius33,
                                      y: dirY * radius33,
                                      z: -height66)
        }
        
        addCameraCalibrationPoint(x: 0.0,
                                  y: 0.0,
                                  z: -heightMaximum)
    }
    
    private func addCameraCalibrationPoint(x: Float, y: Float, z: Float) {
        let meshPoint = JiggleMeshPartsFactory.shared.withdrawJiggleMeshPoint()
        meshPoint.baseX = x
        meshPoint.baseY = y
        meshPoint.baseZ = z
        meshPoint.transformedX = x
        meshPoint.transformedY = y
        meshPoint.transformedZ = z
        addCameraCalibrationPoint(meshPoint)
    }
    
    private func refreshMesh(triangleData: PolyMeshTriangleData,
                             jiggleCenter: Math.Point,
                             jiggleScale: Float,
                             jiggleRotation: Float) {
        
        let maximumIndexCount = triangleData.triangleCount * 3
        
        while indices.count < maximumIndexCount {
            indices.append(0)
        }
        
        indexCount = 0
        for triangleIndex in 0..<triangleData.triangleCount {
            let triangle = triangleData.triangles[triangleIndex]
            
            indices[indexCount] = triangle.index1
            indexCount += 1
            
            indices[indexCount] = triangle.index2
            indexCount += 1
            
            indices[indexCount] = triangle.index3
            indexCount += 1
        }
        
        purgeJiggleMeshPoints()
        
        for vertexIndex in 0..<triangleData.vertexCount {
            let dataVertex = triangleData.vertices[vertexIndex]
            let jiggleMeshPoint = JiggleMeshPartsFactory.shared.withdrawJiggleMeshPoint()
            jiggleMeshPoint.baseX = dataVertex.x
            jiggleMeshPoint.baseY = dataVertex.y
            jiggleMeshPoint.isEdge = dataVertex.isEdge
            addJiggleMeshPoint(jiggleMeshPoint)
        }
        
        
        baseMinX = Float(0.0)
        baseMaxX = Float(0.0)
        baseMinY = Float(0.0)
        baseMaxY = Float(0.0)
        if jiggleMeshPointCount > 0 {
            baseMinX = jiggleMeshPoints[0].baseX
            baseMaxX = jiggleMeshPoints[0].baseX
            baseMinY = jiggleMeshPoints[0].baseY
            baseMaxY = jiggleMeshPoints[0].baseY
            for jiggleMeshPointIndex in 0..<jiggleMeshPointCount {
                let jiggleMeshPoint = jiggleMeshPoints[jiggleMeshPointIndex]
                if jiggleMeshPoint.baseX < baseMinX {
                    baseMinX = jiggleMeshPoint.baseX
                }
                if jiggleMeshPoint.baseX > baseMaxX {
                    baseMaxX = jiggleMeshPoint.baseX
                }
                if jiggleMeshPoint.baseY < baseMinY {
                    baseMinY = jiggleMeshPoint.baseY
                }
                if jiggleMeshPoint.baseY > baseMaxY {
                    baseMaxY = jiggleMeshPoint.baseY
                }
            }
        }
        
        refreshTransform(jiggleCenter: jiggleCenter, jiggleScale: jiggleScale, jiggleRotation: jiggleRotation)
    }
    
    public func refreshMeshWeightsOnly(weightCurveMapperNodes: [WeightCurveMapperNode],
                                       weightCurveMapperNodeCount: Int,
                                       guideCount: Int) {
        calculateHeights(weightCurveMapperNodes: weightCurveMapperNodes,
                         weightCurveMapperNodeCount: weightCurveMapperNodeCount,
                         guideCount: guideCount)
        calculateMovePercents()
        calculateZ()
        refreshUpdateAllInactive()
    }
    
    public func refreshMeshAffine(jiggleCenter: Math.Point, jiggleScale: Float, jiggleRotation: Float) {
        refreshTransform(jiggleCenter: jiggleCenter, jiggleScale: jiggleScale, jiggleRotation: jiggleRotation)
        refreshUpdateAllInactive()
    }
    
    private func refreshUpdateAllInactive() {
        for jiggleMeshPointIndex in 0..<jiggleMeshPointCount {
            let jiggleMeshPoint = jiggleMeshPoints[jiggleMeshPointIndex]
            jiggleMeshPoint.updateInactive()
        }
    }
    
    private func getU(_ x: Float) -> Float {
        return x / widthNaturalized
    }
    
    private func getV(_ y: Float) -> Float {
        return y / heightNaturalized
    }
    
    private func refreshTransform(jiggleCenter: Math.Point,
                                  jiggleScale: Float,
                                  jiggleRotation: Float) {
        
        if jiggleMeshPointCount > 0 {
            meshMinX = Float(100_000_000.0)
            meshMaxX = Float(-100_000_000.0)
            meshMinY = Float(100_000_000.0)
            meshMaxY = Float(-100_000_000.0)
        } else {
            meshMinX = Float(0.0)
            meshMaxX = Float(0.0)
            meshMinY = Float(0.0)
            meshMaxY = Float(0.0)
        }
        
        for jiggleMeshPointIndex in 0..<jiggleMeshPointCount {
            let jiggleMeshPoint = jiggleMeshPoints[jiggleMeshPointIndex]
            var point = Math.Point(x: jiggleMeshPoint.baseX, y: jiggleMeshPoint.baseY)
            point = Math.transformPoint(point: point, translation: jiggleCenter, scale: jiggleScale, rotation: jiggleRotation)
            
            jiggleMeshPoint.transformedX = point.x
            jiggleMeshPoint.transformedY = point.y
            jiggleMeshPoint.u = getU(point.x)
            jiggleMeshPoint.v = getV(point.y)
            
            meshMinX = min(meshMinX, point.x)
            meshMaxX = max(meshMaxX, point.x)
            meshMinY = min(meshMinY, point.y)
            meshMaxY = max(meshMaxY, point.y)
        }
    }
    
    struct WeightLocation {
        let index: Int
        let percent: Float
    }
    
    private func getWeightLocation(lhs: Float,
                                   gp1: Float,
                                   bleed: Float) -> WeightLocation {
        
        let percent = lhs + bleed * gp1
        if percent > 0.5 {
            let percent = (percent - 0.5) * 2.0
            return WeightLocation(index: 1, percent: percent)
        } else {
            let percent = (percent) * 2.0
            return WeightLocation(index: 0, percent: percent)
        }
    }
    
    private func calculateHeights(weightCurveMapperNodes: [WeightCurveMapperNode],
                                  weightCurveMapperNodeCount: Int,
                                  guideCount: Int) {
        
        let gp1 = Float(1.0) / Float(guideCount + 1)
        let nc_a = Float(guideCount + 1)
        var lhs = Float(0.0)
        
        for pointIndex in 0..<level_0_MeshPointCount {
            let jiggleMeshPoint = level_0_MeshPoints[pointIndex]
            let slot = getWeightLocation(lhs: lhs, gp1: gp1, bleed: jiggleMeshPoint.bleed)
            let weightCurveMapperNode = weightCurveMapperNodes[slot.index]
            let measuredY = weightCurveMapperNode.getY(x: slot.percent)
            jiggleMeshPoint.height = measuredY * heightMaximum
        }
        
        lhs = Float(1.0) / nc_a
        for pointIndex in 0..<level_1_MeshPointCount {
            let jiggleMeshPoint = level_1_MeshPoints[pointIndex]
            let slot = getWeightLocation(lhs: lhs, gp1: gp1, bleed: jiggleMeshPoint.bleed)
            let weightCurveMapperNode = weightCurveMapperNodes[slot.index]
            let measuredY = weightCurveMapperNode.getY(x: slot.percent)
            jiggleMeshPoint.height = measuredY * heightMaximum
        }
        
        lhs = Float(2.0) / nc_a
        for pointIndex in 0..<level_2_MeshPointCount {
            let jiggleMeshPoint = level_2_MeshPoints[pointIndex]
            let slot = getWeightLocation(lhs: lhs, gp1: gp1, bleed: jiggleMeshPoint.bleed)
            let weightCurveMapperNode = weightCurveMapperNodes[slot.index]
            let measuredY = weightCurveMapperNode.getY(x: slot.percent)
            jiggleMeshPoint.height = measuredY * heightMaximum
        }
        
        lhs = Float(3.0) / nc_a
        for pointIndex in 0..<level_3_MeshPointCount {
            let jiggleMeshPoint = level_3_MeshPoints[pointIndex]
            let slot = getWeightLocation(lhs: lhs, gp1: gp1, bleed: jiggleMeshPoint.bleed)
            let weightCurveMapperNode = weightCurveMapperNodes[slot.index]
            let measuredY = weightCurveMapperNode.getY(x: slot.percent)
            jiggleMeshPoint.height = measuredY * heightMaximum
        }
        
        lhs = Float(4.0) / nc_a
        for pointIndex in 0..<level_4_MeshPointCount {
            let jiggleMeshPoint = level_4_MeshPoints[pointIndex]
            let slot = getWeightLocation(lhs: lhs, gp1: gp1, bleed: jiggleMeshPoint.bleed)
            let weightCurveMapperNode = weightCurveMapperNodes[slot.index]
            let measuredY = weightCurveMapperNode.getY(x: slot.percent)
            jiggleMeshPoint.height = measuredY * heightMaximum
        }
        
        lhs = Float(5.0) / nc_a
        for pointIndex in 0..<level_5_MeshPointCount {
            let jiggleMeshPoint = level_5_MeshPoints[pointIndex]
            let slot = getWeightLocation(lhs: lhs, gp1: gp1, bleed: jiggleMeshPoint.bleed)
            let weightCurveMapperNode = weightCurveMapperNodes[slot.index]
            let measuredY = weightCurveMapperNode.getY(x: slot.percent)
            jiggleMeshPoint.height = measuredY * heightMaximum
        }
    }
    
    private func calculateMovePercents() {
        if heightMaximum > Math.epsilon {
            for jiggleMeshPointIndex in 0..<jiggleMeshPointCount {
                let jiggleMeshPoint = jiggleMeshPoints[jiggleMeshPointIndex]
                jiggleMeshPoint.percent = (heightMaximum - jiggleMeshPoint.height) / heightMaximum
            }
        } else {
            for jiggleMeshPointIndex in 0..<jiggleMeshPointCount {
                let jiggleMeshPoint = jiggleMeshPoints[jiggleMeshPointIndex]
                jiggleMeshPoint.percent = 0.0
            }
        }
    }
    
    private func calculateZ() {
        for jiggleMeshPointIndex in 0..<jiggleMeshPointCount {
            let jiggleMeshPoint = jiggleMeshPoints[jiggleMeshPointIndex]
            jiggleMeshPoint.baseZ = jiggleMeshPoint.height - heightMaximum
            jiggleMeshPoint.transformedZ = jiggleMeshPoint.height - heightMaximum
            jiggleMeshPoint.animatedZ = jiggleMeshPoint.height - heightMaximum
        }
    }
    
    private func calculateMeshPointLevels(sortedGuides: [Guide],
                                          sortedGuideCount: Int) {
        
        purgeLevel_0_MeshPoints()
        purgeLevel_1_MeshPoints()
        purgeLevel_2_MeshPoints()
        purgeLevel_3_MeshPoints()
        purgeLevel_4_MeshPoints()
        purgeLevel_5_MeshPoints()
        
        for jiggleMeshPointIndex in 0..<jiggleMeshPointCount {
            let jiggleMeshPoint = jiggleMeshPoints[jiggleMeshPointIndex]
            
            var level = 0
            var guideIndex = sortedGuideCount - 1
            while guideIndex >= 0 {
                let guide = sortedGuides[guideIndex]
                if guide.guideWeightPointInsidePolygonBucket.query(x: jiggleMeshPoint.baseX,
                                                                   y: jiggleMeshPoint.baseY) {
                    level = guideIndex + 1
                    break
                }
                guideIndex -= 1
            }
            
            jiggleMeshPoint.depth = level
            
            if level == 0 {
                addLevel_0_MeshPoint(jiggleMeshPoint)
            } else if level == 1 {
                addLevel_1_MeshPoint(jiggleMeshPoint)
            } else if level == 2 {
                addLevel_2_MeshPoint(jiggleMeshPoint)
            } else if level == 3 {
                addLevel_3_MeshPoint(jiggleMeshPoint)
            } else if level == 4 {
                addLevel_4_MeshPoint(jiggleMeshPoint)
            } else {
                addLevel_5_MeshPoint(jiggleMeshPoint)
            }
        }
    }
    
    // @Precondition: calculateMeshPointLevels
    private func calculateGuideBuckets(sortedGuides: [Guide],
                                       sortedGuideCount: Int) {
        guideWeightSegmentBucket.build(guideWeightSegments: guideWeightSegments,
                                       guideWeightSegmentCount: guideWeightSegmentCount,
                                       pointMinX: baseMinX,
                                       pointMaxX: baseMaxX,
                                       pointMinY: baseMinY,
                                       pointMaxY: baseMaxY)
        for guideIndex in 0..<sortedGuideCount {
            let guide = sortedGuides[guideIndex]
            guide.guideWeightSegmentBucket.build(guideWeightSegments: guide.guideWeightSegments,
                                                 guideWeightSegmentCount: guide.guideWeightSegmentCount,
                                                 pointMinX: baseMinX,
                                                 pointMaxX: baseMaxX,
                                                 pointMinY: baseMinY,
                                                 pointMaxY: baseMaxY)
        }
        
        guideWeightSegmentBucket.prepareForPoints_Outer(jiggleMeshPoints: level_0_MeshPoints,
                                                        jiggleMeshPointCount: level_0_MeshPointCount)
        if sortedGuideCount > 0 {
            let guide = sortedGuides[0]
            guide.guideWeightSegmentBucket.prepareForPoints_Inner(jiggleMeshPoints: level_0_MeshPoints,
                                                                  jiggleMeshPointCount: level_0_MeshPointCount)
            guide.guideWeightSegmentBucket.prepareForPoints_Outer(jiggleMeshPoints: level_1_MeshPoints,
                                                                  jiggleMeshPointCount: level_1_MeshPointCount)
        }
        
        if sortedGuideCount > 1 {
            let guide = sortedGuides[1]
            guide.guideWeightSegmentBucket.prepareForPoints_Inner(jiggleMeshPoints: level_1_MeshPoints,
                                                                  jiggleMeshPointCount: level_1_MeshPointCount)
            guide.guideWeightSegmentBucket.prepareForPoints_Outer(jiggleMeshPoints: level_2_MeshPoints,
                                                                  jiggleMeshPointCount: level_2_MeshPointCount)
        }
        
        if sortedGuideCount > 2 {
            let guide = sortedGuides[2]
            guide.guideWeightSegmentBucket.prepareForPoints_Inner(jiggleMeshPoints: level_2_MeshPoints,
                                                                  jiggleMeshPointCount: level_2_MeshPointCount)
            guide.guideWeightSegmentBucket.prepareForPoints_Outer(jiggleMeshPoints: level_3_MeshPoints,
                                                                  jiggleMeshPointCount: level_3_MeshPointCount)
        }
        
        if sortedGuideCount > 3 {
            let guide = sortedGuides[3]
            guide.guideWeightSegmentBucket.prepareForPoints_Inner(jiggleMeshPoints: level_3_MeshPoints,
                                                                  jiggleMeshPointCount: level_3_MeshPointCount)
            guide.guideWeightSegmentBucket.prepareForPoints_Outer(jiggleMeshPoints: level_4_MeshPoints,
                                                                  jiggleMeshPointCount: level_4_MeshPointCount)
        }
        
        if sortedGuideCount > 4 {
            let guide = sortedGuides[4]
            guide.guideWeightSegmentBucket.prepareForPoints_Inner(jiggleMeshPoints: level_4_MeshPoints,
                                                                  jiggleMeshPointCount: level_4_MeshPointCount)
            guide.guideWeightSegmentBucket.prepareForPoints_Outer(jiggleMeshPoints: level_5_MeshPoints,
                                                                  jiggleMeshPointCount: level_5_MeshPointCount)
        }
    }
    
    private func calculateMeshPointOuterPercents(sortedGuides: [Guide],
                                                 sortedGuideCount: Int,
                                                 landscape: Bool,
                                                 scale: Float,
                                                 isPad: Bool,
                                                 guideCenterX: Float,
                                                 guideCenterY: Float) {
        
        guideWeightSegmentBucket.calculateOuterDistance(fallbackSegments: guideWeightSegments,
                                                        fallbackSegmentCount: guideWeightSegmentCount)
        
        if sortedGuideCount <= 0 {
            guideWeightSegmentBucket.calculateOuterDistanceToWeightCenter(guideCenterX: guideCenterX,
                                                                          guideCenterY: guideCenterY)
            guideWeightSegmentBucket.blendOuterWithWeightCenter()
            
            return
        }
        
        let guide0 = sortedGuides[0]
        guide0.guideWeightSegmentBucket.calculateOuterDistance(fallbackSegments: guide0.guideWeightSegments,
                                                               fallbackSegmentCount: guide0.guideWeightSegmentCount)
        guide0.guideWeightSegmentBucket.calculateInnerDistance(fallbackSegments: guide0.guideWeightSegments,
                                                               fallbackSegmentCount: guide0.guideWeightSegmentCount)
        guideWeightSegmentBucket.blendOuterWithInner()
        
        if sortedGuideCount <= 1 {
            guide0.guideWeightSegmentBucket.calculateOuterDistanceToWeightCenter(guideCenterX: guideCenterX,
                                                                                 guideCenterY: guideCenterY)
            guide0.guideWeightSegmentBucket.blendOuterWithWeightCenter()
            return
        }
        
        let guide1 = sortedGuides[1]
        guide1.guideWeightSegmentBucket.calculateOuterDistance(fallbackSegments: guide1.guideWeightSegments,
                                                               fallbackSegmentCount: guide1.guideWeightSegmentCount)
        guide1.guideWeightSegmentBucket.calculateInnerDistance(fallbackSegments: guide1.guideWeightSegments,
                                                               fallbackSegmentCount: guide1.guideWeightSegmentCount)
        guide0.guideWeightSegmentBucket.blendOuterWithInner()
        
        if sortedGuideCount <= 2 {
            guide1.guideWeightSegmentBucket.calculateOuterDistanceToWeightCenter(guideCenterX: guideCenterX,
                                                                                 guideCenterY: guideCenterY)
            guide1.guideWeightSegmentBucket.blendOuterWithWeightCenter()
            return
        }
        
        let guide2 = sortedGuides[2]
        guide2.guideWeightSegmentBucket.calculateOuterDistance(fallbackSegments: guide2.guideWeightSegments,
                                                               fallbackSegmentCount: guide2.guideWeightSegmentCount)
        guide2.guideWeightSegmentBucket.calculateInnerDistance(fallbackSegments: guide2.guideWeightSegments,
                                                               fallbackSegmentCount: guide2.guideWeightSegmentCount)
        guide1.guideWeightSegmentBucket.blendOuterWithInner()
        
        if sortedGuideCount <= 3 {
            guide2.guideWeightSegmentBucket.calculateOuterDistanceToWeightCenter(guideCenterX: guideCenterX,
                                                                                 guideCenterY: guideCenterY)
            guide2.guideWeightSegmentBucket.blendOuterWithWeightCenter()
            return
        }
        
        let guide3 = sortedGuides[3]
        
        guide3.guideWeightSegmentBucket.calculateOuterDistance(fallbackSegments: guide3.guideWeightSegments,
                                                               fallbackSegmentCount: guide3.guideWeightSegmentCount)
        guide3.guideWeightSegmentBucket.calculateInnerDistance(fallbackSegments: guide3.guideWeightSegments,
                                                               fallbackSegmentCount: guide3.guideWeightSegmentCount)
        guide2.guideWeightSegmentBucket.blendOuterWithInner()
        
        if sortedGuideCount <= 4 {
            guide3.guideWeightSegmentBucket.calculateOuterDistanceToWeightCenter(guideCenterX: guideCenterX,
                                                                                 guideCenterY: guideCenterY)
            guide3.guideWeightSegmentBucket.blendOuterWithWeightCenter()
            return
        }
        
        let guide4 = sortedGuides[4]
        guide4.guideWeightSegmentBucket.calculateOuterDistance(fallbackSegments: guide4.guideWeightSegments,
                                                               fallbackSegmentCount: guide4.guideWeightSegmentCount)
        guide4.guideWeightSegmentBucket.calculateInnerDistance(fallbackSegments: guide4.guideWeightSegments,
                                                               fallbackSegmentCount: guide4.guideWeightSegmentCount)
        guide3.guideWeightSegmentBucket.blendOuterWithInner()
        guide4.guideWeightSegmentBucket.calculateOuterDistanceToWeightCenter(guideCenterX: guideCenterX,
                                                                             guideCenterY: guideCenterY)
        guide4.guideWeightSegmentBucket.blendOuterWithWeightCenter()
    }
    
    public func purge() {
        purgeJiggleMeshPoints()
        purgeGuideWeightSegments()
    }
    
}

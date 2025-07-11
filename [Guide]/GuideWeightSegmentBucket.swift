//
//  GuideWeightSegmentBucket.swift
//  Guide3
//
//  Created by Nicholas Raptis on 5/9/25.
//

import Foundation

public final class GuideWeightSegmentBucket {
    
    private static let REQUIRED_SEGMENTS = 16
    private static let GO_DEEPER = 8
    
    class GuideWeightSegmentBucketNode {
        
        var guideWeightSegments = [GuideWeightSegment]()
        var guideWeightSegmentCount = 0
        
        var isTagged = false
        
        var gridX = 0
        var gridY = 0
        
        func remove(_ guideWeightSegment: GuideWeightSegment) {
            for checkIndex in 0..<guideWeightSegmentCount {
                if guideWeightSegments[checkIndex] === guideWeightSegment {
                    remove(checkIndex)
                    return
                }
            }
        }
        
        func remove(_ index: Int) {
            if index >= 0 && index < guideWeightSegmentCount {
                let guideWeightSegmentCount1 = guideWeightSegmentCount - 1
                var guideWeightSegmentIndex = index
                while guideWeightSegmentIndex < guideWeightSegmentCount1 {
                    guideWeightSegments[guideWeightSegmentIndex] = guideWeightSegments[guideWeightSegmentIndex + 1]
                    guideWeightSegmentIndex += 1
                }
                guideWeightSegmentCount -= 1
            }
        }
        
        func add(_ guideWeightSegment: GuideWeightSegment) {
            while guideWeightSegments.count <= guideWeightSegmentCount {
                guideWeightSegments.append(guideWeightSegment)
            }
            guideWeightSegments[guideWeightSegmentCount] = guideWeightSegment
            guideWeightSegmentCount += 1
        }
        
        public var innerMeshPoints = [JiggleMeshPoint]()
        public var innerMeshPointCount = 0
        public func addInnerMeshPoint(_ jiggleMeshPoint: JiggleMeshPoint) {
            while innerMeshPoints.count <= innerMeshPointCount {
                innerMeshPoints.append(jiggleMeshPoint)
            }
            innerMeshPoints[innerMeshPointCount] = jiggleMeshPoint
            innerMeshPointCount += 1
        }
        public func purgeInnerMeshPoints() {
            innerMeshPointCount = 0
        }
        
        var outerMeshPoints = [JiggleMeshPoint]()
        var outerMeshPointCount = 0
        public func addOuterMeshPoint(_ jiggleMeshPoint: JiggleMeshPoint) {
            while outerMeshPoints.count <= outerMeshPointCount {
                outerMeshPoints.append(jiggleMeshPoint)
            }
            outerMeshPoints[outerMeshPointCount] = jiggleMeshPoint
            outerMeshPointCount += 1
        }
        func purgeOuterMeshPoints() {
            outerMeshPointCount = 0
        }
    }
    
    public init() {
        
        gridX = [Float](repeating: 0.0, count: Self.countH)
        gridY = [Float](repeating: 0.0, count: Self.countV)
        guideWeightSegments = [GuideWeightSegment]()
        
        var x = 0
        while x < Self.countH {
            var column = [GuideWeightSegmentBucketNode]()
            var y = 0
            while y < Self.countV {
                let node = GuideWeightSegmentBucketNode()
                node.gridX = x
                node.gridY = y
                column.append(node)
                y += 1
            }
            grid.append(column)
            x += 1
        }
    }
    
    private static let countH = 48
    private static let countV = 48
    
    private var grid = [[GuideWeightSegmentBucketNode]]()
    private var gridX: [Float]
    private var gridY: [Float]
    
    public private(set) var guideWeightSegments: [GuideWeightSegment]
    public private(set) var guideWeightSegmentCount = 0
    
    var innerNodes = [GuideWeightSegmentBucketNode]()
    var innerNodeCount = 0
    func addInnerNode(_ node: GuideWeightSegmentBucketNode) {
        while innerNodes.count <= innerNodeCount {
            innerNodes.append(node)
        }
        innerNodes[innerNodeCount] = node
        innerNodeCount += 1
    }
    public func purgeInnerNodes() {
        innerNodeCount = 0
    }
    
    var outerNodes = [GuideWeightSegmentBucketNode]()
    var outerNodeCount = 0
    func addOuterNode(_ node: GuideWeightSegmentBucketNode) {
        while outerNodes.count <= outerNodeCount {
            outerNodes.append(node)
        }
        outerNodes[outerNodeCount] = node
        outerNodeCount += 1
    }
    public func purgeOuterNodes() {
        outerNodeCount = 0
    }
    
    
    
    public func reset() {
        var x = 0
        var y = 0
        while x < Self.countH {
            y = 0
            while y < Self.countV {
                grid[x][y].guideWeightSegmentCount = 0
                y += 1
            }
            x += 1
        }
        
        guideWeightSegmentCount = 0
    }
    
    public func reset_scan_indices() {
        var x = 0
        var y = 0
        while x < Self.countH {
            y = 0
            while y < Self.countV {
                let node = grid[x][y]
                for guideWeightSegmentIndex in 0..<node.guideWeightSegmentCount {
                    let guideWeightSegment = node.guideWeightSegments[guideWeightSegmentIndex]
                    guideWeightSegment.scanIndex = 0
                }
                y += 1
            }
            x += 1
        }
        
        guideWeightSegmentCount = 0
    }
    
    func prepareForPoints_Inner(jiggleMeshPoints: [JiggleMeshPoint],
                                jiggleMeshPointCount: Int) {
        
        var x = 0
        var y = 0
        while x < Self.countH {
            y = 0
            while y < Self.countV {
                grid[x][y].purgeInnerMeshPoints()
                grid[x][y].isTagged = false
                
                y += 1
            }
            x += 1
        }
        
        purgeInnerNodes()
        for jiggleMeshPointIndex in 0..<jiggleMeshPointCount {
            let jiggleMeshPoint = jiggleMeshPoints[jiggleMeshPointIndex]
            let slotX = upperBoundX(value: jiggleMeshPoint.baseX)
            let slotY = upperBoundY(value: jiggleMeshPoint.baseY)
            if slotX > 0 && slotY > 0 {
                let node = grid[slotX - 1][slotY - 1]
                node.addInnerMeshPoint(jiggleMeshPoint)
                if node.isTagged == false {
                    node.isTagged = true
                    addInnerNode(node)
                }
                
            } else {
                //TODO: This can be removed after test
                print("[Inner] Bonk! This should not happen! on cell (\(slotX), \(slotY))")
            }
        }
    }
    
    func prepareForPoints_Outer(jiggleMeshPoints: [JiggleMeshPoint],
                                jiggleMeshPointCount: Int) {
        
        var x = 0
        var y = 0
        while x < Self.countH {
            y = 0
            while y < Self.countV {
                grid[x][y].purgeOuterMeshPoints()
                grid[x][y].isTagged = false
                y += 1
            }
            x += 1
        }
        
        purgeOuterNodes()
        for jiggleMeshPointIndex in 0..<jiggleMeshPointCount {
            let jiggleMeshPoint = jiggleMeshPoints[jiggleMeshPointIndex]
            let slotX = upperBoundX(value: jiggleMeshPoint.baseX)
            let slotY = upperBoundY(value: jiggleMeshPoint.baseY)
            
            if slotX > 0 && slotY > 0 {
                
                let node = grid[slotX - 1][slotY - 1]
                node.addOuterMeshPoint(jiggleMeshPoint)
                
                if node.isTagged == false {
                    node.isTagged = true
                    addOuterNode(node)
                }
                
            } else {
                //TODO: This can be removed after test
                print("[Outer] Bonk! This should not happen! on cell (\(slotX), \(slotY))")
            }
            
            
        }
    }
    
    public func build(guideWeightSegments: [GuideWeightSegment],
                      guideWeightSegmentCount: Int,
                      pointMinX: Float,
                      pointMaxX: Float,
                      pointMinY: Float,
                      pointMaxY: Float) {
        
        reset()
        
        guard guideWeightSegmentCount > 0 else {
            return
        }
        
        let referenceGuideWeightSegment = guideWeightSegments[0]
        
        var minX = min(referenceGuideWeightSegment.x1, referenceGuideWeightSegment.x2)
        var maxX = max(referenceGuideWeightSegment.x1, referenceGuideWeightSegment.x2)
        var minY = min(referenceGuideWeightSegment.y1, referenceGuideWeightSegment.y2)
        var maxY = max(referenceGuideWeightSegment.y1, referenceGuideWeightSegment.y2)
        
        if pointMinX < minX { minX = pointMinX }
        if pointMaxX > maxX { maxX = pointMaxX }
        if pointMinY < minY { minY = pointMinY }
        if pointMaxY > maxY { maxY = pointMaxY }
        
        var guideWeightSegmentIndex = 1
        while guideWeightSegmentIndex < guideWeightSegmentCount {
            let guideWeightSegment = guideWeightSegments[guideWeightSegmentIndex]
            if guideWeightSegment.x1 < minX { minX = guideWeightSegment.x1 }
            if guideWeightSegment.x2 < minX { minX = guideWeightSegment.x2 }
            if guideWeightSegment.x1 > maxX { maxX = guideWeightSegment.x1 }
            if guideWeightSegment.x2 > maxX { maxX = guideWeightSegment.x2 }
            if guideWeightSegment.y1 < minY { minY = guideWeightSegment.y1 }
            if guideWeightSegment.y2 < minY { minY = guideWeightSegment.y2 }
            if guideWeightSegment.y1 > maxY { maxY = guideWeightSegment.y1 }
            if guideWeightSegment.y2 > maxY { maxY = guideWeightSegment.y2 }
            guideWeightSegmentIndex += 1
        }
        
        minX -= 16.0
        maxX += 16.0
        minY -= 16.0
        maxY += 16.0
        
        var x = 0
        while x < Self.countH {
            let percent = Float(x) / Float(Self.countH - 1)
            gridX[x] = minX + (maxX - minX) * percent
            x += 1
        }
        
        var y = 0
        while y < Self.countV {
            let percent = Float(y) / Float(Self.countV - 1)
            gridY[y] = minY + (maxY - minY) * percent
            y += 1
        }
        
        for guideWeightSegmentIndex in 0..<guideWeightSegmentCount {
            let guideWeightSegment = guideWeightSegments[guideWeightSegmentIndex]
            
            var _minX = guideWeightSegment.x1
            if guideWeightSegment.x2 < _minX { _minX = guideWeightSegment.x2 }
            
            var _maxX = guideWeightSegment.x1
            if guideWeightSegment.x2 > _maxX { _maxX = guideWeightSegment.x2 }
            
            var _minY = guideWeightSegment.y1
            if guideWeightSegment.y2 < _minY { _minY = guideWeightSegment.y2 }
            
            var _maxY = guideWeightSegment.y1
            if guideWeightSegment.y2 > _maxY { _maxY = guideWeightSegment.y2 }
            
            let lowerBoundX = lowerBoundX(value: _minX)
            let upperBoundX = upperBoundX(value: _maxX)
            let lowerBoundY = lowerBoundY(value: _minY)
            let upperBoundY = upperBoundY(value: _maxY)
            
            x = lowerBoundX
            while x <= upperBoundX {
                y = lowerBoundY
                while y <= upperBoundY {
                    grid[x][y].add(guideWeightSegment)
                    y += 1
                }
                x += 1
            }
        }
    }
    
    private func lowerBoundX(value: Float) -> Int {
        var start = 0
        var end = Self.countH
        while start != end {
            let mid = (start + end) >> 1
            if value > gridX[mid] {
                start = mid + 1
            } else {
                end = mid
            }
        }
        return start
    }
    
    private func upperBoundX(value: Float) -> Int {
        var start = 0
        var end = Self.countH
        while start != end {
            let mid = (start + end) >> 1
            if value >= gridX[mid] {
                start = mid + 1
            } else {
                end = mid
            }
        }
        
        let result = start
        let maximum = Self.countH - 1
        if result > maximum {
            return maximum
        } else {
            return result
        }
    }
    
    private func lowerBoundY(value: Float) -> Int {
        var start = 0
        var end = Self.countV
        while start != end {
            let mid = (start + end) >> 1
            if value > gridY[mid] {
                start = mid + 1
            } else {
                end = mid
            }
        }
        return start
        
    }
    
    private func upperBoundY(value: Float) -> Int {
        var start = 0
        var end = Self.countV
        while start != end {
            let mid = (start + end) >> 1
            if value >= gridY[mid] {
                start = mid + 1
            } else {
                end = mid
            }
        }
        
        let result = start
        let maximum = Self.countV - 1
        if result > maximum {
            return maximum
        } else {
            return result
        }
    }
    
    func blendOuterWithWeightCenter() {
        for nodeIndex in 0..<outerNodeCount {
            let node = outerNodes[nodeIndex]
            for pointIndex in 0..<node.outerMeshPointCount {
                let jiggleMeshPoint = node.outerMeshPoints[pointIndex]
                
                let totalDistance = jiggleMeshPoint.distanceWeightCenter + jiggleMeshPoint.distanceOuter
                if totalDistance > Math.epsilon {
                    jiggleMeshPoint.bleed = (1.0 - (jiggleMeshPoint.distanceWeightCenter / totalDistance))
                } else {
                    jiggleMeshPoint.bleed = 1.0
                }
            }
        }
    }
    
    func blendOuterWithInner() {
        for nodeIndex in 0..<outerNodeCount {
            let node = outerNodes[nodeIndex]
            for pointIndex in 0..<node.outerMeshPointCount {
                let jiggleMeshPoint = node.outerMeshPoints[pointIndex]
                
                let totalDistance = jiggleMeshPoint.distanceInner + jiggleMeshPoint.distanceOuter
                if totalDistance > Math.epsilon {
                    jiggleMeshPoint.bleed = (1.0 - (jiggleMeshPoint.distanceInner / totalDistance))
                } else {
                    jiggleMeshPoint.bleed = 1.0
                }
            }
        }
    }
    
    func calculateOuterDistanceToWeightCenter(guideCenterX: Float,
                                              guideCenterY: Float) {
        
        for nodeIndex in 0..<outerNodeCount {
            let node = outerNodes[nodeIndex]
            for pointIndex in 0..<node.outerMeshPointCount {
                let jiggleMeshPoint = node.outerMeshPoints[pointIndex]
                
                let diffX = jiggleMeshPoint.baseX - guideCenterX
                let diffY = jiggleMeshPoint.baseY - guideCenterY
                let distanceSquared = diffX * diffX + diffY * diffY
                if distanceSquared > Math.epsilon {
                    jiggleMeshPoint.distanceWeightCenter = sqrtf(distanceSquared)
                } else {
                    jiggleMeshPoint.distanceWeightCenter = 0.0
                }
            }
        }
    }
    
    private func searchParty(node: GuideWeightSegmentBucketNode,
                             scanIndex: Int) {
        
        purgeGuideWeightSegments()
        let node_x = node.gridX
        let node_y = node.gridY
        var findIndex = -1
        var circleIndex = 0
        while circleIndex < CircleGridShift.count {
            let levelCount = CircleGridShift.counts[circleIndex]
            for level in 0..<levelCount {
                let shiftX = CircleGridShift.shiftX[circleIndex][level]
                let shiftY = CircleGridShift.shiftY[circleIndex][level]
                let check_x = node_x + shiftX
                let check_y = node_y + shiftY
                if check_x >= 0 && check_x < Self.countH && check_y >= 0 && check_y < Self.countV {
                    let inner_node = grid[check_x][check_y]
                    for guideWeightSegmentIndex in 0..<inner_node.guideWeightSegmentCount {
                        let guideWeightSegment = inner_node.guideWeightSegments[guideWeightSegmentIndex]
                        if guideWeightSegment.scanIndex != scanIndex {
                            guideWeightSegment.scanIndex = scanIndex
                            addGuideWeightSegment(guideWeightSegment: guideWeightSegment)
                        }
                    }
                }
            }
            
            circleIndex += 1
            
            //for shiftIndex in
            if guideWeightSegmentCount > 0 {
                findIndex = circleIndex
                break
            }
            
        }
        
        if findIndex != -1 {
            var ceiling = circleIndex + Self.GO_DEEPER
            if ceiling > CircleGridShift.count {
                ceiling = CircleGridShift.count
            }
            while circleIndex < ceiling {
                let levelCount = CircleGridShift.counts[circleIndex]
                for level in 0..<levelCount {
                    let shiftX = CircleGridShift.shiftX[circleIndex][level]
                    let shiftY = CircleGridShift.shiftY[circleIndex][level]
                    let check_x = node_x + shiftX
                    let check_y = node_y + shiftY
                    if check_x >= 0 && check_x < Self.countH && check_y >= 0 && check_y < Self.countV {
                        let inner_node = grid[check_x][check_y]
                        for guideWeightSegmentIndex in 0..<inner_node.guideWeightSegmentCount {
                            let guideWeightSegment = inner_node.guideWeightSegments[guideWeightSegmentIndex]
                            if guideWeightSegment.scanIndex != scanIndex {
                                guideWeightSegment.scanIndex = scanIndex
                                addGuideWeightSegment(guideWeightSegment: guideWeightSegment)
                            }
                        }
                    }
                }
                circleIndex += 1
            }
        }
    }
    
    func calculateOuterDistance(fallbackSegments: [GuideWeightSegment],
                                fallbackSegmentCount: Int) {
        
        reset_scan_indices()
        
        var scanIndex = 1000
        for nodeIndex in 0..<outerNodeCount {
            let node = outerNodes[nodeIndex]
            
            searchParty(node: node, scanIndex: scanIndex)
            scanIndex += 1
            
            if guideWeightSegmentCount >= Self.REQUIRED_SEGMENTS {
                for pointIndex in 0..<node.outerMeshPointCount {
                    let jiggleMeshPoint = node.outerMeshPoints[pointIndex]
                    jiggleMeshPoint.calculateOuterDistance(guideWeightSegments: guideWeightSegments,
                                                           guideWeightSegmentCount: guideWeightSegmentCount)
                }
            } else {
                for pointIndex in 0..<node.outerMeshPointCount {
                    let jiggleMeshPoint = node.outerMeshPoints[pointIndex]
                    
                    jiggleMeshPoint.calculateOuterDistance(guideWeightSegments: fallbackSegments,
                                                           guideWeightSegmentCount: fallbackSegmentCount)
                }
            }
        }
    }
    
    func calculateInnerDistance(fallbackSegments: [GuideWeightSegment],
                                fallbackSegmentCount: Int) {
        
        reset_scan_indices()
        
        var scanIndex = 1000
        for nodeIndex in 0..<innerNodeCount {
            let node = innerNodes[nodeIndex]
            
            searchParty(node: node, scanIndex: scanIndex)
            scanIndex += 1
            
            if guideWeightSegmentCount >= Self.REQUIRED_SEGMENTS {
                for pointIndex in 0..<node.innerMeshPointCount {
                    let jiggleMeshPoint = node.innerMeshPoints[pointIndex]
                    jiggleMeshPoint.calculateInnerDistance(guideWeightSegments: guideWeightSegments,
                                                           guideWeightSegmentCount: guideWeightSegmentCount)
                }
            } else {
                for pointIndex in 0..<node.innerMeshPointCount {
                    let jiggleMeshPoint = node.innerMeshPoints[pointIndex]
                    
                    jiggleMeshPoint.calculateInnerDistance(guideWeightSegments: fallbackSegments,
                                                           guideWeightSegmentCount: fallbackSegmentCount)
                }
            }
        }
    }
    
    func addGuideWeightSegment(guideWeightSegment: GuideWeightSegment) {
        while guideWeightSegments.count <= guideWeightSegmentCount {
            guideWeightSegments.append(guideWeightSegment)
        }
        guideWeightSegments[guideWeightSegmentCount] = guideWeightSegment
        guideWeightSegmentCount += 1
    }
    
    func purgeGuideWeightSegments() {
        guideWeightSegmentCount = 0
    }
    
    
}

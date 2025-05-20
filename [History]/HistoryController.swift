//
//  HistoryController.swift
//  HistoryKit
//
//  Created by Nicholas Raptis on 5/17/25.
//

import Foundation

public class HistoryController {
    
    private var historyStack = [HistoryState]()
    private var historyIndex: Int = 0
    private var isMostRecentActionUndo = false
    private var isMostRecentActionRedo = false
    public weak var delegate: HistoryControllerConforming?
    
    //
    public var snapShotContinuousAttributeIsAppliedToAll = false
    public var snapShotContinuousAttributeOneTargetIndex = -1
    public var snapShotContinuousAttributeOne: ContinuousAttribute?
    public var snapShotContinuousAttributesAllSelectedIndex = -1
    public var snapShotContinuousAttributesAll = [ContinuousAttribute]()
    
    //
    public var snapShotLoopAttributeIsAppliedToAll = false
    public var snapShotLoopAttributeOneTargetIndex = -1
    public var snapShotLoopAttributeOne: LoopAttribute?
    public var snapShotLoopAttributesAllSelectedIndex = -1
    public var snapShotLoopAttributesAll = [LoopAttribute]()
    
    //
    public var snapShotGrabAttributeIsAppliedToAll = false
    public var snapShotGrabAttributeOneTargetIndex = -1
    public var snapShotGrabAttributeOne: GrabAttribute?
    public var snapShotGrabAttributesAllSelectedIndex = -1
    public var snapShotGrabAttributesAll = [GrabAttribute]()
    
    
    @MainActor public init() {
        
    }
    
    private var __tempHistoryStack = [HistoryState]()
    @MainActor func addHistoryState(_ historyState: HistoryState) -> Void {
        __tempHistoryStack.removeAll(keepingCapacity: true)
        var index = historyIndex
        if isMostRecentActionUndo == false {
            index += 1
        }
        if index > 0 {
            if index > historyStack.count { index = historyStack.count }
            for i in 0..<(index) {
                __tempHistoryStack.append(historyStack[i])
            }
        }
        __tempHistoryStack.append(historyState)
        historyIndex = __tempHistoryStack.count
        historyStack.removeAll(keepingCapacity: true)
        historyStack.append(contentsOf: __tempHistoryStack)
        isMostRecentActionUndo = false
        isMostRecentActionRedo = false
        if let delegate = delegate {
            delegate.historyStackDidChange()
        }
    }
    
    @MainActor public func canUndo() -> Bool {
        if historyStack.count > 0 {
            if isMostRecentActionRedo {
                return (historyIndex >= 0 && historyIndex < historyStack.count)
            } else {
                return (historyIndex > 0 && historyIndex <= historyStack.count)
            }
        }
        return false
    }
    
    @MainActor public func canRedo() -> Bool {
        if historyStack.count > 0 {
            if isMostRecentActionUndo {
                return (historyIndex >= 0 && historyIndex < historyStack.count)
            } else {
                return (historyIndex >= 0 && historyIndex < (historyStack.count - 1))
            }
        }
        return false
    }
    
    @MainActor public func undo() {
        let index = isMostRecentActionRedo ? historyIndex : (historyIndex - 1)
        let historyState = historyStack[index]
        if let delegate = delegate {
            delegate.enterHistoryUndo(historyState)
        }
        
        historyIndex = index
        isMostRecentActionUndo = true
        isMostRecentActionRedo = false
    }
    
    @MainActor public func redo() {
        let index = isMostRecentActionUndo ? historyIndex : (historyIndex + 1)
        let historyState = historyStack[index]
        
        if let delegate = delegate {
            delegate.enterHistoryRedo(historyState)
        }
        
        historyIndex = index
        isMostRecentActionUndo = false
        isMostRecentActionRedo = true
    }
    
    
    // Jiggle, A
    @MainActor public func createJiggleNotify(data: Data?) {
        guard let data = data else { return }
        
        let historyStateCreateJiggle = HistoryStateCreateJiggle(data: data)
        addHistoryState(historyStateCreateJiggle)
    }
    
    // Jiggle, B
    var _transformJiggleData = TransformJiggleData()
    @MainActor public func transformJiggleCapture(startCenter: Math.Point,
                                                  startScale: Float,
                                                  startRotation: Float) {
        _transformJiggleData.startCenter = startCenter
        _transformJiggleData.startScale = startScale
        _transformJiggleData.startRotation = startRotation
    }
    @MainActor public func transformJiggleNotify(jiggleIndex: Int?,
                                                 endCenter: Math.Point,
                                                 endScale: Float,
                                                 endRotation: Float) {
        guard let jiggleIndex = jiggleIndex else { return }
        let historyStateTransformJiggle = HistoryStateTransformJiggle(jiggleIndex: jiggleIndex,
                                                                      startCenter: _transformJiggleData.startCenter,
                                                                      startScale: _transformJiggleData.startScale,
                                                                      startRotation: _transformJiggleData.startRotation,
                                                                      endCenter: endCenter,
                                                                      endScale: endScale,
                                                                      endRotation: endRotation)
        addHistoryState(historyStateTransformJiggle)
    }
    
    // Jiggle, C
    @MainActor public func rotateOrFlipJiggleNotify(jiggleIndex: Int,
                                                    startData: Data,
                                                    endData: Data) {
        let historyStateRotateOrFlipJiggle = HistoryStateRotateOrFlipJiggle(jiggleIndex: jiggleIndex,
                                                                            startData: startData,
                                                                            endData: endData)
        addHistoryState(historyStateRotateOrFlipJiggle)
    }
    
    // Jiggle, D
    var _moveJiggleCenterData = MoveJiggleCenterData()
    @MainActor public func moveJiggleCenterCapture(jiggleIndex: Int?,
                                                   startCenter: Math.Point) {
        _moveJiggleCenterData.didChange = false
        _moveJiggleCenterData.jiggleIndex = jiggleIndex
        _moveJiggleCenterData.startCenter = startCenter
    }
    @MainActor public func moveJiggleCenterTrack(endCenter: Math.Point) {
        _moveJiggleCenterData.didChange = true
        _moveJiggleCenterData.endCenter = endCenter
    }
    @MainActor public func moveJiggleCenterNotifyIfChanged() {
        guard let jiggleIndex = _moveJiggleCenterData.jiggleIndex else { return }
        if _moveJiggleCenterData.didChange {
            let historyStateMoveJiggleCenter = HistoryStateMoveJiggleCenter(jiggleIndex: jiggleIndex,
                                                                            startCenter: _moveJiggleCenterData.startCenter,
                                                                            endCenter: _moveJiggleCenterData.endCenter)
            addHistoryState(historyStateMoveJiggleCenter)
        }
    }
    
    // Jiggle, E
    var _moveWeightCenterData = MoveWeightCenterData()
    @MainActor public func moveWeightCenterCapture(jiggleIndex: Int?,
                                                   startCenter: Math.Point) {
        _moveWeightCenterData.didChange = false
        _moveWeightCenterData.jiggleIndex = jiggleIndex
        _moveWeightCenterData.startCenter = startCenter
    }
    @MainActor public func moveWeightCenterTrack(endCenter: Math.Point) {
        _moveWeightCenterData.didChange = true
        _moveWeightCenterData.endCenter = endCenter
    }
    @MainActor public func moveWeightCenterNotifyIfChanged() {
        guard let jiggleIndex = _moveWeightCenterData.jiggleIndex else { return }
        if _moveWeightCenterData.didChange {
            _moveWeightCenterData.didChange = false
            let historyStateMoveWeightCenter = HistoryStateMoveWeightCenter(jiggleIndex: jiggleIndex,
                                                                            startCenter: _moveWeightCenterData.startCenter,
                                                                            endCenter: _moveWeightCenterData.endCenter)
            addHistoryState(historyStateMoveWeightCenter)
        }
    }
    
    // Jiggle, F
    @MainActor public func deleteJiggleNotify(jiggleIndex: Int?,
                                              data: Data?) {
        guard let jiggleIndex = jiggleIndex else { return }
        guard let data = data else { return }
        let historyStateDeleteJiggle = HistoryStateDeleteJiggle(jiggleIndex: jiggleIndex, data: data)
        addHistoryState(historyStateDeleteJiggle)
    }
    
    
    
    
    
    
    // Guide, A
    @MainActor public func createGuideNotify(jiggleIndex: Int?,
                                             data: Data?) {
        guard let jiggleIndex = jiggleIndex else { return }
        guard let data = data else { return }
        let historyStateCreateGuide = HistoryStateCreateGuide(jiggleIndex: jiggleIndex,
                                                              data: data)
        addHistoryState(historyStateCreateGuide)
    }
    
    
    // Guide, B
    var _transformGuideData = TransformGuideData()
    @MainActor public func transformGuideCapture(startCenter: Math.Point,
                                                 startScale: Float,
                                                 startRotation: Float) {
        _transformGuideData.startCenter = startCenter
        _transformGuideData.startScale = startScale
        _transformGuideData.startRotation = startRotation
    }
    @MainActor public func transformGuideNotify(jiggleIndex: Int?,
                                                guideIndex: Int?,
                                                endCenter: Math.Point,
                                                endScale: Float,
                                                endRotation: Float) {
        guard let jiggleIndex = jiggleIndex else { return }
        guard let guideIndex = guideIndex else { return }
        let historyStateTransformGuide = HistoryStateTransformGuide(jiggleIndex: jiggleIndex,
                                                                    guideIndex: guideIndex,
                                                                    startCenter: _transformGuideData.startCenter,
                                                                    startScale: _transformGuideData.startScale,
                                                                    startRotation: _transformGuideData.startRotation,
                                                                    endCenter: endCenter,
                                                                    endScale: endScale,
                                                                    endRotation: endRotation)
        addHistoryState(historyStateTransformGuide)
    }
    
    // Guide, C
    @MainActor public func rotateOrFlipGuideNotify(jiggleIndex: Int,
                                                   guideIndex: Int,
                                                   startData: Data,
                                                   endData: Data) {
        let historyStateRotateOrFlipGuide = HistoryStateRotateOrFlipGuide(jiggleIndex: jiggleIndex,
                                                                          guideIndex: guideIndex,
                                                                          startData: startData,
                                                                          endData: endData)
        addHistoryState(historyStateRotateOrFlipGuide)
    }
    
    // Guide, D
    @MainActor public func replaceAllGuidesNotify(jiggleIndex: Int?,
                                                  weightCurveIndex: Int?,
                                                  startWeightCenter: Math.Point,
                                                  endWeightCenter: Math.Point,
                                                  startDatas: [Data],
                                                  endDatas: [Data]) {
        guard let jiggleIndex = jiggleIndex else { return }
        guard let weightCurveIndex = weightCurveIndex else { return }
        let historyStateGenerateTopography = HistoryStateGenerateTopography(jiggleIndex: jiggleIndex,
                                                                            weightCurveIndex: weightCurveIndex,
                                                                            startDatas: startDatas,
                                                                            endDatas: endDatas,
                                                                            startWeightCenter: startWeightCenter,
                                                                            endWeightCenter: endWeightCenter)
        addHistoryState(historyStateGenerateTopography)
    }
    
    // Guide, E
    @MainActor public func deleteGuideNotify(jiggleIndex: Int?,
                                             guideIndex: Int?,
                                             data: Data?) {
        guard let jiggleIndex = jiggleIndex else { return }
        guard let guideIndex = guideIndex else { return }
        guard let data = data else { return }
        let historyStateDeleteGuide = HistoryStateDeleteGuide(jiggleIndex: jiggleIndex,
                                                              guideIndex: guideIndex,
                                                              data: data)
        addHistoryState(historyStateDeleteGuide)
    }
    
    
    
    
    
    // Jiggle-Point, A
    @MainActor public func createJigglePointNotify(jiggleIndex: Int?,
                                                   controlPointIndex: Int?,
                                                   point: Math.Point) {
        guard let jiggleIndex = jiggleIndex else { return }
        guard let controlPointIndex = controlPointIndex else { return }
        
        let historyStateCreateJigglePoint = HistoryStateCreateJigglePoint(jiggleIndex: jiggleIndex,
                                                                          controlPointIndex: controlPointIndex,
                                                                          point: point)
        addHistoryState(historyStateCreateJigglePoint)
    }
    
    // Jiggle-Point, B
    @MainActor public func insertJigglePointNotify(jiggleIndex: Int?,
                                                   controlPointIndex: Int?,
                                                   selectedJigglePointIndex: Int?,
                                                   point: Math.Point) {
        guard let jiggleIndex = jiggleIndex else { return }
        guard let controlPointIndex = controlPointIndex else { return }
        guard let selectedJigglePointIndex = selectedJigglePointIndex else { return }
        
        let historyStateInsertJigglePoint = HistoryStateInsertJigglePoint(jiggleIndex: jiggleIndex,
                                                                          controlPointIndex: controlPointIndex,
                                                                          selectedJigglePointIndex: selectedJigglePointIndex,
                                                                          point: point)
        addHistoryState(historyStateInsertJigglePoint)
    }
    
    // Jiggle-Point, C
    var _moveJigglePointData = MoveJigglePointData()
    @MainActor public func moveJigglePointCapture(jiggleIndex: Int?,
                                                  controlPointIndex: Int?,
                                                  startPoint: Math.Point) {
        _moveJigglePointData.didChange = false
        _moveJigglePointData.jiggleIndex = jiggleIndex
        _moveJigglePointData.controlPointIndex = controlPointIndex
        _moveJigglePointData.startPoint = startPoint
    }
    @MainActor public func moveJigglePointTrack(endPoint: Math.Point) {
        _moveJigglePointData.didChange = true
        _moveJigglePointData.endPoint = endPoint
    }
    @MainActor public func moveJigglePointNotifyIfChanged() -> Bool {
        var result = false
        if _moveJigglePointData.didChange {
            if let jiggleIndex = _moveJigglePointData.jiggleIndex {
                if let controlPointIndex = _moveJigglePointData.controlPointIndex {
                    let historyStateMoveControlPoint = HistoryStateMoveJigglePoint(jiggleIndex: jiggleIndex,
                                                                                   controlPointIndex: controlPointIndex,
                                                                                   startPoint: _moveJigglePointData.startPoint,
                                                                                   endPoint: _moveJigglePointData.endPoint)
                    addHistoryState(historyStateMoveControlPoint)
                }
            }
            _moveJigglePointData.didChange = false
            result = true
        }
        return result
    }
    
    // Jiggle-Point, D
    var _moveJigglePointTanHandleData = MoveJigglePointTanHandleData()
    @MainActor public func moveJigglePointTanHandleCapture(jiggleIndex: Int?,
                                                           controlPointIndex: Int?,
                                                           tanType: TanType,
                                                           startData: ControlPointData) {
        _moveJigglePointTanHandleData.didChange = false
        _moveJigglePointTanHandleData.jiggleIndex = jiggleIndex
        _moveJigglePointTanHandleData.controlPointIndex = controlPointIndex
        _moveJigglePointTanHandleData.tanType = tanType
        _moveJigglePointTanHandleData.startData = startData
    }
    @MainActor public func moveJigglePointTanHandleTrack(endData: ControlPointData) {
        _moveJigglePointTanHandleData.didChange = true
        _moveJigglePointTanHandleData.endData = endData
    }
    @MainActor public func moveJigglePointTanHandleNotifyIfChanged() -> Bool {
        var result = false
        if _moveJigglePointTanHandleData.didChange {
            if let jiggleIndex = _moveJigglePointTanHandleData.jiggleIndex {
                if let controlPointIndex = _moveJigglePointTanHandleData.controlPointIndex {
                    let historyStateMoveJigglePointTanHandle = HistoryStateMoveJigglePointTanHandle(jiggleIndex: jiggleIndex,
                                                                                                    controlPointIndex: controlPointIndex,
                                                                                                    tanType: _moveJigglePointTanHandleData.tanType,
                                                                                                    startData: _moveJigglePointTanHandleData.startData,
                                                                                                    endData: _moveJigglePointTanHandleData.endData)
                    addHistoryState(historyStateMoveJigglePointTanHandle)
                }
            }
            _moveJigglePointTanHandleData.didChange = false
            result = true
        }
        return result
    }
    
    // Jiggle-Point, E
    @MainActor public func updateJigglePointDataOneNotify(jiggleIndex: Int?,
                                                          controlPointIndex: Int?,
                                                          startData: ControlPointData,
                                                          endData: ControlPointData) {
        guard let jiggleIndex = jiggleIndex else { return }
        guard let controlPointIndex = controlPointIndex else { return }
        let historyStateUpdateJigglePointOne = HistoryStateUpdateJigglePointOne(jiggleIndex: jiggleIndex,
                                                                                controlPointIndex: controlPointIndex,
                                                                                startData: startData,
                                                                                endData: endData)
        addHistoryState(historyStateUpdateJigglePointOne)
    }
    
    // Jiggle-Point, F
    @MainActor public func updateJigglePointDataAllNotify(jiggleIndex: Int?,
                                                          startDatas: [ControlPointData],
                                                          endDatas: [ControlPointData]) {
        guard let jiggleIndex = jiggleIndex else { return }
        let historyStateUpdateGuidePointOne = HistoryStateUpdateJigglePointAll(jiggleIndex: jiggleIndex,
                                                                               startDatas: startDatas,
                                                                               endDatas: endDatas)
        addHistoryState(historyStateUpdateGuidePointOne)
    }
    
    // Jiggle-Point, G
    @MainActor public func deleteJigglePointNotify(jiggleIndex: Int?,
                                                   controlPointIndex: Int?,
                                                   data: ControlPointData) {
        guard let jiggleIndex = jiggleIndex else { return }
        guard let controlPointIndex = controlPointIndex else { return }
        let historyStateDeleteJigglePoint = HistoryStateDeleteJigglePoint(jiggleIndex: jiggleIndex,
                                                                          controlPointIndex: controlPointIndex,
                                                                          data: data)
        addHistoryState(historyStateDeleteJigglePoint)
    }
    
    
    
    // Guide-Point, A
    @MainActor public func createGuidePointNotify(point: Math.Point,
                                                  jiggleIndex: Int?,
                                                  guideIndex: Int?,
                                                  guidePointIndex: Int?) {
        guard let jiggleIndex = jiggleIndex else { return }
        guard let guideIndex = guideIndex else { return }
        guard let guidePointIndex = guidePointIndex else { return }
        
        let historyStateCreateGuidePoint = HistoryStateCreateGuidePoint(jiggleIndex: jiggleIndex,
                                                                        guideIndex: guideIndex,
                                                                        guidePointIndex: guidePointIndex,
                                                                        point: point)
        addHistoryState(historyStateCreateGuidePoint)
    }
    
    // Guide-Point, B
    @MainActor public func insertGuidePointNotify(point: Math.Point,
                                                  jiggleIndex: Int?,
                                                  guideIndex: Int?,
                                                  guidePointIndex: Int?,
                                                  selectedGuidePointIndex: Int?) {
        guard let jiggleIndex = jiggleIndex else { return }
        guard let guideIndex = guideIndex else { return }
        guard let guidePointIndex = guidePointIndex else { return }
        guard let selectedGuidePointIndex = selectedGuidePointIndex else { return }
        
        let historyStateInsertGuidePoint = HistoryStateInsertGuidePoint(jiggleIndex: jiggleIndex,
                                                                        guideIndex: guideIndex,
                                                                        guidePointIndex: guidePointIndex,
                                                                        selectedGuidePointIndex: selectedGuidePointIndex,
                                                                        point: point)
        addHistoryState(historyStateInsertGuidePoint)
    }
    
    // Guide-Point, C
    var _moveGuidePointData = MoveGuidePointData()
    @MainActor public func moveGuidePointCapture(jiggleIndex: Int?,
                                                 guideIndex: Int?,
                                                 guidePointIndex: Int?,
                                                 startPoint: Math.Point) {
        _moveGuidePointData.didChange = false
        _moveGuidePointData.jiggleIndex = jiggleIndex
        _moveGuidePointData.guideIndex = guideIndex
        _moveGuidePointData.guidePointIndex = guidePointIndex
        _moveGuidePointData.startPoint = startPoint
    }
    @MainActor public func moveGuidePointTrack(endPoint: Math.Point) {
        _moveGuidePointData.didChange = true
        _moveGuidePointData.endPoint = endPoint
    }
    @MainActor public func moveGuidePointNotifyIfChanged() -> Bool {
        var result = false
        if _moveGuidePointData.didChange {
            
            if let jiggleIndex = _moveGuidePointData.jiggleIndex {
                if let guideIndex = _moveGuidePointData.guideIndex {
                    if let guidePointIndex = _moveGuidePointData.guidePointIndex {
                        let historyStateMoveGuidePoint = HistoryStateMoveGuidePoint(jiggleIndex: jiggleIndex,
                                                                                    guideIndex: guideIndex,
                                                                                    guidePointIndex: guidePointIndex,
                                                                                    startPoint: _moveGuidePointData.startPoint,
                                                                                    endPoint: _moveGuidePointData.endPoint)
                        addHistoryState(historyStateMoveGuidePoint)
                    }
                }
            }
            _moveGuidePointData.didChange = false
            result = true
        }
        return result
    }
    
    // Guide-Point, D
    var _moveGuidePointTanHandleData = MoveGuidePointTanHandleData()
    @MainActor public func moveGuidePointTanHandleCapture(jiggleIndex: Int?,
                                                          guideIndex: Int?,
                                                          guidePointIndex: Int?,
                                                          tanType: TanType,
                                                          startData: ControlPointData) {
        _moveGuidePointTanHandleData.didChange = false
        _moveGuidePointTanHandleData.jiggleIndex = jiggleIndex
        _moveGuidePointTanHandleData.guideIndex = guideIndex
        _moveGuidePointTanHandleData.guidePointIndex = guidePointIndex
        _moveGuidePointTanHandleData.tanType = tanType
        _moveGuidePointTanHandleData.startData = startData
    }
    @MainActor public func moveGuidePointTanHandleTrack(endData: ControlPointData) {
        _moveGuidePointTanHandleData.didChange = true
        _moveGuidePointTanHandleData.endData = endData
    }
    @MainActor public func moveGuidePointTanHandleNotifyIfChanged() -> Bool {
        var result = false
        if _moveGuidePointTanHandleData.didChange {
            if let jiggleIndex = _moveGuidePointTanHandleData.jiggleIndex {
                if let guideIndex = _moveGuidePointTanHandleData.guideIndex {
                    if let guidePointIndex = _moveGuidePointTanHandleData.guidePointIndex {
                        let historyStateMoveGuidePointTanHandle = HistoryStateMoveGuidePointTanHandle(jiggleIndex: jiggleIndex,
                                                                                                      guideIndex: guideIndex,
                                                                                                      guidePointIndex: guidePointIndex,
                                                                                                      tanType: _moveGuidePointTanHandleData.tanType,
                                                                                                      startData: _moveGuidePointTanHandleData.startData,
                                                                                                      endData: _moveGuidePointTanHandleData.endData)
                        addHistoryState(historyStateMoveGuidePointTanHandle)
                    }
                }
            }
            _moveGuidePointTanHandleData.didChange = false
            result = true
        }
        return result
    }
    
    // Guide-Point, E
    @MainActor public func updateGuidePointDataOneNotify(jiggleIndex: Int?,
                                                         guideIndex: Int?,
                                                         guidePointIndex: Int?,
                                                         startData: ControlPointData,
                                                         endData: ControlPointData) {
        guard let jiggleIndex = jiggleIndex else { return }
        guard let guideIndex = guideIndex else { return }
        guard let guidePointIndex = guidePointIndex else { return }
        
        let historyStateUpdateGuidePointOne = HistoryStateUpdateGuidePointOne(jiggleIndex: jiggleIndex,
                                                                              guideIndex: guideIndex,
                                                                              guidePointIndex: guidePointIndex,
                                                                              startData: startData,
                                                                              endData: endData)
        addHistoryState(historyStateUpdateGuidePointOne)
    }
    
    // Guide-Point, F
    @MainActor public func updateGuidePointDataAllNotify(jiggleIndex: Int?,
                                                         guideIndex: Int?,
                                                         startDatas: [ControlPointData],
                                                         endDatas: [ControlPointData]) {
        guard let jiggleIndex = jiggleIndex else { return }
        guard let guideIndex = guideIndex else { return }
        let historyStateUpdateGuidePointOne = HistoryStateUpdateGuidePointAll(jiggleIndex: jiggleIndex,
                                                                              guideIndex: guideIndex,
                                                                              startDatas: startDatas,
                                                                              endDatas: endDatas)
        addHistoryState(historyStateUpdateGuidePointOne)
    }
    
    // Guide-Point, G
    @MainActor public func deleteGuidePointNotify(jiggleIndex: Int?,
                                                  guideIndex: Int?,
                                                  guidePointIndex: Int?,
                                                  data: ControlPointData) {
        guard let jiggleIndex = jiggleIndex else { return }
        guard let guideIndex = guideIndex else { return }
        guard let guidePointIndex = guidePointIndex else { return }
        let historyStateDeleteGuidePoint = HistoryStateDeleteGuidePoint(jiggleIndex: jiggleIndex,
                                                                        guideIndex: guideIndex,
                                                                        guidePointIndex: guidePointIndex,
                                                                        data: data)
        addHistoryState(historyStateDeleteGuidePoint)
    }
    
    
    
    
    // Weight-Curve-A
    var _moveWeightCurvePointData = MoveWeightCurvePointData()
    @MainActor public func moveWeightCurvePointCapture(jiggleIndex: Int?,
                                                       weightCurveIndex: Int?,
                                                       startManual: Bool,
                                                       startHeightFactor: Float) {
        _moveWeightCurvePointData.didChange = false
        _moveWeightCurvePointData.jiggleIndex = jiggleIndex
        _moveWeightCurvePointData.weightCurveIndex = weightCurveIndex
        _moveWeightCurvePointData.startManual = startManual
        _moveWeightCurvePointData.startHeightFactor = startHeightFactor
    }
    @MainActor public func moveWeightCurvePointTrack(endHeightFactor: Float) {
        _moveWeightCurvePointData.didChange = true
        _moveWeightCurvePointData.endHeightFactor = endHeightFactor
    }
    @MainActor public func moveWeightCurvePointNotifyIfChangedAndSameIndex(jiggleIndex: Int?) {
        if _moveWeightCurvePointData.didChange {
            if _moveWeightCurvePointData.jiggleIndex == jiggleIndex {
                
                if let jiggleIndex = _moveWeightCurvePointData.jiggleIndex {
                    if let weightCurveIndex = _moveWeightCurvePointData.weightCurveIndex {
                        
                        let historyStateMoveWeightGraphPosition = HistoryStateMoveWeightGraphPosition(jiggleIndex: jiggleIndex,
                                                                                                      weightCurveIndex: weightCurveIndex,
                                                                                                      startHeightManual: _moveWeightCurvePointData.startManual,
                                                                                                      startHeightFactor: _moveWeightCurvePointData.startHeightFactor,
                                                                                                      endHeightFactor: _moveWeightCurvePointData.endHeightFactor)
                        addHistoryState(historyStateMoveWeightGraphPosition)
                    }
                    
                }
                _moveWeightCurvePointData.didChange = false
            }
        }
    }
    
    
    
    
    // Weight-Curve-B
    var _moveWeightCurveTanHandleData = MoveWeightCurveTanHandleData()
    @MainActor public func moveWeightCurveTanHandleDataCapture(jiggleIndex: Int?,
                                                               weightCurveIndex: Int?,
                                                               startManual: Bool,
                                                               startDirection: Float,
                                                               startMagnitudeIn: Float,
                                                               startMagnitudeOut: Float) {
        _moveWeightCurveTanHandleData.didChange = false
        _moveWeightCurveTanHandleData.jiggleIndex = jiggleIndex
        _moveWeightCurveTanHandleData.weightCurveIndex = weightCurveIndex
        _moveWeightCurveTanHandleData.startDirection = startDirection
        _moveWeightCurveTanHandleData.startMagnitudeIn = startMagnitudeIn
        _moveWeightCurveTanHandleData.startMagnitudeOut = startMagnitudeOut
    }
    
    @MainActor public func moveWeightCurveTanHandleDataTrack(endDirection: Float,
                                                             endMagnitudeIn: Float,
                                                             endMagnitudeOut: Float) {
        _moveWeightCurveTanHandleData.didChange = true
        _moveWeightCurveTanHandleData.endDirection = endDirection
        _moveWeightCurveTanHandleData.endMagnitudeIn = endMagnitudeIn
        _moveWeightCurveTanHandleData.endMagnitudeOut = endMagnitudeOut
    }
    
    @MainActor public func moveWeightCurveTanHandleDataNotifyIfChangedAndSameIndex(jiggleIndex: Int?) {
        if _moveWeightCurveTanHandleData.didChange {
            if _moveWeightCurveTanHandleData.jiggleIndex == jiggleIndex {
                
                if let jiggleIndex = _moveWeightCurveTanHandleData.jiggleIndex {
                    if let weightCurveIndex = _moveWeightCurveTanHandleData.weightCurveIndex {
                        let historyStateMoveWeightGraphTangent = HistoryStateMoveWeightGraphTangent(jiggleIndex: jiggleIndex,
                                                                                                    weightCurveIndex: weightCurveIndex,
                                                                                                    startTangentManual: _moveWeightCurveTanHandleData.startManual,
                                                                                                    startDirection: _moveWeightCurveTanHandleData.startDirection,
                                                                                                    startMagnitudeIn: _moveWeightCurveTanHandleData.startMagnitudeIn,
                                                                                                    startMagnitudeOut: _moveWeightCurveTanHandleData.startMagnitudeOut,
                                                                                                    endDirection: _moveWeightCurveTanHandleData.endDirection,
                                                                                                    endMagnitudeIn: _moveWeightCurveTanHandleData.endMagnitudeIn,
                                                                                                    endMagnitudeOut: _moveWeightCurveTanHandleData.endMagnitudeOut)
                        addHistoryState(historyStateMoveWeightGraphTangent)
                    }
                    
                    _moveWeightCurveTanHandleData.didChange = false
                }
            }
        }
    }
    
    // Weight-Curve-C
    @MainActor public func resetWeightGraphNotify(jiggleIndex: Int,
                                                  storageNodes: [HistoryStateResetWeightGraph.StorageNode]) {
        let historyStateResetWeightGraph = HistoryStateResetWeightGraph(jiggleIndex: jiggleIndex,
                                                                        storageNodes: storageNodes)
        addHistoryState(historyStateResetWeightGraph)
    }
    
    
    // Grab-Animation-A
    @MainActor public func historyRecordContinuousAttributeOne(jiggleIndex: Int,
                                                        startAttribute: ContinuousAttribute,
                                                        endAttribute: ContinuousAttribute) {
        let historyStateContinuousAttributeOne = HistoryStateContinuousAttributeOne(jiggleIndex: jiggleIndex,
                                                                                    startAttribute: startAttribute,
                                                                                    endAttribute: endAttribute)
        addHistoryState(historyStateContinuousAttributeOne)
    }
    
    // Grab-Animation-B
    @MainActor public func historyRecordContinuousAttributesAll(jiggleIndex: Int,
                                                         startAttributes: [ContinuousAttribute],
                                                         endAttributes: [ContinuousAttribute]) {
        let historyStateContinuousAttributesAll = HistoryStateContinuousAttributesAll(jiggleIndex: jiggleIndex,
                                                                                      startAttributes: startAttributes,
                                                                                      endAttributes: endAttributes)
        addHistoryState(historyStateContinuousAttributesAll)
    }
    
    
    // Continuous-Animation-A
    @MainActor public func grabAttributeOneNotify(jiggleIndex: Int,
                                                  startAttribute: GrabAttribute,
                                                  endAttribute: GrabAttribute) {
        let historyStateGrabAttributeOne = HistoryStateGrabAttributeOne(jiggleIndex: jiggleIndex,
                                                                        startAttribute: startAttribute,
                                                                        endAttribute: endAttribute)
        addHistoryState(historyStateGrabAttributeOne)
    }
    
    // Continuous-Animation-B
    @MainActor public func grabAttributesAllNotify(jiggleIndex: Int,
                                                   startAttributes: [GrabAttribute],
                                                   endAttributes: [GrabAttribute]) {
        let historyStateGrabAttributesAll = HistoryStateGrabAttributesAll(jiggleIndex: jiggleIndex,
                                                                          startAttributes: startAttributes,
                                                                          endAttributes: endAttributes)
        addHistoryState(historyStateGrabAttributesAll)
    }
    
    
    
    // Loop-Animation-A
    @MainActor public func historyRecordLoopAttributeOne(jiggleIndex: Int,
                                                  selectedTimeLineSwatch: Swatch,
                                                  startAttribute: LoopAttribute,
                                                  endAttribute: LoopAttribute) {
        let historyStateLoopAttributeOne = HistoryStateLoopAttributeOne(jiggleIndex: jiggleIndex,
                                                                        startAttribute: startAttribute,
                                                                        endAttribute: endAttribute,
                                                                        selectedTimeLineSwatch: selectedTimeLineSwatch)
        addHistoryState(historyStateLoopAttributeOne)
    }
    
    // Loop-Animation-B
    @MainActor public func historyRecordLoopAttributesAll(jiggleIndex: Int,
                                                   selectedTimeLineSwatch: Swatch,
                                                   startAttributes: [LoopAttribute],
                                                   endAttributes: [LoopAttribute]) {
        let historyStateLoopAttributesAll = HistoryStateLoopAttributesAll(jiggleIndex: jiggleIndex,
                                                                          startAttributes: startAttributes,
                                                                          endAttributes: endAttributes,
                                                                          selectedTimeLineSwatch: selectedTimeLineSwatch)
        addHistoryState(historyStateLoopAttributesAll)
    }
    
    
}

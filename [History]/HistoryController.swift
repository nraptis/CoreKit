//
//  HistoryController.swift
//  HistoryKit
//
//  Created by Nicholas Raptis on 5/17/25.
//

import Foundation

public class HistoryController {
    
    public static let invalidInterfaceElement = UInt16(7777)
    
    private var historyStack = [HistoryState]()
    private var historyIndex: Int = 0
    private var isMostRecentActionUndo = false
    private var isMostRecentActionRedo = false
    public weak var delegate: HistoryControllerConforming?
    
    public struct SnapShotGraphDataControlPoint {
        public let selectedJiggleIndex: Int
        public let selectedGraphIndex: Int
        public let selectedJiggleAttribute: GraphAttribute
    }
    
    public struct SnapShotGraphDataEntireGraph {
        public let selectedJiggleIndex: Int
        public let weightCurvePointStart: GraphAttributeDataControlPoint
        public let weightCurvePointMiddle: GraphAttributeDataControlPoint
        public let weightCurvePointEnd: GraphAttributeDataControlPoint
        public let resetType: WeightCurveResetType
    }
    
    @frozen public enum SnapShotGraphMode {
        case appliedToControlPoint(SnapShotGraphDataControlPoint)
        case appliedToEntireGraph(SnapShotGraphDataEntireGraph)
        case invalid
    }
    
    public var snapShotGraphMode = SnapShotGraphMode.invalid
    public var snapShotGraphIsGraphDrag = false
    
    
    public struct SnapShotGrabOneData {
        public let selectedJiggleIndex: Int
        public let selectedJiggleAttribute: GrabAttribute
    }
    
    public struct SnapShotGrabAllData {
        public let selectedJiggleIndex: Int
        public let selectedJiggleAttribute: GrabAttribute
        public let otherJiggleIndices: [Int]
        public let otherJiggleAttributes: [GrabAttribute]
    }
    
    @frozen public enum SnapShotGrabMode {
        case appliedToSelected(SnapShotGrabOneData)
        case appliedToAll(SnapShotGrabAllData)
        case invalid
    }
    
    public var snapShotGrabMode = SnapShotGrabMode.invalid
    public var snapShotGrabInterfaceElement = HistoryController.invalidInterfaceElement
    
    
    public struct SnapShotContinuousOneData {
        public let selectedJiggleIndex: Int
        public let selectedJiggleAttribute: ContinuousAttribute
        public let mirrorEnabled: Bool
        public let mirrorElementType: MirrorElementType
    }
    
    public struct SnapShotContinuousAllData {
        public let selectedJiggleIndex: Int
        public let selectedJiggleAttribute: ContinuousAttribute
        public let otherJiggleIndices: [Int]
        public let otherJiggleAttributes: [ContinuousAttribute]
        public let mirrorEnabled: Bool
        public let mirrorElementType: MirrorElementType
    }
    
    @frozen public enum SnapShotContinuousMode {
        case appliedToSelected(SnapShotContinuousOneData)
        case appliedToAll(SnapShotContinuousAllData)
        case invalid
    }
    
    public var snapShotContinuousMode = SnapShotContinuousMode.invalid
    public var snapShotContinuousInterfaceElement = HistoryController.invalidInterfaceElement
    
    public struct SnapShotLoopOneData {
        public let selectedJiggleIndex: Int
        public let selectedJiggleAttribute: LoopAttribute
        public let mirrorEnabled: Bool
        public let mirrorElementType: MirrorElementType
    }
    
    public struct SnapShotLoopAllData {
        public let selectedJiggleIndex: Int
        public let selectedJiggleAttribute: LoopAttribute
        public let otherJiggleIndices: [Int]
        public let otherJiggleAttributes: [LoopAttribute]
        public let mirrorEnabled: Bool
        public let mirrorElementType: MirrorElementType
    }
    
    @frozen public enum SnapShotLoopMode {
        case appliedToSelected(SnapShotLoopOneData)
        case appliedToAll(SnapShotLoopAllData)
        case invalid
    }
    
    public var snapShotLoopMode = SnapShotLoopMode.invalid
    public var snapShotLoopInterfaceElement = HistoryController.invalidInterfaceElement
    public var snapShotLoopSelectedTimeLineSwatch = Swatch.x
    public var snapShotLoopIsTimeLineDrag = false
    
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
    @MainActor public func historyRecordCreateJiggle(data: Data?,
                                                     interfaceConfiguration: any InterfaceConfigurationConforming) {
        guard let data = data else { return }
        
        let historyStateCreateJiggle = HistoryStateCreateJiggle(data: data,
                                                                interfaceConfiguration: interfaceConfiguration)
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
                                                 endRotation: Float,
                                                 interfaceConfiguration: any InterfaceConfigurationConforming) {
        guard let jiggleIndex = jiggleIndex else { return }
        let historyStateTransformJiggle = HistoryStateTransformJiggle(jiggleIndex: jiggleIndex,
                                                                      startCenter: _transformJiggleData.startCenter,
                                                                      startScale: _transformJiggleData.startScale,
                                                                      startRotation: _transformJiggleData.startRotation,
                                                                      endCenter: endCenter,
                                                                      endScale: endScale,
                                                                      endRotation: endRotation,
                                                                      interfaceConfiguration: interfaceConfiguration)
        addHistoryState(historyStateTransformJiggle)
    }
    
    
    // Jiggle, C
    @MainActor public func historyRecordRotateOrFlipJiggle(jiggleIndex: Int,
                                                           startData: Data,
                                                           endData: Data,
                                                           interfaceConfiguration: any InterfaceConfigurationConforming) {
        let historyStateRotateOrFlipJiggle = HistoryStateRotateOrFlipJiggle(jiggleIndex: jiggleIndex,
                                                                            startData: startData,
                                                                            endData: endData,
                                                                            interfaceConfiguration: interfaceConfiguration)
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
    @MainActor public func moveJiggleCenterNotifyIfChanged(interfaceConfiguration: any InterfaceConfigurationConforming) {
        guard let jiggleIndex = _moveJiggleCenterData.jiggleIndex else { return }
        if _moveJiggleCenterData.didChange {
            let historyStateMoveJiggleCenter = HistoryStateMoveJiggleCenter(jiggleIndex: jiggleIndex,
                                                                            startCenter: _moveJiggleCenterData.startCenter,
                                                                            endCenter: _moveJiggleCenterData.endCenter,
                                                                            interfaceConfiguration: interfaceConfiguration)
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
    @MainActor public func moveWeightCenterNotifyIfChanged(interfaceConfiguration: any InterfaceConfigurationConforming) {
        guard let jiggleIndex = _moveWeightCenterData.jiggleIndex else { return }
        if _moveWeightCenterData.didChange {
            _moveWeightCenterData.didChange = false
            let historyStateMoveWeightCenter = HistoryStateMoveWeightCenter(jiggleIndex: jiggleIndex,
                                                                            startCenter: _moveWeightCenterData.startCenter,
                                                                            endCenter: _moveWeightCenterData.endCenter,
                                                                            interfaceConfiguration: interfaceConfiguration)
            addHistoryState(historyStateMoveWeightCenter)
        }
    }
    
    
    
    // Jiggle, F
    @MainActor public func historyRecordDeleteJiggle(jiggleIndex: Int?,
                                                     data: Data?,
                                                     interfaceConfiguration: any InterfaceConfigurationConforming) {
        guard let jiggleIndex = jiggleIndex else { return }
        guard let data = data else { return }
        let historyStateDeleteJiggle = HistoryStateDeleteJiggle(jiggleIndex: jiggleIndex,
                                                                data: data,
                                                                interfaceConfiguration: interfaceConfiguration)
        addHistoryState(historyStateDeleteJiggle)
    }
    
    // Guide, A
    @MainActor public func historyRecordCreateGuide(jiggleIndex: Int?,
                                                    data: Data?,
                                                    interfaceConfiguration: any InterfaceConfigurationConforming) {
        guard let jiggleIndex = jiggleIndex else { return }
        guard let data = data else { return }
        let historyStateCreateGuide = HistoryStateCreateGuide(jiggleIndex: jiggleIndex,
                                                              data: data,
                                                              interfaceConfiguration: interfaceConfiguration)
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
                                                endRotation: Float,
                                                interfaceConfiguration: any InterfaceConfigurationConforming) {
        guard let jiggleIndex = jiggleIndex else { return }
        guard let guideIndex = guideIndex else { return }
        let historyStateTransformGuide = HistoryStateTransformGuide(jiggleIndex: jiggleIndex,
                                                                    guideIndex: guideIndex,
                                                                    startCenter: _transformGuideData.startCenter,
                                                                    startScale: _transformGuideData.startScale,
                                                                    startRotation: _transformGuideData.startRotation,
                                                                    endCenter: endCenter,
                                                                    endScale: endScale,
                                                                    endRotation: endRotation,
                                                                    interfaceConfiguration: interfaceConfiguration)
        addHistoryState(historyStateTransformGuide)
    }
    
    
    // Guide, C
    @MainActor public func historyRecordRotateOrFlipGuide(jiggleIndex: Int,
                                                          guideIndex: Int,
                                                          startData: Data,
                                                          endData: Data,
                                                          interfaceConfiguration: any InterfaceConfigurationConforming) {
        let historyStateRotateOrFlipGuide = HistoryStateRotateOrFlipGuide(jiggleIndex: jiggleIndex,
                                                                          guideIndex: guideIndex,
                                                                          startData: startData,
                                                                          endData: endData,
                                                                          interfaceConfiguration: interfaceConfiguration)
        addHistoryState(historyStateRotateOrFlipGuide)
    }
    
    
    
    // Guide, D
    @MainActor public func historyRecordReplaceAllGuides(jiggleIndex: Int?,
                                                         weightCurveIndex: Int?,
                                                         startWeightCenter: Math.Point,
                                                         endWeightCenter: Math.Point,
                                                         startDatas: [Data],
                                                         endDatas: [Data],
                                                         interfaceConfiguration: any InterfaceConfigurationConforming) {
        guard let jiggleIndex = jiggleIndex else { return }
        guard let weightCurveIndex = weightCurveIndex else { return }
        let historyStateGenerateTopography = HistoryStateGenerateTopography(jiggleIndex: jiggleIndex,
                                                                            weightCurveIndex: weightCurveIndex,
                                                                            startDatas: startDatas,
                                                                            endDatas: endDatas,
                                                                            startWeightCenter: startWeightCenter,
                                                                            endWeightCenter: endWeightCenter,
                                                                            interfaceConfiguration: interfaceConfiguration)
        addHistoryState(historyStateGenerateTopography)
    }
    
    // Guide, E
    @MainActor public func historyRecordDeleteGuide(jiggleIndex: Int?,
                                                    guideIndex: Int?,
                                                    data: Data?,
                                                    interfaceConfiguration: any InterfaceConfigurationConforming) {
        guard let jiggleIndex = jiggleIndex else { return }
        guard let guideIndex = guideIndex else { return }
        guard let data = data else { return }
        let historyStateDeleteGuide = HistoryStateDeleteGuide(jiggleIndex: jiggleIndex,
                                                              guideIndex: guideIndex,
                                                              data: data,
                                                              interfaceConfiguration: interfaceConfiguration)
        addHistoryState(historyStateDeleteGuide)
    }
    
    
    // Jiggle-Point, A
    @MainActor public func historyRecordCreateJigglePoint(jiggleIndex: Int?,
                                                          controlPointIndex: Int?,
                                                          point: Math.Point,
                                                          interfaceConfiguration: any InterfaceConfigurationConforming) {
        guard let jiggleIndex = jiggleIndex else { return }
        guard let controlPointIndex = controlPointIndex else { return }
        
        let historyStateCreateJigglePoint = HistoryStateCreateJigglePoint(jiggleIndex: jiggleIndex,
                                                                          controlPointIndex: controlPointIndex,
                                                                          point: point,
                                                                          interfaceConfiguration: interfaceConfiguration)
        addHistoryState(historyStateCreateJigglePoint)
    }
    
    // Jiggle-Point, B
    @MainActor public func historyRecordInsertJigglePoint(jiggleIndex: Int?,
                                                          controlPointIndex: Int?,
                                                          selectedJigglePointIndex: Int?,
                                                          point: Math.Point,
                                                          interfaceConfiguration: any InterfaceConfigurationConforming) {
        guard let jiggleIndex = jiggleIndex else { return }
        guard let controlPointIndex = controlPointIndex else { return }
        guard let selectedJigglePointIndex = selectedJigglePointIndex else { return }
        
        let historyStateInsertJigglePoint = HistoryStateInsertJigglePoint(jiggleIndex: jiggleIndex,
                                                                          controlPointIndex: controlPointIndex,
                                                                          selectedJigglePointIndex: selectedJigglePointIndex,
                                                                          point: point,
                                                                          interfaceConfiguration: interfaceConfiguration)
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
    @MainActor public func moveJigglePointNotifyIfChanged(interfaceConfiguration: any InterfaceConfigurationConforming) -> Bool {
        var result = false
        if _moveJigglePointData.didChange {
            if let jiggleIndex = _moveJigglePointData.jiggleIndex {
                if let controlPointIndex = _moveJigglePointData.controlPointIndex {
                    let historyStateMoveControlPoint = HistoryStateMoveJigglePoint(jiggleIndex: jiggleIndex,
                                                                                   controlPointIndex: controlPointIndex,
                                                                                   startPoint: _moveJigglePointData.startPoint,
                                                                                   endPoint: _moveJigglePointData.endPoint,
                                                                                   interfaceConfiguration: interfaceConfiguration)
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
    @MainActor public func moveJigglePointTanHandleNotifyIfChanged(interfaceConfiguration: any InterfaceConfigurationConforming) -> Bool {
        var result = false
        if _moveJigglePointTanHandleData.didChange {
            if let jiggleIndex = _moveJigglePointTanHandleData.jiggleIndex {
                if let controlPointIndex = _moveJigglePointTanHandleData.controlPointIndex {
                    let historyStateMoveJigglePointTanHandle = HistoryStateMoveJigglePointTanHandle(jiggleIndex: jiggleIndex,
                                                                                                    controlPointIndex: controlPointIndex,
                                                                                                    tanType: _moveJigglePointTanHandleData.tanType,
                                                                                                    startData: _moveJigglePointTanHandleData.startData,
                                                                                                    endData: _moveJigglePointTanHandleData.endData,
                                                                                                    interfaceConfiguration: interfaceConfiguration)
                    addHistoryState(historyStateMoveJigglePointTanHandle)
                }
            }
            _moveJigglePointTanHandleData.didChange = false
            result = true
        }
        return result
    }
    
    
    // Jiggle-Point, E
    @MainActor public func historyRecordUpdateJigglePointDataOne(jiggleIndex: Int?,
                                                                 controlPointIndex: Int?,
                                                                 startData: ControlPointData,
                                                                 endData: ControlPointData,
                                                                 multiModeSelectionType: MultiModeSelectionType,
                                                                 tanType: TanType,
                                                                 interfaceConfiguration: any InterfaceConfigurationConforming) {
        guard let jiggleIndex = jiggleIndex else { return }
        guard let controlPointIndex = controlPointIndex else { return }
        let historyStateUpdateJigglePointOne = HistoryStateUpdateJigglePointOne(jiggleIndex: jiggleIndex,
                                                                                controlPointIndex: controlPointIndex,
                                                                                startData: startData,
                                                                                endData: endData,
                                                                                multiModeSelectionType: multiModeSelectionType,
                                                                                tanType: tanType,
                                                                                interfaceConfiguration: interfaceConfiguration)
        addHistoryState(historyStateUpdateJigglePointOne)
    }
    
    // Jiggle-Point, F
    @MainActor public func historyRecordUpdateJigglePointDataAll(jiggleIndex: Int?,
                                                                 controlPointIndex: Int?,
                                                                 startDatas: [ControlPointData],
                                                                 endDatas: [ControlPointData],
                                                                 multiModeSelectionType: MultiModeSelectionType,
                                                                 tanType: TanType,
                                                                 interfaceConfiguration: any InterfaceConfigurationConforming) {
        guard let jiggleIndex = jiggleIndex else { return }
        guard let controlPointIndex = controlPointIndex else { return }
        
        let historyStateUpdateGuidePointOne = HistoryStateUpdateJigglePointAll(jiggleIndex: jiggleIndex,
                                                                               controlPointIndex: controlPointIndex,
                                                                               startDatas: startDatas,
                                                                               endDatas: endDatas,
                                                                               multiModeSelectionType: multiModeSelectionType,
                                                                               tanType: tanType,
                                                                               interfaceConfiguration: interfaceConfiguration)
        addHistoryState(historyStateUpdateGuidePointOne)
    }
    
    
    // Jiggle-Point, G
    @MainActor public func historyRecordReplaceJigglePointDataAll(jiggleIndex: Int?,
                                                                  startDatas: [ControlPointData],
                                                                  startSelectedIndex: Int,
                                                                  endDatas: [ControlPointData],
                                                                  endSelectedIndex: Int,
                                                                  interfaceConfiguration: any InterfaceConfigurationConforming) {
        guard let jiggleIndex = jiggleIndex else { return }
        let historyStateUpdateGuidePointOne = HistoryStateReplaceJigglePointAll(jiggleIndex: jiggleIndex,
                                                                                startDatas: startDatas,
                                                                                startSelectedIndex: startSelectedIndex,
                                                                                endDatas: endDatas,
                                                                                endSelectedIndex: endSelectedIndex,
                                                                                interfaceConfiguration: interfaceConfiguration)
        
        addHistoryState(historyStateUpdateGuidePointOne)
    }
    
    // Jiggle-Point, H
    @MainActor public func historyRecordDeleteJigglePoint(jiggleIndex: Int?,
                                                          controlPointIndex: Int?,
                                                          data: ControlPointData,
                                                          interfaceConfiguration: any InterfaceConfigurationConforming) {
        guard let jiggleIndex = jiggleIndex else { return }
        guard let controlPointIndex = controlPointIndex else { return }
        let historyStateDeleteJigglePoint = HistoryStateDeleteJigglePoint(jiggleIndex: jiggleIndex,
                                                                          controlPointIndex: controlPointIndex,
                                                                          data: data,
                                                                          interfaceConfiguration: interfaceConfiguration)
        addHistoryState(historyStateDeleteJigglePoint)
    }
    
    
    
    // Guide-Point, A
    @MainActor public func historyRecordCreateGuidePoint(point: Math.Point,
                                                         jiggleIndex: Int?,
                                                         guideIndex: Int?,
                                                         guidePointIndex: Int?,
                                                         interfaceConfiguration: any InterfaceConfigurationConforming) {
        guard let jiggleIndex = jiggleIndex else { return }
        guard let guideIndex = guideIndex else { return }
        guard let guidePointIndex = guidePointIndex else { return }
        
        let historyStateCreateGuidePoint = HistoryStateCreateGuidePoint(jiggleIndex: jiggleIndex,
                                                                        guideIndex: guideIndex,
                                                                        guidePointIndex: guidePointIndex,
                                                                        point: point,
                                                                        interfaceConfiguration: interfaceConfiguration)
        addHistoryState(historyStateCreateGuidePoint)
    }
    
    // Guide-Point, B
    @MainActor public func historyRecordInsertGuidePoint(point: Math.Point,
                                                         jiggleIndex: Int?,
                                                         guideIndex: Int?,
                                                         guidePointIndex: Int?,
                                                         selectedGuidePointIndex: Int?,
                                                         interfaceConfiguration: any InterfaceConfigurationConforming) {
        guard let jiggleIndex = jiggleIndex else { return }
        guard let guideIndex = guideIndex else { return }
        guard let guidePointIndex = guidePointIndex else { return }
        guard let selectedGuidePointIndex = selectedGuidePointIndex else { return }
        let historyStateInsertGuidePoint = HistoryStateInsertGuidePoint(jiggleIndex: jiggleIndex,
                                                                        guideIndex: guideIndex,
                                                                        guidePointIndex: guidePointIndex,
                                                                        selectedGuidePointIndex: selectedGuidePointIndex,
                                                                        point: point,
                                                                        interfaceConfiguration: interfaceConfiguration)
        addHistoryState(historyStateInsertGuidePoint)
    }
    
    // Guide-Point, C
    var _moveGuidePointData = MoveGuidePointData()
    @MainActor public func moveGuidePointCapture(jiggleIndex: Int?,
                                                 guideIndex: Int?,
                                                 guidePointIndex: Int?,
                                                 startPoint: Math.Point,
                                                 interfaceConfiguration: any InterfaceConfigurationConforming) {
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
    
    @MainActor public func moveGuidePointNotifyIfChanged(interfaceConfiguration: any InterfaceConfigurationConforming) -> Bool {
        var result = false
        if _moveGuidePointData.didChange {
            
            if let jiggleIndex = _moveGuidePointData.jiggleIndex {
                if let guideIndex = _moveGuidePointData.guideIndex {
                    if let guidePointIndex = _moveGuidePointData.guidePointIndex {
                        let historyStateMoveGuidePoint = HistoryStateMoveGuidePoint(jiggleIndex: jiggleIndex,
                                                                                    guideIndex: guideIndex,
                                                                                    guidePointIndex: guidePointIndex,
                                                                                    startPoint: _moveGuidePointData.startPoint,
                                                                                    endPoint: _moveGuidePointData.endPoint,
                                                                                    interfaceConfiguration: interfaceConfiguration)
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
    
    @MainActor public func moveGuidePointTanHandleNotifyIfChanged(interfaceConfiguration: any InterfaceConfigurationConforming) -> Bool {
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
                                                                                                      endData: _moveGuidePointTanHandleData.endData,
                                                                                                      interfaceConfiguration: interfaceConfiguration)
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
    @MainActor public func historyRecordUpdateGuidePointDataOne(jiggleIndex: Int?,
                                                                guideIndex: Int?,
                                                                guidePointIndex: Int?,
                                                                startData: ControlPointData,
                                                                endData: ControlPointData,
                                                                multiModeSelectionType: MultiModeSelectionType,
                                                                tanType: TanType,
                                                                interfaceConfiguration: any InterfaceConfigurationConforming) {
        guard let jiggleIndex = jiggleIndex else { return }
        guard let guideIndex = guideIndex else { return }
        guard let guidePointIndex = guidePointIndex else { return }
        
        let historyStateUpdateGuidePointOne = HistoryStateUpdateGuidePointOne(jiggleIndex: jiggleIndex,
                                                                              guideIndex: guideIndex,
                                                                              guidePointIndex: guidePointIndex,
                                                                              startData: startData,
                                                                              endData: endData,
                                                                              multiModeSelectionType: multiModeSelectionType,
                                                                              tanType: tanType,
                                                                              interfaceConfiguration: interfaceConfiguration)
        addHistoryState(historyStateUpdateGuidePointOne)
    }
    
    
    // Guide-Point, F
    @MainActor public func historyRecordUpdateGuidePointDataAll(jiggleIndex: Int?,
                                                                guideIndex: Int?,
                                                                guidePointIndex: Int?,
                                                                startDatas: [ControlPointData],
                                                                endDatas: [ControlPointData],
                                                                multiModeSelectionType: MultiModeSelectionType,
                                                                tanType: TanType,
                                                                interfaceConfiguration: any InterfaceConfigurationConforming) {
        guard let jiggleIndex = jiggleIndex else { return }
        guard let guideIndex = guideIndex else { return }
        guard let guidePointIndex = guidePointIndex else { return }
        
        let historyStateUpdateGuidePointOne = HistoryStateUpdateGuidePointAll(jiggleIndex: jiggleIndex,
                                                                              guideIndex: guideIndex,
                                                                              guidePointIndex: guidePointIndex,
                                                                              startDatas: startDatas,
                                                                              endDatas: endDatas,
                                                                              multiModeSelectionType: multiModeSelectionType,
                                                                              tanType: tanType,
                                                                              interfaceConfiguration: interfaceConfiguration)
        addHistoryState(historyStateUpdateGuidePointOne)
    }
    
    
    // Guide-Point, G
    @MainActor public func historyRecordReplaceGuidePointDataAll(jiggleIndex: Int?,
                                                                 guideIndex: Int?,
                                                                 startDatas: [ControlPointData],
                                                                 startSelectedIndex: Int,
                                                                 endDatas: [ControlPointData],
                                                                 endSelectedIndex: Int,
                                                                 interfaceConfiguration: any InterfaceConfigurationConforming) {
        guard let jiggleIndex = jiggleIndex else { return }
        guard let guideIndex = guideIndex else { return }
        let historyStateUpdateGuidePointOne = HistoryStateReplaceGuidePointAll(jiggleIndex: jiggleIndex,
                                                                               guideIndex: guideIndex,
                                                                               startDatas: startDatas,
                                                                               startSelectedIndex: startSelectedIndex,
                                                                               endDatas: endDatas,
                                                                               endSelectedIndex: endSelectedIndex,
                                                                               interfaceConfiguration: interfaceConfiguration)
        addHistoryState(historyStateUpdateGuidePointOne)
    }
    
    
    
    // Guide-Point, H
    @MainActor public func historyRecordDeleteGuidePoint(jiggleIndex: Int?,
                                                         guideIndex: Int?,
                                                         guidePointIndex: Int?,
                                                         data: ControlPointData,
                                                         interfaceConfiguration: any InterfaceConfigurationConforming) {
        guard let jiggleIndex = jiggleIndex else { return }
        guard let guideIndex = guideIndex else { return }
        guard let guidePointIndex = guidePointIndex else { return }
        let historyStateDeleteGuidePoint = HistoryStateDeleteGuidePoint(jiggleIndex: jiggleIndex,
                                                                        guideIndex: guideIndex,
                                                                        guidePointIndex: guidePointIndex,
                                                                        data: data,
                                                                        interfaceConfiguration: interfaceConfiguration)
        addHistoryState(historyStateDeleteGuidePoint)
    }
    
    @MainActor public func historyRecordGraphPosition(jiggleIndex: Int,
                                                      weightCurveIndex: Int,
                                                      startData: GraphAttributeDataHeight,
                                                      endData: GraphAttributeDataHeight,
                                                      interfaceConfiguration: any InterfaceConfigurationConforming) {
        
        let startHeightManual = startData.isManualHeightEnabled
        let startHeightFactor = startData.normalizedHeightFactor
        let endHeightFactor = endData.normalizedHeightFactor
        let historyStateMoveWeightGraphPosition = HistoryStateMoveWeightGraphPosition(jiggleIndex: jiggleIndex,
                                                                                      weightCurveIndex: weightCurveIndex,
                                                                                      startHeightManual: startHeightManual,
                                                                                      startHeightFactor: startHeightFactor,
                                                                                      endHeightFactor: endHeightFactor,
                                                                                      interfaceConfiguration: interfaceConfiguration)
        addHistoryState(historyStateMoveWeightGraphPosition)
    }
    
    @MainActor public func historyRecordGraphTangent(jiggleIndex: Int,
                                                     weightCurveIndex: Int,
                                                     startData: GraphAttributeDataTanHandles,
                                                     endData: GraphAttributeDataTanHandles,
                                                     interfaceConfiguration: any InterfaceConfigurationConforming) {
        
        let startTangentManual = startData.isManualTanHandleEnabled
        let startDirection = startData.normalizedTanDirection
        let startMagnitudeIn = startData.normalizedTanMagnitudeIn
        let startMagnitudeOut = startData.normalizedTanMagnitudeOut
        
        let endDirection = endData.normalizedTanDirection
        let endMagnitudeIn = endData.normalizedTanMagnitudeIn
        let endMagnitudeOut = endData.normalizedTanMagnitudeOut
        
        let historyStateMoveWeightGraphTangent = HistoryStateMoveWeightGraphTangent(jiggleIndex: jiggleIndex,
                                                                                    weightCurveIndex: weightCurveIndex,
                                                                                    startTangentManual: startTangentManual,
                                                                                    startDirection: startDirection,
                                                                                    startMagnitudeIn: startMagnitudeIn,
                                                                                    startMagnitudeOut: startMagnitudeOut,                       endDirection: endDirection,
                                                                                    endMagnitudeIn: endMagnitudeIn,
                                                                                    endMagnitudeOut: endMagnitudeOut,
                                                                                    interfaceConfiguration: interfaceConfiguration)
        addHistoryState(historyStateMoveWeightGraphTangent)
    }
    
    @MainActor public func historyRecordGraphReset(jiggleIndex: Int,
                                                   startResetType: WeightCurveResetType,
                                                   endResetType: WeightCurveResetType,
                                                   startData: SnapShotGraphDataEntireGraph,
                                                   endData: SnapShotGraphDataEntireGraph,
                                                   interfaceConfiguration: any InterfaceConfigurationConforming) {
        
        let storageNodeStart = WeightGraphStorageNode(startHeightManual: startData.weightCurvePointStart.isManualHeightEnabled,
                                                      startHeightFactor: startData.weightCurvePointStart.normalizedHeightFactor,
                                                      startTangentManual: startData.weightCurvePointStart.isManualTanHandleEnabled,
                                                      startDirection: startData.weightCurvePointStart.normalizedTanDirection,
                                                      startMagnitudeIn: startData.weightCurvePointStart.normalizedTanMagnitudeIn,
                                                      startMagnitudeOut: startData.weightCurvePointStart.normalizedTanMagnitudeOut)
        let storageNodeMiddle = WeightGraphStorageNode(startHeightManual: startData.weightCurvePointMiddle.isManualHeightEnabled,
                                                       startHeightFactor: startData.weightCurvePointMiddle.normalizedHeightFactor,
                                                       startTangentManual: startData.weightCurvePointMiddle.isManualTanHandleEnabled,
                                                       startDirection: startData.weightCurvePointMiddle.normalizedTanDirection,
                                                       startMagnitudeIn: startData.weightCurvePointMiddle.normalizedTanMagnitudeIn,
                                                       startMagnitudeOut: startData.weightCurvePointMiddle.normalizedTanMagnitudeOut)
        let storageNodeEnd = WeightGraphStorageNode(startHeightManual: startData.weightCurvePointEnd.isManualHeightEnabled,
                                                    startHeightFactor: startData.weightCurvePointEnd.normalizedHeightFactor,
                                                    startTangentManual: startData.weightCurvePointEnd.isManualTanHandleEnabled,
                                                    startDirection: startData.weightCurvePointEnd.normalizedTanDirection,
                                                    startMagnitudeIn: startData.weightCurvePointEnd.normalizedTanMagnitudeIn,
                                                    startMagnitudeOut: startData.weightCurvePointEnd.normalizedTanMagnitudeOut)
        
        let historyStateResetWeightGraph = HistoryStateResetWeightGraph(jiggleIndex: jiggleIndex,
                                                                        startResetType: startResetType,
                                                                        endResetType: endResetType,
                                                                        storageNodeStart: storageNodeStart,
                                                                        storageNodeMiddle: storageNodeMiddle,
                                                                        storageNodeEnd: storageNodeEnd,
                                                                        interfaceConfiguration: interfaceConfiguration)
        addHistoryState(historyStateResetWeightGraph)
        
        
    }
    
    
    // Grab-Animation-A
    @MainActor public func historyRecordGrabAttributeOne(jiggleIndex: Int,
                                                         startAttribute: GrabAttribute,
                                                         endAttribute: GrabAttribute,
                                                         interfaceConfiguration: any InterfaceConfigurationConforming) {
        let historyStateGrabAttributeOne = HistoryStateGrabAttributeOne(jiggleIndex: jiggleIndex,
                                                                        startAttribute: startAttribute,
                                                                        endAttribute: endAttribute,
                                                                        interfaceConfiguration: interfaceConfiguration)
        addHistoryState(historyStateGrabAttributeOne)
    }
    
    // Grab-Animation-B
    @MainActor public func historyRecordGrabAttributeAll(jiggleIndex: Int,
                                                         startAttributes: [GrabAttribute],
                                                         endAttributes: [GrabAttribute],
                                                         interfaceConfiguration: any InterfaceConfigurationConforming) {
        let historyStateGrabAttributeAll = HistoryStateGrabAttributeAll(jiggleIndex: jiggleIndex,
                                                                        startAttributes: startAttributes,
                                                                        endAttributes: endAttributes,
                                                                        interfaceConfiguration: interfaceConfiguration)
        addHistoryState(historyStateGrabAttributeAll)
    }
    
    // Continuous-Animation-A
    @MainActor public func historyRecordContinuousAttributeOne(jiggleIndex: Int,
                                                               startAttribute: ContinuousAttribute,
                                                               endAttribute: ContinuousAttribute,
                                                               interfaceConfiguration: any InterfaceConfigurationConforming) {
        let historyStateContinuousAttributeOne = HistoryStateContinuousAttributeOne(jiggleIndex: jiggleIndex,
                                                                                    startAttribute: startAttribute,
                                                                                    endAttribute: endAttribute,
                                                                                    interfaceConfiguration: interfaceConfiguration)
        addHistoryState(historyStateContinuousAttributeOne)
    }
    
    // Continuous-Animation-B
    @MainActor public func historyRecordContinuousAttributeAll(jiggleIndex: Int,
                                                               startAttributes: [ContinuousAttribute],
                                                               endAttributes: [ContinuousAttribute],
                                                               interfaceConfiguration: any InterfaceConfigurationConforming) {
        let historyStateContinuousAttributeAll = HistoryStateContinuousAttributeAll(jiggleIndex: jiggleIndex,
                                                                                    startAttributes: startAttributes,
                                                                                    endAttributes: endAttributes,
                                                                                    interfaceConfiguration: interfaceConfiguration)
        addHistoryState(historyStateContinuousAttributeAll)
    }
    
    
    // Loop-Animation-A
    @MainActor public func historyRecordLoopAttributeOne(jiggleIndex: Int,
                                                         selectedTimeLineSwatch: Swatch,
                                                         startAttribute: LoopAttribute,
                                                         endAttribute: LoopAttribute,
                                                         interfaceConfiguration: any InterfaceConfigurationConforming) {
        let historyStateLoopAttributeOne = HistoryStateLoopAttributeOne(jiggleIndex: jiggleIndex,
                                                                        startAttribute: startAttribute,
                                                                        endAttribute: endAttribute,
                                                                        selectedTimeLineSwatch: selectedTimeLineSwatch,
                                                                        interfaceConfiguration: interfaceConfiguration)
        addHistoryState(historyStateLoopAttributeOne)
    }
    
    // Loop-Animation-B
    @MainActor public func historyRecordLoopAttributeAll(jiggleIndex: Int,
                                                         selectedTimeLineSwatch: Swatch,
                                                         startAttributes: [LoopAttribute],
                                                         endAttributes: [LoopAttribute],
                                                         interfaceConfiguration: any InterfaceConfigurationConforming) {
        let historyStateLoopAttributeAll = HistoryStateLoopAttributeAll(jiggleIndex: jiggleIndex,
                                                                        startAttributes: startAttributes,
                                                                        endAttributes: endAttributes,
                                                                        selectedTimeLineSwatch: selectedTimeLineSwatch,
                                                                        interfaceConfiguration: interfaceConfiguration)
        addHistoryState(historyStateLoopAttributeAll)
    }
    
    func getJiggleIndex(selectedJiggle: Jiggle?,
                        jiggles: [Jiggle],
                        jiggleCount: Int) -> Int? {
        if let selectedJiggle = selectedJiggle {
            for jiggleIndex in 0..<jiggleCount {
                if jiggles[jiggleIndex] === selectedJiggle {
                    return jiggleIndex
                }
            }
        }
        return nil
    }
    
}

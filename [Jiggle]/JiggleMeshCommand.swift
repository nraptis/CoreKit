//
//  JiggleMeshCommand.swift
//  CoreKit
//
//  Created by Nicholas Raptis on 5/18/25.
//

import Foundation

public struct JiggleMeshCommand {

    public let spline: Bool
    public let triangulationType: TriangulationType
    public let meshType: MeshType
    public let outlineType: ForceableType
    public let swivelType: ForceableTypeWithNone
    public let weightCurveType: ForceableTypeWithNone

    public init(spline: Bool,
         triangulationType: TriangulationType,
         meshType: MeshType,
         outlineType: ForceableType,
         swivelType: ForceableTypeWithNone,
         weightCurveType: ForceableTypeWithNone) {
        self.spline = spline
        self.triangulationType = triangulationType
        self.meshType = meshType
        self.outlineType = outlineType
        self.swivelType = swivelType
        self.weightCurveType = weightCurveType
    }
    
    public static func getMeshTypeIfNeeded(documentMode: DocumentMode,
                                    isGuidesEnabled: Bool) -> MeshType {
        if documentMode.isView {
            return .weightsIfNeeded
        } else {
            if isGuidesEnabled {
                return .weightsIfNeeded
            } else {
                return .standardIfNeeded
            }
        }
    }
    
    public static func getMeshTypeForced(documentMode: DocumentMode,
                                  isGuidesEnabled: Bool) -> MeshType {
        if documentMode.isView {
            return .weightsForced
        } else {
            if isGuidesEnabled {
                return .weightsForced
            } else {
                return .standardForced
            }
        }
    }
    
    public static func getSwivelTypeIfNeeded(documentMode: DocumentMode,
                                      displayMode: DisplayMode,
                                      isGuidesEnabled: Bool,
                                      isGraphModeEnabled: Bool) -> ForceableTypeWithNone {
        if documentMode.isView {
            return .none
        } else {
            if isGuidesEnabled {
                if isGraphModeEnabled {
                    switch displayMode {
                    case .regular:
                        return .none
                    case .swivel:
                        return .ifNeeded
                    }
                } else {
                    return .none
                }
            } else {
                return .none
            }
        }
    }
    
    public static func getSwivelTypeForced(documentMode: DocumentMode,
                                    displayMode: DisplayMode,
                                    isGuidesEnabled: Bool,
                                    isGraphModeEnabled: Bool) -> ForceableTypeWithNone {
        
        if documentMode.isView {
            return .none
        } else {
            if isGuidesEnabled {
                if isGraphModeEnabled {
                    switch displayMode {
                    case .regular:
                        return .none
                    case .swivel:
                        return .forced
                    }
                } else {
                    return .none
                }
            } else {
                return .none
            }
        }
    }
    
    public static func getWeightCurveTypeIfNeeded(documentMode: DocumentMode,
                                           isGuidesEnabled: Bool,
                                           isGraphModeEnabled: Bool) -> ForceableTypeWithNone {
        if documentMode.isView {
            return .ifNeeded
        } else {
            if isGuidesEnabled {
                return .ifNeeded
            } else {
                return .none
            }
        }
    }
    
    public static func getWeightCurveTypeForced(documentMode: DocumentMode,
                                         isGuidesEnabled: Bool,
                                         isGraphModeEnabled: Bool) -> ForceableTypeWithNone {
        if documentMode.isView {
            return .forced
        } else {
            if isGuidesEnabled {
                return .forced
            } else {
                return .none
            }
        }
    }
}

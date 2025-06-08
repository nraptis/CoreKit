//
//  LinePointSize.swift
//  Jiggle3
//
//  Created by Nicholas Raptis on 5/12/25.
//

import Foundation

public struct LinePointSizes {
    
    // TODO: This can be B for release
    
    //public nonisolated(unsafe) static var userPointSizeType = RenderPointSizeType.b
    //public nonisolated(unsafe) static var userLineThicknessType = RenderLineThicknessType.b
    public nonisolated(unsafe) static var userPointSizeType = RenderPointSizeType.a
    public nonisolated(unsafe) static var userLineThicknessType = RenderLineThicknessType.a
    
    
    static func getSelectedPointExpansion(lineThicknessType: RenderLineThicknessType,
                                          pointSizeType: RenderPointSizeType,
                                          isPad: Bool) -> Int {
        
        let isBigLine: Bool
        switch lineThicknessType {
        case .a, .b:
            isBigLine = false
        default:
            isBigLine = true
        }
        
        let isBigPoint: Bool
        switch pointSizeType {
        case .a, .b:
            isBigPoint = false
        default:
            isBigPoint = true
        }
        
        if isPad {
            if isBigLine {
                if isBigPoint {
                    return 4
                } else {
                    return 2
                }
            } else {
                if isBigPoint {
                    return 2
                } else {
                    return 2
                }
            }
        } else {
            if isBigLine {
                if isBigPoint {
                    return 4
                } else {
                    return 2
                }
            } else {
                if isBigPoint {
                    return 2
                } else {
                    return 2
                }
            }
        }
    }
    
    public static func getPointFillBase(lineThicknessType: RenderLineThicknessType,
                                 pointSizeType: RenderPointSizeType,
                                 isSelected: Bool,
                                 isPad: Bool) -> Int {
        
        let expand: Int
        if isSelected {
            expand = getSelectedPointExpansion(lineThicknessType: lineThicknessType,
                                               pointSizeType: pointSizeType,
                                               isPad: isPad)
        } else {
            expand = 0
        }
        
        if isPad {
            
            switch lineThicknessType {
            case .a:
                // [G][O][L][D][E][N] [$$$$$$$$$$$$$$$$$$] 8========>
                return pointSizeType.process(start: 4 + expand, step: 2)
            case .b:
                // [G][O][L][D][E][N] [$$$$$$$$$$$$$$$$$$] 8========>
                return pointSizeType.process(start: 4 + expand, step: 2)
            case .c:
                // [G][O][L][D][E][N] [$$$$$$$$$$$$$$$$$$] 8========>
                return pointSizeType.process(start: 6 + expand, step: 2)
            case .d:
                // [G][O][L][D][E][N] [$$$$$$$$$$$$$$$$$$] 8========>
                return pointSizeType.process(start: 6 + expand, step: 2)
            }
            
        } else {
            
            switch lineThicknessType {
            case .a:
                // [G][O][L][D][E][N] [$$$$$$$$$$$$$$$$$$] 8========>
                return pointSizeType.process(start: 3 + expand, step: 2)
            case .b:
                // [G][O][L][D][E][N] [$$$$$$$$$$$$$$$$$$] 8========>
                return pointSizeType.process(start: 3 + expand, step: 2)
            case .c:
                // [G][O][L][D][E][N] [$$$$$$$$$$$$$$$$$$] 8========>
                return pointSizeType.process(start: 5 + expand, step: 2)
            case .d:
                // [G][O][L][D][E][N] [$$$$$$$$$$$$$$$$$$] 8========>
                return pointSizeType.process(start: 5 + expand, step: 2)
            }
        }
    }
    
    public static func getLineBase(lineThicknessType: RenderLineThicknessType,
                            isPad: Bool) -> Float {
        if isPad {
            // [G][O][L][D][E][N] [$$$$$$$$$$$$$$$$$$] 8========>
            return lineThicknessType.process(start: 1.0, step: 0.35)
        } else {
            // [G][O][L][D][E][N] [$$$$$$$$$$$$$$$$$$] 8========>
            return lineThicknessType.process(start: 0.75, step: 0.375)
        }
    }
    
    static func getLineStrokeExpandBase(lineThicknessType: RenderLineThicknessType,
                                        isPad: Bool) -> Float {
        if isPad {
            switch lineThicknessType {
            case .a, .b:
                // [G][O][L][D][E][N] [$$$$$$$$$$$$$$$$$$] 8========>
                return 1.0
            default:
                // [G][O][L][D][E][N] [$$$$$$$$$$$$$$$$$$] 8========>
                return 1.5
            }
        } else {
            switch lineThicknessType {
            case .a, .b:
                // [G][O][L][D][E][N] [$$$$$$$$$$$$$$$$$$] 8========>
                return 1.25
            default:
                // [G][O][L][D][E][N] [$$$$$$$$$$$$$$$$$$] 8========>
                return 1.85
            }
        }
    }
    
    static func getPointStrokeExpandBase(lineThicknessType: RenderLineThicknessType,
                                         pointSizeType: RenderPointSizeType,
                                         isSelected: Bool,
                                         isPad: Bool) -> Int {
        if isPad {
            switch lineThicknessType {
            case .a, .b:
                // [G][O][L][D][E][N] [$$$$$$$$$$$$$$$$$$] 8========>
                return 2
            default:
                // [G][O][L][D][E][N] [$$$$$$$$$$$$$$$$$$] 8========>
                return 4
            }
        } else {
            switch lineThicknessType {
            case .a, .b:
                // [G][O][L][D][E][N] [$$$$$$$$$$$$$$$$$$] 8========>
                return 2
            default:
                // [G][O][L][D][E][N] [$$$$$$$$$$$$$$$$$$] 8========>
                return 4
            }
        }
    }
    
    public static func getPointStrokeBase(lineThicknessType: RenderLineThicknessType,
                                   pointSizeType: RenderPointSizeType,
                                   isSelected: Bool,
                                   isPad: Bool) -> Int {
        // [G][O][L][D][E][N] [$$$$$$$$$$$$$$$$$$] 8========>
        let fillBase = getPointFillBase(lineThicknessType: lineThicknessType,
                                        pointSizeType: pointSizeType,
                                        isSelected: isSelected,
                                        isPad: isPad)
        let strokeExpand = getPointStrokeExpandBase(lineThicknessType: lineThicknessType,
                                                    pointSizeType: pointSizeType,
                                                    isSelected: isSelected,
                                                    isPad: isPad)
        return fillBase + strokeExpand
    }
    
    
    // On ipad, scale were "0.320155025"
    // On iphone, scale were "0.185271323"
    public static func getLineThicknessFill(lineThicknessType: RenderLineThicknessType,
                                            isPad: Bool) -> Float {
        // [G][O][L][D][E][N] [$$$$$$$$$$$$$$$$$$] 8========>
        let baseAmount = getLineBase(lineThicknessType: lineThicknessType,
                                     isPad: isPad)
        if isPad {
            return Float(baseAmount)
        } else {
            return Float(baseAmount)
        }
        
    }
    
    public static func getLineThicknessStroke(lineThicknessType: RenderLineThicknessType,
                                              isPad: Bool) -> Float {
        // [G][O][L][D][E][N] [$$$$$$$$$$$$$$$$$$] 8========>
        let baseAmount = getLineBase(lineThicknessType: lineThicknessType,
                                     isPad: isPad)
        let strokeExpand = getLineStrokeExpandBase(lineThicknessType: lineThicknessType,
                                                   isPad: isPad)
        return Float(baseAmount + strokeExpand + strokeExpand)
    }
    
    public static func getLineThicknessDrawingFill(lineThicknessType: RenderLineThicknessType,
                                                   isPad: Bool) -> Float {
        let drawExpand: Float
        if Device.isPad {
            drawExpand = 0.65
        } else {
            drawExpand = 0.4
        }
        let baseAmount = getLineBase(lineThicknessType: lineThicknessType,
                                     isPad: isPad) + drawExpand
        return Float(baseAmount)
    }
    
    public static func getLineThicknessDrawingStroke(lineThicknessType: RenderLineThicknessType,
                                                     isPad: Bool) -> Float {
        let drawExpand: Float
        if Device.isPad {
            drawExpand = 0.65
        } else {
            drawExpand = 0.4
        }
        let baseAmount = getLineBase(lineThicknessType: lineThicknessType,
                                     isPad: isPad) + drawExpand
        let strokeExpand = getLineStrokeExpandBase(lineThicknessType: lineThicknessType,
                                                   isPad: isPad)
        return Float(baseAmount + strokeExpand)
    }
}

//
//  LoopAttributeTypeWithData.swift
//  Jiggle3
//
//  Created by Nicholas Raptis on 5/16/25.
//

import Foundation

@frozen public enum LoopAttributeTypeWithData {
    case timeLineSwatchX(LoopAttributeDataTimeLineSwatch)
    case timeLineSwatchY(LoopAttributeDataTimeLineSwatch)
    case timeLineSwatchScale(LoopAttributeDataTimeLineSwatch)
    case timeLineSwatchRotation(LoopAttributeDataTimeLineSwatch)
    case timeLine(LoopAttributeDataTimeLine)
    case timeLineFrameOffset(LoopAttributeDataTimeLineFrameOffset)
    case timeLineDuration(LoopAttributeDataTimeLineDuration)
}

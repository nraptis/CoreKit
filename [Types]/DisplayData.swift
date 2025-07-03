//
//  DisplayData.swift
//  CoreKit
//
//  Created by Nicholas Raptis on 6/10/25.
//

import Foundation
import simd

public struct DisplayData {
    public let projectionRegular: matrix_float4x4
    public let modelViewRegular: matrix_float4x4
    public let projectionSwivel: matrix_float4x4
    public let modelViewSwivel: matrix_float4x4
    public let projectionPreciseBox: matrix_float4x4
    public let modelViewPreciseBox: matrix_float4x4
    public init(projectionRegular: matrix_float4x4,
                modelViewRegular: matrix_float4x4,
                projectionSwivel: matrix_float4x4,
                modelViewSwivel: matrix_float4x4,
                projectionPreciseBox: matrix_float4x4,
                modelViewPreciseBox: matrix_float4x4) {
        self.projectionRegular = projectionRegular
        self.modelViewRegular = modelViewRegular
        self.projectionSwivel = projectionSwivel
        self.modelViewSwivel = modelViewSwivel
        self.projectionPreciseBox = projectionPreciseBox
        self.modelViewPreciseBox = modelViewPreciseBox
    }
}

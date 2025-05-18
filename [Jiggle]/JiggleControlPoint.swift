//
//  JigglePoint.swift
//  JiggleKit
//
//  Created by Nicholas Raptis on 5/15/25.
//

import Foundation

public class JigglePoint: ControlPoint {
    
    public var selectedTanType = TanTypeOrNone.none
    
    public var renderPointSelected = RenderPointSelectedStrategy.ignore
    public var renderTanInSelected = false
    public var renderTanOutSelected = false
    
    public var renderX = Float(0.0)
    public var renderY = Float(0.0)
    public var renderTanInX = Float(0.0)
    public var renderTanInY = Float(0.0)
    public var renderTanOutX = Float(0.0)
    public var renderTanOutY = Float(0.0)
    public var renderTanNormalInX = Float(0.0)
    public var renderTanNormalInY = Float(-1.0)
    public var renderTanNormalOutX = Float(0.0)
    public var renderTanNormalOutY = Float(-1.0)
}

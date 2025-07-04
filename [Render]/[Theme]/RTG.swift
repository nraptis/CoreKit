//
//  RTG.swift
//  Jiggle3
//
//  Created by Nicky Taylor on 12/22/24.
//

import Foundation

public struct RTG {
    
    nonisolated(unsafe) public static let D = RenderThemeGuideDark()
    nonisolated(unsafe) public static let L = RenderThemeGuideLight()
    
    public static func fillRegSelUnm(index: Int, isDarkModeEnabled: Bool) -> RGBA {
        isDarkModeEnabled ? D.fillRegSelUnm(index: index) : L.fillRegSelUnm(index: index)
    }

    public static func fillRegUnsUnm(index: Int, isDarkModeEnabled: Bool) -> RGBA {
        isDarkModeEnabled ? D.fillRegUnsUnm(index: index) : L.fillRegUnsUnm(index: index)
    }
    
    public static func fillRegSelMod(index: Int, isDarkModeEnabled: Bool) -> RGBA {
        isDarkModeEnabled ? D.fillRegSelMod(index: index) : L.fillRegSelMod(index: index)
    }

    public static func fillRegUnsMod(index: Int, isDarkModeEnabled: Bool) -> RGBA {
        isDarkModeEnabled ? D.fillRegUnsMod(index: index) : L.fillRegUnsMod(index: index)
    }
    
    public static func tanPointFillSel(index: Int, isDarkModeEnabled: Bool) -> RGBA {
        isDarkModeEnabled ? D.tanPointFillSel(index: index) : L.tanPointFillSel(index: index)
    }

    public static func tanPointFillUns(index: Int, isDarkModeEnabled: Bool) -> RGBA {
        isDarkModeEnabled ? D.tanPointFillUns(index: index) : L.tanPointFillUns(index: index)
    }
    
}

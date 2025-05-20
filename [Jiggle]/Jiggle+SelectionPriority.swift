//
//  Jiggle+SelectionPriority.swift
//  Jiggle3
//
//  Created by Nicky Taylor on 12/20/24.
//

import Foundation

public extension Jiggle {
    
    func selectionPriorityGuidesAdd(_ guide: Guide) {
        while selectionPriorityGuides.count <= selectionPriorityGuideCount {
            selectionPriorityGuides.append(guide)
        }
        selectionPriorityGuides[selectionPriorityGuideCount] = guide
        selectionPriorityGuideCount += 1
    }
    
    func selectionPriorityGuidesImplant_FrozenEqualPriority() {
        selectionPriorityGuideCount = 0
        
        for guideIndex in 0..<guideCount {
            let guide = guides[guideIndex]
            selectionPriorityGuidesAdd(guide)
        }
        
        var i = 1
        while i < selectionPriorityGuideCount {
            let holdGuide = selectionPriorityGuides[i]
            var j = i - 1
            while j >= 0, selectionPriorityGuides[j].selectionPriorityNumber > holdGuide.selectionPriorityNumber {
                selectionPriorityGuides[j + 1] = selectionPriorityGuides[j]
                j -= 1
            }
            selectionPriorityGuides[j + 1] = holdGuide
            i += 1
        }
    }
    
    func selectionPriorityGuidesImplant_FrozenLowestPriority() {
        func sortTempGuidesBySelectionPriorityNumber() {
            var i = 1
            while i < guideTempCount {
                let holdGuide = guidesTemp[i]
                var j = i - 1
                while j >= 0, guidesTemp[j].selectionPriorityNumber > holdGuide.selectionPriorityNumber {
                    guidesTemp[j + 1] = guidesTemp[j]
                    j -= 1
                }
                guidesTemp[j + 1] = holdGuide
                i += 1
            }
        }
        
        selectionPriorityGuideCount = 0
        
        guideTempCount = 0
        for guideIndex in 0..<guideCount {
            let guide = guides[guideIndex]
            if guide.isFrozen == true {
                addGuideTemp(guide: guide)
            }
        }
        sortTempGuidesBySelectionPriorityNumber()
        
        for guideIndex in 0..<guideTempCount {
            let guide = guidesTemp[guideIndex]
            selectionPriorityGuidesAdd(guide)
        }
        
        guideTempCount = 0
        for guideIndex in 0..<guideCount {
            let guide = guides[guideIndex]
            if guide.isFrozen == false {
                addGuideTemp(guide: guide)
            }
        }
        sortTempGuidesBySelectionPriorityNumber()
        
        for guideIndex in 0..<guideTempCount {
            let guide = guidesTemp[guideIndex]
            selectionPriorityGuidesAdd(guide)
        }
    }
    
    func selectionPriorityGuidesDownShift() {
        selectionPriorityGuidesImplant_FrozenEqualPriority()
        for guideIndex in 0..<selectionPriorityGuideCount {
            let guide = selectionPriorityGuides[guideIndex]
            guide.selectionPriorityNumber = guideIndex
        }
        selectionPriorityGuideNumber = selectionPriorityGuideCount
        selectionPriorityGuidesImplant_FrozenLowestPriority()
    }
    
}

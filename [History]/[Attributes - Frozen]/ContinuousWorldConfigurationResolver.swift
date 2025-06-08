//
//  HistoryWorldConfigurationResolver.swift
//  CoreKit
//
//  Created by Nicholas Raptis on 5/30/25.
//

import Foundation

struct ContinuousWorldConfigurationResolver {
    
    static func getFivePageType(creationInterfaceConfiguration: any InterfaceConfigurationConforming,
                                currentInterfaceConfiguration: any InterfaceConfigurationConforming,
                                startAttributes: [ContinuousAttribute],
                                endAttributes: [ContinuousAttribute],
                                isUndo: Bool) -> HistoryWorldConfiguration.FivePageType {
        
        var attributeIndex = 0
        let attributeCount = min(startAttributes.count, endAttributes.count)
        
        var pages_with_changes = [Int]()
        var pages_all = [Int]()
        
        while attributeIndex < attributeCount {
            
            let startDatums = startAttributes[attributeIndex].getDatums()
            let endDatums = endAttributes[attributeIndex].getDatums()
            let datumCount = min(startDatums.count, endDatums.count)
            var datumIndex = 0
            while datumIndex < datumCount {
                
                let startDatum = startDatums[datumIndex]
                let endDatum = endDatums[datumIndex]
                let page = startDatum.page
                
                pages_all.append(page)
                if startDatum.value != endDatum.value {
                    pages_with_changes.append(page)
                }
                datumIndex += 1
            }
            attributeIndex += 1
        }
        
        print("pages_with_changes = \(pages_with_changes)")
        print("pages_all = \(pages_all)")
        
        let current_page = currentInterfaceConfiguration.animationContinuousPage
        for page in pages_with_changes {
            if page == current_page {
                print("The page we are on [\(page)] contains change, we can stay here")
                return .dontCare
            }
        }
        
        // Nearest page with changes?
        for offset in 1...4 {
            var backward = current_page - offset
            while backward < 1 { backward += 5 }
            
            var forward = current_page + offset
            while forward > 5 { forward -= 5 }
            
            for page in pages_with_changes {
                if page == backward {
                    print("The nearest page, backwards [\(page)] move to \(backward) contains change, we can move here")
                    
                    if backward == 1 { return .forcePage1 }
                    if backward == 2 { return .forcePage2 }
                    if backward == 3 { return .forcePage3 }
                    if backward == 4 { return .forcePage4 }
                    if backward == 5 { return .forcePage5 }
                }
                
                if page == forward {
                    print("The nearest page, forward [\(page)] move to \(forward) contains change, we can move here")
                    
                    if forward == 1 { return .forcePage1 }
                    if forward == 2 { return .forcePage2 }
                    if forward == 3 { return .forcePage3 }
                    if forward == 4 { return .forcePage4 }
                    if forward == 5 { return .forcePage5 }
                }
            }
            
        }
        
        for page in pages_all {
            if page == current_page {
                print("The page we are on [\(page)] no change, but it's a relavant page, we can stay here")
                return .dontCare
            }
        }
        
        
        for offset in 1...4 {
            let backward = current_page - offset
            let forward = current_page + offset
            
            for page in pages_all {
                if page == backward {
                    print("The nearest page, backwards [\(page)] move to \(backward) no change, but it's a relavant page, we can move here")
                    
                    if backward == 1 { return .forcePage1 }
                    if backward == 2 { return .forcePage2 }
                    if backward == 3 { return .forcePage3 }
                    if backward == 4 { return .forcePage4 }
                    if backward == 5 { return .forcePage5 }
                }
                
                if page == forward {
                    print("The nearest page, forward [\(page)] move to \(forward) no change, but it's a relavant page, we can move here")
                    
                    if forward == 1 { return .forcePage1 }
                    if forward == 2 { return .forcePage2 }
                    if forward == 3 { return .forcePage3 }
                    if forward == 4 { return .forcePage4 }
                    if forward == 5 { return .forcePage5 }
                }
            }
        }
        
        return .dontCare
    }
    
}

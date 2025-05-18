//
//  Ring+TooFewPoints.swift
//  Yo Mamma Be Ugly
//
//  Created by Nick Raptis on 11/22/23.
//

import Foundation

extension Ring {
    func containsTooFewPoints() -> Bool {
        return ringPointCount < 3
    }
}

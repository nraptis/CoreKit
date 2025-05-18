//
//  SelectJiggleResponse.swift
//  TypeKit
//
//  Created by Nicholas Raptis on 5/10/25.
//

import Foundation

@frozen public enum SelectJiggleResponse {
    case invalid
    case valid(SelectJiggleResponseData)
}

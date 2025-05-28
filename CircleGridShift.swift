//
//  CircleGridShift.swift
//  Jiggle3
//
//  Created by Nicholas Raptis on 5/28/25.
//

import Foundation

public struct CircleGridShift: Equatable {
    
    
    public private(set) nonisolated(unsafe) static var shiftX = [[Int]]()
    public private(set) nonisolated(unsafe) static var shiftY = [[Int]]()
    public private(set) nonisolated(unsafe) static var counts = [Int]()
    
    public static let count = 414
    
    
    public static func build() {
        
        shiftX.reserveCapacity(CircleGridShift.count)
        shiftY.reserveCapacity(CircleGridShift.count)
        counts.reserveCapacity(CircleGridShift.count)
        
        //~~~~~~~~
        //Level 0
        shiftX.append([0])
        shiftY.append([0])
        counts.append(1)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 1
        shiftX.append([1, 0, 0, -1])
        shiftY.append([0, 1, -1, 0])
        counts.append(4)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 2
        shiftX.append([1, 1, -1, -1])
        shiftY.append([1, -1, 1, -1])
        counts.append(4)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 3
        shiftX.append([2, 0, 0, -2])
        shiftY.append([0, 2, -2, 0])
        counts.append(4)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 4
        shiftX.append([2, 2, 1, -1, 1, -1, -2, -2])
        shiftY.append([1, -1, 2, 2, -2, -2, 1, -1])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 5
        shiftX.append([2, 2, -2, -2])
        shiftY.append([2, -2, 2, -2])
        counts.append(4)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 6
        shiftX.append([3, 0, 0, -3])
        shiftY.append([0, 3, -3, 0])
        counts.append(4)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 7
        shiftX.append([3, 3, 1, 1, -1, -1, -3, -3])
        shiftY.append([1, -1, 3, -3, 3, -3, 1, -1])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 8
        shiftX.append([3, 2, 2, -3, 3, -2, -2, -3])
        shiftY.append([2, 3, -3, 2, -2, 3, -3, -2])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 9
        shiftX.append([4, 0, 0, -4])
        shiftY.append([0, 4, -4, 0])
        counts.append(4)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 10
        shiftX.append([4, 4, 1, 1, -1, -1, -4, -4])
        shiftY.append([1, -1, 4, -4, 4, -4, 1, -1])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 11
        shiftX.append([3, 3, -3, -3])
        shiftY.append([3, -3, 3, -3])
        counts.append(4)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 12
        shiftX.append([4, 2, 2, -4, 4, -2, -2, -4])
        shiftY.append([2, 4, -4, 2, -2, 4, -4, -2])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 13
        shiftX.append([4, 4, 3, 3, -3, -3, -4, -4, 5, 0, 0, -5])
        shiftY.append([3, -3, 4, -4, 4, -4, 3, -3, 0, 5, -5, 0])
        counts.append(12)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 14
        shiftX.append([5, 5, 1, 1, -1, -1, -5, -5])
        shiftY.append([1, -1, 5, -5, 5, -5, 1, -1])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 15
        shiftX.append([5, 2, 2, -5, 5, -2, -2, -5])
        shiftY.append([2, 5, -5, 2, -2, 5, -5, -2])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 16
        shiftX.append([4, 4, -4, -4])
        shiftY.append([4, -4, 4, -4])
        counts.append(4)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 17
        shiftX.append([5, 5, 3, 3, -3, -3, -5, -5])
        shiftY.append([3, -3, 5, -5, 5, -5, 3, -3])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 18
        shiftX.append([6, 0, 0, -6])
        shiftY.append([0, 6, -6, 0])
        counts.append(4)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 19
        shiftX.append([6, 6, 1, -1, 1, -1, -6, -6])
        shiftY.append([1, -1, 6, 6, -6, -6, 1, -1])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 20
        shiftX.append([6, 2, 6, -2, 2, -6, -2, -6])
        shiftY.append([2, 6, -2, 6, -6, 2, -6, -2])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 21
        shiftX.append([5, 5, 4, 4, -4, -4, -5, -5])
        shiftY.append([4, -4, 5, -5, 5, -5, 4, -4])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 22
        shiftX.append([6, 6, 3, -3, 3, -3, -6, -6])
        shiftY.append([3, -3, 6, 6, -6, -6, 3, -3])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 23
        shiftX.append([7, 0, 0, -7])
        shiftY.append([0, 7, -7, 0])
        counts.append(4)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 24
        shiftX.append([7, 7, 1, 1, -1, -1, -7, -7, 5, 5, -5, -5])
        shiftY.append([1, -1, 7, -7, 7, -7, 1, -1, 5, -5, 5, -5])
        counts.append(12)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 25
        shiftX.append([6, 6, 4, -4, 4, -4, -6, -6])
        shiftY.append([4, -4, 6, 6, -6, -6, 4, -4])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 26
        shiftX.append([7, 2, 2, -7, 7, -2, -2, -7])
        shiftY.append([2, 7, -7, 2, -2, 7, -7, -2])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 27
        shiftX.append([7, 7, 3, 3, -3, -3, -7, -7])
        shiftY.append([3, -3, 7, -7, 7, -7, 3, -3])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 28
        shiftX.append([6, 6, 5, -5, 5, -5, -6, -6])
        shiftY.append([5, -5, 6, 6, -6, -6, 5, -5])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 29
        shiftX.append([8, 0, 0, -8])
        shiftY.append([0, 8, -8, 0])
        counts.append(4)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 30
        shiftX.append([8, 8, 1, 1, -1, -1, -8, -8, 7, 7, 4, 4, -4, -4, -7, -7])
        shiftY.append([1, -1, 8, -8, 8, -8, 1, -1, 4, -4, 7, -7, 7, -7, 4, -4])
        counts.append(16)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 31
        shiftX.append([8, 2, 2, -8, 8, -2, -2, -8])
        shiftY.append([2, 8, -8, 2, -2, 8, -8, -2])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 32
        shiftX.append([6, 6, -6, -6])
        shiftY.append([6, -6, 6, -6])
        counts.append(4)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 33
        shiftX.append([8, 8, 3, 3, -3, -3, -8, -8])
        shiftY.append([3, -3, 8, -8, 8, -8, 3, -3])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 34
        shiftX.append([7, 7, 5, 5, -5, -5, -7, -7])
        shiftY.append([5, -5, 7, -7, 7, -7, 5, -5])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 35
        shiftX.append([8, 8, 4, 4, -4, -4, -8, -8])
        shiftY.append([4, -4, 8, -8, 8, -8, 4, -4])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 36
        shiftX.append([9, 0, 0, -9])
        shiftY.append([0, 9, -9, 0])
        counts.append(4)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 37
        shiftX.append([9, 9, 1, 1, -1, -1, -9, -9])
        shiftY.append([1, -1, 9, -9, 9, -9, 1, -1])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 38
        shiftX.append([7, 6, 6, -7, 9, 9, 2, 2, -2, -2, -9, -9, 7, -6, -6, -7])
        shiftY.append([6, 7, -7, 6, 2, -2, 9, -9, 9, -9, 2, -2, -6, 7, -7, -6])
        counts.append(16)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 39
        shiftX.append([8, 8, 5, 5, -5, -5, -8, -8])
        shiftY.append([5, -5, 8, -8, 8, -8, 5, -5])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 40
        shiftX.append([9, 9, 3, 3, -3, -3, -9, -9])
        shiftY.append([3, -3, 9, -9, 9, -9, 3, -3])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 41
        shiftX.append([9, 9, 4, 4, -4, -4, -9, -9])
        shiftY.append([4, -4, 9, -9, 9, -9, 4, -4])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 42
        shiftX.append([7, 7, -7, -7])
        shiftY.append([7, -7, 7, -7])
        counts.append(4)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 43
        shiftX.append([10, 8, 6, 6, 0, -8, 8, -6, -6, -8, 0, -10])
        shiftY.append([0, 6, 8, -8, 10, 6, -6, 8, -8, -6, -10, 0])
        counts.append(12)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 44
        shiftX.append([10, 10, 1, -1, 1, -1, -10, -10])
        shiftY.append([1, -1, 10, 10, -10, -10, 1, -1])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 45
        shiftX.append([10, 10, 2, -2, 2, -10, -2, -10])
        shiftY.append([2, -2, 10, 10, -10, 2, -10, -2])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 46
        shiftX.append([9, 9, 5, 5, -5, -5, -9, -9])
        shiftY.append([5, -5, 9, -9, 9, -9, 5, -5])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 47
        shiftX.append([10, 10, 3, -3, 3, -3, -10, -10])
        shiftY.append([3, -3, 10, 10, -10, -10, 3, -3])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 48
        shiftX.append([8, 8, 7, 7, -7, -7, -8, -8])
        shiftY.append([7, -7, 8, -8, 8, -8, 7, -7])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 49
        shiftX.append([10, 10, 4, -4, 4, -4, -10, -10])
        shiftY.append([4, -4, 10, 10, -10, -10, 4, -4])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 50
        shiftX.append([9, 6, 6, -9, 9, -6, -6, -9])
        shiftY.append([6, 9, -9, 6, -6, 9, -9, -6])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 51
        shiftX.append([11, 0, 0, -11])
        shiftY.append([0, 11, -11, 0])
        counts.append(4)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 52
        shiftX.append([11, 11, 1, 1, -1, -1, -11, -11])
        shiftY.append([1, -1, 11, -11, 11, -11, 1, -1])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 53
        shiftX.append([10, 10, 5, -5, 11, 2, 2, -11, 11, -2, -2, -11, 5, -5, -10, -10])
        shiftY.append([5, -5, 10, 10, 2, 11, -11, 2, -2, 11, -11, -2, -10, -10, 5, -5])
        counts.append(16)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 54
        shiftX.append([8, 8, -8, -8])
        shiftY.append([8, -8, 8, -8])
        counts.append(4)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 55
        shiftX.append([11, 11, 9, 9, 7, 7, 3, 3, -3, -3, -7, -7, -9, -9, -11, -11])
        shiftY.append([3, -3, 7, -7, 9, -9, 11, -11, 11, -11, 9, -9, 7, -7, 3, -3])
        counts.append(16)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 56
        shiftX.append([10, 6, 10, -6, 6, -10, -6, -10])
        shiftY.append([6, 10, -6, 10, -10, 6, -10, -6])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 57
        shiftX.append([11, 11, 4, 4, -4, -4, -11, -11])
        shiftY.append([4, -4, 11, -11, 11, -11, 4, -4])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 58
        shiftX.append([12, 0, 0, -12])
        shiftY.append([0, 12, -12, 0])
        counts.append(4)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 59
        shiftX.append([12, 12, 1, -1, 9, 9, 8, 8, -8, -8, -9, -9, 1, -1, -12, -12])
        shiftY.append([1, -1, 12, 12, 8, -8, 9, -9, 9, -9, 8, -8, -12, -12, 1, -1])
        counts.append(16)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 60
        shiftX.append([11, 11, 5, 5, -5, -5, -11, -11])
        shiftY.append([5, -5, 11, -11, 11, -11, 5, -5])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 61
        shiftX.append([12, 2, 12, -2, 2, -12, -2, -12])
        shiftY.append([2, 12, -2, 12, -12, 2, -12, -2])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 62
        shiftX.append([10, 10, 7, -7, 7, -7, -10, -10])
        shiftY.append([7, -7, 10, 10, -10, -10, 7, -7])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 63
        shiftX.append([12, 12, 3, -3, 3, -3, -12, -12])
        shiftY.append([3, -3, 12, 12, -12, -12, 3, -3])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 64
        shiftX.append([11, 6, 6, -11, 11, -6, -6, -11])
        shiftY.append([6, 11, -11, 6, -6, 11, -11, -6])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 65
        shiftX.append([12, 12, 4, -4, 4, -4, -12, -12])
        shiftY.append([4, -4, 12, 12, -12, -12, 4, -4])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 66
        shiftX.append([9, 9, -9, -9])
        shiftY.append([9, -9, 9, -9])
        counts.append(4)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 67
        shiftX.append([10, 10, 8, -8, 8, -8, -10, -10])
        shiftY.append([8, -8, 10, 10, -10, -10, 8, -8])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 68
        shiftX.append([12, 12, 5, -5, 13, 0, 0, -13, 5, -5, -12, -12])
        shiftY.append([5, -5, 12, 12, 0, 13, -13, 0, -12, -12, 5, -5])
        counts.append(12)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 69
        shiftX.append([13, 13, 11, 11, 7, 7, 1, 1, -1, -1, -7, -7, -11, -11, -13, -13])
        shiftY.append([1, -1, 7, -7, 11, -11, 13, -13, 13, -13, 11, -11, 7, -7, 1, -1])
        counts.append(16)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 70
        shiftX.append([13, 13, 2, 2, -2, -2, -13, -13])
        shiftY.append([2, -2, 13, -13, 13, -13, 2, -2])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 71
        shiftX.append([13, 13, 3, 3, -3, -3, -13, -13])
        shiftY.append([3, -3, 13, -13, 13, -13, 3, -3])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 72
        shiftX.append([12, 6, 12, -6, 6, -12, -6, -12])
        shiftY.append([6, 12, -6, 12, -12, 6, -12, -6])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 73
        shiftX.append([10, 10, 9, -9, 9, -9, -10, -10])
        shiftY.append([9, -9, 10, 10, -10, -10, 9, -9])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 74
        shiftX.append([13, 13, 11, 11, 8, 8, 4, 4, -4, -4, -8, -8, -11, -11, -13, -13])
        shiftY.append([4, -4, 8, -8, 11, -11, 13, -13, 13, -13, 11, -11, 8, -8, 4, -4])
        counts.append(16)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 75
        shiftX.append([12, 12, 7, -7, 7, -7, -12, -12])
        shiftY.append([7, -7, 12, 12, -12, -12, 7, -7])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 76
        shiftX.append([13, 13, 5, 5, -5, -5, -13, -13])
        shiftY.append([5, -5, 13, -13, 13, -13, 5, -5])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 77
        shiftX.append([14, 0, 0, -14])
        shiftY.append([0, 14, -14, 0])
        counts.append(4)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 78
        shiftX.append([14, 14, 1, -1, 1, -1, -14, -14])
        shiftY.append([1, -1, 14, 14, -14, -14, 1, -1])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 79
        shiftX.append([10, 14, 2, 14, -2, 10, -10, 2, -14, -2, -14, -10])
        shiftY.append([10, 2, 14, -2, 14, -10, 10, -14, 2, -14, -2, -10])
        counts.append(12)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 80
        shiftX.append([11, 11, 9, 9, -9, -9, -11, -11])
        shiftY.append([9, -9, 11, -11, 11, -11, 9, -9])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 81
        shiftX.append([14, 14, 3, -3, 13, 6, 6, -13, 13, -6, -6, -13, 3, -3, -14, -14])
        shiftY.append([3, -3, 14, 14, 6, 13, -13, 6, -6, 13, -13, -6, -14, -14, 3, -3])
        counts.append(16)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 82
        shiftX.append([12, 12, 8, -8, 8, -8, -12, -12])
        shiftY.append([8, -8, 12, 12, -12, -12, 8, -8])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 83
        shiftX.append([14, 14, 4, -4, 4, -4, -14, -14])
        shiftY.append([4, -4, 14, 14, -14, -14, 4, -4])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 84
        shiftX.append([13, 13, 7, 7, -7, -7, -13, -13])
        shiftY.append([7, -7, 13, -13, 13, -13, 7, -7])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 85
        shiftX.append([14, 14, 5, -5, 11, 10, 10, -11, 11, -10, -10, -11, 5, -5, -14, -14])
        shiftY.append([5, -5, 14, 14, 10, 11, -11, 10, -10, 11, -11, -10, -14, -14, 5, -5])
        counts.append(16)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 86
        shiftX.append([12, 12, 9, -9, 15, 0, 9, -9, -12, -12, 0, -15])
        shiftY.append([9, -9, 12, 12, 0, 15, -12, -12, 9, -9, -15, 0])
        counts.append(12)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 87
        shiftX.append([15, 15, 1, -1, 1, -1, -15, -15])
        shiftY.append([1, -1, 15, 15, -15, -15, 1, -1])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 88
        shiftX.append([15, 15, 2, -2, 2, -2, -15, -15])
        shiftY.append([2, -2, 15, 15, -15, -15, 2, -2])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 89
        shiftX.append([14, 6, 14, -6, 6, -14, -6, -14])
        shiftY.append([6, 14, -6, 14, -14, 6, -14, -6])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 90
        shiftX.append([13, 13, 8, 8, -8, -8, -13, -13])
        shiftY.append([8, -8, 13, -13, 13, -13, 8, -8])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 91
        shiftX.append([15, 15, 3, -3, 3, -3, -15, -15])
        shiftY.append([3, -3, 15, 15, -15, -15, 3, -3])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 92
        shiftX.append([15, 15, 4, -4, 4, -4, -15, -15])
        shiftY.append([4, -4, 15, 15, -15, -15, 4, -4])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 93
        shiftX.append([11, 11, -11, -11])
        shiftY.append([11, -11, 11, -11])
        counts.append(4)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 94
        shiftX.append([12, 10, 12, -10, 10, -12, -10, -12])
        shiftY.append([10, 12, -10, 12, -12, 10, -12, -10])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 95
        shiftX.append([14, 14, 7, -7, 7, -7, -14, -14])
        shiftY.append([7, -7, 14, 14, -14, -14, 7, -7])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 96
        shiftX.append([15, 15, 13, 13, 9, 9, 5, -5, -9, -9, -13, -13, 5, -5, -15, -15])
        shiftY.append([5, -5, 9, -9, 13, -13, 15, 15, 13, -13, 9, -9, -15, -15, 5, -5])
        counts.append(16)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 97
        shiftX.append([16, 0, 0, -16])
        shiftY.append([0, 16, -16, 0])
        counts.append(4)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 98
        shiftX.append([16, 16, 1, -1, 1, -1, -16, -16])
        shiftY.append([1, -1, 16, 16, -16, -16, 1, -1])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 99
        shiftX.append([14, 14, 8, -8, 16, 2, 16, -2, 8, 2, -8, -14, -14, -16, -2, -16])
        shiftY.append([8, -8, 14, 14, 2, 16, -2, 16, -14, -16, -14, 8, -8, 2, -16, -2])
        counts.append(16)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 100
        shiftX.append([15, 6, 15, -6, 6, -15, -6, -15])
        shiftY.append([6, 15, -6, 15, -15, 6, -15, -6])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 101
        shiftX.append([12, 12, 11, -11, 16, 16, 3, -3, 11, 3, -3, -11, -12, -12, -16, -16])
        shiftY.append([11, -11, 12, 12, 3, -3, 16, 16, -12, -16, -16, -12, 11, -11, 3, -3])
        counts.append(16)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 102
        shiftX.append([13, 10, 10, -13, 13, -10, -10, -13])
        shiftY.append([10, 13, -13, 10, -10, 13, -13, -10])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 103
        shiftX.append([16, 16, 4, -4, 4, -4, -16, -16])
        shiftY.append([4, -4, 16, 16, -16, -16, 4, -4])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 104
        shiftX.append([15, 15, 7, -7, 7, -7, -15, -15])
        shiftY.append([7, -7, 15, 15, -15, -15, 7, -7])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 105
        shiftX.append([14, 14, 9, -9, 9, -9, -14, -14])
        shiftY.append([9, -9, 14, 14, -14, -14, 9, -9])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 106
        shiftX.append([16, 16, 5, -5, 5, -5, -16, -16])
        shiftY.append([5, -5, 16, 16, -16, -16, 5, -5])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 107
        shiftX.append([12, 12, -12, -12])
        shiftY.append([12, -12, 12, -12])
        counts.append(4)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 108
        shiftX.append([17, 15, 15, 8, 0, 0, -8, -17, 8, -8, -15, -15])
        shiftY.append([0, 8, -8, 15, 17, -17, 15, 0, -15, -15, 8, -8])
        counts.append(12)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 109
        shiftX.append([17, 17, 1, 1, -1, -1, -17, -17, 13, 13, 11, 11, -11, -11, -13, -13])
        shiftY.append([1, -1, 17, -17, 17, -17, 1, -1, 11, -11, 13, -13, 13, -13, 11, -11])
        counts.append(16)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 110
        shiftX.append([16, 16, 6, -6, 6, -6, -16, -16])
        shiftY.append([6, -6, 16, 16, -16, -16, 6, -6])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 111
        shiftX.append([17, 2, 2, -17, 17, -2, -2, -17])
        shiftY.append([2, 17, -17, 2, -2, 17, -17, -2])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 112
        shiftX.append([14, 10, 14, 10, -10, -14, -10, -14])
        shiftY.append([10, 14, -10, -14, 14, 10, -14, -10])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 113
        shiftX.append([17, 17, 3, 3, -3, -3, -17, -17])
        shiftY.append([3, -3, 17, -17, 17, -17, 3, -3])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 114
        shiftX.append([17, 17, 16, 16, 7, 4, 4, -4, -4, -7, -17, -17, 7, -7, -16, -16])
        shiftY.append([4, -4, 7, -7, 16, 17, -17, 17, -17, 16, 4, -4, -16, -16, 7, -7])
        counts.append(16)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 115
        shiftX.append([15, 15, 9, -9, 9, -9, -15, -15])
        shiftY.append([9, -9, 15, 15, -15, -15, 9, -9])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 116
        shiftX.append([13, 12, 12, -13, 13, -12, -12, -13])
        shiftY.append([12, 13, -13, 12, -12, 13, -13, -12])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 117
        shiftX.append([17, 17, 5, 5, -5, -5, -17, -17])
        shiftY.append([5, -5, 17, -17, 17, -17, 5, -5])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 118
        shiftX.append([14, 14, 11, -11, 11, -11, -14, -14])
        shiftY.append([11, -11, 14, 14, -14, -14, 11, -11])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 119
        shiftX.append([16, 16, 8, -8, 8, -8, -16, -16])
        shiftY.append([8, -8, 16, 16, -16, -16, 8, -8])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 120
        shiftX.append([18, 0, 0, -18])
        shiftY.append([0, 18, -18, 0])
        counts.append(4)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 121
        shiftX.append([17, 6, 6, -17, 17, 15, 10, -6, -6, -17, 18, 18, 15, 10, 1, 1, -1, -1, -10, -15, -18, -18, -10, -15])
        shiftY.append([6, 17, -17, 6, -6, 10, 15, 17, -17, -6, 1, -1, -10, -15, 18, -18, 18, -18, 15, 10, 1, -1, -15, -10])
        counts.append(24)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 122
        shiftX.append([18, 18, 2, 2, -2, -2, -18, -18])
        shiftY.append([2, -2, 18, -18, 18, -18, 2, -2])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 123
        shiftX.append([18, 18, 3, 3, -3, -3, -18, -18])
        shiftY.append([3, -3, 18, -18, 18, -18, 3, -3])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 124
        shiftX.append([16, 16, 9, -9, 9, -9, -16, -16])
        shiftY.append([9, -9, 16, 16, -16, -16, 9, -9])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 125
        shiftX.append([17, 17, 13, 13, 7, 7, -7, -7, -13, -13, -17, -17])
        shiftY.append([7, -7, 13, -13, 17, -17, 17, -17, 13, -13, 7, -7])
        counts.append(12)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 126
        shiftX.append([14, 12, 14, 12, -12, -14, 18, 18, 4, 4, -4, -4, -12, -14, -18, -18])
        shiftY.append([12, 14, -12, -14, 14, 12, 4, -4, 18, -18, 18, -18, -14, -12, 4, -4])
        counts.append(16)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 127
        shiftX.append([15, 15, 11, -11, 11, -11, -15, -15])
        shiftY.append([11, -11, 15, 15, -15, -15, 11, -11])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 128
        shiftX.append([18, 18, 5, 5, -5, -5, -18, -18])
        shiftY.append([5, -5, 18, -18, 18, -18, 5, -5])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 129
        shiftX.append([17, 17, 8, 8, -8, -8, -17, -17])
        shiftY.append([8, -8, 17, -17, 17, -17, 8, -8])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 130
        shiftX.append([16, 16, 10, 10, -10, -16, -10, -16])
        shiftY.append([10, -10, 16, -16, 16, 10, -16, -10])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 131
        shiftX.append([18, 6, 6, -18, 18, -6, -6, -18])
        shiftY.append([6, 18, -18, 6, -6, 18, -18, -6])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 132
        shiftX.append([19, 0, 0, -19])
        shiftY.append([0, 19, -19, 0])
        counts.append(4)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 133
        shiftX.append([19, 19, 1, -1, 1, -1, -19, -19])
        shiftY.append([1, -1, 19, 19, -19, -19, 1, -1])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 134
        shiftX.append([19, 14, 14, 13, 2, -13, 19, -2, 13, 2, -13, -14, -14, -19, -2, -19])
        shiftY.append([2, 13, -13, 14, 19, 14, -2, 19, -14, -19, -14, 13, -13, 2, -19, -2])
        counts.append(16)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 135
        shiftX.append([15, 12, 15, 12, -12, -15, -12, -15])
        shiftY.append([12, 15, -12, -15, 15, 12, -15, -12])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 136
        shiftX.append([19, 19, 17, 17, 9, 9, 3, -3, -9, -9, -17, -17, 3, -3, -19, -19])
        shiftY.append([3, -3, 9, -9, 17, -17, 19, 19, 17, -17, 9, -9, -19, -19, 3, -3])
        counts.append(16)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 137
        shiftX.append([18, 18, 7, 7, -7, -7, -18, -18])
        shiftY.append([7, -7, 18, -18, 18, -18, 7, -7])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 138
        shiftX.append([19, 19, 16, 16, 11, 4, -4, -11, 11, -11, -16, -16, 4, -4, -19, -19])
        shiftY.append([4, -4, 11, -11, 16, 19, 19, 16, -16, -16, 11, -11, -19, -19, 4, -4])
        counts.append(16)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 139
        shiftX.append([19, 19, 5, -5, 5, -5, -19, -19])
        shiftY.append([5, -5, 19, 19, -19, -19, 5, -5])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 140
        shiftX.append([18, 18, 8, 8, -8, -8, -18, -18])
        shiftY.append([8, -8, 18, -18, 18, -18, 8, -8])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 141
        shiftX.append([17, 17, 10, 10, -10, -10, -17, -17])
        shiftY.append([10, -10, 17, -17, 17, -17, 10, -10])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 142
        shiftX.append([14, 14, -14, -14])
        shiftY.append([14, -14, 14, -14])
        counts.append(4)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 143
        shiftX.append([15, 15, 13, -13, 13, -13, -15, -15])
        shiftY.append([13, -13, 15, 15, -15, -15, 13, -13])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 144
        shiftX.append([19, 6, 19, -6, 6, -19, -6, -19])
        shiftY.append([6, 19, -6, 19, -19, 6, -19, -6])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 145
        shiftX.append([16, 12, 12, -16, 20, 16, 0, 0, -12, -20, -12, -16])
        shiftY.append([12, 16, -16, 12, 0, -12, 20, -20, 16, 0, -16, -12])
        counts.append(12)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 146
        shiftX.append([20, 20, 1, 1, -1, -1, -20, -20])
        shiftY.append([1, -1, 20, -20, 20, -20, 1, -1])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 147
        shiftX.append([20, 20, 2, 2, -2, -2, -20, -20])
        shiftY.append([2, -2, 20, -20, 20, -20, 2, -2])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 148
        shiftX.append([18, 18, 9, 9, -9, -9, -18, -18])
        shiftY.append([9, -9, 18, -18, 18, -18, 9, -9])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 149
        shiftX.append([20, 20, 3, 3, -3, -3, -20, -20])
        shiftY.append([3, -3, 20, -20, 20, -20, 3, -3])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 150
        shiftX.append([19, 19, 17, 17, 11, 11, 7, -7, -11, -11, -17, -17, 7, -7, -19, -19])
        shiftY.append([7, -7, 11, -11, 17, -17, 19, 19, 17, -17, 11, -11, -19, -19, 7, -7])
        counts.append(16)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 151
        shiftX.append([20, 20, 4, 4, -4, -4, -20, -20])
        shiftY.append([4, -4, 20, -20, 20, -20, 4, -4])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 152
        shiftX.append([15, 14, 15, 14, -14, -15, -14, -15])
        shiftY.append([14, 15, -14, -15, 15, 14, -15, -14])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 153
        shiftX.append([18, 18, 10, 10, -10, -10, -18, -18])
        shiftY.append([10, -10, 18, -18, 18, -18, 10, -10])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 154
        shiftX.append([19, 19, 16, 16, 13, 8, -8, -13, 20, 20, 13, 8, 5, 5, -5, -5, -8, -13, -16, -16, -19, -19, -20, -20])
        shiftY.append([8, -8, 13, -13, 16, 19, 19, 16, 5, -5, -16, -19, 20, -20, 20, -20, -19, -16, 13, -13, 8, -8, 5, -5])
        counts.append(24)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 155
        shiftX.append([17, 12, 12, -17, 17, -12, -12, -17])
        shiftY.append([12, 17, -17, 12, -12, 17, -17, -12])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 156
        shiftX.append([20, 6, 6, -20, 20, -6, -6, -20])
        shiftY.append([6, 20, -20, 6, -6, 20, -20, -6])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 157
        shiftX.append([21, 0, 0, -21])
        shiftY.append([0, 21, -21, 0])
        counts.append(4)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 158
        shiftX.append([21, 21, 1, 1, -1, -1, -21, -21, 19, 19, 9, -9, 9, -9, -19, -19])
        shiftY.append([1, -1, 21, -21, 21, -21, 1, -1, 9, -9, 19, 19, -19, -19, 9, -9])
        counts.append(16)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 159
        shiftX.append([21, 2, 2, -21, 21, 18, 18, 11, 11, -2, -2, -11, -11, -18, -18, -21])
        shiftY.append([2, 21, -21, 2, -2, 11, -11, 18, -18, 21, -21, 18, -18, 11, -11, -2])
        counts.append(16)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 160
        shiftX.append([20, 20, 7, 7, -7, -7, -20, -20])
        shiftY.append([7, -7, 20, -20, 20, -20, 7, -7])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 161
        shiftX.append([21, 21, 15, 3, 3, -3, -3, -21, -21, 15, -15, -15])
        shiftY.append([3, -3, 15, 21, -21, 21, -21, 3, -3, -15, 15, -15])
        counts.append(12)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 162
        shiftX.append([16, 14, 16, 14, -14, -14, -16, -16])
        shiftY.append([14, 16, -14, -16, 16, -16, 14, -14])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 163
        shiftX.append([21, 21, 4, 4, -4, -4, -21, -21])
        shiftY.append([4, -4, 21, -21, 21, -21, 4, -4])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 164
        shiftX.append([17, 17, 13, 13, -13, -13, -17, -17])
        shiftY.append([13, -13, 17, -17, 17, -17, 13, -13])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 165
        shiftX.append([19, 10, 19, 10, -10, -19, -10, -19])
        shiftY.append([10, 19, -10, -19, 19, 10, -19, -10])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 166
        shiftX.append([20, 20, 8, 8, -8, -8, -20, -20])
        shiftY.append([8, -8, 20, -20, 20, -20, 8, -8])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 167
        shiftX.append([21, 21, 5, 5, -5, -5, -21, -21])
        shiftY.append([5, -5, 21, -21, 21, -21, 5, -5])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 168
        shiftX.append([18, 12, 12, -18, 18, -12, -12, -18])
        shiftY.append([12, 18, -18, 12, -12, 18, -18, -12])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 169
        shiftX.append([21, 6, 6, -21, 21, -6, -6, -21])
        shiftY.append([6, 21, -21, 6, -6, 21, -21, -6])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 170
        shiftX.append([16, 15, 20, 20, 16, 15, 9, 9, -9, -9, -15, -16, -20, -20, -15, -16])
        shiftY.append([15, 16, 9, -9, -15, -16, 20, -20, 20, -20, 16, 15, 9, -9, -16, -15])
        counts.append(16)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 171
        shiftX.append([19, 19, 11, -11, 11, -11, -19, -19])
        shiftY.append([11, -11, 19, 19, -19, -19, 11, -11])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 172
        shiftX.append([22, 0, 0, -22])
        shiftY.append([0, 22, -22, 0])
        counts.append(4)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 173
        shiftX.append([17, 14, 14, -17, 22, 22, 17, 1, 1, -1, -1, -14, -14, -17, -22, -22])
        shiftY.append([14, 17, -17, 14, 1, -1, -14, 22, -22, 22, -22, 17, -17, -14, 1, -1])
        counts.append(16)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 174
        shiftX.append([22, 22, 2, 2, -2, -2, -22, -22])
        shiftY.append([2, -2, 22, -22, 22, -22, 2, -2])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 175
        shiftX.append([21, 21, 7, 7, -7, -7, -21, -21])
        shiftY.append([7, -7, 21, -21, 21, -21, 7, -7])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 176
        shiftX.append([22, 22, 18, 18, 13, 13, 3, 3, -3, -3, -13, -13, -18, -18, -22, -22])
        shiftY.append([3, -3, 13, -13, 18, -18, 22, -22, 22, -22, 18, -18, 13, -13, 3, -3])
        counts.append(16)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 177
        shiftX.append([22, 22, 20, 20, 10, 10, 4, 4, -4, -4, -10, -10, -20, -20, -22, -22])
        shiftY.append([4, -4, 10, -10, 20, -20, 22, -22, 22, -22, 20, -20, 10, -10, 4, -4])
        counts.append(16)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 178
        shiftX.append([21, 21, 19, 12, 8, 8, -8, -8, -21, -21, 19, -12, 12, -19, -12, -19])
        shiftY.append([8, -8, 12, 19, 21, -21, 21, -21, 8, -8, -12, 19, -19, 12, -19, -12])
        counts.append(16)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 179
        shiftX.append([22, 22, 5, 5, -5, -5, -22, -22])
        shiftY.append([5, -5, 22, -22, 22, -22, 5, -5])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 180
        shiftX.append([16, 16, -16, -16])
        shiftY.append([16, -16, 16, -16])
        counts.append(4)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 181
        shiftX.append([17, 15, 15, -17, 17, -15, -15, -17])
        shiftY.append([15, 17, -17, 15, -15, 17, -17, -15])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 182
        shiftX.append([22, 18, 14, 14, 6, 6, -18, -22, 22, 18, -6, -6, -14, -14, -18, -22])
        shiftY.append([6, 14, 18, -18, 22, -22, 14, 6, -6, -14, 22, -22, 18, -18, -14, -6])
        counts.append(16)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 183
        shiftX.append([20, 20, 11, 11, -11, -11, -20, -20])
        shiftY.append([11, -11, 20, -20, 20, -20, 11, -11])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 184
        shiftX.append([21, 21, 9, 9, -9, -9, -21, -21])
        shiftY.append([9, -9, 21, -21, 21, -21, 9, -9])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 185
        shiftX.append([23, 0, 0, -23])
        shiftY.append([0, 23, -23, 0])
        counts.append(4)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 186
        shiftX.append([23, 23, 1, -1, 19, 19, 13, -13, 13, 1, -1, -13, -19, -19, -23, -23])
        shiftY.append([1, -1, 23, 23, 13, -13, 19, 19, -19, -23, -23, -19, 13, -13, 1, -1])
        counts.append(16)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 187
        shiftX.append([23, 2, 23, 22, 22, 7, 7, -2, -7, -7, -22, -22, 2, -2, -23, -23])
        shiftY.append([2, 23, -2, 7, -7, 22, -22, 23, 22, -22, 7, -7, -23, -23, 2, -2])
        counts.append(16)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 188
        shiftX.append([23, 23, 3, -3, 3, -3, -23, -23])
        shiftY.append([3, -3, 23, 23, -23, -23, 3, -3])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 189
        shiftX.append([21, 10, 10, -21, 21, -10, -10, -21])
        shiftY.append([10, 21, -21, 10, -10, 21, -21, -10])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 190
        shiftX.append([20, 12, 12, -20, 20, -12, -12, -20])
        shiftY.append([12, 20, -20, 12, -12, 20, -20, -12])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 191
        shiftX.append([23, 23, 17, 16, 16, 4, -4, -17, 17, -16, -16, -17, 4, -4, -23, -23])
        shiftY.append([4, -4, 16, 17, -17, 23, 23, 16, -16, 17, -17, -16, -23, -23, 4, -4])
        counts.append(16)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 192
        shiftX.append([22, 22, 8, 8, -8, -8, -22, -22])
        shiftY.append([8, -8, 22, -22, 22, -22, 8, -8])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 193
        shiftX.append([18, 15, 15, -18, 18, -15, -15, -18])
        shiftY.append([15, 18, -18, 15, -15, 18, -18, -15])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 194
        shiftX.append([23, 23, 5, -5, 5, -5, -23, -23])
        shiftY.append([5, -5, 23, 23, -23, -23, 5, -5])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 195
        shiftX.append([19, 14, 19, 14, -14, -19, -14, -19])
        shiftY.append([14, 19, -14, -19, 19, 14, -19, -14])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 196
        shiftX.append([21, 21, 11, 11, -11, -11, -21, -21])
        shiftY.append([11, -11, 21, -21, 21, -21, 11, -11])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 197
        shiftX.append([23, 6, 23, 22, 22, 9, 9, -6, -9, -9, -22, -22, 6, -6, -23, -23])
        shiftY.append([6, 23, -6, 9, -9, 22, -22, 23, 22, -22, 9, -9, -23, -23, 6, -6])
        counts.append(16)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 198
        shiftX.append([20, 20, 13, 13, -13, -13, -20, -20])
        shiftY.append([13, -13, 20, -20, 20, -20, 13, -13])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 199
        shiftX.append([24, 0, 0, -24])
        shiftY.append([0, 24, -24, 0])
        counts.append(4)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 200
        shiftX.append([24, 24, 1, 1, -1, -1, -24, -24])
        shiftY.append([1, -1, 24, -24, 24, -24, 1, -1])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 201
        shiftX.append([23, 23, 17, 17, 7, -7, -17, -17, 7, -7, -23, -23])
        shiftY.append([7, -7, 17, -17, 23, 23, 17, -17, -23, -23, 7, -7])
        counts.append(12)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 202
        shiftX.append([24, 24, 18, 18, 16, 16, 2, 2, -2, -2, -16, -16, -18, -18, -24, -24])
        shiftY.append([2, -2, 16, -16, 18, -18, 24, -24, 24, -24, 18, -18, 16, -16, 2, -2])
        counts.append(16)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 203
        shiftX.append([22, 10, 10, -22, 22, -10, -10, -22])
        shiftY.append([10, 22, -22, 10, -10, 22, -22, -10])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 204
        shiftX.append([24, 24, 21, 21, 12, 12, 3, 3, -3, -3, -12, -12, -21, -21, -24, -24])
        shiftY.append([3, -3, 12, -12, 21, -21, 24, -24, 24, -24, 21, -21, 12, -12, 3, -3])
        counts.append(16)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 205
        shiftX.append([19, 15, 19, 15, -15, -19, -15, -19])
        shiftY.append([15, 19, -15, -19, 19, 15, -19, -15])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 206
        shiftX.append([24, 24, 4, 4, -4, -4, -24, -24])
        shiftY.append([4, -4, 24, -24, 24, -24, 4, -4])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 207
        shiftX.append([23, 23, 8, -8, 8, -8, -23, -23])
        shiftY.append([8, -8, 23, 23, -23, -23, 8, -8])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 208
        shiftX.append([20, 14, 14, -20, 20, -14, -14, -20])
        shiftY.append([14, 20, -20, 14, -14, 20, -20, -14])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 209
        shiftX.append([24, 24, 5, 5, -5, -5, -24, -24])
        shiftY.append([5, -5, 24, -24, 24, -24, 5, -5])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 210
        shiftX.append([22, 22, 11, 11, -11, -11, -22, -22])
        shiftY.append([11, -11, 22, -22, 22, -22, 11, -11])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 211
        shiftX.append([23, 23, 21, 21, 13, 13, 9, -9, -13, -13, -21, -21, 9, -9, -23, -23])
        shiftY.append([9, -9, 13, -13, 21, -21, 23, 23, 21, -21, 13, -13, -23, -23, 9, -9])
        counts.append(16)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 212
        shiftX.append([24, 24, 6, 6, -6, -6, -24, -24])
        shiftY.append([6, -6, 24, -24, 24, -24, 6, -6])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 213
        shiftX.append([18, 18, 17, 17, -17, -17, -18, -18])
        shiftY.append([17, -17, 18, -18, 18, -18, 17, -17])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 214
        shiftX.append([19, 19, 16, -16, 16, -16, -19, -19])
        shiftY.append([16, -16, 19, 19, -19, -19, 16, -16])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 215
        shiftX.append([0, -25, 25, 24, 24, 20, 15, 15, 7, 7, 0, -7, -7, -20, -24, -24, 20, -15, -15, -20])
        shiftY.append([-25, 0, 0, 7, -7, 15, 20, -20, 24, -24, 25, 24, -24, 15, 7, -7, -15, 20, -20, -15])
        counts.append(20)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 216
        shiftX.append([1, -1, -25, -25, 25, 25, 1, -1])
        shiftY.append([-25, -25, 1, -1, 1, -1, 25, 25])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 217
        shiftX.append([22, 22, 12, 12, -12, -12, -22, -22])
        shiftY.append([12, -12, 22, -22, 22, -22, 12, -12])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 218
        shiftX.append([23, 23, 10, 2, -2, -10, -25, -25, 25, 25, 10, 2, -2, -23, -10, -23])
        shiftY.append([10, -10, 23, -25, -25, 23, 2, -2, 2, -2, -23, 25, 25, 10, -23, -10])
        counts.append(16)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 219
        shiftX.append([3, -3, -25, -25, 25, 25, 3, -3])
        shiftY.append([-25, -25, 3, -3, 3, -3, 25, 25])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 220
        shiftX.append([21, 14, 14, -21, 21, -14, -14, -21])
        shiftY.append([14, 21, -21, 14, -14, 21, -21, -14])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 221
        shiftX.append([24, 24, 8, 8, -8, -8, -24, -24])
        shiftY.append([8, -8, 24, -24, 24, -24, 8, -8])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 222
        shiftX.append([4, -4, -25, -25, 25, 25, 4, -4])
        shiftY.append([-25, -25, 4, -4, 4, -4, 25, 25])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 223
        shiftX.append([18, 18, -18, -18])
        shiftY.append([18, -18, 18, -18])
        counts.append(4)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 224
        shiftX.append([23, 23, 19, 19, 17, 11, 5, -5, -11, -17, -25, -25, 25, 25, 5, -5, 17, 11, -11, -17, -19, -19, -23, -23])
        shiftY.append([11, -11, 17, -17, 19, 23, -25, -25, 23, 19, 5, -5, 5, -5, 25, 25, -19, -23, -23, -19, 17, -17, 11, -11])
        counts.append(24)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 225
        shiftX.append([22, 22, 13, 13, -13, -13, -22, -22])
        shiftY.append([13, -13, 22, -22, 22, -22, 13, -13])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 226
        shiftX.append([20, 20, 16, 16, -16, -16, -20, -20])
        shiftY.append([16, -16, 20, -20, 20, -20, 16, -16])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 227
        shiftX.append([24, 24, 9, 9, -9, -9, -24, -24])
        shiftY.append([9, -9, 24, -24, 24, -24, 9, -9])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 228
        shiftX.append([6, -6, -25, -25, 25, 6, 25, -6])
        shiftY.append([-25, -25, 6, -6, 6, 25, -6, 25])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 229
        shiftX.append([21, 15, 15, -21, 21, -15, -15, -21])
        shiftY.append([15, 21, -21, 15, -15, 21, -21, -15])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 230
        shiftX.append([23, 12, 23, 12, -12, -23, -12, -23])
        shiftY.append([12, 23, -12, -23, 23, 12, -23, -12])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 231
        shiftX.append([7, -7, -25, -25, 25, 25, 7, -7])
        shiftY.append([-25, -25, 7, -7, 7, -7, 25, 25])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 232
        shiftX.append([24, 10, 10, -24, 26, 0, 0, -26, 24, -10, -10, -24])
        shiftY.append([10, 24, -24, 10, 0, 26, -26, 0, -10, 24, -24, -10])
        counts.append(12)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 233
        shiftX.append([26, 26, 1, 1, -1, -1, -26, -26])
        shiftY.append([1, -1, 26, -26, 26, -26, 1, -1])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 234
        shiftX.append([22, 14, 14, -22, 26, 26, 22, 2, 2, -2, -2, -14, -14, -22, -26, -26])
        shiftY.append([14, 22, -22, 14, 2, -2, -14, 26, -26, 26, -26, 22, -22, -14, 2, -2])
        counts.append(16)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 235
        shiftX.append([26, 26, 19, 19, 18, 3, 3, -3, -3, -18, -26, -26, 18, -18, -19, -19])
        shiftY.append([3, -3, 18, -18, 19, 26, -26, 26, -26, 19, 3, -3, -19, -19, 18, -18])
        counts.append(16)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 236
        shiftX.append([8, -8, -25, -25, 25, 25, 20, 20, 17, 17, 8, -8, -17, -17, -20, -20])
        shiftY.append([-25, -25, 8, -8, 8, -8, 17, -17, 20, -20, 25, 25, 20, -20, 17, -17])
        counts.append(16)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 237
        shiftX.append([26, 26, 4, 4, -4, -4, -26, -26])
        shiftY.append([4, -4, 26, -26, 26, -26, 4, -4])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 238
        shiftX.append([24, 24, 21, 21, 16, 16, 11, 11, -11, -11, -16, -16, -21, -21, -24, -24])
        shiftY.append([11, -11, 16, -16, 21, -21, 24, -24, 24, -24, 21, -21, 16, -16, 11, -11])
        counts.append(16)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 239
        shiftX.append([23, 23, 13, -13, 13, -13, -23, -23])
        shiftY.append([13, -13, 23, 23, -23, -23, 13, -13])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 240
        shiftX.append([26, 26, 5, 5, -5, -5, -26, -26])
        shiftY.append([5, -5, 26, -26, 26, -26, 5, -5])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 241
        shiftX.append([9, -9, -25, -25, 25, 25, 9, -9])
        shiftY.append([-25, -25, 9, -9, 9, -9, 25, 25])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 242
        shiftX.append([22, 15, 15, -22, 22, -15, -15, -22])
        shiftY.append([15, 22, -22, 15, -15, 22, -22, -15])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 243
        shiftX.append([26, 6, 6, -26, 26, -6, -6, -26])
        shiftY.append([6, 26, -26, 6, -6, 26, -26, -6])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 244
        shiftX.append([24, 12, 12, -24, 24, -12, -12, -24])
        shiftY.append([12, 24, -24, 12, -12, 24, -24, -12])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 245
        shiftX.append([19, 19, -19, -19])
        shiftY.append([19, -19, 19, -19])
        counts.append(4)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 246
        shiftX.append([20, 20, 18, 18, -18, -18, -20, -20])
        shiftY.append([18, -18, 20, -20, 20, -20, 18, -18])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 247
        shiftX.append([23, 14, 10, -25, 25, 23, 10, -10, -14, -25, 26, 26, 25, 14, 7, 7, -7, -7, -10, -23, -26, -26, -14, -23])
        shiftY.append([14, 23, -25, 10, 10, -14, 25, -25, 23, -10, 7, -7, -10, -23, 26, -26, 26, -26, 25, 14, 7, -7, -23, -14])
        counts.append(24)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 248
        shiftX.append([27, 0, 0, -27])
        shiftY.append([0, 27, -27, 0])
        counts.append(4)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 249
        shiftX.append([27, 27, 21, 21, 17, 17, 1, -1, -17, -17, -21, -21, 1, -1, -27, -27])
        shiftY.append([1, -1, 17, -17, 21, -21, 27, 27, 21, -21, 17, -17, -27, -27, 1, -1])
        counts.append(16)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 250
        shiftX.append([27, 27, 2, -2, 2, -2, -27, -27])
        shiftY.append([2, -2, 27, 27, -27, -27, 2, -2])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 251
        shiftX.append([27, 27, 3, -3, 3, -3, -27, -27])
        shiftY.append([3, -3, 27, 27, -27, -27, 3, -3])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 252
        shiftX.append([26, 26, 8, 8, -8, -8, -26, -26, 22, 22, 16, 16, -16, -16, -22, -22])
        shiftY.append([8, -8, 26, -26, 26, -26, 8, -8, 16, -16, 22, -22, 22, -22, 16, -16])
        counts.append(16)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 253
        shiftX.append([27, 27, 24, 24, 13, 13, 4, -4, -13, -13, -24, -24, 4, -4, -27, -27])
        shiftY.append([4, -4, 13, -13, 24, -24, 27, 27, 24, -24, 13, -13, -27, -27, 4, -4])
        counts.append(16)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 254
        shiftX.append([11, -11, -25, -25, 25, 25, 11, -11])
        shiftY.append([-25, -25, 11, -11, 11, -11, 25, 25])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 255
        shiftX.append([27, 27, 23, 23, 15, 5, -5, -15, 15, 5, -5, -23, -27, -27, -15, -23])
        shiftY.append([5, -5, 15, -15, 23, 27, 27, 23, -23, -27, -27, 15, 5, -5, -23, -15])
        counts.append(16)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 256
        shiftX.append([26, 26, 9, 9, -9, -9, -26, -26])
        shiftY.append([9, -9, 26, -26, 26, -26, 9, -9])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 257
        shiftX.append([20, 19, 19, -20, 20, -19, -19, -20])
        shiftY.append([19, 20, -20, 19, -19, 20, -20, -19])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 258
        shiftX.append([27, 6, 27, 21, 21, 18, 18, 6, -6, -18, -18, -21, -21, -27, -6, -27])
        shiftY.append([6, 27, -6, 18, -18, 21, -21, -27, 27, 21, -21, 18, -18, 6, -27, -6])
        counts.append(16)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 259
        shiftX.append([12, -12, -25, -25, 25, 25, 12, -12])
        shiftY.append([-25, -25, 12, -12, 12, -12, 25, 25])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 260
        shiftX.append([24, 14, 14, -24, 24, -14, -14, -24])
        shiftY.append([14, 24, -24, 14, -14, 24, -24, -14])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 261
        shiftX.append([22, 22, 17, 17, -17, -17, -22, -22])
        shiftY.append([17, -17, 22, -22, 22, -22, 17, -17])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 262
        shiftX.append([26, 10, 10, -26, 26, -10, -10, -26])
        shiftY.append([10, 26, -26, 10, -10, 26, -26, -10])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 263
        shiftX.append([27, 27, 7, -7, 7, -7, -27, -27])
        shiftY.append([7, -7, 27, 27, -27, -27, 7, -7])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 264
        shiftX.append([28, 0, 0, -28])
        shiftY.append([0, 28, -28, 0])
        counts.append(4)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 265
        shiftX.append([28, 28, 23, 23, 16, 1, 1, -1, -1, -16, -28, -28, 16, -16, -23, -23])
        shiftY.append([1, -1, 16, -16, 23, 28, -28, 28, -28, 23, 1, -1, -23, -23, 16, -16])
        counts.append(16)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 266
        shiftX.append([28, 28, 2, 2, -2, -2, -28, -28])
        shiftY.append([2, -2, 28, -28, 28, -28, 2, -2])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 267
        shiftX.append([27, 27, 8, -8, 28, 28, 3, 3, -3, -3, -28, -28, 8, -8, -27, -27])
        shiftY.append([8, -8, 27, 27, 3, -3, 28, -28, 28, -28, 3, -3, -27, -27, 8, -8])
        counts.append(16)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 268
        shiftX.append([13, -13, -25, -25, 25, 25, 13, -13])
        shiftY.append([-25, -25, 13, -13, 13, -13, 25, 25])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 269
        shiftX.append([26, 26, 11, 11, -11, -11, -26, -26])
        shiftY.append([11, -11, 26, -26, 26, -26, 11, -11])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 270
        shiftX.append([28, 28, 20, 20, 4, 4, -4, -4, -20, -20, -28, -28])
        shiftY.append([4, -4, 20, -20, 28, -28, 28, -28, 20, -20, 4, -4])
        counts.append(12)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 271
        shiftX.append([24, 15, 15, -24, 24, -15, -15, -24])
        shiftY.append([15, 24, -24, 15, -15, 24, -24, -15])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 272
        shiftX.append([21, 19, 19, -21, 21, -19, -19, -21])
        shiftY.append([19, 21, -21, 19, -19, 21, -21, -19])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 273
        shiftX.append([22, 22, 18, 18, -18, -18, -22, -22])
        shiftY.append([18, -18, 22, -22, 22, -22, 18, -18])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 274
        shiftX.append([28, 28, 5, 5, -5, -5, -28, -28])
        shiftY.append([5, -5, 28, -28, 28, -28, 5, -5])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 275
        shiftX.append([27, 27, 9, -9, 9, -9, -27, -27])
        shiftY.append([9, -9, 27, 27, -27, -27, 9, -9])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 276
        shiftX.append([23, 23, 17, -17, 17, -17, -23, -23])
        shiftY.append([17, -17, 23, 23, -23, -23, 17, -17])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 277
        shiftX.append([28, 28, 26, 26, 12, 12, 6, 6, -6, -6, -12, -12, -26, -26, -28, -28])
        shiftY.append([6, -6, 12, -12, 26, -26, 28, -28, 28, -28, 26, -26, 12, -12, 6, -6])
        counts.append(16)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 278
        shiftX.append([14, -25, 25, 14, -14, -25, 25, -14])
        shiftY.append([-25, 14, 14, 25, -25, -14, -14, 25])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 279
        shiftX.append([27, 10, 27, 10, -10, -27, -10, -27])
        shiftY.append([10, 27, -10, -27, 27, 10, -27, -10])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 280
        shiftX.append([24, 16, 16, -24, 24, -16, -16, -24])
        shiftY.append([16, 24, -24, 16, -16, 24, -24, -16])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 281
        shiftX.append([28, 28, 7, 7, -7, -7, -28, -28])
        shiftY.append([7, -7, 28, -28, 28, -28, 7, -7])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 282
        shiftX.append([0, -29, 29, 21, 21, 20, 20, 0, -20, -20, -21, -21])
        shiftY.append([-29, 0, 0, 20, -20, 21, -21, 29, 21, -21, 20, -20])
        counts.append(12)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 283
        shiftX.append([1, -1, -29, -29, 29, 29, 1, -1])
        shiftY.append([-29, -29, 1, -1, 1, -1, 29, 29])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 284
        shiftX.append([2, -2, -29, -29, 29, 29, 26, 26, 22, 19, 19, 13, 13, 2, -2, -13, -13, -22, -26, -26, 22, -19, -19, -22])
        shiftY.append([-29, -29, 2, -2, 2, -2, 13, -13, 19, 22, -22, 26, -26, 29, 29, 26, -26, 19, 13, -13, -19, 22, -22, -19])
        counts.append(24)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 285
        shiftX.append([28, 28, 8, 8, -8, -8, -28, -28])
        shiftY.append([8, -8, 28, -28, 28, -28, 8, -8])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 286
        shiftX.append([15, 3, -3, -25, -29, -29, 29, 29, 27, 27, 25, 15, 11, 3, -3, -11, -15, -25, 25, 11, -11, -15, -27, -27])
        shiftY.append([-25, -29, -29, 15, 3, -3, 3, -3, 11, -11, 15, 25, 27, 29, 29, 27, -25, -15, -15, -27, -27, 25, 11, -11])
        counts.append(24)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 287
        shiftX.append([23, 23, 18, -18, 18, -18, -23, -23])
        shiftY.append([18, -18, 23, 23, -23, -23, 18, -18])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 288
        shiftX.append([4, -4, -29, -29, 29, 29, 4, -4])
        shiftY.append([-29, -29, 4, -4, 4, -4, 29, 29])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 289
        shiftX.append([28, 28, 24, 24, 17, 17, 9, 9, -9, -9, -17, -17, -24, -24, -28, -28])
        shiftY.append([9, -9, 17, -17, 24, -24, 28, -28, 28, -28, 24, -24, 17, -17, 9, -9])
        counts.append(16)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 290
        shiftX.append([5, -5, -29, -29, 29, 29, 5, -5])
        shiftY.append([-29, -29, 5, -5, 5, -5, 29, 29])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 291
        shiftX.append([26, 14, 14, -26, 26, -14, -14, -26])
        shiftY.append([14, 26, -26, 14, -14, 26, -26, -14])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 292
        shiftX.append([27, 27, 12, -12, 12, -27, -12, -27])
        shiftY.append([12, -12, 27, 27, -27, 12, -27, -12])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 293
        shiftX.append([6, -6, -29, -29, 29, 6, 29, -6])
        shiftY.append([-29, -29, 6, -6, 6, 29, -6, 29])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 294
        shiftX.append([16, -16, -25, -25, 25, 25, 16, -16])
        shiftY.append([-25, -25, 16, -16, 16, -16, 25, 25])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 295
        shiftX.append([21, 21, -21, -21])
        shiftY.append([21, -21, 21, -21])
        counts.append(4)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 296
        shiftX.append([28, 10, 10, -28, 28, 22, 22, 20, 20, -10, -10, -20, -20, -22, -22, -28])
        shiftY.append([10, 28, -28, 10, -10, 20, -20, 22, -22, 28, -28, 22, -22, 20, -20, -10])
        counts.append(16)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 297
        shiftX.append([7, -7, -29, -29, 29, 29, 23, 19, 7, -7, 23, 19, -19, -23, -19, -23])
        shiftY.append([-29, -29, 7, -7, 7, -7, 19, 23, 29, 29, -19, -23, 23, 19, -23, -19])
        counts.append(16)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 298
        shiftX.append([27, 27, 13, -13, 13, -13, -27, -27])
        shiftY.append([13, -13, 27, 27, -27, -27, 13, -13])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 299
        shiftX.append([30, 24, 24, 18, 18, 0, 0, -18, -18, -24, -24, -30])
        shiftY.append([0, 18, -18, 24, -24, 30, -30, 24, -24, 18, -18, 0])
        counts.append(12)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 300
        shiftX.append([30, 30, 26, 15, 15, 1, 1, -1, -1, -26, -30, -30, 26, -15, -15, -26])
        shiftY.append([1, -1, 15, 26, -26, 30, -30, 30, -30, 15, 1, -1, -15, 26, -26, -15])
        counts.append(16)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 301
        shiftX.append([30, 30, 2, 2, -2, -2, -30, -30])
        shiftY.append([2, -2, 30, -30, 30, -30, 2, -2])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 302
        shiftX.append([8, -8, -29, -29, 29, 29, 8, -8, 28, 28, 11, 11, -11, -11, -28, -28])
        shiftY.append([-29, -29, 8, -8, 8, -8, 29, 29, 11, -11, 28, -28, 28, -28, 11, -11])
        counts.append(16)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 303
        shiftX.append([30, 30, 3, 3, -3, -3, -30, -30])
        shiftY.append([3, -3, 30, -30, 30, -30, 3, -3])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 304
        shiftX.append([17, -17, -25, -25, 25, 25, 17, -17])
        shiftY.append([-25, -25, 17, -17, 17, -17, 25, 25])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 305
        shiftX.append([30, 30, 4, 4, -4, -4, -30, -30])
        shiftY.append([4, -4, 30, -30, 30, -30, 4, -4])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 306
        shiftX.append([9, -9, -29, -29, 29, 29, 9, -9])
        shiftY.append([-29, -29, 9, -9, 9, -9, 29, 29])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 307
        shiftX.append([27, 14, 30, 30, 27, 22, 22, 21, 21, 14, 5, 5, -5, -5, -14, -21, -21, -22, -22, -27, -30, -30, -14, -27])
        shiftY.append([14, 27, 5, -5, -14, 21, -21, 22, -22, -27, 30, -30, 30, -30, 27, 22, -22, 21, -21, 14, 5, -5, -27, -14])
        counts.append(24)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 308
        shiftX.append([28, 12, 12, -28, 28, -12, -12, -28])
        shiftY.append([12, 28, -28, 12, -12, 28, -28, -12])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 309
        shiftX.append([23, 23, 20, -20, 20, -20, -23, -23])
        shiftY.append([20, -20, 23, 23, -23, -23, 20, -20])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 310
        shiftX.append([26, 26, 16, 16, -16, -16, -26, -26])
        shiftY.append([16, -16, 26, -26, 26, -26, 16, -16])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 311
        shiftX.append([30, 6, 6, -30, 30, -6, -6, -30])
        shiftY.append([6, 30, -30, 6, -6, 30, -30, -6])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 312
        shiftX.append([24, 19, 19, -24, 24, -19, -19, -24])
        shiftY.append([19, 24, -24, 19, -19, 24, -24, -19])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 313
        shiftX.append([10, -29, 29, 10, -10, -29, 29, -10])
        shiftY.append([-29, 10, 10, 29, -29, -10, -10, 29])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 314
        shiftX.append([18, -18, -25, -25, 30, 30, 25, 25, 18, 7, 7, -7, -7, -18, -30, -30])
        shiftY.append([-25, -25, 18, -18, 7, -7, 18, -18, 25, 30, -30, 30, -30, 25, 7, -7])
        counts.append(16)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 315
        shiftX.append([28, 28, 13, 13, -13, -13, -28, -28, 27, 15, 27, 15, -15, -27, -15, -27])
        shiftY.append([13, -13, 28, -28, 28, -28, 13, -13, 15, 27, -15, -27, 27, 15, -27, -15])
        counts.append(16)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 316
        shiftX.append([31, 0, 0, -31, 11, -11, -29, -29, 31, 31, 29, 29, 11, 1, -1, -11, 1, -1, -31, -31])
        shiftY.append([0, 31, -31, 0, -29, -29, 11, -11, 1, -1, 11, -11, 29, 31, 31, 29, -31, -31, 1, -1])
        counts.append(20)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 317
        shiftX.append([30, 30, 8, 8, -8, -8, -30, -30, 31, 31, 26, 26, 17, 17, 2, -2, -17, -17, -26, -26, 2, -2, -31, -31])
        shiftY.append([8, -8, 30, -30, 30, -30, 8, -8, 2, -2, 17, -17, 26, -26, 31, 31, 26, -26, 17, -17, -31, -31, 2, -2])
        counts.append(24)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 318
        shiftX.append([22, 22, -22, -22])
        shiftY.append([22, -22, 22, -22])
        counts.append(4)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 319
        shiftX.append([31, 31, 23, 23, 21, 3, -3, -21, 21, 3, -3, -21, -23, -23, -31, -31])
        shiftY.append([3, -3, 21, -21, 23, 31, 31, 23, -23, -31, -31, -23, 21, -21, 3, -3])
        counts.append(16)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 320
        shiftX.append([24, 24, 20, 20, -20, -20, -24, -24, 31, 31, 4, -4, 4, -4, -31, -31])
        shiftY.append([20, -20, 24, -24, 24, -24, 20, -20, 4, -4, 31, 31, -31, -31, 4, -4])
        counts.append(16)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 321
        shiftX.append([28, 14, 14, -28, 28, -14, -14, -28, 30, 30, 9, 9, -9, -9, -30, -30])
        shiftY.append([14, 28, -28, 14, -14, 28, -28, -14, 9, -9, 30, -30, 30, -30, 9, -9])
        counts.append(16)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 322
        shiftX.append([12, -12, -29, -29, 29, 29, 27, 27, 16, 12, -12, -16, 16, -16, -27, -27, 31, 31, 19, 5, -5, -25, 25, 19, 5, -5, -19, -25, -31, -31, 25, -19])
        shiftY.append([-29, -29, 12, -12, 12, -12, 16, -16, 27, 29, 29, 27, -27, -27, 16, -16, 5, -5, -25, 31, 31, 19, 19, 25, -31, -31, -25, -19, 5, -5, -19, 25])
        counts.append(32)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 323
        shiftX.append([31, 6, 31, 6, -6, -31, -6, -31])
        shiftY.append([6, 31, -6, -31, 31, 6, -31, -6])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 324
        shiftX.append([30, 10, 10, -30, 30, 26, 26, 18, 18, -10, -10, -18, -18, -26, -26, -30])
        shiftY.append([10, 30, -30, 10, -10, 18, -18, 26, -26, 30, -30, 26, -26, 18, -18, -10])
        counts.append(16)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 325
        shiftX.append([28, 15, 15, -28, 28, -15, -15, -28, 13, -13, -29, -29, 31, 31, 29, 29, 13, 7, -7, -13, 7, -7, -31, -31])
        shiftY.append([15, 28, -28, 15, -15, 28, -28, -15, -29, -29, 13, -13, 7, -7, 13, -13, 29, 31, 31, 29, -31, -31, 7, -7])
        counts.append(24)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 326
        shiftX.append([23, 23, 22, -22, 22, -22, -23, -23])
        shiftY.append([22, -22, 23, 23, -23, -23, 22, -22])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 327
        shiftX.append([24, 24, 21, 21, -21, -21, -24, -24, 27, 27, 17, -17, 17, -17, -27, -27])
        shiftY.append([21, -21, 24, -24, 24, -24, 21, -21, 17, -17, 27, 27, -27, -27, 17, -17])
        counts.append(16)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 328
        shiftX.append([30, 30, 11, 11, -11, -11, -30, -30])
        shiftY.append([11, -11, 30, -30, 30, -30, 11, -11])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 329
        shiftX.append([31, 31, 20, 8, -8, -20, -25, -25, 25, 25, 20, 8, -8, -20, -31, -31])
        shiftY.append([8, -8, -25, 31, 31, -25, 20, -20, 20, -20, 25, -31, -31, 25, 8, -8])
        counts.append(16)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 330
        shiftX.append([14, -29, 29, 26, 19, 19, 14, -14, -26, -29, 29, 26, -14, -19, -19, -26])
        shiftY.append([-29, 14, 14, 19, 26, -26, 29, -29, 19, -14, -14, -19, 29, 26, -26, -19])
        counts.append(16)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 331
        shiftX.append([28, 28, 16, 16, -16, -16, -28, -28])
        shiftY.append([16, -16, 28, -28, 28, -28, 16, -16])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 332
        shiftX.append([31, 31, 9, -9, 9, -9, -31, -31])
        shiftY.append([9, -9, 31, 31, -31, -31, 9, -9])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 333
        shiftX.append([30, 30, 12, 12, -12, -12, -30, -30])
        shiftY.append([12, -12, 30, -30, 30, -30, 12, -12])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 334
        shiftX.append([27, 27, 18, -18, 18, -18, -27, -27])
        shiftY.append([18, -18, 27, 27, -27, -27, 18, -18])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 335
        shiftX.append([23, 23, -23, -23])
        shiftY.append([23, -23, 23, -23])
        counts.append(4)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 336
        shiftX.append([24, 24, 22, 22, -22, -22, -24, -24, 31, 10, 31, 10, -10, -31, -10, -31])
        shiftY.append([22, -22, 24, -24, 24, -24, 22, -22, 10, 31, -10, -31, 31, 10, -31, -10])
        counts.append(16)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 337
        shiftX.append([21, 15, -21, -25, -25, -29, 29, 25, 25, 21, 15, -15, -21, -29, 29, -15])
        shiftY.append([-25, -29, -25, 21, -21, 15, 15, 21, -21, 25, 29, -29, 25, -15, -15, 29])
        counts.append(16)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 338
        shiftX.append([30, 30, 13, 13, -13, -13, -30, -30])
        shiftY.append([13, -13, 30, -30, 30, -30, 13, -13])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 339
        shiftX.append([28, 28, 17, 17, -17, -17, -28, -28])
        shiftY.append([17, -17, 28, -28, 28, -28, 17, -17])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 340
        shiftX.append([26, 26, 20, 20, -20, -20, -26, -26])
        shiftY.append([20, -20, 26, -26, 26, -26, 20, -20])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 341
        shiftX.append([31, 31, 11, -11, 11, -11, -31, -31])
        shiftY.append([11, -11, 31, 31, -31, -31, 11, -11])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 342
        shiftX.append([27, 19, 27, 19, -19, -27, -19, -27])
        shiftY.append([19, 27, -19, -27, 27, 19, -27, -19])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 343
        shiftX.append([30, 14, 14, -30, 30, -14, -14, -30, 16, -16, -29, -29, 29, 29, 16, -16])
        shiftY.append([14, 30, -30, 14, -14, 30, -30, -14, -29, -29, 16, -16, 16, -16, 29, 29])
        counts.append(16)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 344
        shiftX.append([31, 24, 23, 23, 12, -24, 31, 24, 12, -12, -23, -23, -24, -31, -12, -31])
        shiftY.append([12, 23, 24, -24, 31, 23, -12, -23, -31, 31, 24, -24, -23, 12, -31, -12])
        counts.append(16)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 345
        shiftX.append([28, 28, 18, 18, -18, -18, -28, -28, 22, -22, -25, -25, 25, 25, 22, -22])
        shiftY.append([18, -18, 28, -28, 28, -28, 18, -18, -25, -25, 22, -22, 22, -22, 25, 25])
        counts.append(16)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 346
        shiftX.append([26, 26, 21, 21, -21, -21, -26, -26])
        shiftY.append([21, -21, 26, -26, 26, -26, 21, -21])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 347
        shiftX.append([30, 30, 15, 15, -15, -15, -30, -30])
        shiftY.append([15, -15, 30, -30, 30, -30, 15, -15])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 348
        shiftX.append([27, 27, 20, 20, -20, -20, -27, -27, 17, -17, -29, -29, 31, 31, 29, 29, 17, 13, 13, -13, -13, -17, -31, -31])
        shiftY.append([20, -20, 27, -27, 27, -27, 20, -20, -29, -29, 17, -17, 13, -13, 17, -17, 29, 31, -31, 31, -31, 29, 13, -13])
        counts.append(24)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 349
        shiftX.append([28, 19, 19, -28, 28, -19, -19, -28])
        shiftY.append([19, 28, -28, 19, -19, 28, -28, -19])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 350
        shiftX.append([24, 24, -24, -24])
        shiftY.append([24, -24, 24, -24])
        counts.append(4)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 351
        shiftX.append([23, -25, 25, 25, 23, -23, -23, -25])
        shiftY.append([-25, 23, 23, -23, 25, 25, -25, -23])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 352
        shiftX.append([30, 30, 16, 16, -16, -16, -30, -30, 31, 31, 14, 14, -14, -31, -14, -31])
        shiftY.append([16, -16, 30, -30, 30, -30, 16, -16, 14, -14, 31, -31, 31, 14, -31, -14])
        counts.append(16)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 353
        shiftX.append([26, 26, 22, 22, -22, -22, -26, -26])
        shiftY.append([22, -22, 26, -26, 26, -26, 22, -22])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 354
        shiftX.append([18, -18, -29, -29, 29, 29, 18, -18])
        shiftY.append([-29, -29, 18, -18, 18, -18, 29, 29])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 355
        shiftX.append([27, 27, 21, 21, -21, -21, -27, -27])
        shiftY.append([21, -21, 27, -27, 27, -27, 21, -21])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 356
        shiftX.append([28, 28, 20, 20, -20, -20, -28, -28])
        shiftY.append([20, -20, 28, -28, 28, -28, 20, -20])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 357
        shiftX.append([31, 31, 15, 15, -15, -15, -31, -31])
        shiftY.append([15, -15, 31, -31, 31, -31, 15, -15])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 358
        shiftX.append([30, 30, 17, 17, -17, -17, -30, -30])
        shiftY.append([17, -17, 30, -30, 30, -30, 17, -17])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 359
        shiftX.append([24, -24, -25, -25, 25, 25, 24, -24, 29, 19, 19, -19, -29, -29, 29, -19])
        shiftY.append([-25, -25, 24, -24, 24, -24, 25, 25, 19, 29, -29, -29, 19, -19, -19, 29])
        counts.append(16)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 360
        shiftX.append([26, 26, 23, 23, -23, -23, -26, -26])
        shiftY.append([23, -23, 26, -26, 26, -26, 23, -23])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 361
        shiftX.append([27, 27, 22, 22, -22, -22, -27, -27])
        shiftY.append([22, -22, 27, -27, 27, -27, 22, -22])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 362
        shiftX.append([31, 16, 31, 16, -16, -16, -31, -31])
        shiftY.append([16, 31, -16, -31, 31, -31, 16, -16])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 363
        shiftX.append([30, 30, 18, 18, -18, -18, -30, -30, 28, 28, 21, 21, -21, -21, -28, -28])
        shiftY.append([18, -18, 30, -30, 30, -30, 18, -18, 21, -21, 28, -28, 28, -28, 21, -21])
        counts.append(16)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 364
        shiftX.append([29, 29, 20, 20, -20, -20, -29, -29])
        shiftY.append([20, -20, 29, -29, 29, -29, 20, -20])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 365
        shiftX.append([-25, 31, 31, 25, 25, 17, 17, -17, -17, -25, -31, -31])
        shiftY.append([-25, 17, -17, 25, -25, 31, -31, 31, -31, 25, 17, -17])
        counts.append(12)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 366
        shiftX.append([26, 26, 24, 24, -24, -24, -26, -26])
        shiftY.append([24, -24, 26, -26, 26, -26, 24, -24])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 367
        shiftX.append([27, 27, 23, 23, -23, -27, -23, -27])
        shiftY.append([23, -23, 27, -27, 27, 23, -27, -23])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 368
        shiftX.append([30, 30, 19, 19, -19, -19, -30, -30])
        shiftY.append([19, -19, 30, -30, 30, -30, 19, -19])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 369
        shiftX.append([28, 28, 22, 22, -22, -22, -28, -28])
        shiftY.append([22, -22, 28, -28, 28, -28, 22, -22])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 370
        shiftX.append([29, 29, 21, 21, -21, -21, -29, -29])
        shiftY.append([21, -21, 29, -29, 29, -29, 21, -21])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 371
        shiftX.append([31, 31, 18, 18, -18, -18, -31, -31])
        shiftY.append([18, -18, 31, -31, 31, -31, 18, -18])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 372
        shiftX.append([30, 30, 20, 20, -20, -20, -30, -30, 26, -25, -25, -26, 26, 25, 25, -26])
        shiftY.append([20, -20, 30, -30, 30, -30, 20, -20, -25, 26, -26, -25, 25, 26, -26, 25])
        counts.append(16)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 373
        shiftX.append([27, 27, 24, 24, -24, -24, -27, -27])
        shiftY.append([24, -24, 27, -27, 27, -27, 24, -24])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 374
        shiftX.append([28, 28, 23, 23, -23, -23, -28, -28])
        shiftY.append([23, -23, 28, -28, 28, -28, 23, -23])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 375
        shiftX.append([31, 19, 31, 19, -19, -19, -31, -31])
        shiftY.append([19, 31, -19, -31, 31, -31, 19, -19])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 376
        shiftX.append([22, -22, -29, -29, 29, 29, 22, -22])
        shiftY.append([-29, -29, 22, -22, 22, -22, 29, 29])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 377
        shiftX.append([30, 30, 21, 21, -21, -21, -30, -30])
        shiftY.append([21, -21, 30, -30, 30, -30, 21, -21])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 378
        shiftX.append([26, 26, -26, -26])
        shiftY.append([26, -26, 26, -26])
        counts.append(4)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 379
        shiftX.append([27, -25, 27, 25, 25, -25, -27, -27])
        shiftY.append([-25, 27, 25, 27, -27, -27, 25, -25])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 380
        shiftX.append([28, 28, 24, 24, -24, -24, -28, -28, 31, 31, 20, 20, -20, -20, -31, -31])
        shiftY.append([24, -24, 28, -28, 28, -28, 24, -24, 20, -20, 31, -31, 31, -31, 20, -20])
        counts.append(16)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 381
        shiftX.append([29, 23, 23, -23, -29, -29, 29, -23])
        shiftY.append([23, 29, -29, -29, 23, -23, -23, 29])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 382
        shiftX.append([30, 30, 22, 22, -22, -22, -30, -30])
        shiftY.append([22, -22, 30, -30, 30, -30, 22, -22])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 383
        shiftX.append([31, 31, 21, 21, -21, -21, -31, -31])
        shiftY.append([21, -21, 31, -31, 31, -31, 21, -21])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 384
        shiftX.append([27, 27, 26, 26, -26, -26, -27, -27])
        shiftY.append([26, -26, 27, -27, 27, -27, 26, -26])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 385
        shiftX.append([28, 28, 25, 25, -25, -25, -28, -28])
        shiftY.append([25, -25, 28, -28, 28, -28, 25, -25])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 386
        shiftX.append([24, -24, -29, -29, 29, 29, 24, -24])
        shiftY.append([-29, -29, 24, -24, 24, -24, 29, 29])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 387
        shiftX.append([30, 23, 23, -30, 30, -23, -23, -30])
        shiftY.append([23, 30, -30, 23, -23, 30, -30, -23])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 388
        shiftX.append([31, 31, 22, -22, 22, -22, -31, -31])
        shiftY.append([22, -22, 31, 31, -31, -31, 22, -22])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 389
        shiftX.append([27, 27, -27, -27])
        shiftY.append([27, -27, 27, -27])
        counts.append(4)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 390
        shiftX.append([28, 28, 26, 26, -26, -26, -28, -28])
        shiftY.append([26, -26, 28, -28, 28, -28, 26, -26])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 391
        shiftX.append([29, 25, -25, -25, -29, -29, 29, 25])
        shiftY.append([-25, -29, 29, -29, 25, -25, 25, 29])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 392
        shiftX.append([30, 30, 24, 24, -24, -24, -30, -30])
        shiftY.append([24, -24, 30, -30, 30, -30, 24, -24])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 393
        shiftX.append([31, 31, 23, 23, -23, -23, -31, -31])
        shiftY.append([23, -23, 31, -31, 31, -31, 23, -23])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 394
        shiftX.append([28, 27, 27, -28, 28, -27, -27, -28])
        shiftY.append([27, 28, -28, 27, -27, 28, -28, -27])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 395
        shiftX.append([29, 29, 26, 26, -26, -26, -29, -29])
        shiftY.append([26, -26, 29, -29, 29, -29, 26, -26])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 396
        shiftX.append([30, -25, -25, -30, 30, 25, 25, -30])
        shiftY.append([-25, 30, -30, -25, 25, 30, -30, 25])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 397
        shiftX.append([31, 31, 24, -24, 24, -24, -31, -31])
        shiftY.append([24, -24, 31, 31, -31, -31, 24, -24])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 398
        shiftX.append([28, 28, -28, -28])
        shiftY.append([28, -28, 28, -28])
        counts.append(4)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 399
        shiftX.append([29, 29, 27, 27, -27, -27, -29, -29])
        shiftY.append([27, -27, 29, -29, 29, -29, 27, -27])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 400
        shiftX.append([30, 30, 26, 26, -26, -26, -30, -30])
        shiftY.append([26, -26, 30, -30, 30, -30, 26, -26])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 401
        shiftX.append([31, -25, 31, 25, 25, -25, -31, -31])
        shiftY.append([-25, 31, 25, 31, -31, -31, 25, -25])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 402
        shiftX.append([29, 29, 28, 28, -28, -28, -29, -29])
        shiftY.append([28, -28, 29, -29, 29, -29, 28, -28])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 403
        shiftX.append([30, 27, 27, -30, 30, -27, -27, -30])
        shiftY.append([27, 30, -30, 27, -27, 30, -30, -27])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 404
        shiftX.append([31, 31, 26, 26, -26, -26, -31, -31])
        shiftY.append([26, -26, 31, -31, 31, -31, 26, -26])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 405
        shiftX.append([29, 29, -29, -29])
        shiftY.append([29, -29, 29, -29])
        counts.append(4)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 406
        shiftX.append([30, 30, 28, 28, -28, -28, -30, -30])
        shiftY.append([28, -28, 30, -30, 30, -30, 28, -28])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 407
        shiftX.append([31, 31, 27, 27, -27, -31, -27, -31])
        shiftY.append([27, -27, 31, -31, 31, 27, -31, -27])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 408
        shiftX.append([30, 30, 29, 29, -29, -29, -30, -30])
        shiftY.append([29, -29, 30, -30, 30, -30, 29, -29])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 409
        shiftX.append([31, 31, 28, 28, -28, -28, -31, -31])
        shiftY.append([28, -28, 31, -31, 31, -31, 28, -28])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 410
        shiftX.append([30, 30, -30, -30])
        shiftY.append([30, -30, 30, -30])
        counts.append(4)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 411
        shiftX.append([31, -29, 31, 29, 29, -29, -31, -31])
        shiftY.append([-29, 31, 29, 31, -31, -31, 29, -29])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 412
        shiftX.append([31, 31, 30, 30, -30, -30, -31, -31])
        shiftY.append([30, -30, 31, -31, 31, -31, 30, -30])
        counts.append(8)
        //~~~~~~~~
        //--------
        //~~~~~~~~
        //Level 413
        shiftX.append([31, 31, -31, -31])
        shiftY.append([31, -31, 31, -31])
        counts.append(4)
        //~~~~~~~~
        //--------
        
    }
    
}

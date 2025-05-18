//
//  AnimationTouchStateCommandChunk.swift
//  Yo Mamma Be Ugly
//
//  Created by Nick Raptis on 12/8/24.
//

enum AnimationTouchStateCommandChunk {
    case add(ObjectIdentifier, Float, Float)
    case remove(ObjectIdentifier)
    case move(ObjectIdentifier, Float, Float)
}

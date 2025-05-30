//
//  AnimationTouchStateCommand.swift
//  Yo Mamma Be Ugly
//
//  Created by Nick Raptis on 12/8/24.
//

import Foundation

class AnimationTouchStateCommand {
    
    var type = AnimationTouchStateCommandType.move
    var chunks = [AnimationTouchStateCommandChunk]()
    var chunkCount = 0
    func addChunk(chunk: AnimationTouchStateCommandChunk) {
        while chunks.count <= chunkCount {
            chunks.append(chunk)
        }
        chunks[chunkCount] = chunk
        chunkCount += 1
    }
    
}

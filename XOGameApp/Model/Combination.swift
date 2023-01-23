//
//  Parallel.swift
//  XOGameApp
//
//  Created by Julia on 16.01.2023.
//

import Foundation

enum Combination {
    case horizontall (parallel: HorizontallParallel)
    case vertcal (parallel: VerticalParallel)
    case diagonal (line: Diagonal)
}

enum VerticalParallel {
    case left
    case middle
    case rigth
}

enum HorizontallParallel {
    case upper
    case middle
    case lower
}

enum Diagonal {
    case first
    case second
}

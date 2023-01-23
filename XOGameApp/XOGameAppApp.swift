//
//  XOGameAppApp.swift
//  XOGameApp
//
//  Created by Julia on 15.12.2022.
//

import SwiftUI

@main
struct XOGameAppApp: App {
    
    @Namespace var nameSpace
    
    var body: some Scene {
        WindowGroup {
           StarterView(nameSpace: nameSpace)
        }
    }
}

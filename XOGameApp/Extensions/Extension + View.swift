//
//  Extension + View.swift
//  XOGameApp
//
//  Created by Julia on 12.01.2023.
//

import SwiftUI

extension View {
    func dissmissKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

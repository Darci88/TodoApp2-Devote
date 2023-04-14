//
//  HideKeyboardExtension.swift
//  Devote
//
//  Created by user219285 on 3/30/23.
//

import Foundation
import SwiftUI

#if canImport(UIKit)
extension View {
    func hideKeyvoard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

#endif

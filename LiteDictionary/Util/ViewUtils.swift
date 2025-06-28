//
//  ViewUtils.swift
//  LiteDictionary
//
//  Created by lee on 6/29/25.
//

import Foundation
import SwiftUI

public class ViewUtils {
    static var divider: some View {
        GeometryReader { _ in
            Color.clear.frame(height: 1).overlay(Divider())
        }
        .frame(height: 1)
    }
}

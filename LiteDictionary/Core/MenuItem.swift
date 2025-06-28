//
//  MenuItem.swift
//  LiteDictionary
//
//  Created by lee on 6/29/25.
//

import Foundation
import SwiftUI

struct MenuItem: View {
    let title: String
    var action: () -> Void

    @State private var isHovering = false

    var body: some View {
        HStack {
            Text(title)
                .foregroundColor(.black)
                .padding(.vertical, 4)
                .padding(.horizontal, 8)
            Spacer()
        }
        .background(isHovering ? Color.orange.opacity(0.3) : Color.clear)
        .cornerRadius(4)
        .onHover { hovering in
            withAnimation(.easeInOut(duration: 0.15)) {
                isHovering = hovering
            }
        }
        .onTapGesture {
            action()
        }
    }
}

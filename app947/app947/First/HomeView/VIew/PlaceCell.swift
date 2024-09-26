//
//  HomeCell.swift
//  app947
//
//  Created by Dias Atudinov on 26.09.2024.
//

import SwiftUI

struct PlaceCell: View {
    var body: some View {
        ZStack {
            VStack {
                Text("asdasd")
            }
        }
        .frame(height: 157)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.secondaryRed, lineWidth: 1)
        )
    }
}

#Preview {
    PlaceCell()
}

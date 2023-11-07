//
//  GridItemView.swift
//  Vaultorama
//
//  Created by Olivier Guillemot on 07/11/2023.
//

import SwiftUI

struct GridItemView: View {
    let size: Double
    let file: URL

    var body: some View {
        ZStack(alignment: .topTrailing) {
            AsyncImage(url: file) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                ProgressView()
            }
            .frame(width: size, height: size)
        }
    }
}

#Preview {
    ContentView()
}

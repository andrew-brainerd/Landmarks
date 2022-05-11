//
//  CircleImage.swift
//  Not Toast
//
//  Created by Andrew Brainerd on 5/8/22.
//

import SwiftUI

struct CircleImage: View {
    var previewImageUrl: String

    var body: some View {
        AsyncImage(
            url: URL(string: previewImageUrl),
            content: { image in
                image.clipShape(Circle())
                    .overlay {
                        Circle().stroke(.white, lineWidth: 4)
                    }
                    .shadow(radius: 7)
            },
            placeholder: {
                LottieView()
            }
        )
    }
}

struct CircleImage_Previews: PreviewProvider {
    static var previews: some View {
        CircleImage(previewImageUrl: "https://wallpaperaccess.com/full/5077863.jpg")
    }
}

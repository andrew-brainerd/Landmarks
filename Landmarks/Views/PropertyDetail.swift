//
//  PropertyDetail.swift
//  Not Toast
//
//  Created by Andrew Brainerd on 5/8/22.
//

import SwiftUI

struct PropertyDetail: View {
    var property: Property

    var body: some View {
        ScrollView {
            VStack() {
                Text("\(property.street) \(property.city)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Spacer()
                Text(property.price)
                    .font(.title2)
                    .foregroundColor(.green)
                Spacer()
                Button(action: {
                    guard let urlShare = URL(string: "https://developer.apple.com/xcode/swiftui/") else { return }
                    let activityVC = UIActivityViewController(activityItems: [urlShare], applicationActivities: nil)
                    UIApplication.shared.windows.first?.rootViewController?.present(activityVC, animated: true, completion: nil)

                }) {
                    Image(systemName: "square.and.arrow.up")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 32, height: 32)
                }

                Spacer()
                Spacer()

                ForEach(property.images, id: \.self) { imageUrl in
                    AsyncImage(
                        url: URL(string: imageUrl),
                        content: { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        },
                        placeholder: {
                            LottieView()
                        }
                    )
                }
            }
            .padding()
        }
        .navigationTitle(property.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct PropertyDetail_Prieviews: PreviewProvider {
    static var previews: some View {
        PropertyDetail(property: localProperties[0])
    }
}

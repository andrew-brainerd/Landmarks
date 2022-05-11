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
                
                ForEach(property.images, id: \.self) { imageUrl in
                    AsyncImage(
                        url: URL(string: imageUrl),
                        content: { image in
                            image.shadow(radius: 7)
                        },
                        placeholder: {
                            Text("Loading image...")
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

//
//  PropertyDetail.swift
//  Not Toast
//
//  Created by Andrew Brainerd on 5/8/22.
//

import SwiftUI

var defaultProperty = Property(id: "0", name: "Loading...", price: "0", bedrooms: 0, bathrooms: 0, street: "123 Easy St", city: "Ann Arbor, MI", images: [])

struct PropertyDetail: View {
    @State private var isLoadingPropertyDetails = true
    @State private var property: Property = defaultProperty
    @State public var propertyId: String

    var body: some View {
        if isLoadingPropertyDetails {
            LottieView()
        }
        ScrollView {
            if !isLoadingPropertyDetails {
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
                        guard let urlShare = URL(string: "https://not-toast-ui.herokuapp.com/properties/\(property.id)") else { return }
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
                                    .transition(.scale)
                            },
                            placeholder: {
                                Text("")
                            }
                        )
                    }
                }
                .padding()
            }
        }
        .navigationTitle(property.name)
        .navigationBarTitleDisplayMode(.inline)
        .task(id: propertyId) {
            property = await fetchProperty(propertyId: propertyId) ?? defaultProperty
            isLoadingPropertyDetails = false
        }
    }
}

struct PropertyDetail_Prieviews: PreviewProvider {
    static var previews: some View {
        PropertyDetail(propertyId: "00000")
    }
}

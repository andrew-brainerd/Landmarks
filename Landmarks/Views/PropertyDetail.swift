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
    @State private var isShowingPropertyList: Bool = false
    @State public var shouldShowBackButton: Bool = false

    var body: some View {
        if isLoadingPropertyDetails {
            LottieView()
        }
        ScrollView(.vertical, showsIndicators: false) {
            if shouldShowBackButton && !isShowingPropertyList {
                StickyHeader {
                    NavigationView {
                        ZStack {
                            VStack {
                                NavigationLink(destination: PropertyList(), isActive: $isShowingPropertyList) { EmptyView() }
                                Button("X") {
                                    isShowingPropertyList = true
                                }
                                .buttonStyle(.bordered)
                            }
                        }
                    }
                }
            }
            if !isLoadingPropertyDetails && !isShowingPropertyList {
                VStack {
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
                        guard let firstScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
                            return
                        }

                        guard let firstWindow = firstScene.windows.first else {
                            return
                        }

                        guard let viewController = firstWindow.rootViewController else {
                            return
                        }
                        viewController.present(activityVC, animated: true, completion: nil)

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

//
//  PropertyList.swift
//  Not Toast
//
//  Created by Andrew Brainerd on 5/8/22.
//

import SwiftUI

struct PropertyList: View {
    @State private var isLoadingLandmarks = true
    @State private var properties = [Property]()

    var body: some View {
        VStack {
            NavigationView {
                if isLoadingLandmarks {
                    LottieView(animationName: "home")
                        .offset(y: -100)
                        .padding()
                } else {
                    List(properties) { property in
                        NavigationLink {
                            PropertyDetail(property: property)
                        } label: {
                            PropertyRow(property: property)
                        }
                    }
                    .navigationTitle("Properties")
                    .refreshable {
                        properties = await fetchProperties()
                    }
                }
            }
            .task {
                properties = await fetchProperties()
                isLoadingLandmarks = false
            }

            if !isLoadingLandmarks {
                Divider()
                Button(action: {
                    UserDefaults.standard.set(false, forKey: "isAuthorized")
                }) {
                    Text("Logout")
                        .font(.title)
                        .foregroundColor(.white)
                }
                .padding(EdgeInsets(top: 5, leading: 25, bottom: 5, trailing: 25))
                .background(.purple)
                .frame(height: 50)
            }
        }
    }
}

struct PropertyList_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["iPhone SE (2nd generation)", "iPhone XS Max"], id: \.self) { deviceName in
            PropertyList()
                .previewDevice(PreviewDevice(rawValue: deviceName))
                .previewDisplayName(deviceName)
        }
    }
}

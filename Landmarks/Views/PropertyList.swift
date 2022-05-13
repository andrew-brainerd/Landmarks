//
//  PropertyList.swift
//  Not Toast
//
//  Created by Andrew Brainerd on 5/8/22.
//

import Auth0
import SwiftUI

struct PropertyList: View {
    @State private var isLoadingProperties = true
    @State private var properties = [Property]()

    var body: some View {
        VStack {
            NavigationView {
                if isLoadingProperties {
                    VStack {
                        if let userName = UserDefaults.standard.string(forKey: "userName") {
                            let _ = Log.write(message: "User name: \(userName)")
                            Text("Welcome \(userName)!")
                        }

                        LottieView(animationName: "home")
                            .offset(y: -100)
                            .padding()
                    }
                } else {
                    List(properties) { property in
                        NavigationLink {
                            PropertyDetail(propertyId: property.id)
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
                isLoadingProperties = false
            }

            if !isLoadingProperties {
                Divider()
                PurpleButton(text: "Logout", action: {
                    UserDefaults.standard.set(false, forKey: "isAuthorized")
                })
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

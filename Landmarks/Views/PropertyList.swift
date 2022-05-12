//
//  PropertyList.swift
//  Not Toast
//
//  Created by Andrew Brainerd on 5/8/22.
//

import Auth0
import SwiftUI

struct PropertyList: View {
    @State private var isLoadingLandmarks = true
    @State private var properties = [Property]()

    var body: some View {
        VStack {
            NavigationView {
                if isLoadingLandmarks {
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
                    Auth0
                        .webAuth()
                        .clearSession { result in
                            switch result {
                            case .success:
                                Log.write(message: "Logged out")
                                UserDefaults.standard.set(false, forKey: "isAuthorized")
                            case let .failure(error):
                                Log.write(message: "Failed with: \(error)")
                            }
                        }
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

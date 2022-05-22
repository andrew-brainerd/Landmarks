//
//  ContentView.swift
//  Not Toast
//
//  Created by Andrew Brainerd on 5/7/22.
//

import Auth0
import JWTDecode
import SwiftUI

struct ContentView: View {
    @Binding var redirectUrl: String
    @State var isLinkHandled = false

    @AppStorage("isAuthorized") var isAuthorized = false
    @AppStorage("userName") var userName: String = "Home Lover"

    var body: some View {
        if !isAuthorized {
            PurpleButton(text: "Login", action: {
                Auth0
                    .webAuth()
                    .useEphemeralSession()
                    .parameters(["prompt": "login"])
                    .start { result in
                        switch result {
                        case .success(let credentials):
                            Log.write(message: "Obtained credentials: \(credentials.expiresIn)")
                            guard let jwt = try? decode(jwt: credentials.idToken),
                                  let name = jwt.claim(name: "name").string else { return }
                            userName = name
                            isAuthorized = true
                        case .failure(let error):
                            Log.write(message: "Failed with: \(error)")
                        }
                    }

            })
        } else {
            if redirectUrl.isEmpty {
                PropertyList()
            } else {
                PropertyDetail(propertyId: redirectUrl, shouldShowBackButton: true)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(redirectUrl: .constant(""))
            .preferredColorScheme(.dark)
    }
}

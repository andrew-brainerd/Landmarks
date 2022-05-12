//
//  ContentView.swift
//  Not Toast
//
//  Created by Andrew Brainerd on 5/7/22.
//

import SwiftUI
import Auth0

struct ContentView: View {
    @AppStorage("isAuthorized") var isAuthorized = false

    var body: some View {
        let _ = Log.write(message: "Authorized: \(isAuthorized)")
        if (!isAuthorized) {
            Button(action: {
                Auth0
                    .webAuth()
                    .useEphemeralSession()
                    .start { result in
                        switch result {
                        case .success(let credentials):
                            Log.write(message: "Obtained credentials: \(credentials.expiresIn)")
                            isAuthorized = true
                        case .failure(let error):
                            Log.write(message: "Failed with: \(error)")
                        }
                    }

            }) {
                Text("Login")
                    .font(.title)
                    .foregroundColor(.white)
            }
            .padding(EdgeInsets(top: 5, leading: 25, bottom: 5, trailing: 25))
            .background(.purple)
        } else {
            PropertyList()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}

//
//  PurpleButton.swift
//  Landmarks
//
//  Created by Andrew Brainerd on 5/12/22.
//

import SwiftUI

struct PurpleButton: View {
    var text: String
    var action: (() -> Void)
    
    var body: some View {
        Button(action: action) {
            HStack {
                Text(text)
                    .font(.title)
                    .foregroundColor(.white)
            }
        }
        .padding(EdgeInsets(top: 10, leading: 25, bottom: 10, trailing: 25))
        .background(.purple)
        .cornerRadius(16)
    }
}

struct PurpleButton_Previews: PreviewProvider {
    static var previews: some View {
        PurpleButton(text: "Click Me", action: {
            print("Clicked the button")
        })
    }
}

//
//  ContentView.swift
//  Landmarks
//
//  Created by Andrew Brainerd on 5/7/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Turtle Rock")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.green)
            .textCase(Text.Case.uppercase)
            
            HStack {
                Text("Joshua Tree National Park")
                    .font(.subheadline)
                    .foregroundColor(.white)
                Spacer()
                Text("California")
                    .font(.subheadline)
                    .foregroundColor(.white)
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}


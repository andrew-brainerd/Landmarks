//
//  ContentView.swift
//  Landmarks
//
//  Created by Andrew Brainerd on 5/7/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            MapView()
                .ignoresSafeArea(edges: .top)
                .frame(height: 300)
            
            CircleImage()
                .offset(y: -130)
                .padding(.bottom, -130)
            
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
                
                Divider()
                
                Text("About Turtle Rock")
                    .font(.title2)
                Text("Turle Rock has lots of turtles")
            }
            .padding()
            
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}


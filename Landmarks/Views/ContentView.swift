//
//  ContentView.swift
//  Not Toast
//
//  Created by Andrew Brainerd on 5/7/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        PropertyList()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}

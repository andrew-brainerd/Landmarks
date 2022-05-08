//
//  LandmarkDetail.swift
//  Landmarks
//
//  Created by Andrew Brainerd on 5/8/22.
//

import SwiftUI

struct LandmarkDetail: View {
    var landmark: Landmark

    var body: some View {
        ScrollView {
            MapView(coordinate: landmark.locationCoordinate)
                .ignoresSafeArea(edges: .top)
                .frame(height: 300)
            
            CircleImage(image: landmark.image)
                .offset(y: -130)
                .padding(.bottom, -130)
            
            VStack(alignment: .leading) {
                Text(landmark.name)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.green)
                .textCase(Text.Case.uppercase)
                
                HStack {
                    Text(landmark.park)
                        .font(.subheadline)
                        .foregroundColor(.white)
                    Spacer()
                    Text(landmark.state)
                        .font(.subheadline)
                        .foregroundColor(.white)
                }
                
                Divider()
                
                Text("About \(landmark.name)")
                    .font(.title2)
                Text(landmark.description)
            }
            .padding()
        }
        .navigationTitle(landmark.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct LandmarkDetail_Previews: PreviewProvider {
    static var previews: some View {
        LandmarkDetail(landmark: landmarks[0])
    }
}
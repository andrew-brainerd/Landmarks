//
//  LandmarkList.swift
//  Landmarks
//
//  Created by Andrew Brainerd on 5/8/22.
//

import SwiftUI

struct LandmarkList: View {
    @State private var isLoadingLandmarks = true
    @State private var _landmarks = [Landmark]()

    var body: some View {
        NavigationView {
            if (isLoadingLandmarks) {
                VStack {
                    Text("Loading landmarks...")
                    LottieView()
                }
            } else {
                List(_landmarks) { landmark in
                    NavigationLink {
                        LandmarkDetail(landmark: landmark)
                    } label: {
                        LandmarkRow(landmark: landmark)
                    }
                }
                .navigationTitle("Landmarks")
            }
        }
        .task {
            _landmarks = await loadFromApi()
            isLoadingLandmarks = false
        }
    }
}

struct LandmarkList_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["iPhone SE (2nd generation)", "iPhone XS Max"], id: \.self) { deviceName in
            LandmarkList()
                .previewDevice(PreviewDevice(rawValue: deviceName))
                .previewDisplayName(deviceName)
        }
    }
}

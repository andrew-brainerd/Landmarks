//
//  PropertyRow.swift
//  Not Toast
//
//  Created by Andrew Brainerd on 5/8/22.
//

import SwiftUI

struct PropertyRow: View {
    var property: Property

    var body: some View {
        HStack {
            AsyncImage(
                url: URL(string: property.images[0]),
                content: { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: 50, maxHeight: 50)
                        },
                placeholder: {
                    Text("Loading...")
                }
            )
            Text(property.name)
            Spacer()
        }
    }
}

struct PropertyRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PropertyRow(property: localProperties[0])
            PropertyRow(property: localProperties[1])
        }
        .previewLayout(.fixed(width: 300, height: 70))
    }
}

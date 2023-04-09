//
//  Cat.swift
//  Dashboard
//
//  Created by Chris Ross on 4/9/23.
//

import SwiftUI

struct Cat: View {
    @EnvironmentObject var network: ImageFromNetwork
    @State var catImage: Image?
    
    var body: some View {
        VStack {
            catImage
        }.onAppear { network.getCatImage() }
            .onChange(of: network.cat, perform: setCatImage)
    }

    // Used to re-cache the network.cat image locally
    private func setCatImage(img: Image?) {
        catImage = img
    }
}

struct Cat_Previews: PreviewProvider {
    static var previews: some View {
        Cat()
            .environmentObject(ImageFromNetwork())
    }
}

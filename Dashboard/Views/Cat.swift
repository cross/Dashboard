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
    static var catImgUrl: String = "https://cataas.com/cat"
    
    var body: some View {
        VStack {    // Why does this need a VStack?  Maybe beacuse it starts nil?
            catImage?.resizable().scaledToFit()
        }
        .onAppear {
            network.setImgUrl(url: Cat.catImgUrl)
            network.getCatImage()
        }
        .onChange(of: network.image, perform: { image in
            if image != nil {
                setCatImage(img: image!)
            }
        })
    }

    // Used to re-cache the network.cat image locally
    private func setCatImage(img: Image) {
        catImage = img
    }
}

struct Cat_Previews: PreviewProvider {
    static var previews: some View {
        Cat()
            .environmentObject(ImageFromNetwork(url: Cat.catImgUrl))
    }
}

//
//  Network.swift
//  Dashboard
//
//  Created by Chris Ross on 4/9/23.
//

import Foundation
import SwiftUI

class ImageFromNetwork: ObservableObject {
    var imgUrl: String = "https://cataas.com/cat"
    @Published var cat: Image?
    
    // Create an image from Data, differently depending on platform
    func createImage(_ value: Data) -> Image {
        #if canImport(UIKit)
        let image: UIImage = UIImage(data: value) ?? UIImage()
        return Image(uiImage: image)
        #elseif canImport(AppKit)
        let image: NSImage = NSImage(data: value) ?? NSImage()
        return Image(nsImage: image)
        #else
        return Image(systemName: "globe")
        #endif
    }
    // So, this shouldn't be Cat specific.  :-/  But for now.
    func getCatImage() {
        guard let catUrl = URL(string: imgUrl) else { fatalError("Missing URL") }
        
        let urlRequest = URLRequest(url: catUrl)
        
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                print("Request error: ", error)
                return
            }
            
            guard let response = response as? HTTPURLResponse else { return }
            
            if response.statusCode == 200 {
                guard let data = data else { return }
                DispatchQueue.main.async {
                    self.cat = self.createImage(data)
                }
            }
        }
        dataTask.resume()
    }
    
}

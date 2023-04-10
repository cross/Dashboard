//
//  Network.swift
//  Dashboard
//
//  Created by Chris Ross on 4/9/23.
//

import Foundation
import SwiftUI

class ImageFromNetwork: ObservableObject {
    private var imgUrl: String?
    @Published var image: Image?
    
    init(url: String? = nil) {
        self.imgUrl = url
    }
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
        guard imgUrl != nil else { return; }
        guard let catUrl = URL(string: imgUrl!) else { fatalError("Missing URL") }
        
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
                    self.image = self.createImage(data)
                }
            }
        }
        dataTask.resume()
    }
    func setImgUrl(url: String) {
        self.imgUrl = url
    }
    
}

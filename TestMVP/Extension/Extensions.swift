//
//  Extensions.swift
//  AppDemos
//
//  Created by Juan Gerardo Cruz on 11/13/19.
//  Copyright © 2019 Juan Gerardo Cruz. All rights reserved.
//

import Foundation
import UIKit


extension UIImageView {
    func downloadFromServer(url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { (data, response, error) in
                guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
        }.resume()
    }
    
    func dowloadFromServer(link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloadFromServer(url: url, contentMode: mode)
    }
}

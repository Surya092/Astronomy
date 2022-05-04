//
//  UIImageView + Extension.swift
//  demo
//
//  Created by Surya on 04/05/22.
//

import UIKit

extension UIImageView {
    
    func setImage(image: String?) {
        guard let imageURL = image else { return }
        guard let url = URL(string: imageURL) else { return }
        downloadImage(url)
    }
    
    private func downloadImage(_ url: URL) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let data = data, error == nil,
                let image = UIImage(data: data)
            else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
}

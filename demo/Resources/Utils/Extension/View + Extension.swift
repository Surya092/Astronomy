//
//  View + Extension.swift
//  demo
//
//  Created by Surya on 04/05/22.
//

import Foundation
import UIKit

extension UIView {
    
    func addActivityIndicator() {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.color = UIColor.gray
        activityIndicator.center = self.center
        activityIndicator.bounds = CGRect(x: 0, y: 0, width: self.bounds.size.width * 0.2, height: self.bounds.size.width * 0.2)
        activityIndicator.startAnimating()
        self.addSubview(activityIndicator)
    }
    
    func removeActivityIndicator() {
        for view in self.subviews {
            if view.isKind(of: UIActivityIndicatorView.self) {
                view.removeFromSuperview()
            }
        }
    }
}

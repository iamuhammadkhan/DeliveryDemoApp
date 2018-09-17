//
//  ImageView+SetImageWithURL.swift
//  lalamove
//
//  Created by Muhammad Khan on 14/09/2018.
//  Copyright © 2018 Muhammad Khan. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {
    
    func setImageWithUrl(with url: String) {
        if let url = URL(string: url) {
            self.kf.setImage(with: url, placeholder: UIImage(named: "placeholder"), options: nil, progressBlock: nil, completionHandler: nil)
        }
    }
}

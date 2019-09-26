//
//  UIImageViewExtension.swift
//  PersonCounter
//
//  Created by Collin Hemeltjen on 24/09/2019.
//  Copyright © 2019 Collin Hemeltjen. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    var contentClippingRect: CGRect {
        guard let image = image else { return bounds }
        guard contentMode == .scaleAspectFit else { return bounds }
        guard image.size.width > 0 && image.size.height > 0 else { return bounds }

		let viewSize = bounds.size
		let scale = min(viewSize.width / image.size.width,
						viewSize.height / image.size.height)

        let size = CGSize(width: image.size.width * scale, height: image.size.height * scale)
        let xPos = (bounds.width - size.width) / 2.0
        let yPos = (bounds.height - size.height) / 2.0

        return CGRect(x: xPos, y: yPos, width: size.width, height: size.height)
    }

}

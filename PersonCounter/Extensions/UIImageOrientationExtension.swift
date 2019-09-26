//
//  UIImageOrientationExtension.swift
//  PersonCounter
//
//  Created by Collin Hemeltjen on 26/09/2019.
//  Copyright © 2019 Collin Hemeltjen. All rights reserved.
//

import UIKit

extension UIImage.Orientation {
	var cgOrientation: CGImagePropertyOrientation {
		get {
			switch self {
			case .up: return .up
			case .upMirrored: return .upMirrored
			case .down: return .down
			case .downMirrored: return .downMirrored
			case .left: return .left
			case .leftMirrored: return .leftMirrored
			case .right: return .right
			case .rightMirrored: return .rightMirrored
			@unknown default:
				fatalError()
			}
		}
	}
}

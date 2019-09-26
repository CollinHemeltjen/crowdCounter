//
//  SelectionBox.swift
//  PersonCounter
//
//  Created by Collin Hemeltjen on 06/09/2019.
//  Copyright © 2019 Collin Hemeltjen. All rights reserved.
//

import Foundation
import UIKit
import Vision

class SelectionBoxContainer: UIView {
	var boundingBoxes = [CGRect]()

	func clear() {
		boundingBoxes = []

		DispatchQueue.main.async {
			self.setNeedsDisplay()
		}
	}

	override func draw(_ rect: CGRect) {
		guard let context = UIGraphicsGetCurrentContext() else {
			return
		}

		context.saveGState()

		defer {
			context.restoreGState()
		}

		context.addRects(boundingBoxes)
		context.setLineWidth(5)

		tintColor.setStroke()

		context.strokePath()
	}
}

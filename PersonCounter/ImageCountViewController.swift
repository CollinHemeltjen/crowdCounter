//
//  ImageCountViewController.swift
//  PersonCounter
//
//  Created by Collin Hemeltjen on 08/09/2019.
//  Copyright © 2019 Collin Hemeltjen. All rights reserved.
//

import UIKit
import Vision

class ImageCountViewController: UIViewController, Storyboarded {
	var image: UIImage?

	@IBOutlet weak var countLabel: UILabel!
	@IBOutlet weak var boxView: SelectionBoxContainer!
	@IBOutlet weak var imageView: UIImageView!
	@IBOutlet weak var countLabelView: UIVisualEffectView!

	var amountOfFaces = 0 {
		didSet {
			DispatchQueue.main.async {
				self.countLabel.text = "\(self.amountOfFaces)"
			}
		}
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		imageView.image = image

		countLabelView.layer.cornerRadius = 10
		countLabelView.clipsToBounds = true

		startFaceDetection()
	}

	func startFaceDetection() {
		guard let image = image else { return }
		guard let cgImage = image.cgImage else { return }
		// Create a request handler.
		let imageRequestHandler = VNImageRequestHandler(cgImage: cgImage,
														orientation: image.imageOrientation.cgOrientation,
														options: [:])

		var request: VNImageBasedRequest
		// create detection request
		request = VNDetectFaceRectanglesRequest(completionHandler: detectedFace)

		// Send the requests to the request handler.
		DispatchQueue.global(qos: .userInitiated).async {
			do {
				self.isCounting(true)
				try imageRequestHandler.perform([request])
			} catch {
				self.isCounting(false)
				print(error.localizedDescription)
			}
		}
	}

	func detectedFace(request: VNRequest, error: Error?) {
		// get first result
		guard
			let results = request.results as? [VNFaceObservation]
			else {
				// clear view if nothing is detected
				amountOfFaces = 0
				boxView.clear()
				isCounting(false)
				return
		}

		amountOfFaces = results.count
		isCounting(false)
		// draw box
		boxView.clear()

		for result in results {
			let box = result.boundingBox

			DispatchQueue.main.async {
				self.boxView.boundingBoxes.append(self.convertToLayerRect(deviceRect: box))
				self.boxView.setNeedsDisplay()
			}
		}
	}

	func convertToLayerRect(deviceRect rect: CGRect) -> CGRect {
		let size = CGSize(width: rect.width * boxView.bounds.width,
						  height: rect.height * boxView.bounds.height)

		let origin = CGPoint(x: rect.minX * boxView.bounds.width,
							 y: (1 - rect.minY) * boxView.bounds.height - size.height)

		return CGRect(origin: origin, size: size)
	}

	@IBAction func clickedBack(_ sender: Any) {
		dismiss(animated: true, completion: nil)
	}

	override func viewDidLayoutSubviews() {
		boxView.frame = imageView.contentClippingRect
	}

	@IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
	func isCounting(_ isCounting: Bool) {
		DispatchQueue.main.async {
			self.activityIndicatorView.isHidden = !isCounting
			self.countLabel.isHidden = isCounting
		}
	}
}

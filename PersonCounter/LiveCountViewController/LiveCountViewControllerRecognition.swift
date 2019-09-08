//
//  LiveCountViewControllerRecognition.swift
//  PersonCounter
//
//  Created by Collin Hemeltjen on 07/09/2019.
//  Copyright © 2019 Collin Hemeltjen. All rights reserved.
//

import UIKit
import AVFoundation
import Vision

extension LiveCountViewController: AVCaptureVideoDataOutputSampleBufferDelegate {
	// swiftlint:disable vertical_parameter_alignment
	func captureOutput(_ output: AVCaptureOutput,
					   didOutput sampleBuffer: CMSampleBuffer,
					   from connection: AVCaptureConnection) {

		// get image buffer
		guard let imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {
			return
		}

		// create detection request
		let detectFaceRequest = VNDetectFaceRectanglesRequest(completionHandler: detectedFace)

		// perform detection
		do {
			try sequenceHandler.perform(
				[detectFaceRequest],
				on: imageBuffer,
				orientation: .downMirrored)
		} catch {
			print(error.localizedDescription)
		}
	}

	func convertToLayerRect(deviceRect rect: CGRect) -> CGRect {
		let opposite = rect.origin + rect.size.cgPoint
		let origin = cameraLayer.layerPointConverted(fromCaptureDevicePoint: rect.origin)

		let opp = cameraLayer.layerPointConverted(fromCaptureDevicePoint: opposite)

		let size = (opp - origin).cgSize
		return CGRect(origin: origin, size: size)
	}

	func detectedFace(request: VNRequest, error: Error?) {
		// get first result
		guard
			let results = request.results as? [VNFaceObservation]
			else {
				// clear view if nothing is detected
				amountOfFaces = 0
				boxView.clear()
				return
		}

		amountOfFaces = results.count
		// draw box
		boxView.clear()

		for result in results {
			let box = result.boundingBox
			self.boxView.boundingBoxes.append(self.convertToLayerRect(deviceRect: box))

			DispatchQueue.main.async {

				self.boxView.setNeedsDisplay()
			}
		}
	}
}

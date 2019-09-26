//
//  LieveCountViewControllerVideoInit.swift
//  PersonCounter
//
//  Created by Collin Hemeltjen on 07/09/2019.
//  Copyright © 2019 Collin Hemeltjen. All rights reserved.
//

import UIKit
import AVFoundation

// configures all camera based actions
extension LiveCountViewController: UIGestureRecognizerDelegate {
	func configureCaptureSession() {
		// Define the camera to use
		guard let camera = AVCaptureDevice.default(.builtInWideAngleCamera,
												   for: .video,
												   position: .back) else {

			fatalError("No camera available")
		}

		// connect camera to session input
		do {
			let camera = try AVCaptureDeviceInput(device: camera)
			captureSession.addInput(camera)
		} catch {
			
		}

		// define video data output
		let videoOutput = AVCaptureVideoDataOutput()
		videoOutput.setSampleBufferDelegate(self, queue: dataOutputQueue)
		videoOutput.videoSettings = [kCVPixelBufferPixelFormatTypeKey as String: kCVPixelFormatType_32BGRA]

		captureSession.addOutput(videoOutput)

		// configure camera layer
		cameraLayer = AVCaptureVideoPreviewLayer(session: captureSession)
		cameraLayer.videoGravity = .resizeAspectFill

		// ajust the frame to always use portrait
		let width = min(view.bounds.width, view.bounds.height)
		let height = max(view.bounds.width, view.bounds.height)
		let frame = CGRect(x: 0, y: 0, width: width, height: height)
		cameraLayer.frame = frame
		view.layer.insertSublayer(cameraLayer, at: 0)

		// start session
		captureSession.startRunning()

		// add double tap to switch camera
		let tap = UITapGestureRecognizer(target: self, action: #selector(switchCamera))
		tap.numberOfTapsRequired = 2
		view.addGestureRecognizer(tap)
	}

	/// Create new capture device with requested position
	func captureDevice(with position: AVCaptureDevice.Position) -> AVCaptureDevice? {

		let devices = AVCaptureDevice.DiscoverySession(deviceTypes: [ .builtInWideAngleCamera],
													   mediaType: AVMediaType.video,
													   position: .unspecified).devices

		for device in devices where device.position == position {
			return device
		}

		return nil
	}

	@IBAction func switchCamera(_ sender: Any) {
		// Get current input
		guard let input = captureSession.inputs[0] as? AVCaptureDeviceInput else { return }

		// Begin new session configuration and defer commit
		captureSession.beginConfiguration()
		defer { captureSession.commitConfiguration() }

		// Create new capture device
		var newDevice: AVCaptureDevice?
		if input.device.position == .back {
			newDevice = captureDevice(with: .front)
		} else {
			newDevice = captureDevice(with: .back)
		}

		guard let device = newDevice else {
			fatalError("No camera available")
		}

		// Create new capture input
		var deviceInput: AVCaptureDeviceInput!
		do {
			deviceInput = try AVCaptureDeviceInput(device: device)
		} catch let error {
			print(error.localizedDescription)
			return
		}

		// Swap capture device inputs
		captureSession.removeInput(input)
		captureSession.addInput(deviceInput)
	}

}

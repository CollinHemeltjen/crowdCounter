//
//  ViewController.swift
//  PersonCounter
//
//  Created by Collin Hemeltjen on 06/09/2019.
//  Copyright © 2019 Collin Hemeltjen. All rights reserved.
//

import UIKit
import AVFoundation
import Vision

class LiveCountViewController: UIViewController {

	@IBOutlet weak var boxView: SelectionBoxContainer!

	var sequenceHandler = VNSequenceRequestHandler()

	let captureSession = AVCaptureSession()
	var cameraLayer: AVCaptureVideoPreviewLayer!

	let dataOutputQueue = DispatchQueue(
		label: "video data queue",
		qos: .userInitiated,
		attributes: [],
		autoreleaseFrequency: .workItem)

	@IBOutlet weak var countLabel: UILabel!
	var amountOfFaces = 0 {
		didSet {
			DispatchQueue.main.async {
				self.countLabel.text = "\(self.amountOfFaces)"
			}
		}
	}

	@IBOutlet weak var countLabelView: UIVisualEffectView!

	override func viewDidLoad() {
		super.viewDidLoad()
		
		configureCaptureSession()
		NotificationCenter.default.addObserver(self,
											   selector: #selector(deviceRotated),
											   name: UIDevice.orientationDidChangeNotification,
											   object: nil)

		countLabelView.layer.cornerRadius = 10
		countLabelView.clipsToBounds = true
	}

	override var shouldAutorotate: Bool {
		get { return false }
	}
	
	override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
		return .portrait
	}

	@IBOutlet weak var backButton: UIButton!
	@IBOutlet weak var countLabelStackView: UIStackView!
	@IBOutlet weak var rotateCameraButton: UIButton!
	@objc func deviceRotated() {
		let deviceOrientation = UIDevice.current.orientation

		let potentialAngle: Double?
		switch deviceOrientation {
		case .portraitUpsideDown:
			potentialAngle = Double.pi
		case .landscapeLeft:
			potentialAngle = Double.pi / 2
		case .landscapeRight:
			potentialAngle = -Double.pi / 2
		case .portrait:
			potentialAngle = 0
		default:
			potentialAngle = nil
		}

		guard let angle = potentialAngle else { return }
		UIView.animate(withDuration: 0.2) {
			self.countLabelStackView.transform = CGAffineTransform(rotationAngle: CGFloat(angle))
			self.rotateCameraButton.transform = CGAffineTransform(rotationAngle: CGFloat(angle))
			self.backButton.transform = CGAffineTransform(rotationAngle: CGFloat(angle))
		}
	}

	@IBAction func test(_ sender: Any) {
		dismiss(animated: true, completion: nil)
	}
}

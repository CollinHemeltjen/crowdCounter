//
//  MenuViewController.swift
//  PersonCounter
//
//  Created by Collin Hemeltjen on 08/09/2019.
//  Copyright © 2019 Collin Hemeltjen. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

class MenuViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

	@IBAction func countFromImage(_ sender: UIButton) {
		let alertController = UIAlertController(title: "How would you like to proceed?",
												message: "What method do you want to use to select a picture?",
												preferredStyle: .actionSheet)

		// check if device has a functional camera before giving the option to use it
		if UIImagePickerController.isSourceTypeAvailable(.camera) {
			alertController.addAction(UIAlertAction(title: "Camera", style: .default) { _ in
				self.showImagePicker(sourceType: .camera)
			})
		}
		alertController.addAction(UIAlertAction(title: "Photo library", style: .default) { _ in
			self.showImagePicker(sourceType: .photoLibrary)
		})
		alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

		// add source to support iPad
		alertController.popoverPresentationController?.sourceView = self.view
		alertController.popoverPresentationController?.sourceRect = sender.bounds

		self.present(alertController, animated: true)
	}

	func showImagePicker(sourceType: UIImagePickerController.SourceType) {
		let imagePickerController = UIImagePickerController()
		imagePickerController.delegate = self
		imagePickerController.sourceType = sourceType
		self.present(imagePickerController, animated: true)
	}

	@IBAction func showLiveCounter(_ sender: Any) {
		// check if device has camera
		guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
			showNoCameraAlert()
			return
		}

		// start live count view controller
		let viewController = LiveCountViewController.instantiate()
		self.present(viewController, animated: true)
	}

	func showNoCameraAlert() {
		let alertController = UIAlertController(title: "No camera found.",
		message: "We couldn't find a camera to use.",
		preferredStyle: .alert)
		alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
		self.present(alertController, animated: true)
	}

	//swiftlint:disable vertical_parameter_alignment
	func imagePickerController(_ picker: UIImagePickerController,
							   didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
		var newImage: UIImage

		if let possibleImage = info[.editedImage] as? UIImage {
			newImage = possibleImage
		} else if let possibleImage = info[.originalImage] as? UIImage {
			newImage = possibleImage
		} else {
			return
		}

		dismiss(animated: true) {
			let viewController = ImageCountViewController.instantiate()
			viewController.image = newImage
			self.present(viewController, animated: true)
		}
	}
}

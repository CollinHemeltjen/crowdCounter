//
//  MenuViewController.swift
//  PersonCounter
//
//  Created by Collin Hemeltjen on 08/09/2019.
//  Copyright © 2019 Collin Hemeltjen. All rights reserved.
//

import Foundation
import UIKit

class MenuViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

	@IBAction func countFromImage(_ sender: Any) {
		let alertController = UIAlertController(title: "How would you like to proceed?",
												message: "Do you want to select an image, or take a picture?",
												preferredStyle: .actionSheet)
		alertController.addAction(UIAlertAction(title: "Camera", style: .default) { _ in
			self.showImagePicker(sourceType: .camera)
		})
		alertController.addAction(UIAlertAction(title: "Photo library", style: .default) { _ in
			self.showImagePicker(sourceType: .photoLibrary)
		})
		alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
		self.present(alertController, animated: true)
	}

	func showImagePicker(sourceType: UIImagePickerController.SourceType) {
		let imagePickerController = UIImagePickerController()
		imagePickerController.delegate = self
		imagePickerController.sourceType = sourceType
		self.present(imagePickerController, animated: true)
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

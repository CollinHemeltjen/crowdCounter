//
//  ImageCountViewController.swift
//  PersonCounter
//
//  Created by Collin Hemeltjen on 08/09/2019.
//  Copyright © 2019 Collin Hemeltjen. All rights reserved.
//

import UIKit

class ImageCountViewController: UIViewController, Storyboarded {
	var image: UIImage?

	@IBOutlet weak var imageView: UIImageView!
	override func viewDidLoad() {
        super.viewDidLoad()
		imageView.image = image

    }

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
	}

	var passedOnce = false
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()

	}

	@IBAction func clickedBack(_ sender: Any) {
		dismiss(animated: true, completion: nil)
	}
}

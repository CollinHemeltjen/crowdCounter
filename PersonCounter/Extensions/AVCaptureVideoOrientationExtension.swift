//
//  AVCaptureVideoOrientationExtension.swift
//  PersonCounter
//
//  Created by Collin Hemeltjen on 07/09/2019.
//  Copyright © 2019 Collin Hemeltjen. All rights reserved.
//
import AVFoundation
import UIKit
extension AVCaptureVideoOrientation {
	var uiInterfaceOrientation: UIInterfaceOrientation {
		get {
			switch self {
			case .landscapeLeft:        return .landscapeLeft
			case .landscapeRight:       return .landscapeRight
			case .portrait:             return .portrait
			case .portraitUpsideDown:   return .portraitUpsideDown
			@unknown default:
				fatalError()
			}
		}
	}

	init(ui: UIInterfaceOrientation) {
		switch ui {
		case .landscapeRight:       self = .landscapeRight
		case .landscapeLeft:        self = .landscapeLeft
		case .portrait:             self = .portrait
		case .portraitUpsideDown:   self = .portraitUpsideDown
		default:                    self = .portrait
		}
	}

	init?(orientation: UIDeviceOrientation) {
		switch orientation {
		case .landscapeRight:       self = .landscapeLeft
		case .landscapeLeft:        self = .landscapeRight
		case .portrait:             self = .portrait
		case .portraitUpsideDown:   self = .portraitUpsideDown
		default:
			return nil
		}
	}
}

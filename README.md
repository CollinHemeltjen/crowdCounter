# PeopleCounter

![Preview](preview.png)

## Overview
The goal of the app was to count the amount of people in a frame. 
This app uses the [Vision API](https://developer.apple.com/documentation/vision
) to detect the amout of faces in a picture. The app includes a live count view which analyses every frame to count the amount of visible faces. Aswell as an option to pass a static image.

![Liveview demo](peopleCounter.gif)


At the moment of developing, iOS 13 was still in beta. Which meant I had to use ```VNDetectFaceRectanglesRequest``` instead of the new ```VNDetectHumanRectanglesRequest``` I may update the app someday to use this instead

*The app was developed for the Mobile Application Development Minor at the HAN University of Applied Sciences in the Netherlands.*

## Installation
Try this app download or clone the project (on a Mac) and open ```PersonCounter.xcodeproj``` in xCode. From there you can run the app in the simulator or on a device.

*Note: The live view wil not work inside the simulator or a device without a camera.*
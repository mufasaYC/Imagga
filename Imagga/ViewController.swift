//
//  ViewController.swift
//  Imagga
//
//  Created by Mustafa Yusuf on 20/08/17.
//  Copyright © 2017 Mustafa Yusuf. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

	@IBOutlet weak var selectedImageView: UIImageView!
	@IBOutlet weak var tagsLabel: UILabel!
	var imagePicker: UIImagePickerController!
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
	}
	
	@IBAction func takePhoto(_ sender: UIBarButtonItem) {
		imagePicker =  UIImagePickerController()
		imagePicker.delegate = self
		imagePicker.sourceType = .camera
		present(imagePicker, animated: true, completion: nil)
	}
	
	//MARK: - Done image capture here
	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
		imagePicker.dismiss(animated: true, completion: nil)
		selectedImageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
	}
	
	//MARK: - Taking image from gallery
	
	@IBAction func btnClicked() {
		
		if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
			print("Button capture")
			
			imagePicker.delegate = self
			imagePicker.sourceType = .savedPhotosAlbum;
			imagePicker.allowsEditing = false
			
			self.present(imagePicker, animated: true, completion: nil)
		}
	}
	
	func imagePickerController(_ picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!){
		self.dismiss(animated: true, completion: { () -> Void in
			
		})
		selectedImageView.image = image
	}

}


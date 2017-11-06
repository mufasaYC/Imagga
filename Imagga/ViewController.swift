//
//  ViewController.swift
//  Imagga
//
//  Created by Mustafa Yusuf on 20/08/17.
//  Copyright © 2017 Mustafa Yusuf. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

	@IBOutlet weak var selectedImageView: UIImageView!
	@IBOutlet weak var tagsLabel: UILabel!
	
	var imagePicker = UIImagePickerController()
	
	var localPath = URL(fileURLWithPath: "")
	
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
	
	@IBAction func btnClicked(_ sender: UIBarButtonItem) {
		
		if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
			print("Button capture")
			imagePicker =  UIImagePickerController()
			imagePicker.delegate = self
			imagePicker.sourceType = .savedPhotosAlbum;
			imagePicker.allowsEditing = false
			
			self.present(imagePicker, animated: true, completion: nil)
		}
	}
	
	func imagePickerController(_ picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!){
		
		let imageUrl          = editingInfo[UIImagePickerControllerReferenceURL] as! NSURL
		let imageName         = imageUrl.lastPathComponent
		let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
		let photoURL          = NSURL(fileURLWithPath: documentDirectory)
		localPath         = photoURL.appendingPathComponent(imageName!)!

		
		
		
		
		self.dismiss(animated: true, completion: { () -> Void in
		})
		
		selectedImageView.image = image
	}
	
	@IBAction func uploadImage(_ sender: UIButton) {
		
//		let credentialData = "acc_76c01341e0a5f87:7a81527f653ab86b3a630c830dc583be".data(using: String.Encoding.utf8)!
//		let base64Credentials = credentialData.base64EncodedString()
		let headers = ["Accept": "application/json", "Authorization" : "Basic YWNjXzc2YzAxMzQxZTBhNWY4Nzo3YTgxNTI3ZjY1M2FiODZiM2E2MzBjODMwZGM1ODNiZQ=="]
		
		Alamofire.upload(localPath, to: "https://api.imagga.com/v1/content", method: .post, headers: headers).responseJSON(completionHandler: {res in
		
			if res.result.isSuccess {
				print("SUCCESS")
				if let JSON: NSDictionary = res.result.value as? NSDictionary {
					print(JSON)
				}
			} else {
				print("FAILURE: \(res.error.debugDescription)")
			}
		
		})
		
	}

}

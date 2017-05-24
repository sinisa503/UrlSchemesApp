//
//  ViewController.swift
//  UrlSchemeApp
//
//  Created by Sinisa Vukovic on 23/05/2017.
//  Copyright © 2017 Sinisa Vukovic. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
   
   @IBOutlet weak var phoneLabel: UITextField!
   @IBOutlet weak var mailLabel: UITextField!
   @IBOutlet weak var urlLabel: UITextField!
   private var selectedPhoto:UIImage?
   
   let imagePicker = UIImagePickerController()
   
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      if let imageVC = segue.destination as? ImageVC {
         if let selectedPhoto = selectedPhoto {
            imageVC.photo = selectedPhoto
         }
      }
   }
   
   @IBAction func callPhone(_ sender: UIButton) {
      if let phoneNumber = phoneLabel.text {
         if verifyUrl(urlString: phoneNumber) {
            UIApplication.shared.open(URL(string: "tel://\(phoneNumber)")!, options: [:], completionHandler: nil)
         }else {
            issueAlert(title: "Error", messagge: "You have entered phone wrong number")
         }
      }
   }
   
   @IBAction func sendEmail(_ sender: UIButton) {
      if let emaiAddress = mailLabel.text {
         if verifyUrl(urlString: emaiAddress) {
            UIApplication.shared.open(URL(string: "mailto:\(emaiAddress)")!, options: [:], completionHandler: nil)
         }else {
            issueAlert(title: "Error", messagge: "You have entered wrong email address")
         }
      }
   }
   
   @IBAction func goToURL(_ sender: UIButton) {
      if let url = urlLabel.text {
         if verifyUrl(urlString: url) {
            UIApplication.shared.open(URL(string: url)!, options: [:], completionHandler: nil)
         }else {
            issueAlert(title: "Error", messagge: "You have entered wrong URL")
         }
      }
   }
   
   @IBAction func selectImage(_ sender: UIButton) {
      imagePicker.sourceType = .photoLibrary
      imagePicker.delegate = self
      present(imagePicker, animated: true, completion: nil)
   }
   
   override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
      urlLabel.resignFirstResponder()
      mailLabel.resignFirstResponder()
      phoneLabel.resignFirstResponder()
   }
   
   func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
      
      let frame = view.bounds
      
      if let editedPhoto = info[UIImagePickerControllerEditedImage] as? UIImage {
         UIGraphicsBeginImageContext(CGSize(width: 320.0, height: 480.0));
         editedPhoto.draw(in: CGRect(x: 0, y: 0, width: 320, height: 480))
         let watermarkFrame = CGRect(x: frame.minX, y: frame.midY - 75.0, width: frame.width - 16.0, height: 150.0)
         UIImage(named:"watermark.png")?.draw(in: watermarkFrame , blendMode: .normal, alpha: 0.5)
         let watImage = UIGraphicsGetImageFromCurrentImageContext();
         if let watermarkedImage = watImage {
            selectedPhoto = watermarkedImage
         }else {
            selectedPhoto = editedPhoto
         }
            UIGraphicsEndImageContext();
      } else if let originalPhoto = info[UIImagePickerControllerOriginalImage] as? UIImage {
         UIGraphicsBeginImageContext(CGSize(width: frame.width, height: frame.height));
         originalPhoto.draw(in: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
         let watermarkFrame = CGRect(x: frame.minX, y: frame.midY - 75.0, width: frame.width - 16.0, height: 150.0)
         UIImage(named:"watermark.png")?.draw(in: watermarkFrame , blendMode: .normal, alpha: 0.5)
         let watImage = UIGraphicsGetImageFromCurrentImageContext();
         if let watermarkedImage = watImage {
            selectedPhoto = watermarkedImage
         }else {
            selectedPhoto = originalPhoto
         }
         UIGraphicsEndImageContext();
      }
      imagePicker.dismiss(animated: true, completion: nil)
      performSegue(withIdentifier: "GoToImageVC", sender: nil)
   }
   
   private func issueAlert(title:String, messagge:String) {
      let alert = UIAlertController(title: title, message: messagge, preferredStyle: .alert)
      let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
      alert.addAction(action)
      present(alert, animated: true, completion: nil)
   }
   
   private func verifyUrl (urlString: String?) -> Bool {
      if let urlString = urlString {
         if let url = URL(string: urlString) {
            return UIApplication.shared.canOpenURL(url)
         }
      }
      return false
   }
}


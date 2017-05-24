//
//  ImageVC.swift
//  UrlSchemeApp
//
//  Created by Sinisa Vukovic on 24/05/2017.
//  Copyright © 2017 Sinisa Vukovic. All rights reserved.
//

import UIKit

class ImageVC: UIViewController {
   
   @IBOutlet weak var image: UIImageView!
   
   var photo: UIImage?
   
   
   override func viewDidLoad() {
      super.viewDidLoad()
      makeCancelButton()
   }

   override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      
      if let photo = photo {
         image.image = photo
      }
   }
   
   //Interface builder for some reason won't make connection so button is made in code
   private func makeCancelButton() {
      let height = CGFloat(35.0)
      let constraint = CGFloat(8.0)
      let width = view.bounds.width - (constraint * 2)
      let frame = CGRect(x: view.bounds.midX - (width / 2), y: view.bounds.maxY - (height + constraint) , width: width, height: height)
      let cancelButton = UIButton(frame: frame)
      cancelButton.backgroundColor = UIColor.blue
      cancelButton.setTitle("Cancel", for: .normal)
      cancelButton.setTitleColor(UIColor.white, for: .normal)
      cancelButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
      
      view.addSubview(cancelButton)
      view.bringSubview(toFront: cancelButton)
   }
   
   @objc private func goBack() {
      dismiss(animated: true, completion: nil)
   }
}

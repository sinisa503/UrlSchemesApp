//
//  CustomButton.swift
//  UrlSchemeApp
//
//  Created by Sinisa Vukovic on 24/05/2017.
//  Copyright © 2017 Sinisa Vukovic. All rights reserved.
//

import UIKit
@IBDesignable
class CustomButton: UIButton {
   
   override func layoutSubviews() {
      super.layoutSubviews()
      
      self.layer.cornerRadius = self.frame.height / 2
   }

}

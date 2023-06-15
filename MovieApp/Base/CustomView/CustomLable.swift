//
//  CustomLable.swift
//  MovieApp
//
//  Created by BeeTech on 15/06/2023.
//

import UIKit

public class CustomLabel: UILabel {

    @IBInspectable var topInset: CGFloat = 10.0
   @IBInspectable var bottomInset: CGFloat = 10.0
   @IBInspectable var leftInset: CGFloat = 10.0
   @IBInspectable var rightInset: CGFloat = 10.0

    public override func drawText(in rect: CGRect) {
      let insets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
       super.drawText(in: rect.inset(by: insets))
   }

    public override var intrinsicContentSize: CGSize {
      get {
         var contentSize = super.intrinsicContentSize
         contentSize.height += topInset + bottomInset
         contentSize.width += leftInset + rightInset
         return contentSize
      }
   }
}

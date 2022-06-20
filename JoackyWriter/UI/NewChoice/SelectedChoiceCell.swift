//
//  SelectedChoiceCell.swift
//  SQLitedemo
//
//  Created by Vinay Patel on 04/08/2021.
//

import UIKit

class SelectedChoiceCell: UICollectionViewCell {
    
    @IBOutlet weak var lblChoice: UILabel!
    @IBOutlet weak var imgChoice : UIImageView!
    
    var selectedChoice : selectedChoiceWords? {
        didSet {
            
            guard let model = selectedChoice else {
                return
            }
            
            lblChoice.text = model.strCaption
            lblChoice.isHidden = model.isImageHasText
            
            if model.strImageName.isEmpty {
                imgChoice.isHidden = true
                lblChoice.font = UIFont.systemFont(ofSize: 18,weight: .bold)
            } else {
                lblChoice.font = UIFont.systemFont(ofSize: 17,weight: .regular)
                imgChoice.isHidden = false
                guard let img = APPDELEGATE.loadImageFromDocumentDirectory(nameOfImage: model.strImageName) else {return}
                imgChoice.image = img
            }
            
        }
    }
}

class SelectedChoiceWithTextOnlyCell: UICollectionViewCell {
    
    @IBOutlet weak var lblChoice: UILabel!
    
    var selectedChoice : selectedChoiceWords? {
        didSet {
            
            guard let model = selectedChoice else {
                return
            }
            //lblChoice.font = UIFont.systemFont(ofSize: 18,weight: .bold)
            lblChoice.text = model.strCaption
        }
    }
}

/*
 
 if let parentVC = self.parentContainerViewController() as? ProductsDetailsViewController{
     parentVC.productDetailsViewModel.productQuantity = num
 }
 
 
 extension QuantityHolderTableCell : UITextFieldDelegate {
     func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
         let newText = (textField.text! as NSString).replacingCharacters(in: range, with: string) as String
         if let num = Int(newText), num >= 0 && num <= 1000{
             
             if let parentVC = self.parentContainerViewController() as? ProductsDetailsViewController{
                 parentVC.productDetailsViewModel.productQuantity = num
             }
             return true
         } else {
             return false
         }
     }
 }
 
 //REgisterationViewModel
 
 invalid = invalid ? invalid :model?.email?.isValidEmail ?? false
 message = invalid && message == nil  ? K().validEmail : message
 invalid = invalid ? invalid : model?.phone?.isValidPhone ?? false
 message = invalid && message == nil  ? K().validPhone:message
 
 //registrationViewController
 
 registration success Alert
 message?.replacingOccurrences(of: "<ul>", with: "\n").removeHTMLTag()
 
 // extesion StringProtocol
 
 func removeHTMLTag() -> String {

        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: String.CompareOptions.regularExpression, range: nil)

     }
 
 
 ContactVenderViewController
 
 checkForTextField
 
 func checkForTextField() -> Bool {
     
     self.submitButton.backgroundColor = .systemGray
     
     guard (self.nameTextInputView.textField.text?.trimmingCharacters(in: .whitespacesAndNewlines).count ?? 0) > 0 else {
         return false
     }
     
     guard (self.emailTextInputView.textField.text?.count ?? 0) > 0 else {
         return false
     }
     
     guard (self.enquiryTextInputView.textField.text?.trimmingCharacters(in: .whitespacesAndNewlines).count ?? 0) > 0 else {
         return false
     }
     
     self.submitButton.backgroundColor = KColor.buttonBackgroundColor
     
     return true
 }
 
 */

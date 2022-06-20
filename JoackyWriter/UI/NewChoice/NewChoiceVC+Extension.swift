//
//  AddChoiceVC+Extension.swift
//  JoackyWriter
//
//  Created by Vinay Patel on 13/04/2022.
//

import Foundation
import UIKit

extension NewChoiceVC : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
        if collectionView == clVwChoices {
        
            return choices.count
        } else {
            return arrSelectedChoices.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        
        if collectionView == clVwChoices {
            
        let cell = clVwChoices.dequeueReusableCell(withReuseIdentifier: "choiceCell", for: indexPath) as! ChoiceClVwCell
        
        cell.modelChoice = choices[indexPath.row]
        
        return cell
        } else {
            
//            if indexPath.row >= arrSelectedChoices.count - 1 {
//                return UICollectionViewCell()
//            } else {
                
                let model = arrSelectedChoices[indexPath.row]
                
                if model.strImageName.isEmpty {
                    
                    let cell = clVwSelectedChoices.dequeueReusableCell(withReuseIdentifier: "cell1", for: indexPath) as! SelectedChoiceWithTextOnlyCell
                    
                    cell.selectedChoice = model
                    
                    if isSpeaking {
                        cell.lblChoice.textColor = model.isSpeaking ? .red : .black
    //                    if indexPath.row == arrSelectedChoices.count - 1 {
    //                        isSpeaking = false
    //                    }
                        
                    } else {
                        if lblKeyboard.text != "Add" {
                            if indexPath.row == arrSelectedChoices.count - 1 {
                                
                               
                                    cell.lblChoice.textColor = .red
                               
                            } else {
                               
                                    cell.lblChoice.textColor = .black
                                    
                              
                            }
                        } else {
                            
                            cell.lblChoice.textColor = .black
                            print("cell.lblChoice \(cell.lblChoice.text!)")
                        }
                    }
                   
                    return cell
                }
                
                let cell = clVwSelectedChoices.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SelectedChoiceCell
                
                cell.selectedChoice = model
                
                if model.isSpeaking {
                    cell.lblChoice.textColor = .red
                } else {
                    cell.lblChoice.textColor = .black
                    
                }
                return cell
          //  }
//
//                return UICollectionViewCell
//            }
            
          
        }
    }
    func collectionView(_ collectionView: UICollectionView,
                                layout collectionViewLayout: UICollectionViewLayout,
                                sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == clVwSelectedChoices {
            
            let model = arrSelectedChoices[indexPath.row]
            
            if model.strImageName.isEmpty{
                let height = collectionView.contentSize.height
                let text = model.strCaption
                let width = text.width(withConstrainedHeight: height, font: UIFont.boldSystemFont(ofSize: UIDevice.current.userInterfaceIdiom == .pad ? 24 : 18)) + 8
                return CGSize(width: width , height: height)
            }
            
            return UIDevice.current.userInterfaceIdiom == .phone ? CGSize(width: 106, height: 64) : CGSize(width: 106, height: 84)
        }

        return UIDevice.current.userInterfaceIdiom == .phone ? CGSize(width: 120, height: collectionView.frame.height/3 - 4) :CGSize(width: 150, height: 170)
        
            }

            func collectionView(_ collectionView: UICollectionView,
                                layout collectionViewLayout: UICollectionViewLayout,
                                minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
                return 0.0
            }

            func collectionView(_ collectionView: UICollectionView, layout
                collectionViewLayout: UICollectionViewLayout,
                                minimumLineSpacingForSectionAt section: Int) -> CGFloat {
                return 0.0
            }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == clVwSelectedChoices {
            return
        }
        
        if btnEdit.isSelected {
            
            choices[indexPath.row].isSelected.toggle()
            clVwChoices.reloadItems(at: [IndexPath.init(item: indexPath.row, section: 0)])

            if choices.filter({$0.isSelected}).count != 0 {

                if choices.filter({$0.isSelected}).count == 1 {
                    btnDelete.setImage(#imageLiteral(resourceName: "edit"), for: .normal)
                    lblDelete.text = "Edit"
                    btnDelete.tag = 1
                    btnDelete.isEnabled = true
                    btnDelete.alpha = 1.0
                } else {
                    btnDelete.isEnabled = false
                    btnDelete.alpha = 0.5
                }
                btnBack.tag = 1
                btnBack.isEnabled = true
                btnBack.alpha = 1.0
                btnBack.imageView?.tintColor = UIColor.blue
                btnBack.setImage(#imageLiteral(resourceName: "ic_delete"), for: .normal)
                
                lblBack.text = "Delete"
                
            } else {
                
                btnDelete.alpha = 0.5
                btnDelete.isEnabled = false
                btnBack.isEnabled = false
                btnBack.alpha = 0.5
                btnDelete.tag = 0
                btnDelete.setImage(#imageLiteral(resourceName: "delete"), for: .normal)
                btnBack.tag = 0
                btnBack.setImage(#imageLiteral(resourceName: "back-arrow"), for: .normal)
                lblDelete.text = "Delete"
                lblBack.text = "Back"
            }
            
            return
        } else {
            
            btnDelete.setImage(#imageLiteral(resourceName: "delete"), for: .normal)
            lblDelete.text = "Delete"
            btnDelete.tag = 0
            btnDelete.isEnabled = true
            btnDelete.alpha = 1.0
            
        }
        
        let model = choices[indexPath.row]
        
        if model.isCategory {
            arrTravel.append(model.caption)
            arrSelectedParentID.append(model.id)
            selectedParentID = btnEdit.isSelected ? selectedParentID : model.id
            self.readChoiceDB(parentID: model.id, withTableName: strSelectedTable)
            
        } else {
            
            if let audioURL = URL(string: model.recordingPath!) {
                
                audioManager.playAudioFile(from: audioURL)
                
            }
            vwTag.removeAllTags()
            
            if  !model.moreWords.isEmpty {
                
                vwTag.addTags(model.moreWords.components(separatedBy: ","))
                
            }
            let cell = clVwChoices.cellForItem(at: indexPath) as! ChoiceClVwCell
            let imageViewPosition : CGPoint = cell.vw.convert(cell.vw.bounds.origin, to: self.view)
            
            let vwTemp = UIView(frame: CGRect(x: imageViewPosition.x, y: imageViewPosition.y, width: cell.vw.frame.size.width, height: cell.vw.frame.size.height))
            vwTemp.backgroundColor = cell.vw.backgroundColor
            vwTemp.layer.cornerRadius = 8
            let lbl = UILabel(frame: CGRect(x: 0, y: 0, width: vwTemp.frame.width, height: vwTemp.frame.height))
            
            lbl.text = cell.lblChoiceName.text
            lbl.textAlignment = .center
            vwTemp.addSubview(lbl)
            animation(tempView: vwTemp) { [weak self] in
                
                //self!.arrSelectedChoices.append(selectedChoiceWords(strCaption: model.caption, strImageName: model.imgPath!))
                self!.arrSelectedChoices.append(selectedChoiceWords(strCaption: model.caption, strImageName: model.imgPath!, isImageHasText: model.isImageHasText))
                self!.tapOnChoicesWords(strToSpeak: model.caption)
                
            }
        }
    }    
}



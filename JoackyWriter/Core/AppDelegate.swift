//
//  AppDelegate.swift
//  JoackyWriter
//
//  Created by Ilya Kulbakin on 01/02/2017.
//  Copyright © 2017 Jenex Software. All rights reserved.
//

import UIKit
import AVFoundation
import MKProgress
import Firebase
//import FBSDKCoreKit
//import SwiftyDropbox
//import Firebase
//import IQKeyboardManagerSwift
//com.picaboo.com.JaclynSia.JoackyWriter1


let APPDELEGATE = AppDelegate.sharedAppDelegate()
let USERDEFAULT = UserDefaults.standard

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, AVSpeechSynthesizerDelegate {

    var myOrientation : UIInterfaceOrientationMask = UIDevice.current.userInterfaceIdiom == .phone ? .portrait : .all
    static var speechSynthesizer = AVSpeechSynthesizer()
    static var isFinish = true
    var window: UIWindow?
    
    class func sharedAppDelegate() -> AppDelegate{
                return UIApplication.shared.delegate as! AppDelegate
            }
        
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        FirebaseApp.configure()
        MKProgress.config.hudType = .radial
       // MKProgress.config.hudColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        MKProgress.config.circleBorderColor = #colorLiteral(red: 0, green: 0.3764705882, blue: 0.5960784314, alpha: 1)
        MKProgress.config.logoImage = #imageLiteral(resourceName: "ic_logo")

        Sounds.default.prepare()
        DBHelper.shared.createTable(withName: "TABLE_CHOICE")
        return true
    }
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        
        return myOrientation
        
        /*
         if self.window?.rootViewController?.presentedViewController is SecondViewController {

                 let secondController = self.window!.rootViewController!.presentedViewController as! SecondViewController

             if secondController.isBeingPresented {

                     return UIInterfaceOrientationMask.landscapeLeft;

             } else {
                return UIInterfaceOrientationMask.all;
             }
     } else {
         
         return UIInterfaceOrientationMask.all;
     }
    */

    }

    
    func saveImageToDocumentDirectory(image: UIImage, imageName: String) -> Bool {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
         // name of the image to be saved
        let fileURL = documentsDirectory.appendingPathComponent("\(imageName).png")
        if let data = image.jpegData(compressionQuality: 1.0) {//,!FileManager.default.fileExists(atPath: fileURL.path){
            do {
                try data.write(to: fileURL)
                print("file saved")
                return true
                
            } catch {
                print("error saving file:", error)
                return false
            }
        }
        return false
    }
    
    func showLoadingView()
    {
       // MKProgress.show()
        DispatchQueue.main.async {
        
        MKProgress.show()
//
//            self.progressLoading = MRProgressOverlayView.init()
//            self.progressLoading?.titleLabelText = ""
//            self.window?.addSubview(self.progressLoading!)
//            self.progressLoading?.show(true)
//
        }
        
    }
    
    func hideLoadingView()
    {
        
        DispatchQueue.main.async {
            MKProgress.hide()
//            self.progressLoading?.dismiss(true)
        }
//
    }


    func loadImageFromDocumentDirectory(nameOfImage : String) -> UIImage? {
        let nsDocumentDirectory = FileManager.SearchPathDirectory.documentDirectory
        let nsUserDomainMask = FileManager.SearchPathDomainMask.userDomainMask
        let paths = NSSearchPathForDirectoriesInDomains(nsDocumentDirectory, nsUserDomainMask, true)
        if let dirPath = paths.first{
            let imageURL = URL(fileURLWithPath: dirPath).appendingPathComponent("\(nameOfImage).png")
            let image    = UIImage(contentsOfFile: imageURL.path)
            return image!
        }
        return nil
    }
    
    
    func saveImageToDocumentDirectory(image: UIImage, fileName: String) -> String {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
       /// let fileName = "image001.png" // name of the image to be saved
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        
        if let data = image.pngData(),!FileManager.default.fileExists(atPath: fileURL.path){
            do {
                try data.write(to: fileURL)
                print("file saved")
                return fileName
            } catch {
                print("error saving file:", error)
            }
        } else {
            
            if FileManager.default.fileExists(atPath: fileURL.path) {
                return fileURL.lastPathComponent
            }
        }
        
        return ""
    }


    func loadImageFromDocumentDirectory1(nameOfImage : String) -> UIImage {
        let nsDocumentDirectory = FileManager.SearchPathDirectory.documentDirectory
        let nsUserDomainMask = FileManager.SearchPathDomainMask.userDomainMask
        let paths = NSSearchPathForDirectoriesInDomains(nsDocumentDirectory, nsUserDomainMask, true)
        if let dirPath = paths.first{
            let imageURL = URL(fileURLWithPath: dirPath).appendingPathComponent(nameOfImage)
            let image    = UIImage(contentsOfFile: imageURL.path)
            return image!
        }
        return #imageLiteral(resourceName: "no-image")
    }

    
    func removeItemForDocument(itemName:String, fileExtension: String) {
      let fileManager = FileManager.default
      let NSDocumentDirectory = FileManager.SearchPathDirectory.documentDirectory
      let NSUserDomainMask = FileManager.SearchPathDomainMask.userDomainMask
      let paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, true)
      guard let dirPath = paths.first else {
          return
      }
      let filePath = "\(dirPath)/\(itemName).\(fileExtension)"
      do {
        try fileManager.removeItem(atPath: filePath)
        
      } catch let error as NSError {
        print(error.debugDescription)
      }}
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        
       // debugPrint("Finish...")
        AppDelegate.isFinish = true
        APPDELEGATE.window?.isUserInteractionEnabled = true
        
    }
    
    func deleteFile(fileNameToDelete: String) {
           // let fileNameToDelete = "myFileName.txt"
            var filePath = ""
            // Fine documents directory on device
             let dirs : [String] = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.allDomainsMask, true)
            if dirs.count > 0 {
                let dir = dirs[0] //documents directory
                filePath = dir.appendingFormat("/" + fileNameToDelete)
                print("Local path = \(filePath)")
             
            } else {
                print("Could not find local directory to store file")
                return
            }
            do {
                 let fileManager = FileManager.default
                
                // Check if file exists
                if fileManager.fileExists(atPath: filePath) {
                    // Delete file
                    try fileManager.removeItem(atPath: filePath)
                } else {
                    print("File does not exist")
                }
             
            }
            catch let error as NSError {
                print("An error took place: \(error)")
            }
        }
}


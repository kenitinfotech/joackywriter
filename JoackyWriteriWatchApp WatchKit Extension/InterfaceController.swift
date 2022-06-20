//
//  InterfaceController.swift
//  JoackyWriteriWatchApp WatchKit Extension
//
//  Created by Vinay Patel on 25/04/2022.
//

import WatchKit
import Foundation
import WatchConnectivity
import AVFoundation
import UIKit


class InterfaceController: WKInterfaceController {
    
    @IBOutlet weak var img: WKInterfaceImage!
    @IBOutlet weak var lbl: WKInterfaceLabel!
    var imgName: String?
    var session: WCSession!
    
    var data: [String] = []
    var count: Int = 0
    var isAlertPresented: Bool = false
    override func awake(withContext context: Any?) {
        // Configure interface objects here.
        if(WCSession.isSupported()){
            self.session = WCSession.default;
            self.session.delegate = self;
            self.session.activate()
        }
        
        do {
                    try AVAudioSession.sharedInstance().setActive(false)
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playAndRecord, options: [.mixWithOthers])
                    try AVAudioSession.sharedInstance().setActive(true)
               }
               catch{
                 print("Error setting up AVAudioSession category")
               }
        // img.setImage(UIImage(named: "ic_help"))
        
        if (UserDefaults.standard.object(forKey: "data") != nil) {
            
            data = UserDefaults.standard.stringArray(forKey: "data")!
            if data.count > 0 {
                img.setImage(getImage(imgNm: "\(data[0].replacingOccurrences(of: " ", with: "_")).png"))
                lbl.setText(data[0])
            }
           
        }
    }
    
    override func willActivate() {
        super.willActivate()
        
        
        // This method is called when watch view controller is about to be visible to user
    }
    
    @IBAction func tapGesture(_ sender: Any) {
        if data.count == 0 {
            return
        }
        let synth:AVSpeechSynthesizer = AVSpeechSynthesizer.init()
        synth.delegate = self
        synth.speak(AVSpeechUtterance(string: data[count]))
        
        
    }
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
    }
    func getImage(imgNm: String) -> UIImage?{
        let fileManager = FileManager.default
        do {
            let documentDirectory = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor:nil, create:false)
            let fileURL = documentDirectory.appendingPathComponent(imgNm)
            
            if fileManager.fileExists(atPath: fileURL.path) {
                return UIImage(contentsOfFile: fileURL.path)
            }
            //            if fileManager.fileExistsAtPath(fileURL.path){
            //                self.imageView.image = UIImage(contentsOfFile: imagePAth)
            //            }
            return nil
            
        } catch {
            
            
        }
        return nil
        
    }
    
    
    private func setUserDefaults() {
        UserDefaults.standard.set(data, forKey: "data")
        UserDefaults.standard.synchronize()
    }
    //try fileManager.removeItem(atPath: tempFolderPath + filePath)
    
    func removeFileFromDirectory(imgName: String) -> Bool {
        let fileManager = FileManager.default
        do {
            let documentDirectory = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor:nil, create:false)
            let fileURL = documentDirectory.appendingPathComponent(imgName)
            
            if fileManager.fileExists(atPath: fileURL.path) {
                try fileManager.removeItem(at: fileURL)
            }
            return true
        } catch {
            print(error)
        }
        return false
    }
    
    func saveToDocumentDirectory(imgData: Data, imgName: String) -> Bool {
        let fileManager = FileManager.default
        do {
            let documentDirectory = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor:nil, create:false)
            let fileURL = documentDirectory.appendingPathComponent(imgName)
            
            //if let imageData = image.jpegData(compressionQuality: 0.5) {
            try imgData.write(to: fileURL)
            return true
            // }
        } catch {
            print(error)
        }
        return false
    }
    
    func showAlert() {
        isAlertPresented = true
        let action = WKAlertAction(title: "DELETE", style: WKAlertActionStyle.default) { [weak self] in
            print("Ok")
            self!.isAlertPresented = false
            
            if self!.removeFileFromDirectory(imgName: "\(self!.data[self!.count].replacingOccurrences(of: " ", with: "_")).png") {
                
                self!.data.remove(at: self!.count)
                self!.setUserDefaults()
                
                if self!.data.count == 0 {
                    self!.lbl.setText("Please Add Choice")
                    
                    self!.img.setImageNamed("ic_joackyWriter")
                    return
                }
                if self!.count == self!.data.count - 1 {
                    self!.count -= 1
                } else if self!.count == 0 {
                    self!.count = 0
                } else {
                    self!.count = self!.data.count - 1
                }
                
                self!.setData()
            }
        }
        let cancelAction = WKAlertAction(title: "CANCEL", style: .cancel) { [weak self] in
            self!.isAlertPresented = false
            print("cancel")
        }
        presentAlert(withTitle: "ALERT!", message: "Are you sure, You want to delete this Choice?", preferredStyle: WKAlertControllerStyle.alert, actions:[action, cancelAction])
    }
    
    private func setData() {
        lbl.setText(data[count])
        if let img = getImage(imgNm: "\(data[count].replacingOccurrences(of: " ", with: "_")).png") {
            self.img.setImage(img)
        } else {
            self.img.setImage(nil)
        }
    }
    
    @IBAction func swipeUp(_ sender: Any) {
        debugPrint("up")
        if count != data.count - 1 && data.count > 0 {
            count += 1
            setData()
        }
    }
    
    @IBAction func longPressGesture(_ sender: Any) {
        if !isAlertPresented {
            showAlert()
        }
        
        debugPrint("Long Pressed")
    }
    @IBAction func swipeDown(_ sender: Any) {
        debugPrint("down")
        
        if count != 0 && data.count > 0{
            count -= 1
            setData()
        }
    }
}

extension InterfaceController: WCSessionDelegate {
    
    func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String : Any]) {
        
        guard let imge = UIImage(data: applicationContext["imgData"] as! Data) else {
            return
        }
        
        img.setImage(imge)
        
        
    }
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    
    func session(_ session: WCSession, didReceive file: WCSessionFile) {
        
        guard let img = UIImage(contentsOfFile: file.fileURL.path) else {
            return
        }
        
        DispatchQueue.main.async {
            self.img.setImage(img)
        }
        
    }
    
    func session(_ session: WCSession, didReceiveMessageData messageData: Data) {
        
        guard let image = UIImage(data: messageData) else {
            return
        }
        let fileName = "\(imgName!.replacingOccurrences(of: " ", with: "_")).png"
        if saveToDocumentDirectory(imgData: messageData, imgName: fileName) {
            debugPrint("success")
        }
        // throw to the main queue to upate properly
        DispatchQueue.main.async {
            self.img.setImage(image)
        }
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        
        let msg = message["a"] as? String
        imgName = msg
        // img.setImageNamed("ic_help")
        data.append(msg!)
        count = data.count - 1
        UserDefaults.standard.set(data, forKey: "data")
        UserDefaults.standard.synchronize()
        lbl.setText(msg)
        img.setImage(nil)
        sendMessage()
    }
    
    func sendMessage(){
        session.sendMessage(["b":"Choice Added Successfully"], replyHandler: nil) { err in
            debugPrint("Message Sending error --- \(err.localizedDescription)")
        }
    }
}

extension InterfaceController: AVSpeechSynthesizerDelegate {
    
}

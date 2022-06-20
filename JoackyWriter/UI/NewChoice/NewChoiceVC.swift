//
//  ViewController.swift
//  SQLitedemo
//
//  Created by Vinay Patel on 31/07/21.
//

///********fa ldsadflfj ;laj --- ghp_VU5xPdd4NNjkYzk8PM7VPPbap63zyb9CB1njdwK-------


/*
 var myOrientation : UIInterfaceOrientationMask = UIDevice.current.userInterfaceIdiom == .phone ? .portrait : .all
 

 var window: UIWindow?
 func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
     // Override point for customization after application launch.
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
 override func viewDidLoad() {
     super.viewDidLoad()
     
     let appDelegate = UIApplication.shared.delegate as! AppDelegate
     
     appDelegate.myOrientation = .landscapeLeft

     // Do any additional setup after loading the view.
 }
 
 
 @IBAction func btnClosePressed(_ sender: Any) {
     
     let appDelegate = UIApplication.shared.delegate as! AppDelegate
     appDelegate.myOrientation = UIDevice.current.userInterfaceIdiom == .phone ? .portrait : .all
     self.dismiss(animated: true, completion: nil)
 }
 */


import UIKit
import TagListView

class NewChoiceVC: UIViewController {

    @IBOutlet weak var vwTag: TagListView!
    
    var db:DBHelper = DBHelper.shared
    var selectedParentID = 0
    var arrSelectedParentID : [Int] = []
    
   // let synthesizer = AVSpeechSynthesizer()
    @IBOutlet weak var clVwChoices : UICollectionView!
    @IBOutlet weak var btnKeyboard: UIButton!
    @IBOutlet weak var btnDelete : UIButton!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var lblDelete : UILabel!
    @IBOutlet weak var lblBack: UILabel!
    @IBOutlet weak var btnHome: UIButton!
    @IBOutlet weak var btnCore: UIButton!
    @IBOutlet weak var btnEdit: UIButton!
    var isSpeaking: Bool = false
//    @IBOutlet weak var btnMistake: UIButton!
//    @IBOutlet weak var btnAler:UIButton!
    
    @IBOutlet weak var btnA: UIButton!
    @IBOutlet weak var btnB: UIButton!
    @IBOutlet weak var btnC: UIButton!
    @IBOutlet weak var btnD: UIButton!
    @IBOutlet weak var btnE: UIButton!
    @IBOutlet weak var btnF: UIButton!
    @IBOutlet weak var btnG: UIButton!
    @IBOutlet weak var btnH: UIButton!
    @IBOutlet weak var btnI: UIButton!
    @IBOutlet weak var btnJ: UIButton!
    @IBOutlet weak var btnK: UIButton!
    @IBOutlet weak var btnL: UIButton!
    @IBOutlet weak var btnM: UIButton!
    @IBOutlet weak var btnN: UIButton!
    @IBOutlet weak var btnO: UIButton!
    @IBOutlet weak var btnP: UIButton!
    @IBOutlet weak var btnQ: UIButton!
    @IBOutlet weak var btnR: UIButton!
    @IBOutlet weak var btnS: UIButton!
    @IBOutlet weak var btnT: UIButton!
    @IBOutlet weak var btnU: UIButton!
    @IBOutlet weak var btnV: UIButton!
    @IBOutlet weak var btnW: UIButton!
    @IBOutlet weak var btnX: UIButton!
    @IBOutlet weak var btnY: UIButton!
    @IBOutlet weak var btnZ: UIButton!
    
    @IBOutlet weak var btnMinus: UIButton!
    @IBOutlet weak var btnKeyboardDelete: UIButton!
    @IBOutlet weak var btnComma: UIButton!
    @IBOutlet weak var btnQue: UIButton!
    @IBOutlet weak var btnShift1: UIButton!
    @IBOutlet weak var btnShift2: UIButton!
    @IBOutlet weak var btnSpace: UIButton!
    
    
    @IBOutlet weak var imgVwShift1: UIImageView!
    @IBOutlet weak var imgVwShift2: UIImageView!
    
    
    @IBOutlet weak var vwKeyboard: UIView!
    
    var isMainDeletePressed: Bool = false
    var isDoubleTap: Bool = false
    var isSelected: Bool = false {
        
        didSet {
            btnA.isSelected = isSelected
            btnB.isSelected = isSelected
            btnC.isSelected = isSelected
            btnD.isSelected = isSelected
            btnE.isSelected = isSelected
            btnF.isSelected = isSelected
            btnG.isSelected = isSelected
            btnH.isSelected = isSelected
            btnI.isSelected = isSelected
            btnJ.isSelected = isSelected
            btnK.isSelected = isSelected
            btnL.isSelected = isSelected
            btnM.isSelected = isSelected
            btnN.isSelected = isSelected
            btnO.isSelected = isSelected
            btnP.isSelected = isSelected
            btnQ.isSelected = isSelected
            btnR.isSelected = isSelected
            btnS.isSelected = isSelected
            btnT.isSelected = isSelected
            btnU.isSelected = isSelected
            btnV.isSelected = isSelected
            btnW.isSelected = isSelected
            btnX.isSelected = isSelected
            btnY.isSelected = isSelected
            btnZ.isSelected = isSelected
        }
        
    }
    
    private var isDeleting: Bool = true
    let audioManager: SCAudioManager!
    //private let arrSelectedCellForEdit: [Int] = []
    required init?(coder: NSCoder) {
        audioManager = SCAudioManager()
        
        
        super.init(coder: coder)

    }
    
    
    var isFromSuggestion: Bool = false
    var strSelectedTable : String = "TABLE_CHOICE"
    var arrTempSelectedChoices : [String] = []
    var arrSelectedChoices: [selectedChoiceWords] = [] {
        
        didSet {
            clVwSelectedChoices.reloadData()
            clVwSelectedChoices.scrollToItem(at: IndexPath(row: arrSelectedChoices.count - 1, section: 0), at: .left, animated: true)
//            if arrSelectedChoices.count > 0 && btnKeyboard.tag == 1 && (arrSelectedChoices.last?.strCaption.count)! >= 3 && !isDeleting  {
            if arrSelectedChoices.count > 0 && (arrSelectedChoices.last?.strCaption.count)! >= 3 && (btnKeyboard.tag == 1 ? !isDeleting : isDeleting) && !isFromSuggestion{
                
                
//                if btnKeyboard.tag == 1 {
//                    tapOnChoicesWords(strToSpeak: arrSelectedChoices.last!.strCaption)
//                }
               
                let arrChoice =  DBHelper.shared.getCategoryIDForSuggestionWords(withText: arrSelectedChoices.last!.strCaption.lowercased(), strColumn: btnKeyboard.tag == 1 ? "sWord" : "sWord")
                
                if arrChoice.count > 0 {
                    
                    let storyboard = UIStoryboard(name: "iPad_Choice", bundle: nil)
                    
//                    if UIDevice.current.userInterfaceIdiom == .phone {
//
//                        storyboard = UIStoryboard(name: "iPhone_Choice", bundle: nil)
//                    }
                    
                    let vc = storyboard.instantiateViewController(withIdentifier: "SuggetionVC") as! SuggetionVC
                    
                    vc.arrChoice = arrChoice
                    
                    if let presenter = vc.popoverPresentationController {
                        presenter.sourceView = self.clVwSelectedChoices;
                        presenter.sourceRect = self.clVwSelectedChoices.bounds;
                        }
                    
                  //  self.present(vc, animated: true, completion: nil)
                    
                    vc.callBackViewDidDisAppear = {
                        self.isFromSuggestion = false
                    }
                    
                    vc.callBackWithChoice = { [weak self] (value, count) in
                        self!.isDeleting = true
                        self!.isFromSuggestion = true
                        if count == 0 {
                            self!.arrSelectedChoices.removeLast()
                        }
                        
                        self!.arrSelectedChoices.append(selectedChoiceWords(strCaption: value.caption, strImageName: value.imgPath!))
                        
                        if self!.btnKeyboard.tag == 1 {
//
//                            if self!.arrSelectedChoices.last!.strCaption.isEmpty {
//                                self!.arrSelectedChoices.append(selectedChoiceWords(strCaption: "", strImageName: ""))
//                            }
                            //self!.strkeyboardType = value.caption
                           // self!.btnSpaceClick(self!)
                            self!.strkeyboardType = "#"
                            self!.arrSelectedChoices.append(selectedChoiceWords(strCaption: "", strImageName: ""))
                            
                            
                            
                        }
                        
                    }
                    
                    if UIDevice.current.userInterfaceIdiom == .phone {
                        vc.modalPresentationStyle = .popover

                        vc.preferredContentSize = CGSize(width: self.clVwChoices.frame.width, height: self.clVwChoices.frame.height)

                                let ppc = vc.popoverPresentationController
                                ppc?.permittedArrowDirections = .any
                                ppc?.delegate = self
                               // ppc?.barButtonItem = navigationItem.rightBarButtonItem
                        ppc?.sourceView = self.clVwSelectedChoices
                        ppc?.sourceRect = self.clVwSelectedChoices.bounds
                                present(vc, animated: true, completion: nil)
                    } else {
                        
                        vc.view.backgroundColor = UIColor.white
                        vc.modalPresentationStyle = UIModalPresentationStyle.popover
                        let popvc = vc.popoverPresentationController
                      //  popvc?.delegate = self
                        popvc?.permittedArrowDirections = UIPopoverArrowDirection.any
                    popvc?.sourceView = self.clVwSelectedChoices
                    vc.preferredContentSize = CGSize.init(width: self.view.frame.width * 0.8, height: self.view.frame.height * 0.8)

                        self.present(vc, animated: true, completion: nil)
                    }
                    
                     
                    
                }
                
            }
        }
        
    }
    
    @IBOutlet weak var clVwSelectedChoices: UICollectionView!
    
    var isEnabled: Bool = true {
        
        didSet {
            
            btnDelete.isEnabled = isEnabled
            btnBack.isEnabled = isEnabled
            btnHome.isEnabled = isEnabled
            //btnCore.isEnabled = isEnabled
//            btnMistake.isEnabled = isEnabled
//            btnAler.isEnabled = isEnabled
            
            btnDelete.alpha = isEnabled ? 1.0: 0.5
            btnBack.alpha = isEnabled ? 1.0: 0.5
            btnHome.alpha = isEnabled ? 1.0: 0.5
            //btnCore.alpha = isEnabled ? 1.0: 0.5
//            btnMistake.alpha = isEnabled ? 1.0: 0.5
//            btnAler.alpha = isEnabled ? 1.0: 0.5


        }
    }
    
    var strkeyboardType: String = "" {
        
        didSet {
            
            if isMainDeletePressed || strkeyboardType == "#" {
                return
            }
            
            if arrSelectedChoices.count > 0 {
                arrSelectedChoices[arrSelectedChoices.count - 1] = selectedChoiceWords(strCaption: strkeyboardType.trimmingCharacters(in: .whitespacesAndNewlines), strImageName: "")
            } else {
                arrSelectedChoices = [selectedChoiceWords(strCaption: strkeyboardType.trimmingCharacters(in: .whitespacesAndNewlines), strImageName: "")]
            }
            
//            if strkeyboardType.isEmpty {
//
//            }
            
        }
    }
    
    
    
    @IBOutlet weak var lblKeyboard: UILabel!
        
    var choices:[Choices] = [] {
        
        didSet {
            self.clVwChoices.reloadData()
        }
    }
    
    var arrTravel: [String] = [] {
        
        didSet {
            
            if arrTravel.count == 1 {
                strPath = arrTravel[0]
                btnHome.isEnabled = false
                btnBack.isEnabled = false
                //btnCore.isEnabled = true
            } else {
                btnHome.isEnabled = true
                btnBack.isEnabled = true
                //btnCore.isEnabled = false
                strPath = ""
                for i in 0..<arrTravel.count {
                    
                    if i == arrTravel.count - 1 {
                        
                        strPath = strPath + " " + arrTravel[i]
                        strPath = strPath.trimmingCharacters(in: .whitespacesAndNewlines)
                    }  else  {
                        
                        strPath = strPath + " " + arrTravel[i] + "->"
                        strPath = strPath.trimmingCharacters(in: .whitespacesAndNewlines)
                    }
                }
            }
        }
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        if USERDEFAULT.bool(forKey: "kIsLock") {
            btnEdit.isEnabled = false
        }
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        appDelegate.myOrientation = .landscape
        
        
        arrTravel = ["Home"]
        arrSelectedParentID = [0]
        readChoiceDB(parentID: 0, withTableName: strSelectedTable)
        vwTag.textFont = UIFont.systemFont(ofSize: UIDevice.current.userInterfaceIdiom == .pad ? 28 : 24)
        vwTag.alignment = .center
        vwTag.delegate = self
        btnDelete.addTarget(self, action: #selector(multipleTap(_:event:)), for: .touchDownRepeat)
//        btnShift1.addTarget(self, action: #selector(doubleTap(_:event:)), for: .touchDownRepeat)
//        btnShift2.addTarget(self, action: #selector(doubleTap(_:event:)), for: .touchDownRepeat)
//
        // Do any additional setup after loading the view.
        
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapOnChoicesWords))
//        clVwSelectedChoices.addGestureRecognizer(tapGesture)
//
//
        let doubleTapGesture = UITapGestureRecognizer(target: self, action: #selector(doubleTap))
        doubleTapGesture.numberOfTapsRequired = 2
        btnShift1.addGestureRecognizer(doubleTapGesture)
        
    }
    
    @objc func tapOnChoicesWords(strToSpeak: String) {
        
        
//        let arrCaption = arrSelectedChoices.map({$0.strCaption})
//        arrTempSelectedChoices = arrCaption
        let utterance = AVSpeechUtterance(string: strToSpeak)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        utterance.rate = 0.3
        AppDelegate.speechSynthesizer.delegate = self
       // let synthesizer = AVSpeechSynthesizer()
        AppDelegate.speechSynthesizer.speak(utterance)
    }
    
    @IBOutlet weak var lblTravelPath: UILabel!
    
    var strPath: String = "" {
        
        didSet {
            lblTravelPath.text = strPath
        }
        
    }
    
    func readChoiceDB(parentID: Int, withTableName name: String) {
        
        choices = db.read(parentID: parentID, withTableName: name)
    }
    
    @objc fileprivate func multipleTap(_ sender: UIButton, event: UIEvent) {
        
        if btnDelete.tag != 0 {
            return
        }
        if arrSelectedChoices.count == 0 {
            return
        }
        let touch: UITouch = event.allTouches!.first!
        
        
        if (touch.tapCount == 1) {
            
            arrSelectedChoices.removeLast()
            
            // do action.
        } else {
            
            arrSelectedChoices.removeAll()
            
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
       
       if AppDelegate.speechSynthesizer.isSpeaking {
        AppDelegate.speechSynthesizer.stopSpeaking(at: .immediate)
        }
//        self.dismiss(animated: true, completion: nil)
       // self.navigationController?.popViewController(animated: true)
    }
    
    @objc fileprivate func doubleTap() {
      
//        let touch: UITouch = event.allTouches!.first!
//
//
//        if touch.tapCount == 2 {//&& (!btnShift1.isSelected || !btnShift2.isSelected) {
//
           isSelected = true
            isDoubleTap = true
            btnShift1.isSelected = true
            btnShift2.isSelected = true
            imgVwShift1.tintColor = .red
            imgVwShift2.tintColor = .red
        
            // do action.
      //  }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    fileprivate func openChoiceVC(isCategory: Bool){
        
        let storyboard = UIStoryboard.init(name: UIDevice.current.userInterfaceIdiom == .pad ? "iPad_Choice" : "iPhone_Choice", bundle: nil)
        
        let vc = storyboard.instantiateViewController(withIdentifier: "AddChoiceVC") as! AddChoiceVC
        vc.isCategory = isCategory
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .fullScreen
        vc.selectedParentID = selectedParentID
        vc.strSelectedTable = strSelectedTable
        vc.callBack = { [weak self] in
           
            self!.readChoiceDB(parentID: self!.selectedParentID, withTableName: self!.strSelectedTable)
        }
        self.present(vc, animated: true, completion: nil)
    }
    
    fileprivate func saveMultipleChoices(arrChoices: [String]) {
        
        let myGroup = DispatchGroup()
        
        arrChoices.forEach { [weak self] strCaption in
            myGroup.enter()
            debugPrint(strCaption)
            if db.insert(id: 0, parentId: self!.selectedParentID, caption: strCaption.trimmingCharacters(in: .whitespacesAndNewlines), showInMessageBox: false, imgPath: "", recordingPath: "", wordType: WordType.Noun.rawValue, color: "#808080", moreWords: "", isCategory: false, sWord: "", isImageHasText: 0, tableName: self!.strSelectedTable) {
                myGroup.leave()
            }
        }
        
        myGroup.notify(queue: .main) { [weak self] in
            debugPrint("All Added.....")
            self!.readChoiceDB(parentID: self!.selectedParentID, withTableName: self!.strSelectedTable)
        }

    }
    
    func animation(tempView : UIView,  finished: @escaping() -> Void)  {
        self.view.addSubview(tempView)
        UIView.animate(withDuration: 1.0,
                       animations: {
                        tempView.animationZoom(scaleX: 1.5, y: 1.5)
        }, completion: { _ in
            
            UIView.animate(withDuration: 0.5, animations: {
                
                tempView.animationZoom(scaleX: 0.2, y: 0.2)
                tempView.animationRoted(angle: CGFloat(Double.pi))
                
                tempView.frame.origin.x = self.clVwSelectedChoices.frame.width/2
                tempView.frame.origin.y = self.clVwSelectedChoices.frame.height
                
            }, completion: { _ in
                
                tempView.removeFromSuperview()
                
                finished()
//                UIView.animate(withDuration: 1.0, animations: {
////
//////                    self.counterItem += 1
//////                    self.lableNoOfCartItem.text = "\(self.counterItem)"
//                    self.clVwSelectedChoices.animationZoom(scaleX: 1.1, y: 1.1)
//                }, completion: {_ in
//                    self.clVwSelectedChoices.animationZoom(scaleX: 1.0, y: 1.0)
//                })
                
            })
            
        })
    }
    
    
    @IBAction func btnShiftClick(_ sender: Any) {
        
        if btnShift1.isSelected || btnShift2.isSelected {
            isDoubleTap = false
            btnShift1.isSelected = false
            btnShift2.isSelected = false
            imgVwShift1.tintColor = .white
            imgVwShift2.tintColor = .white
        } else {
            btnShift1.isSelected = true
            btnShift2.isSelected = true
            imgVwShift1.tintColor = .red
            imgVwShift2.tintColor = .red
        }
        
        isSelected.toggle()
    }
    
    @IBAction func btnDeleteFromKeyboard(_ sender: Any) {
        
        isDeleting = true
        if arrSelectedChoices.count > 0 {
         
            if arrSelectedChoices.last?.strCaption == "" {
                arrSelectedChoices.removeLast()
                
                return
            }
            let tempArr = arrSelectedChoices.last
            if tempArr!.strImageName.isEmpty {
                
                var strArr = tempArr!.strCaption.map( { String($0) })//Array(tempArr!.strCaption)
                strArr.remove(at: strArr.count -  1)
                
                if strArr.count == 0 {
                    strkeyboardType = ""
                    arrSelectedChoices.removeLast()
                    
                    
                } else {
                    strkeyboardType = strArr.joined(separator: "")
                    //arrSelectedChoices[arrSelectedChoices.count - 1] = selectedChoiceWords(strCaption: strArr.joined(separator: ""), strImageName: "")
                }
            }
            
        }
    }

    
    @IBAction func btnKeyboardClick(_ sender: UIButton) {
        
        isDeleting = false
        var tempString = ""
        if strkeyboardType == "#" {
            strkeyboardType = ""
        }
        
        switch sender.tag {
        case 0:
            tempString = strkeyboardType + "0"
            break
            
        case 1:
            tempString = strkeyboardType + "1"
            break
            
        case 2:
            tempString = strkeyboardType + "2"
            break
        case 3:
            tempString = strkeyboardType + "3"
            break
        case 4:
            tempString = strkeyboardType + "4"
            break
        case 5:
            tempString = strkeyboardType + "5"
            break
        case 6:
            tempString = strkeyboardType + "6"
            break
        case 7:
            tempString = strkeyboardType + "7"
            break
        case 8:
            tempString = strkeyboardType + "8"
            break
        case 9:
            tempString = strkeyboardType + "9"
            break
        case 10:
            tempString = strkeyboardType + "-"
            break
        case 11:
            tempString = strkeyboardType + btnQ.titleLabel!.text!
            break
        case 12:
            tempString = strkeyboardType + btnW.titleLabel!.text!
            break
        case 13:
            tempString = strkeyboardType + btnE.titleLabel!.text!
            break
        case 14:
            tempString = strkeyboardType + btnR.titleLabel!.text!
            break
            
        case 15:
            tempString = strkeyboardType + btnT.titleLabel!.text!
            break
        case 16:
            tempString = strkeyboardType + btnY.titleLabel!.text!
            break
        case 17:
            tempString = strkeyboardType + btnU.titleLabel!.text!
            break
        case 18:
            tempString = strkeyboardType + btnI.titleLabel!.text!
            break
            
        case 19:
            tempString = strkeyboardType + btnO.titleLabel!.text!
            break
        case 20:
            tempString = strkeyboardType + btnP.titleLabel!.text!
            break
//        case 21:
//
//            if arrSelectedChoices.count > 0 {
//
//                let tempArr = arrSelectedChoices.last
//                if tempArr!.strImageName.isEmpty {
//
//                    var strArr = tempArr!.strCaption.map( { String($0) })//Array(tempArr!.strCaption)
//                    strArr.remove(at: strArr.count -  1)
//
//                    if strArr.count == 0 {
//                        arrSelectedChoices.removeLast()
//                    } else {
//                        tempString = strArr.joined(separator: "")
//                        arrSelectedChoices[arrSelectedChoices.count - 1] = selectedChoiceWords(strCaption: strArr.joined(separator: ""), strImageName: "")
//                    }
//
//
//                }
//
//            }
//           // tempString = strkeyboardType + btnA.titleLabel!.text!
//            break
        case 22:
            tempString = strkeyboardType + btnA.titleLabel!.text!
            break
            
        case 23:
            tempString = strkeyboardType + btnS.titleLabel!.text!
            break
        case 24:
            tempString = strkeyboardType + btnD.titleLabel!.text!
            break
        case 25:
            tempString = strkeyboardType + btnF.titleLabel!.text!
            break
        case 26:
            tempString = strkeyboardType + btnG.titleLabel!.text!
            break
            
            
        case 27:
            tempString = strkeyboardType + btnH.titleLabel!.text!
            break
        case 28:
            tempString = strkeyboardType + btnJ.titleLabel!.text!
            break
        case 29:
            tempString = strkeyboardType + btnK.titleLabel!.text!
            break
        case 30:
            tempString = strkeyboardType + btnL.titleLabel!.text!
            break
            
        case 31:
            tempString = strkeyboardType + btnL.titleLabel!.text!
            break
        case 32:
            tempString = strkeyboardType + btnZ.titleLabel!.text!
            break
        case 33:
            tempString = strkeyboardType + btnX.titleLabel!.text!
            break
        case 34:
            tempString = strkeyboardType + btnC.titleLabel!.text!
            break
            
            
        case 35:
            tempString = strkeyboardType + btnV.titleLabel!.text!
            break
        case 36:
            tempString = strkeyboardType + btnB.titleLabel!.text!
            break
        case 37:
            tempString = strkeyboardType + btnN.titleLabel!.text!
            break
        case 38:
            tempString = strkeyboardType + btnM.titleLabel!.text!
            break
            
        case 39:
            tempString = strkeyboardType + (btnShift1!.isSelected ? "!" : ",")
            break
        case 40:
            tempString = strkeyboardType + (btnShift1!.isSelected ? "?" : ".")
            break
//        case 41:
//
//            break
            
        default:
            break
        }
    
        strkeyboardType = tempString.trimmingCharacters(in: .whitespacesAndNewlines)
        if !isDoubleTap {
            isSelected = false
        }
    }
    
    @IBAction func btnSpaceClick(_ sender: Any) {
        
        if arrSelectedChoices.last?.strCaption != "" {
            strkeyboardType = "#"
          //  if !isDeleting {
                tapOnChoicesWords(strToSpeak: arrSelectedChoices.last!.strCaption)
                
           // }
            
            arrSelectedChoices.append(selectedChoiceWords(strCaption: "", strImageName: ""))
        }
    }
}

extension NewChoiceVC {
    
    @IBAction func btnSpeakPressed(_ sender: UIButton) {
        
        if arrSelectedChoices.count == 0 || isSpeaking {
            isSpeaking = false
            if AppDelegate.speechSynthesizer.isSpeaking {
                AppDelegate.speechSynthesizer.stopSpeaking(at: .immediate)
            }
            return
        }
        
        isSpeaking.toggle()

        let arrCaption = arrSelectedChoices.map({$0.strCaption})
        arrTempSelectedChoices = arrCaption
       let strToSpeak =  arrCaption.joined(separator: " ")
    
        tapOnChoicesWords(strToSpeak: strToSpeak)
//
//        let string = "This is a test. This is only a test. If this was an actual emergency, then this wouldn’t have been a test."
//            let utterance = AVSpeechUtterance(string: string)
//            utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
//
//
//            synthesizer.delegate = self
//            synthesizer.speak(utterance)
            
//            arrTravel = ["Home"]
//            arrSelectedParentID = [0]
//            arrTravel.append("Core")
//            arrSelectedParentID.append(0)
//            selectedParentID = 0
//            strSelectedTable = "TABLE_CORE_CHOICE"
//            readChoiceDB(parentID: 0, withTableName: strSelectedTable)

    }
    
    @IBAction func btnSendMessagePressed(_ sender: Any) {
        
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ContactSelectionViewController") as! ContactSelectionViewController
        
        let arrCaption = arrSelectedChoices.map({$0.strCaption})
       // arrTempSelectedChoices = arrCaption
        //let nav = UINavigationController(rootViewController: vc)
         
        vc.strMessageText = arrCaption.joined(separator: " ")
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
            // self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func btnDashboardPressed(_ sender: Any) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.myOrientation = UIDevice.current.userInterfaceIdiom == .phone ? .portrait : .all
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
    @IBAction func btnDeletePressed(_ sender: Any) {
        
        if AppDelegate.speechSynthesizer.isSpeaking {
            AppDelegate.speechSynthesizer.stopSpeaking(at: .immediate)
            self.isSpeaking = false
        }
        
        if btnDelete.tag == 1 {
            let arrSelectedChoices = choices.filter({$0.isSelected})
            if arrSelectedChoices.count == 1 {
                
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddChoiceVC") as! AddChoiceVC
                vc.selectedChoice = arrSelectedChoices[0]
                vc.modalTransitionStyle = .crossDissolve
                vc.modalPresentationStyle = .fullScreen
                vc.selectedParentID = arrSelectedChoices[0].parentId
                vc.isCategory = arrSelectedChoices[0].isCategory
                vc.strSelectedTable = strSelectedTable
                vc.callBack = { [weak self] in
                    if self!.btnEdit.isSelected {
                        self?.btnEditPressed(self!.btnEdit)
                    }
                    self!.readChoiceDB(parentID: self!.selectedParentID, withTableName: self!.strSelectedTable)
                }
                self.present(vc, animated: true, completion: nil)
            }
            
            return
        }
        
        isDeleting = true
        if arrSelectedChoices.count > 0 {
            arrSelectedChoices.removeLast()
            
            if !strkeyboardType.isEmpty {
                isMainDeletePressed = true
                strkeyboardType = ""
                isMainDeletePressed = false
            }
        }
    }
    
    @IBAction func btnHomePressed(_ sender: Any) {
        arrTravel = ["Home"]
        arrSelectedParentID = [0]
        strSelectedTable = "TABLE_CHOICE"
        selectedParentID = 0
        readChoiceDB(parentID: selectedParentID, withTableName: strSelectedTable)
    }
    
    @IBAction func btnBackPressed(_ sender: Any) {
        
        if btnBack.tag == 1 {
            
            let myGroup = DispatchGroup()
            let arrSelected = choices.filter({$0.isSelected})
            
            arrSelected.forEach { choice in
                myGroup.enter()
                let arrChoiceWithParentID = choices.filter({$0.parentId == choice.id})
                
                if arrChoiceWithParentID.count > 0 {
                    myGroup.enter()
                    arrChoiceWithParentID.forEach { id in
                        if id.imgPath != "" {
                            APPDELEGATE.deleteFile(fileNameToDelete: id.imgPath!)
                        }
                        if id.recordingPath != "", let recordURL = URL(string:id.recordingPath!)?.lastPathComponent {
                            APPDELEGATE.deleteFile(fileNameToDelete: "recordings/\(recordURL)")
                        }
                        db.deleteByID(id: id.id, fromTable: strSelectedTable)
                        myGroup.leave()
                    }
                }
                if choice.imgPath != "" {
                    APPDELEGATE.deleteFile(fileNameToDelete: choice.imgPath!)
                }
                if choice.recordingPath != "", let recordURL = URL(string:choice.recordingPath!)?.lastPathComponent  {
                    APPDELEGATE.deleteFile(fileNameToDelete: "recordings/\(recordURL)")
                    }
                db.deleteByID(id: choice.id, fromTable: strSelectedTable)
                myGroup.leave()
            }
            
            myGroup.notify(queue: .main) { [weak self] in
                
                self!.readChoiceDB(parentID: self!.selectedParentID, withTableName: self!.strSelectedTable)
            }
            
            btnBack.isEnabled = false
            btnBack.alpha = 0.5
//                btnDelete.tag = 0
//                btnDelete.setImage(#imageLiteral(resourceName: "delete"), for: .normal)
            btnBack.tag = 0
            btnBack.setImage(#imageLiteral(resourceName: "back-arrow"), for: .normal)
//                lblDelete.text = "Delete"
            lblBack.text = "Back"
            
            return
        }
        
        arrTravel.removeLast()
        arrSelectedParentID.removeLast()
        if arrTravel.count == 1 {
            strSelectedTable = "TABLE_CHOICE"
        }
        readChoiceDB(parentID: arrSelectedParentID[arrSelectedParentID.last!], withTableName: strSelectedTable)
        
    }
    
    @IBAction func btnEditPressed(_ sender: UIButton) {
        
        btnEdit.isSelected.toggle()
        btnEdit.tintColor = sender.isSelected ? .orange : .blue
        isEnabled.toggle()
        
        if btnEdit.isSelected {
            
            btnKeyboard.setImage(#imageLiteral(resourceName: "ic_add"), for: .normal)
            lblKeyboard.text = "Add"
            
        } else {
            if lblBack.text == "Delete" {
                readChoiceDB(parentID: arrSelectedParentID[selectedParentID], withTableName: strSelectedTable)
                btnDelete.setImage(#imageLiteral(resourceName: "delete"), for: .normal)
                btnDelete.tag = 0
                if arrTravel.count >= 1 {
                    btnDelete.isEnabled = true
                    btnDelete.alpha = 1.0
                    if arrTravel.count == 1 {
                         
                        btnBack.isEnabled = false
                        btnBack.alpha = 0.5
                        btnHome.isEnabled = false
                        btnHome.alpha = 0.5
                        
                    } else {
                        
                        btnBack.isEnabled = true
                        btnBack.alpha = 1.0
                        btnHome.isEnabled = true
                        btnHome.alpha = 1.0
                    }
                    
                } else {
                    btnBack.isEnabled = false
                    btnBack.alpha = 0.5
                }
               
                btnBack.tag = 0
                btnBack.setImage(#imageLiteral(resourceName: "back-arrow"), for: .normal)
                lblBack.text = "Back"
            } else {
                if arrTravel.count >= 1 {
                    btnDelete.isEnabled = true
                    btnDelete.alpha = 1.0
                    if arrTravel.count == 1 {
                        
                        btnBack.isEnabled = false
                        btnBack.alpha = 0.5
                        btnHome.isEnabled = false
                        btnHome.alpha = 0.5
                        
                    } else {
                        
                        btnBack.isEnabled = true
                        btnBack.alpha = 1.0
                        btnHome.isEnabled = true
                        btnHome.alpha = 1.0
                    }
                    
                } else {
                    btnBack.isEnabled = false
                    btnBack.alpha = 0.5
                }
            }
            btnKeyboard.setImage(#imageLiteral(resourceName: "keyboard"), for: .normal)
            lblKeyboard.text = "Keyboard"
            lblDelete.text = "Delete"
        }
    }
    
    @IBAction func btnAddChoicePressed(_ sender: Any) {
        
        if lblKeyboard.text == "Add" {
            isDeleting = true
            let alertView = UIAlertController(title: "Choice", message: "What do you want to create?", preferredStyle: .actionSheet)
            
            alertView.addAction(UIAlertAction(title: "Add Many items together", style: .default, handler: { [weak self] alert in
                
                let alertController = UIAlertController(title: "Add Many choice words", message: "Enter words to add, separated by commas.", preferredStyle: .alert)

                   let saveAction = UIAlertAction(title: "ADD", style: .default, handler: { alert -> Void in
                       let firstTextField = alertController.textFields![0] as UITextField
                    print(firstTextField.text!)
                    self!.saveMultipleChoices(arrChoices: firstTextField.text!.components(separatedBy: ","))
                   })
                   let cancelAction = UIAlertAction(title: "CANCEL", style: .default, handler: {
                       (action : UIAlertAction!) -> Void in })
                   alertController.addTextField { (textField : UITextField!) -> Void in
                       textField.placeholder = "Breakfast, Launch, Dinner"
                   }

                   alertController.addAction(saveAction)
                   alertController.addAction(cancelAction)

                   self!.present(alertController, animated: true, completion: nil)
                
            }))
            alertView.addAction(UIAlertAction(title: "Add New Choice", style: .default, handler: { [weak self] alert in
                self!.openChoiceVC(isCategory: false)
               
            }))
            alertView.addAction(UIAlertAction(title: "Add New Category", style: .default, handler: { [weak self] alert in
                self!.openChoiceVC(isCategory: true)
               
            }))
            
            alertView.addAction(UIAlertAction(title: "CANCEL", style: .cancel, handler: nil))
            
            if let presenter = alertView.popoverPresentationController {
                    presenter.sourceView = btnKeyboard;
                    presenter.sourceRect = btnKeyboard.bounds;
                }
            
            self.present(alertView, animated: true, completion: nil)
            return
        }
        
        if btnKeyboard.tag == 0 {
            self.isDeleting = false
            UIView.transition(with: vwKeyboard, duration: 0.5, options: .transitionCrossDissolve) { [weak self] in
                self!.vwKeyboard.isHidden = false
                self!.view.layoutIfNeeded()
            } completion: { [weak self] _ in
                self!.btnKeyboard.setImage(#imageLiteral(resourceName: "picture"), for: .normal)
                self!.lblKeyboard.text = "Dashboard"
                self!.btnKeyboard.tag = 1
                if self!.arrSelectedChoices.count > 0 && !self!.arrSelectedChoices.last!.strCaption.isEmpty {
                    self!.arrSelectedChoices.append(selectedChoiceWords(strCaption: "", strImageName: ""))
                    
                } else {
                    self!.arrSelectedChoices = [selectedChoiceWords(strCaption: "", strImageName: "")]
                    
                }
            }

        } else {
            strkeyboardType = "#"
            
//            if strkeyboardType != "" {
//
//                btnSpaceClick(se)
//            }
            
            if arrSelectedChoices.count > 0 && arrSelectedChoices.last?.strCaption == ""{
                
                arrSelectedChoices.removeLast()
                
            }
            
            UIView.transition(with: vwKeyboard, duration: 0.5, options: .transitionCrossDissolve) { [weak self] in
                self!.vwKeyboard.isHidden = true
                self!.view.layoutIfNeeded()
            } completion: { [weak self] _ in
                self!.btnKeyboard.setImage(#imageLiteral(resourceName: "keyboard"), for: .normal)
                self!.lblKeyboard.text = "Keyboard"
                self!.btnKeyboard.tag = 0
            }
        }
//       else {
//
//
//
//        }
        
       // let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddChoiceVC") as! AddChoiceVC
    }
   
}

extension NewChoiceVC : TagListViewDelegate {
    func tagPressed(_ title: String, tagView: TagView, sender: TagListView) {
        
        var arrTemp = arrSelectedChoices.last
        arrTemp!.strCaption = title
        
        arrSelectedChoices[arrSelectedChoices.count - 1] = arrTemp!
        
    }
}


//extension UIView{
//    func animationZoom(scaleX: CGFloat, y: CGFloat) {
//        self.transform = CGAffineTransform(scaleX: scaleX, y: y)
//    }
//    
//    func animationRoted(angle : CGFloat) {
//        self.transform = self.transform.rotated(by: angle)
//    }
//}
///********fa ldsadflfj ;laj --- ghp_VU5xPdd4NNjkYzk8PM7VPPbap63zyb9CB1njdwK-------



extension NewChoiceVC: AVSpeechSynthesizerDelegate {

    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        
        if !isSpeaking {
            return
        }
          
        arrSelectedChoices.enumerated().forEach { index, model in
            
            if model.isSpeaking {
                arrSelectedChoices[index].isSpeaking = false
            }
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.isSpeaking = false
        }
        //label.attributedText = NSAttributedString(string: utterance.speechString)
    }
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, willSpeakRangeOfSpeechString characterRange: NSRange, utterance: AVSpeechUtterance) {

        if !isSpeaking {
            return
        }
        let mutableAttributedString = NSMutableAttributedString(string: utterance.speechString)
        let str = mutableAttributedString.attributedSubstring(from: characterRange)
        
       
        if let index = arrTempSelectedChoices.firstIndex(where: {$0 == str.string}),  let _ = arrSelectedChoices.firstIndex(where: {$0.strCaption == str.string}) {
            
            arrSelectedChoices[index].isSpeaking = true
            arrTempSelectedChoices[index] = ""
            
            print("index \(index)")
            if index > 0 {
                print("index - 1 ----- \(index-1)")
                arrSelectedChoices[index - 1].isSpeaking = false
            }
            //clVwSelectedChoices.reloadItems(at: [IndexPath(row: index, section: 0)])
           // sleep(UInt32(0.3))
           // arrSelectedChoices[index].isSpeaking = false
        }
        
        print(str.string)
        
           // mutableAttributedString.addAttribute(.foregroundColor, value: UIColor.red, range: characterRange)

    }
}

extension NewChoiceVC : UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return .none
    }
}

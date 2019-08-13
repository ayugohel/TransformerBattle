//
//  AddUpdateVC.swift
//  Transformer Battle
//
//  Created by Aayushi on 2019-08-10.
//  Copyright © 2019 Aayushi. All rights reserved.
//

import UIKit
import Moya
import QorumLogs
import SwiftyJSON

/**
 The purpose of the `AddUpdateVC` view controller is to provide a user interface where Create Transformer and Edit Transformer with all the details.
 
 There's a matching scene in the *AddUpdateVC.storyboard* file, and in that scene there are multiple UITextField display all Transformer's List. Go to Interface Builder for details.
 
 */
class AddUpdateVC: UIViewController {
    
    // MARK: - Outlets
    
    /// The UITextField for enter Transformer's value.
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtTeam: UITextField!
    @IBOutlet weak var txtStrength: UITextField!
    @IBOutlet weak var txtIntelligence: UITextField!
    @IBOutlet weak var txtSpeed: UITextField!
    @IBOutlet weak var txtEndurance: UITextField!
    @IBOutlet weak var txtRank: UITextField!
    @IBOutlet weak var txtCourage: UITextField!
    @IBOutlet weak var txtFirePower: UITextField!
    @IBOutlet weak var txtSkill: UITextField!
    
    /// The UILabel for display Title for Transformer's value. Asign class for reuse Fonts and Color.
    @IBOutlet weak var lblName: ThemeLabel!
    @IBOutlet weak var lblTeam: ThemeLabel!
    @IBOutlet weak var lblStrength: ThemeLabel!
    @IBOutlet weak var lblIntelligence: ThemeLabel!
    @IBOutlet weak var lblSpeed: ThemeLabel!
    @IBOutlet weak var lblEndurance: ThemeLabel!
    @IBOutlet weak var lblRank: ThemeLabel!
    @IBOutlet weak var lblCourage: ThemeLabel!
    @IBOutlet weak var lblFirePower: ThemeLabel!
    @IBOutlet weak var lblSkill: ThemeLabel!
    
    /// The UIButton for Create and Update Transformer's Value.
    @IBOutlet weak var btnAddUpdate: UIButton!
    
    /// The UIActivityIndicatorView display while load data in tableview
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    // MARK: - Variables
    
    var arrCountTen : [String] = []
    var arrCountEight : [String] = []
    var arrTeam : [String] = ["Autobot","Decepticon"]
    var pickerView = UIPickerView()
    var editype : EditType = .Add
    
    var editDataTransformer : Transformer = Transformer()
    
    // MARK: - Custom Methods
    
    /**
     This function is for Basic setup method for this view where implemented Transformer's Value when flag is `Edit` and set UIPickerView for UITextFields.
     */
    func setUP() {
        
        if editype == .Edit {
            
            txtName.text = JSON(editDataTransformer.name!).stringValue
            txtTeam.text = JSON(editDataTransformer.team!).stringValue == "A" ? "Autobot" : "Decepticon"
            txtStrength.text = JSON(editDataTransformer.strength!).stringValue
            txtIntelligence.text = JSON(editDataTransformer.intelligence!).stringValue
            txtSpeed.text = JSON(editDataTransformer.speed!).stringValue
            txtEndurance.text = JSON(editDataTransformer.endurance!).stringValue
            txtRank.text = JSON(editDataTransformer.rank!).stringValue
            txtCourage.text = JSON(editDataTransformer.courage!).stringValue
            txtFirePower.text = JSON(editDataTransformer.firepower!).stringValue
            txtSkill.text = JSON(editDataTransformer.skill!).stringValue
            
            btnAddUpdate.setTitle("Update", for: .normal)
            self.title = "UPDATE TRANSFORMER"
            
        } else {
            
            btnAddUpdate.setTitle("Create", for: .normal)
            self.title = "CREATE TRANSFORMER"
            
        }
        
        _ = (1...10).compactMap({ (data) -> Void in
            arrCountTen.append(String(data))
        })
        
        _ = (1...8).compactMap({ (data) -> Void in
            arrCountEight.append(String(data))
        })
        
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        
        txtTeam.inputView = pickerView
        txtStrength.inputView = pickerView
        txtIntelligence.inputView = pickerView
        txtSpeed.inputView = pickerView
        txtEndurance.inputView = pickerView
        txtRank.inputView = pickerView
        txtCourage.inputView = pickerView
        txtFirePower.inputView = pickerView
        txtSkill.inputView = pickerView
        
    }
    
    /**
     This function is for set activityIndicator and for start animation
     */
    func showActivityIndicator() {
        activityIndicator.isHidden = false
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = UIColor.black
        activityIndicator.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
    }
    
    /**
     This function is for and for stop animation
     */
    func hideActivityIndicator() {
        activityIndicator.hidesWhenStopped = true
        activityIndicator.isHidden = true
        UIApplication.shared.endIgnoringInteractionEvents()
        activityIndicator.stopAnimating()
    }
    
    func showAlert(message : String) {
        
        let titleStr = ""
        let messageStr = message
        
        let alert = UIAlertController(title: titleStr, message: messageStr, preferredStyle: UIAlertController.Style.alert)
        
        let action = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { (_) -> Void in

        })
        
        alert.addAction(action)
        
        alert.view.tintColor = UIColor.themeColor
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: - API Methods
    
    /**
     This function is for API Create Transformer.
     */
    func addTransformerAPI (param : Transformer) {
        
        self.showActivityIndicator()
        
        let provider = MoyaProvider<TransformerService>()
        provider.request(TransformerService.addTransformer(params: param.toDictionary())) { (result) in
            
            switch result {
                
            case .success(let response):
                
                do {
                    
                    if response.statusCode == 201 {
                        let res = try response.mapJSON()
                        let resJSON = JSON(res)
                        QL1(resJSON)
                        
                        self.navigationController?.popViewController(animated: true)
                        
                    } else {
                        QL1(try response.mapString())
                    }
                    
                } catch(let error){
                    QL1(error.localizedDescription)
                }
                break
            case .failure(let error):
                QL1(error.localizedDescription)
                break
            }
            
            self.hideActivityIndicator()
            
        }
        
    }
    
    /**
     This function is for API Update Transformer's Value.
     */
    func editTransformer(param : Transformer) {
        
        self.showActivityIndicator()
        
        let provider = MoyaProvider<TransformerService>()
        provider.request(TransformerService.editTransformer(params: param.toDictionary())) { (result) in
            
            switch result{
                
            case .success(let response):
                
                do{
                    
                    if response.statusCode == 200 {
                        
                        let res = try response.mapJSON()
                        let resJSON = JSON(res)
                        QL1(resJSON)
                        
                        self.navigationController?.popViewController(animated: true)
                        
                    } else {
                        QL1(try response.mapString())
                        
                    }
                    
                } catch(let error) {
                    QL1(error.localizedDescription)
                }
                
                break
            case .failure(let error):
                QL1(error.localizedDescription)
                break
            }
            
            self.hideActivityIndicator()
            
        }
    }
    
    
    // MARK: IBAction Methods
    
    /**
     It triggers the creation of the `Create` and `Update`.
     
     ### How it works ###
     On Tapped set Parameters for Create and Update API and execute relative API calling function.
     
     */
    
    @IBAction func btnAddUpdateTapped(_ sender: Any) {
        
        if txtName.text!.isEmpty {
            self.showAlert(message: kName)
            
        } else if txtTeam.text!.isEmpty {
            self.showAlert(message: kTEAM)

        } else if txtStrength.text!.isEmpty {
            self.showAlert(message: kSTRENGTH)

        } else if txtIntelligence.text!.isEmpty {
            self.showAlert(message: kINTELLIGENCE)

        } else if txtSpeed.text!.isEmpty {
            self.showAlert(message: kSPEED)

        } else if txtEndurance.text!.isEmpty {
            self.showAlert(message: kENDURANCE)

        } else if txtRank.text!.isEmpty {
            self.showAlert(message: kRANK)

        } else if txtCourage.text!.isEmpty {
            self.showAlert(message: kCOURAGE)

        } else if txtFirePower.text!.isEmpty {
            self.showAlert(message: kFIREPOWER)

        } else if txtSkill.text!.isEmpty {
            self.showAlert(message: kSKILL)

        } else {
            
            let param : Transformer = Transformer()
            
            param.name = txtName.text!
            param.team = txtTeam.text! == "Autobot" ? "A" : "D"
            param.strength = Int(txtStrength.text!)
            param.intelligence = Int(txtIntelligence.text!)
            param.speed = Int(txtSpeed.text!)
            param.endurance = Int(txtEndurance.text!)
            param.rank = Int(txtRank.text!)
            param.courage = Int(txtCourage.text!)
            param.firepower = Int(txtFirePower.text!)
            param.skill = Int(txtSkill.text!)
            
            if editype == .Add {
                param.id = 0
                self.addTransformerAPI(param: param)
                
            } else {
                param.TransformerId = JSON(editDataTransformer.TransformerId!).stringValue
                self.editTransformer(param: param)
            }
        }
    }
    
    // MARK: - View Life Cycle Method
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setUP()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
}

// MARK: UIPickerViewDelegate, UIPickerViewDataSource Methods
extension AddUpdateVC : UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if txtTeam.isFirstResponder {
            return arrTeam.count
            
        } else if txtStrength.isFirstResponder || txtIntelligence.isFirstResponder || txtEndurance.isFirstResponder || txtRank.isFirstResponder || txtCourage.isFirstResponder || txtSkill.isFirstResponder {
            return arrCountTen.count
            
        } else if txtSpeed.isFirstResponder || txtFirePower.isFirstResponder {
            return arrCountEight.count
            
        } else {
            return 0
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if txtTeam.isFirstResponder {
            return arrTeam[row]
            
        } else if txtStrength.isFirstResponder || txtIntelligence.isFirstResponder || txtEndurance.isFirstResponder || txtRank.isFirstResponder || txtCourage.isFirstResponder || txtSkill.isFirstResponder {
            return String(arrCountTen[row])
            
        } else if txtSpeed.isFirstResponder || txtFirePower.isFirstResponder {
            return String(arrCountEight[row])
            
        } else {
            return ""
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if txtTeam.isFirstResponder {
            txtTeam.text = arrTeam[row]
            
        } else if txtStrength.isFirstResponder {
            txtStrength.text = String(arrCountTen[row])
            
        } else if txtIntelligence.isFirstResponder {
            txtIntelligence.text = String(arrCountTen[row])
            
        } else if txtEndurance.isFirstResponder {
            txtEndurance.text = String(arrCountTen[row])
            
        } else if txtRank.isFirstResponder {
            txtRank.text = String(arrCountTen[row])
            
        } else if txtCourage.isFirstResponder {
            txtCourage.text = String(arrCountTen[row])
            
        } else if txtSkill.isFirstResponder {
            txtSkill.text = String(arrCountTen[row])
            
        } else if txtSpeed.isFirstResponder {
            txtSpeed.text = String(arrCountEight[row])
            
        } else if txtFirePower.isFirstResponder {
            txtFirePower.text = String(arrCountEight[row])
        }
        
    }
    
}

// MARK: UITextFieldDelegate
extension AddUpdateVC : UITextFieldDelegate {
    
    /// for Reload UIPickerView
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.pickerView.reloadAllComponents()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.pickerView.reloadAllComponents()
    }
}

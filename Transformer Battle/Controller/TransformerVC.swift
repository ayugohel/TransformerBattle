//
//  TransformerVC.swift
//  Transformer Battle
//
//  Created by Aayushi on 2019-08-10.
//  Copyright © 2019 Aayushi. All rights reserved.
//

import UIKit
import Moya
import QorumLogs
import SwiftyJSON
import Alamofire
import AlamofireImage

/**
 The purpose of the `TransformerVC` view controller is to provide a user interface where display team Autobot & Decepticon List and also have an option for create and edit Transformer, and Start battle option, and on UITableviewCell Swipe to delete functionality used for delete Transformer.
 
 There's a matching scene in the *TransformerVC.storyboard* file, and in that scene there is UITableViewfor display all Transformer's List. Go to Interface Builder for details.
 
 */
class TransformerVC: UIViewController {
    
    // MARK: Outlets
    
    /// The UITableView for Transformer data display.
    @IBOutlet weak var tblTransformer: UITableView!
    
    /// The UIActivityIndicatorView display while load data in tableview
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: Variables
    
    var arrTransformerList : [Transformer] = []
    
    
    // MARK: Custom Methods
    
    /**
     This function is for Basic setup method for this view where implemented allSpark API and get all transformer API.
     */
    func setUP() {
        
        if Authorization.authToken != nil {
            
            self.getAllTransformer()
            
        } else {
            
            self.showActivityIndicator()
            
            let provider = MoyaProvider<TransformerService>()
            provider.request(TransformerService.allSpark) { (result) in
                
                switch result {
                    
                case .success(let result):
                    QL1(String(data: result.data, encoding: .utf8))
                    Authorization.authToken = String(data: result.data, encoding: .utf8)
                    break
                    
                case .failure(let error):
                    QL1(error.localizedDescription)
                    break
                }
                
                self.hideActivityIndicator()
                
            }
        }
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
    
    /**
     This function is for and for show Alert.
     */
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
    
    
    // MARK: API Methods
    
    /**
     This function is for API get all Transformer List.
     */
    func getAllTransformer() {
        
        self.arrTransformerList = []
        self.tblTransformer.reloadData()
        
        self.showActivityIndicator()
        
        let provider = MoyaProvider<TransformerService>()
        provider.request(TransformerService.transformers) { (result) in
            
            switch result {
                
            case .success(let response):
                
                do {
                    
                    if response.statusCode == 200 {
                        let res = try response.mapJSON()
                        let resJSON = JSON(res)
                        
                        self.arrTransformerList = Transformer.appendArray(jsonArray: resJSON["transformers"].arrayValue)
                        
                        QL1(resJSON)
                        
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
            self.tblTransformer.reloadData()
            
        }
    }
    
    /**
     This function is for API delete perticular Transformer with ID.
     */
    func deleteAPI(id : String)  {
        
        self.showActivityIndicator()
        
        let provider = MoyaProvider<TransformerService>()
        provider.request(TransformerService.deleteTransformer(id: id)) { (result) in
            
            switch result {
                
            case .success(let response):
                
                do{
                    
                    if response.statusCode == 204 {
                        let res = try response.mapJSON()
                        let resJSON = JSON(res)
                        QL1(resJSON)
                        
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
            self.getAllTransformer()
            
        }
        
    }
    
    
    // MARK: IBAction Methods
    
    /**
     It triggers the creation of the `Create`.
     
     ### How it works ###
     On Tapped navigate `AddUpdateVC` viewcontroller.
     
     */
    @IBAction func btnAddUpdateTapped(_ sender: Any) {
        
        let vc = AppStoryboard.TRANSFORMER.instance.instantiateViewController(withIdentifier: "AddUpdateVC") as! AddUpdateVC
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    /**
     It triggers the creation of the `Start Battle`.
     
     ### How it works ###
     On Tapped navigate `BattleVC` viewcontroller, and pass Transformer's Array, but exception is if there is no any Transformer then it will not navigate on Batlle view.
     */
    @IBAction func btnBattleTapped(_ sender: Any) {
        
        let arrAutobot = arrTransformerList.filter({$0.team == "A"})
        let arrDecepticon = arrTransformerList.filter({$0.team == "D"})
        
        if (!arrAutobot.isEmpty && !arrDecepticon.isEmpty) {
            
            let vc = AppStoryboard.TRANSFORMER.instance.instantiateViewController(withIdentifier: "BattleVC") as! BattleVC
            vc.arrAllTransformer = self.arrTransformerList
            self.navigationController?.pushViewController(vc, animated: true)
            
        } else {
            self.showAlert(message: kAdd)
        }
        
        
    }
    
    
    // MARK: View Life Cycle Method
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setUP()
        self.tblTransformer.tableFooterView = UIView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.getAllTransformer()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
}


/**
 The purpose of the `TransformerCell` Cell is to provide a user interface where display team Autobot & Decepticon List on UITableView.
 */
class  TransformerCell : UITableViewCell {
    
    @IBOutlet weak var lblName: ThemeLabel!
    @IBOutlet weak var lblTeam: ThemeLabel!
    @IBOutlet weak var btnEdit: UIButton!
    @IBOutlet weak var imgIcon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}


// MARK: UITableViewDelegate, UITableViewDataSource Methods

extension TransformerVC : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrTransformerList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TransformerCell") as! TransformerCell
        
        cell.lblName.textColor(color: UIColor.black)
        
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: appFont.semiBold, size: size16)!,
            .foregroundColor: UIColor.black,
            .underlineStyle: NSUnderlineStyle.single.rawValue]
        
        let attributeString = NSMutableAttributedString(string: "Update",
                                                        attributes: attributes)
        
        cell.btnEdit.setAttributedTitle(attributeString, for: .normal)
        
        let data = arrTransformerList[indexPath.row]
        
        cell.lblName.text = data.name
        cell.lblTeam.text = data.team == "D" ? "Decepticon" : "Autobot"
        cell.imgIcon.af_setImage(withURL: URL(string: data.teamIcon)!)
        
        cell.btnEdit.addAction {
            let vc = AppStoryboard.TRANSFORMER.instance.instantiateViewController(withIdentifier: "AddUpdateVC") as! AddUpdateVC
            vc.editDataTransformer = self.arrTransformerList[indexPath.row]
            vc.editype = .Edit
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        return cell
        
    }
    
    private func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    /// Swipe to delete functionality for Transformer with ID.
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let deleteButton = UITableViewRowAction(style: .default, title: "Delete") { (action, indexPath) in
            self.deleteAPI(id: JSON(self.arrTransformerList[indexPath.row].TransformerId!).stringValue)
            return
        }
        
        deleteButton.backgroundColor = UIColor.themeColor
        return [deleteButton]
    }
}

/*
 @IBAction func btnGetAllTransformer(_ sender: AnyObject) {
 
 
 let provider = MoyaProvider<TransformerService>()
 provider.request(TransformerService.transformers) { (result) in
 
 switch result{
 
 case .success(let response):
 
 do{
 let _ = try response.mapJSON()
 
 } catch {
 
 }
 
 break
 case .failure(let error):
 QL1(error.localizedDescription)
 break
 }
 
 }
 } */



//
//  BattleVC.swift
//  Transformer Battle
//
//  Created by Aayushi on 2019-08-11.
//  Copyright © 2019 Aayushi. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
import AlamofireImage

/**
 The purpose of the `BattleVC` view controller is to provide a user interface where display team Autobot & Decepticon and after complition of the battle diplay winner name and battle count.
 
 There's a matching scene in the *BattleVC.storyboard* file, and in that scene there are three stackview maintain with team and winner for data display. Go to Interface Builder for details.
 
 */
class BattleVC: UIViewController {
    
    // MARK: - Outlets
    
    /// The UIStackView for winner and Team.
    @IBOutlet weak var stackTeam: UIStackView!
    @IBOutlet weak var stackWinner: UIStackView!
    
    /// The UIImageView for winner and Team icon display.
    @IBOutlet weak var imgTeamA: UIImageView!
    @IBOutlet weak var imgTeamD: UIImageView!
    @IBOutlet weak var imgWinner: UIImageView!
    
    /// The Label for winner and Team data(text) display.
    @IBOutlet weak var lblBattleCount: ThemeLabel!
    @IBOutlet weak var lblWinnerName: ThemeLabel!
    @IBOutlet weak var lblLosserName: ThemeLabel!
    @IBOutlet weak var lblTeamDtile: ThemeLabel!
    @IBOutlet weak var lblTeamAtitle: ThemeLabel!
    
    /// The UIActivityIndicatorView display while Battle is running.
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Variables
    
    var arrAllTransformer : [Transformer] = []
    var arrAutobot : [Transformer] = []
    var arrDecepticon : [Transformer] = []
    var arrteamAwinners : [String] = []
    var arrteamDwinners : [String] = []
    var arrteamAeliminate : [Transformer] = []
    var arrteamDeliminate : [Transformer] = []
    
    // MARK: - Custom Methods
    
    /**
     This function is for Basic setup method for this view where apply Label's text, font, fontColor and other necessary function calling
     */
    func setUP() {
        
        lblLosserName.textColor(color: UIColor.black)
        lblWinnerName.textColor(color: UIColor.black)
        lblBattleCount.textColor(color: UIColor.black)
        
        arrAutobot = arrAllTransformer.filter({$0.team == "A"})
        arrDecepticon = arrAllTransformer.filter({$0.team == "D"})
        
        arrAutobot = arrAutobot.sorted { $0.rank > $1.rank }
        arrDecepticon = arrDecepticon.sorted { $0.rank > $1.rank }
        
        lblTeamAtitle.text = "Autobot"
        lblTeamDtile.text = "Decepticon"
        
        if !arrAutobot.isEmpty {
            imgTeamA.af_setImage(withURL: URL(string: arrAutobot[0].teamIcon)!)
        }
        
        if !arrDecepticon.isEmpty {
            imgTeamD.af_setImage(withURL: URL(string: arrDecepticon[0].teamIcon)!)
        }
        
        self.startBattle()
        
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
     This function is for start Battle where all the conditions executes for important for battle challenge and in conclusion , that display winner team name with winner team icon , Survivors from the losing team.
     */
    func startBattle () {
        
        var battleCount : Int = 0
        
        let loopCount = min(arrAutobot.count,arrDecepticon.count)

        self.showActivityIndicator()
        
        self.arrteamDeliminate = self.arrDecepticon
        self.arrteamAeliminate = self.arrAutobot
        
        for i in 0...loopCount - 1 {
            
            battleCount += 1
            print(battleCount)
            
            let userD = arrDecepticon[i]
            let userA = arrAutobot[i]
            
            if (userD.name == "Optimus Prime" || userD.name == "Predaking") && (userA.name == "Optimus Prime" || userA.name == "Predaking" ) {
                
                print("TIE")
                print(battleCount,"Battle")
                print("Team Distroyed")
                
                stackTeam.isHidden = true
                stackWinner.isHidden = false
                
                lblBattleCount.text = "\(battleCount) Battle"
                lblWinnerName.text = "TEAM DISTROYED"
                lblLosserName.text = ""
                
                self.hideActivityIndicator()
                
                break
                
            } else if checkName(teamA: userA, teamD: userD) {
                
            } else if checkCourageAndStrength(teamA: userA, teamD: userD) {
                
            } else if checkSkills(teamA: userA, teamD: userD) {
                
            } else if checkOverAllRating(teamA: userA, teamD: userD) {
                
            }
        }
        
        self.hideActivityIndicator()
        
        if arrteamAwinners.count > arrteamDwinners.count {
            
            stackTeam.isHidden = true
            stackWinner.isHidden = false
            imgWinner.af_setImage(withURL: URL(string: arrAutobot[0].teamIcon)!)
            lblBattleCount.text = "\(battleCount) Battle"
            lblWinnerName.text = "Winning team (Autobot) : \(arrteamAwinners.joined(separator: ", "))"
            lblLosserName.text = arrteamDeliminate.isEmpty ? "No Survivors" : "Survivors from the losing team (Decepticon) : \(arrteamDeliminate.compactMap({$0.name}).joined(separator: ", "))"
            
        } else if arrteamDwinners.count > arrteamAwinners.count {
            
            stackTeam.isHidden = true
            stackWinner.isHidden = false
            imgWinner.af_setImage(withURL: URL(string: arrDecepticon[0].teamIcon)!)
            lblBattleCount.text = "\(battleCount) Battle"
            lblWinnerName.text = "Winning team (Decepticon) : \(arrteamDwinners.joined(separator: ", "))"
            
            lblLosserName.text = arrteamAeliminate.isEmpty ? "No Survivors" : "Survivors from the losing team (Autobot) : \(arrteamAeliminate.compactMap({$0.name}).joined(separator: ", "))"
            
        } else {
            
            print("TIE")
            stackTeam.isHidden = true
            stackWinner.isHidden = false
            lblBattleCount.text = "\(battleCount) Battle"
            lblWinnerName.text = "TEAM DISTROYED"
            lblLosserName.text = ""
        }
    }
    
    /**
     This function is for on of the battle condition where check condition for special  rule of Battle that on perticular name it decide winner team and looser team and add points to the winner team.
     */
    func checkName(teamA : Transformer, teamD : Transformer) -> Bool {
        
        let isAwin = (teamA.name == "Optimus Prime" || teamA.name == "Predaking" )
        let isDwin = (teamD.name == "Optimus Prime" || teamD.name == "Predaking")
        
        if isDwin {
            arrteamDwinners.append(teamD.name)
            arrteamAeliminate = arrteamAeliminate.filter{$0.TransformerId != teamA.TransformerId}
            return true
            
        } else if isAwin {
            arrteamAwinners.append(teamA.name)
            arrteamDeliminate = arrteamDeliminate.filter{$0.TransformerId != teamD.TransformerId}
            return true
            
        } else {
            return false
        }
    }
    
    /**
     This function is for on of the battle condition where check condition for Battle that
     **If any fighter is down 4 or more points of courage and 3 or more points of strength
     compared to their opponent**
     and it decide winner team and looser team and add points to the winner team.
     */
    func checkCourageAndStrength(teamA : Transformer, teamD : Transformer) -> Bool {
        
        let isAwin = ((teamA.courage - teamD.courage)) >= 4 && (teamA.strength - teamD.strength) >= 3
        let isDwin = ((teamD.courage - teamA.courage)) >= 4 && (teamD.strength - teamA.strength) >= 3
        
        if isDwin {
            arrteamDwinners.append(teamD.name)
            arrteamAeliminate = arrteamAeliminate.filter{$0.TransformerId != teamA.TransformerId}
            return true
            
        } else if isAwin {
            arrteamAwinners.append(teamA.name)
            arrteamDeliminate = arrteamDeliminate.filter{$0.TransformerId != teamD.TransformerId}
            return true
            
        } else {
            return false
        }
        
    }
    
    /**
     This function is for on of the battle condition where check condition for Battle that
     **If one of the fighters is 3 or more points of skill above their opponent**
     and it decide winner team and looser team and add points to the winner team.
     */
    func checkSkills(teamA : Transformer, teamD : Transformer) -> Bool {
        
        let isAwin = ((teamA.skill - teamD.skill)) >= 3
        let isDwin = ((teamD.skill - teamA.skill)) >= 3
        
        if isDwin {
            arrteamDwinners.append(teamD.name)
            arrteamAeliminate = arrteamAeliminate.filter{$0.TransformerId != teamA.TransformerId}
            return true
            
        } else if isAwin {
            arrteamAwinners.append(teamA.name)
            arrteamDeliminate = arrteamDeliminate.filter{$0.TransformerId != teamD.TransformerId}
            return true
            
        } else {
            return false
        }
        
    }
    
    /**
     This function is for on of the battle condition where check condition for Battle that
     **The winner is the Transformer with the highest overall rating**
     and it decide winner team and looser team and add points to the winner team.
     */
    func checkOverAllRating(teamA : Transformer, teamD : Transformer) -> Bool {
        
        //        Strength + Intelligence + Speed + Endurance + Firepower
        
        let arrA : [Int] = [teamA.strength , teamA.intelligence , teamA.speed , teamA.endurance , teamA.firepower]
        let arrD : [Int] = [teamD.strength , teamD.intelligence , teamD.speed , teamD.endurance , teamD.firepower]
        
        let teamAoverallPoints = arrA.sum()
        let teamDoverallPoints = arrD.sum()
        
        if teamAoverallPoints > teamDoverallPoints {
            arrteamDwinners.append(teamD.name)
            arrteamAeliminate = arrteamAeliminate.filter{$0.TransformerId != teamA.TransformerId}
            return true
            
        } else if teamDoverallPoints > teamAoverallPoints {
            arrteamAwinners.append(teamA.name)
            arrteamDeliminate = arrteamDeliminate.filter{$0.TransformerId != teamD.TransformerId}
            return true
            
        } else { //if teamDoverallPoints == teamAoverallPoints
            print("TIE")
            return false
        }
        
    }
    
    
    // MARK: - API Methods
    
    
    // MARK: IBAction Methods
    
    
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

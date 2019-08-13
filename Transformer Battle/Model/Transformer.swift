//
//    Transformer.swift
//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation
import SwiftyJSON


class Transformer : NSObject, NSCoding {
    
    var courage : Int!
    var endurance : Int!
    var firepower : Int!
    var id : Int!
    var intelligence : Int!
    var name : String!
    var rank : Int!
    var skill : Int!
    var speed : Int!
    var strength : Int!
    var team : String!
    var teamIcon : String!
    var TransformerId : String!
    
    override init() {
        super.init()
    }
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        courage = json["courage"].intValue
        endurance = json["endurance"].intValue
        firepower = json["firepower"].intValue
        id = json["id"].intValue
        intelligence = json["intelligence"].intValue
        name = json["name"].stringValue
        rank = json["rank"].intValue
        skill = json["skill"].intValue
        speed = json["speed"].intValue
        strength = json["strength"].intValue
        team = json["team"].stringValue
        teamIcon = json["team_icon"].stringValue
        TransformerId = json["id"].stringValue
    }
    
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if courage != nil{
            dictionary["courage"] = courage
        }
        if endurance != nil{
            dictionary["endurance"] = endurance
        }
        if firepower != nil{
            dictionary["firepower"] = firepower
        }
        if id != nil{
            dictionary["id"] = id
        }
        if intelligence != nil{
            dictionary["intelligence"] = intelligence
        }
        if name != nil{
            dictionary["name"] = name
        }
        if rank != nil{
            dictionary["rank"] = rank
        }
        if skill != nil{
            dictionary["skill"] = skill
        }
        if speed != nil{
            dictionary["speed"] = speed
        }
        if strength != nil{
            dictionary["strength"] = strength
        }
        if team != nil{
            dictionary["team"] = team
        }
        if teamIcon != nil{
            dictionary["team_icon"] = teamIcon
        }
        if TransformerId != nil{
            dictionary["id"] = TransformerId
        }
        return dictionary
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        courage = aDecoder.decodeObject(forKey: "courage") as? Int
        endurance = aDecoder.decodeObject(forKey: "endurance") as? Int
        firepower = aDecoder.decodeObject(forKey: "firepower") as? Int
        id = aDecoder.decodeObject(forKey: "id") as? Int
        intelligence = aDecoder.decodeObject(forKey: "intelligence") as? Int
        name = aDecoder.decodeObject(forKey: "name") as? String
        rank = aDecoder.decodeObject(forKey: "rank") as? Int
        skill = aDecoder.decodeObject(forKey: "skill") as? Int
        speed = aDecoder.decodeObject(forKey: "speed") as? Int
        strength = aDecoder.decodeObject(forKey: "strength") as? Int
        team = aDecoder.decodeObject(forKey: "team") as? String
        teamIcon = aDecoder.decodeObject(forKey: "team_icon") as? String
        TransformerId = aDecoder.decodeObject(forKey: "id") as? String

    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    func encode(with aCoder: NSCoder)
    {
        if courage != nil{
            aCoder.encode(courage, forKey: "courage")
        }
        if endurance != nil{
            aCoder.encode(endurance, forKey: "endurance")
        }
        if firepower != nil{
            aCoder.encode(firepower, forKey: "firepower")
        }
        if id != nil{
            aCoder.encode(id, forKey: "id")
        }
        if intelligence != nil{
            aCoder.encode(intelligence, forKey: "intelligence")
        }
        if name != nil{
            aCoder.encode(name, forKey: "name")
        }
        if rank != nil{
            aCoder.encode(rank, forKey: "rank")
        }
        if skill != nil{
            aCoder.encode(skill, forKey: "skill")
        }
        if speed != nil{
            aCoder.encode(speed, forKey: "speed")
        }
        if strength != nil{
            aCoder.encode(strength, forKey: "strength")
        }
        if team != nil{
            aCoder.encode(team, forKey: "team")
        }
        if teamIcon != nil{
            aCoder.encode(teamIcon, forKey: "team_icon")
        }
        if TransformerId != nil{
            aCoder.encode(teamIcon, forKey: "id")
        }
        
    }
    
    static func appendArray(jsonArray : [JSON]) -> [Transformer] {
        
        var arrModel: [Transformer] = []
        for json in jsonArray {
            let model = Transformer.init(fromJson: json)
            arrModel.append(model)
        }
        return arrModel
    }
    
}

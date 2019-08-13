//
//  APIManager.swift
//  Transformer Battle
//
//  Created by admin on 10/08/19.
//  Copyright © 2019 Kushal. All rights reserved.
//

import Foundation
import Moya
import QorumLogs
import Alamofire

enum TransformerService {
    
    case allSpark
    case transformers
    case addTransformer(params : Parameters)
    case deleteTransformer(id : String)
    case editTransformer(params : Parameters)
    case getTransformerDetails(id : String)
    
}

// MARK: - TargetType Protocol Implementation
extension TransformerService : TargetType {
        
    var headers: [String : String]? {
        
        var headers : [String : String] = [:]
        headers += ["Content-Type" : "application/json"]
        
        if let token = UserDefaults.standard.value(forKey: UserDefaultKeys.authorization) as? String{
            headers += ["Authorization" : "Bearer " + token]
        }
        
        
        //        headers += APISecurity.security().dictionary()
        
        return headers
    }
    
    // MARK: - baseURL
    var baseURL: URL {
        return URL(string: "https://transformers-api.firebaseapp.com/")!
    }
    
    // MARK: - path
    var path: String {
        
        switch self{
        case .allSpark:
            return "allspark"
        case .transformers:
            return "transformers"
        case .addTransformer:
            return "transformers"
        case .deleteTransformer(let id):
            return "transformers/" +  id
        case .editTransformer:
            return "transformers"
        case .getTransformerDetails(let id):
            return "transformers/" +  id
            
        }
    }
    
    // MARK: - method
    var method: Moya.Method {
        switch self {
        case .allSpark , .transformers ,.getTransformerDetails :
            return .get
        case .addTransformer:
            return .post
        case .deleteTransformer:
            return .delete
        case .editTransformer:
            return .put
        }
    }
    
    // MARK: - task
    var task: Task {
        switch self {
        case .allSpark , .transformers , .addTransformer , .deleteTransformer , .editTransformer , .getTransformerDetails:
            return .requestParameters(parameters: parameters!, encoding: JSONEncoding.default)
        }
    }
    
    // MARK: - parameters
    var parameters: [String: Any]? {
        var params : [String: Any] = [:]
        switch self {
            
        case .allSpark , .transformers , .deleteTransformer , .getTransformerDetails:
            break
        case .addTransformer(let parameter):
            params = parameter
        case .editTransformer(let parameter):
            params = parameter
            break
        }
        
        QL1("\n==================== API CALL : ==================")
        QL1("TransformerService := \(self.path)");
        QL1("Headers := \(String(describing: self.headers))");
        QL1("params := \(params)");
        QL1("\n======================================")
        return params
        
    }
    
    var sampleData: Data {
        return "Half measures are as bad as nothing at all.".utf8Encoded
    }
}


// MARK: - Helpers
extension String {
    var urlEscaped: String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
    
    var utf8Encoded: Data {
        return self.data(using: .utf8)!
    }
}

func += <Key, Value> ( left: inout [Key:Value], right: [Key:Value]) {
    for (key, value) in right {
        left.updateValue(value, forKey: key)
    }
}


struct Authorization {
    static var authToken: String? {
        set{
            guard let unwrappedKey = newValue else{
                return
            }
            UserDefaults.standard.set(unwrappedKey, forKey: UserDefaultKeys.authorization)
            UserDefaults.standard.synchronize()
        }get{
            return UserDefaults.standard.value(forKey: UserDefaultKeys.authorization) as? String
        }
    }
    
}


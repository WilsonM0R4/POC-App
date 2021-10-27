//
//  LocalStorage.swift
//  poc_app
//
//  Created by wilson on 26/10/21.
//

import Foundation

class LocalStorage {
    
    init () {
        
    }
    
    func saveToStorage (objectToSave:Any, key: String) {
        UserDefaults.standard.set(objectToSave, forKey: key)
    }
    
    func readArrayFromStorage(key:String) -> [Any] {        
        return UserDefaults.standard.array(forKey: key) ?? []
    }
    
    
    func readFromStorage (key:String) -> Any{
        return UserDefaults.standard.object(forKey: key) as Any
    }
    
    func readStringFromStorage(key:String) -> String {
        return UserDefaults.standard.string(forKey: key) ?? ""
    }
    
}

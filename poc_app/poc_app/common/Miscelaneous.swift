//
//  Miscelaneous.swift
//  poc_app
//
//  Created by wilson on 24/10/21.
//

import Foundation

class Miscelaneous {
    /**
     Divides an array into some subarrays of a determined lenght
     */
    static func splitArray(splitLenght:Int, arrayToSplit:[Any]) -> [Any]{
        var splitArray : [Any] = []
        
        let splitNum = arrayToSplit.count / splitLenght
        var c = 0
        var start = 0
        
        while c < splitNum {
            let end = start + splitLenght
            
            let split : ArraySlice<Any> = arrayToSplit[start ..< end]
            splitArray.append(Array(split))
            start = end
            c += 1
        }
        
        return splitArray
    }
    
}

//
//  Pizza.swift
//  Watch
//
//  Created by Administrator on 09/09/14.
//  Copyright (c) 2014 IBM. All rights reserved.
//

import Foundation

class Pizza {
    var pizzaPricePerInSq = ["Cheese": 0.03 , "Sausage": 0.06 , "Pepperoni": 0.05 , "Veggie": 0.04]
    var typeList:Array<String> {
        get {
            return Array(pizzaPricePerInSq.keys)
        }
    }
    
    let pi = 3.1415926
    
    var pizzaDiameter = 0.0
    let maxPizza = 24.0
    var pizzaType = "Cheese"
    
    var radius : Double {  //computed property
        get{   //must define a getter
            return pizzaDiameter/2.0
        }
        set(newRadius){ //optionally define a setter
            pizzaDiameter = newRadius * 2.0
        }
    }
    
    var area :  Double {
        get{
            return pizzaArea()
        }
    }
    
    func pizzaArea() -> Double{
        return radius * radius * pi
    }
    
    func unitPrice() ->Double{
        let unitPrice = pizzaPricePerInSq[pizzaType]    //optional type ?Double
        if (unitPrice != nil){
            return unitPrice!
        }                               //optional type ?Double checking for nil
        else {
            return 0.0
        }
    }
    
    func pizzaPrice() ->Double{
        let unitPrice = pizzaPricePerInSq[pizzaType]    //optional type ?Double
        if (unitPrice != nil){                                   //optional type ?Double checking for nil
            return pizzaArea() * unitPrice!             //unwrapping the optional type
        }
        return 0.0
    }
    
    func diameterFromString(aString:NSString) -> Double {
        switch aString {
        case "Personal":
            return 8.0
        case "10\"":
            return 10.0
        case "12\"":
            return 12.0
        case "16\"","15\"":
            return 16.0
        case "18\"":
            return 18.0
        case "24\"":
            return 24.0
        default:
            return 0.0
        }
    }
    
}
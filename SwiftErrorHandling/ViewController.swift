//
//  ViewController.swift
//  SwiftErrorHandline
//
//  Created by FrankLiu on 15/10/12.
//  Copyright © 2015年 刘大帅. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    enum VendingMachineError : ErrorType {
        
        case InvalidSelection
        
        case InsufficientFunds(coinsNeeded:Int)
        
        case OutOfStock
    }
    
    struct Item {
        
        var price : Int
        
        var count : Int
    }
    
    class VendingMachine {
        
        var inventory = [
            
            "Candy Bar" : Item(price: 12, count: 7),
            
            "Chips"     : Item(price: 10, count: 4),
            
            "Pretzels"  : Item(price: 7, count: 11)
        ]
        
        var coinsDeposited = 0
        
        func dispenseSnack(snack:String) {
            
            print("dispensine \(snack)")
        }
        
        func vend(itemNamed name:String) throws {
            
            guard var item = inventory[name] else {
                
                throw
                    
                    VendingMachineError.InvalidSelection
            }
            
            guard item.count > 0 else {
                
                throw
                    
                    VendingMachineError.OutOfStock
            }
            
            guard item.price <= coinsDeposited else {
                
                throw
                    
                    VendingMachineError.InsufficientFunds(coinsNeeded: item.price - coinsDeposited)
            }
            
            coinsDeposited -= item.price
            
            --item.count
            
            inventory[name] = item
            
            dispenseSnack(name)
        }
    }
    
    let favoriteSnacks = [
    
        "Alice" : "Chips",
        
        "Bob"   : "Licorice",
        
        "Eve"   : "Pretzels"
    ]
    
    func buyFavoriteSnack(person:String, vendingMachine:VendingMachine) throws {
    
        let snackName = favoriteSnacks[person] ?? "Candy Bar"
        
        try vendingMachine.vend(itemNamed: snackName)
    }
    
    func someThrowingFunction(value : Int) throws -> Int {
    
        // ...
        
        return value*3
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let vendingMachine = VendingMachine()
        
        vendingMachine.coinsDeposited = 8
        
        // 标准用法
        do {
        
            try buyFavoriteSnack("Alice", vendingMachine: vendingMachine)
            
        } catch VendingMachineError.InvalidSelection {
        
            print("Invalid Selection.")
            
        } catch VendingMachineError.OutOfStock {
        
            print("Out of Stock.")
            
        } catch VendingMachineError.InsufficientFunds(let coinsNeeded) {
        
            print("Insufficient funds.Please insert an addtional \(coinsNeeded) coins.")
            
        } catch is ErrorType {
        
            print("其他异常.")
        }
        
        // try?
        let x = try? someThrowingFunction(100)
        
        // 相当于
        let y :Int?
        
        do {
        
            y = try someThrowingFunction(100)
            
        } catch {
        
            y = nil
        }
        
        // TODO: try!
        
        // TODO: defer 关键字
        
    }
}


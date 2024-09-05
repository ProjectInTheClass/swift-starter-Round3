//
//  person.swift
//  CodeStarterCamp_Week3
//
//  Created by 구현 on 9/2/24.
//

import Foundation

struct Person {
    var name: String
    var money: Int = 0 {
        didSet {
            printMoney()
        }
    }
    
    init(name: String, money: Int) {
        self.name = name
        self.money = money
    }
    
    init(name: String) {
        self.name = name
    }
    
    mutating func buyCoffee(_ coffees: [Coffee], shop: CoffeeShop) {
        guard let totalAmount: Int = calculateTotalAmount(coffees, at: shop) else {
            print("가게에 없는 메뉴입니다.")
            return
        }
        
        let remainingMoney: Int = calculateRemainingMoney(with: totalAmount)
        
        guard remainingMoney >= 0 else {
            print("\(self.name)의 잔액이 \(-remainingMoney)원만큼 부족합니다.")
            return
        }
        
        shop.order(coffees, by: self)
        self.money = remainingMoney
    }
    
    func calculateTotalAmount(_ coffees: [Coffee], at shop: CoffeeShop) -> Int? {
        var totalAmount: Int = 0
        
        for coffee in coffees {
            guard shop.menu.contains(coffee) else {
                print("\(coffee.rawValue)(은/는) 없는 품목입니다.")
                return nil
            }
            
            totalAmount += coffee.price
        }
        
        return totalAmount
    }
    
    func calculateRemainingMoney(with totalAmount: Int) -> Int {
        self.money - totalAmount
    }
    
    func printMoney() {
        print("\(self.name)의 잔액이 \(self.money)원 남았습니다.")
    }
}

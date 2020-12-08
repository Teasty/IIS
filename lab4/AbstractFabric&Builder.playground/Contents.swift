import UIKit
import Foundation

struct House {
    var lenght = Int()
    var width = Int()
    var height = Int()
    var garden: Bool?
    var pool: Bool?
}

protocol HouseBuilder {
    func reset()
    func stepA()
    func stepB()
}

class Director {
    init(builder: HouseBuilder) {
        self.builder = builder
    }
    var builder: HouseBuilder
    
    func make(type: String) {
        builder.reset()
        if type == "simple" {
            builder.stepA()
        } else {
            builder.stepA()
            builder.stepB()
        }
    }
    func swap(builder: HouseBuilder) {
        self.builder = builder
    }
}

class EnglishHouseBuilder: HouseBuilder {
    
    var house = House()
    
    func reset() {
        house = House()
    }
    
    func stepA() {
        house.width = 6
        house.lenght = 4
        house.height = 4
    }
    
    func stepB() {
        house.garden = true
    }
    
    func getResult() {
        print(house)
    }
}

class FachwerkHouseBuilder: HouseBuilder {
    var house = House()
    
    func reset() {
        house = House()
    }
    
    func stepA() {
        house.width = 4
        house.lenght = 4
        house.height = 4
    }
    
    func stepB() {
        house.garden = true
    }
    
    func getResult() {
        print(house)
    }
}

class ModernHouseBuilder: HouseBuilder {
    
    var house = House()
    
    func reset() {
        house = House()
    }
    
    func stepA() {
        house.width = 3
        house.lenght = 6
        house.height = 4
    }
    
    func stepB() {
        house.pool = true
    }
    
    func getResult() {
        print(house)
    }
}


let m = ModernHouseBuilder()
let f = FachwerkHouseBuilder()
let e = EnglishHouseBuilder()
let director = Director(builder: m)

director.make(type: "simple")
m.getResult()

director.swap(builder: f)
director.make(type: "not simple")
f.getResult()

director.swap(builder: e)
director.make(type: "simple")
e.getResult()


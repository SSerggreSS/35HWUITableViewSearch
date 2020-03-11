//
//  Student.swift
//  HWUITableViewSearch
//
//  Created by Сергей on 06.03.2020.
//  Copyright © 2020 Sergei. All rights reserved.
//

import Foundation

class Student {
    
    //MARK: Properties
       var name = ""
       var secondName = ""
       var dateOfBirth = Date()
       
       init(name: String, secondName: String, dateOfBirth: Date) {
           
           self.name = name
           self.secondName = secondName
           self.dateOfBirth = dateOfBirth
           
       }

    //MARK: Static Properties
    static let firstNames = ["Tran",    "Lenore",    "Bud",     "Fredda",   "Katrice",
                            "Clyde",   "Hildegard", "Vernell", "Nellie",   "Rupert",
                            "Billie",  "Tamica",    "Crystle", "Kandi",    "Caridad",
                            "Vanetta", "Taylor",    "Pinkie",  "Ben",      "Rosanna",
                            "Eufemia", "Britteny",  "Ramon",   "Jacque",   "Telma",
                            "Colton",  "Monte",     "Pam",     "Tracy",    "Tresa",
                            "Willard", "Mireille",  "Roma",    "Elise",    "Trang",
                            "Ty",      "Pierre",    "Floyd",   "Savanna",  "Arvilla",
                            "Whitney", "Denver",    "Norbert", "Meghan",   "Tandra",
                            "Jenise",  "Brent",     "Elenor",  "Sha",      "Jessie"]

    
    static let lastNames = ["Farrah",       "Heal",         "Heal",      "Sechrest",  "Roots",
                            "Homan",        "Starns",       "Oldham",    "Yocum",     "Mancia",
                            "Prill",        "Lush",         "Piedra",    "Lenz",      "Warnock",
                            "Vanderlinden", "Simms",        "Gilroy",    "Brann",     "Bodden",
                            "Lenz",         "Gildersleeve", "Wimbish",   "Bello",     "Beachy",
                            "Jurado",       "William",      "Beaupre",   "Dyal",      "Doiron",
                            "Plourde",      "Bator",        "Krause",    "Odriscoll", "Corby",
                            "Waltman",      "Michaud",      "Kobayashi", "Sherrick",  "Woolfolk",
                            "Holladay",     "Hornback",     "Moler",     "Bowles",    "Libbey",
                            "Spano",        "Folso" ,       "Wimbish",   "Plourde",   "Beachy"]
    
    static let namesCount = 50
 
    //MARK: Static Function
    
    static func randomStudent() -> Student {

        let name = Student.firstNames[Int(arc4random()) % Student.namesCount]
        let secondName = Student.lastNames[Int(arc4random()) % Student.namesCount]
        let dateOfBirth = Date.createRandomDate(in: 1992..<2002)
        let student = Student(name: name, secondName: secondName, dateOfBirth: dateOfBirth)

        return student
    }
    
    static func randomStudents(amount: Int) -> [Student] {
        
        var studentsArray = [Student]()
        
        for _ in 0..<amount {
    
            studentsArray.append(randomStudent())
            
        }
        
        sorted(studetns: &studentsArray)
        
        return studentsArray
    }
    
    static private func countDaysIn(month: Int, year: Int) -> Int {
        
        var amountDeys = 0
        
        switch month {
            case 1:
                amountDeys = 31
            case 2:
                amountDeys = year % 4 == 0 ? 29 : 28
            case 3:
                amountDeys = 30
            case 4:
                amountDeys = 31
            case 5:
                amountDeys = 30
            case 6:
                amountDeys = 31
            case 7:
                amountDeys = 30
            case 8:
                amountDeys = 31
            case 9:
                amountDeys = 30
            case 10:
                amountDeys = 31
            case 11:
                amountDeys = 30
            case 12:
                amountDeys = 31
            default:
                break
        }
    
        return amountDeys
        
    }
    
    private func createRandomDate(in range: Range<Int>) -> Date {
        
        let randomYear = Int.random(in: range)
        let randomMonth = Int(arc4random() % 12 + 1)
        let randomDay = Student.countDaysIn(month: randomMonth, year: randomYear)
        
        let gregorianCalendar = Calendar(identifier: .gregorian)
        
        var dateComponents = DateComponents()
        
        dateComponents.calendar = gregorianCalendar
        dateComponents.setValue(randomYear, for: .year)
        dateComponents.setValue(randomMonth, for: .month)
        dateComponents.setValue(randomDay, for: .day)
        
        return gregorianCalendar.date(from: dateComponents) ?? Date()
    }
    
    //MARK: Sorting
    
    static private func sorted(studetns: inout [Student]) {
        
        studetns.sort { (lStud, rStud)  -> Bool in
            
            if lStud.name != rStud.name {
                return lStud.name < rStud.name
            } else if lStud.name == rStud.name &&
                lStud.secondName != rStud.secondName  {
                return lStud.secondName < rStud.secondName
            } else {
                return lStud.dateOfBirth > rStud.dateOfBirth
            }
            
        }
    }
    
    func description() {
        print("name: \(name), surname: \(secondName), dateOfBirth: \(dateOfBirth)")
    }

}

//
//  DateExtension.swift
//  HWUITableViewSearch
//
//  Created by Сергей on 06.03.2020.
//  Copyright © 2020 Sergei. All rights reserved.
//

import Foundation

extension Date {
    
   static func createRandomDate(in range: Range<Int>) -> Date {
        
        let randomYear = Int.random(in: range)
        let randomMonth = Int(arc4random() % 12 + 1)
        let randomDay = Date.countDaysIn(month: randomMonth, year: randomYear)
        
        let gregorianCalendar = Calendar(identifier: .gregorian)
        
        var dateComponents = DateComponents()
        
        dateComponents.calendar = gregorianCalendar
        dateComponents.setValue(randomYear, for: .year)
        dateComponents.setValue(randomMonth, for: .month)
        dateComponents.setValue(randomDay, for: .day)
        
        return gregorianCalendar.date(from: dateComponents) ?? Date()
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
    
}

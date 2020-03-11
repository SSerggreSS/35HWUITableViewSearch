//
//  CalendarExtension.swift
//  HWUITableViewSearch
//
//  Created by Сергей on 10.03.2020.
//  Copyright © 2020 Sergei. All rights reserved.
//

import Foundation

extension Calendar {
    
    func getComponentMonth(date: Date) -> Int {
        
        return self.component(.month, from: date)
        
    }
    
}

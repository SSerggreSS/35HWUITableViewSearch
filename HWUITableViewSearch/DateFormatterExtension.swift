//
//  DateFormatterExtension.swift
//  HWUITableViewSearch
//
//  Created by Сергей on 06.03.2020.
//  Copyright © 2020 Sergei. All rights reserved.
//

import Foundation

extension DateFormatter {
    
    static func stringFrom(date: Date, format: String) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        let str = dateFormatter.string(from: date)
        
        return str
        
    }
    
}

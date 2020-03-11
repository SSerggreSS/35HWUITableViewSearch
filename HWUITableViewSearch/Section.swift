//
//  Section.swift
//  HWUITableViewSearch
//
//  Created by Сергей on 06.03.2020.
//  Copyright © 2020 Sergei. All rights reserved.
//

import Foundation

class Section {
    
    var name = ""
    var students = [Student]()
    
    init() {
        name = ""
        students = [Student]()
    }
    
    init(name: String, students: [Student]) {
        self.name = name
        self.students = students
    }
    
}

//
//  File.swift
//  HWUITableViewSearch
//
//  Created by Сергей on 10.03.2020.
//  Copyright © 2020 Sergei. All rights reserved.
//

import Foundation
import UIKit

  // placeholder for things to come -- only fades in for now
  class TipInCellAnimator {
    
    static func animate(cell:UITableViewCell) {
      let view = cell.contentView
        view.layer.opacity = 0.1
        UIView.animate(withDuration: 1.0) {
            view.layer.opacity = 1
        }
    }
}


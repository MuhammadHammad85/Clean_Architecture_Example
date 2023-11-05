//
//  TableView + Extension.swift
//  Small World Task
//
//  Created by Hammad Baig on 04/11/2023.
//

import Foundation
import UIKit

extension UITableView {
    
    func registerCell(name: String){
        register(UINib(nibName: name, bundle: nil), forCellReuseIdentifier: name)
    }
    
}

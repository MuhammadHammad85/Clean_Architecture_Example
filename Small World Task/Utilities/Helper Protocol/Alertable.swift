//
//  Alertable.swift
//  Small World Task
//
//  Created by Hammad Baig on 04/11/2023.
//

import Foundation
import UIKit

public protocol Alertable {}
public extension Alertable where Self: UIViewController {
    
    func showAlert(title: String = "",
                   message: String,
                   completion: (() -> Void)? = nil) {
        
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK",
                                      style: UIAlertAction.Style.default,
                                      handler: nil))
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: completion)
        }
    }
}

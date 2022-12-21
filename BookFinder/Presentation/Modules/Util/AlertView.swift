//
//  AlerView.swift
//  BookFinder
//
//  Created by Smriti Rana on 22/12/22.
//

import UIKit

public protocol AlerView {}
public extension AlerView where Self: UIViewController {
    
    func showAlert(title: String = "",
                   message: String,
                   preferredStyle: UIAlertController.Style = .alert,
                   completion: (() -> Void)? = nil) {

        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: completion)
    }
}

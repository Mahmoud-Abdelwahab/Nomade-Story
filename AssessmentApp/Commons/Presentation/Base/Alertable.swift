//
//  Alertable.swift
//  AssessmentApp
//
//  Created by Mahmoud Abdul-wahab on 22/11/2022.
//

import UIKit
public protocol Alertable {}

public extension Alertable where Self: UIViewController {
    func showAlert(title: String = "ALERT", message: String, preferredStyle: UIAlertController.Style = .alert, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: completion)
    }
    
    func showTwoActionAlert(title: String, message: String,okButtonTitle: String,cancelButtonTitle: String, preferredStyle: UIAlertController.Style = .alert, okHandler: (() -> Void)? = nil ,cancelHandler: (() -> Void)? = nil ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: cancelButtonTitle, style: .default){ _ in
            cancelHandler?()
        })
        alert.addAction(UIAlertAction(title: okButtonTitle, style: .default) { _ in
            okHandler?()
        })
        self.present(alert, animated: true, completion: nil)
    }
}

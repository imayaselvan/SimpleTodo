//
//  ViewController+Utils.swift
//  NewyorkSample
//
//  Created by Imayaselvan Ramakrishnan on 8/2/17.
//  Copyright © 2017 Imayaselvan. All rights reserved.
//

import UIKit

extension UIViewController {
    /// Display error msg with default title - "Error!", and an "OK" button
    func displayError(_ title: String = "Error!", errorMsg: String, completion: (()->())? = nil) {
        displayAlertWithSingleButton(title, msg: errorMsg, buttonTitle: "OK", completion: completion)
    }
    
    /// Display error with configurable title, message, and an "OK" button
    func displayAlertWithSingleButton(_ title: String, msg: String, buttonTitle: String = "OK", completion: (()->())? = nil) {
        let alertController = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: buttonTitle, style: .default, handler: { (UIAlertAction) -> Void in
            completion?()
        }))
        present(alertController, animated: true, completion: { })
    }
}

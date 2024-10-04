//
//  UIViewController+Ext.swift
//  StudiosPopulation
//
//  Created by Jose Cruz on 03/10/2024.
//

import UIKit

extension UIViewController {
    func presentAlertOnMainThread(alertTitle: String, message: String, buttonTitle: String){
        DispatchQueue.main.async{
            let alertController = UIAlertController(title: alertTitle, message: message, preferredStyle: .alert)
            let action = UIAlertAction(title: buttonTitle, style: .default, handler: nil)
            alertController.addAction(action)
            self.present(alertController, animated: true, completion: nil)
        }
    }
}

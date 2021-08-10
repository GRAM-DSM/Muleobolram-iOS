//
//  ViewControllerExtenstion.swift
//  Muleobolram
//
//  Created by 김기영 on 2021/07/21.
//

import UIKit

extension UIViewController{
    func errorAlert(title: String, action: ((UIAlertAction)->Void)?){
        let alert = UIAlertController(title: title , message: nil, preferredStyle: .alert)
        let Ok = UIAlertAction(title: "확인", style: .default, handler: action)
        alert.addAction(Ok)
        present(alert, animated: true, completion: nil)
    }
    
    func Alert(title: String, action: ((UIAlertAction)->Void)?){
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let yes = UIAlertAction(title: "확인", style: .default, handler: action)
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        alert.addAction(yes)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
}

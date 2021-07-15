//
//  ViewController.swift
//  Muleobolram
//
//  Created by 김기영 on 2021/07/11.
//

import UIKit
import Alamofire

class LoginViewController: UIViewController {
    
    @IBOutlet weak private var idTxt : UITextField!
    @IBOutlet weak private var psTxt : UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    @IBAction func didLogIn(_ sender: UIButton){
        guard let id = idTxt.text, !id.isEmpty else {return}
        guard let ps = psTxt.text, !ps.isEmpty else {return}
        
        clickLogIn(id: id, password: ps)
    }
    
    private func clickLogIn(id : String, password : String) {
        let httpClient : HTTPClient
        httpClient.post(url: AuthAPI.login.path(), params: ["id" : id, "password" : password], header: Header.tokenIsEmpty.header()).responseJSON(completionHandler: { res in
            switch res.response?.statusCode {
            case 200 :
                do {
                    print("okay")
                    guard let data = res.data else {
                        return
                    }
                    guard let model = try? JSONDecoder().decode(SignInModel.self, from: data) else {
                        return
                    }
                    print(model)
                    
                    Token.token = model.acess_token
                    Token.refreshToken = model.refresh_token
                    
                    let userDefaults = UserDefaults.standard
                    
                    let ListVC = self.storyboard?.instantiateViewController(withIdentifier: "list")
                    self.navigationController?.pushViewController(ListVC!, animated: true)
                }
                catch {
                    print("Error \(error)")
                }
            case 404 :
                print("not found id, password")
            default :
                print(res.response?.statusCode)
            }
        }
        )
        
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    
}




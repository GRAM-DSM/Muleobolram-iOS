//
//  SignupViewController.swift
//  Muleobolram
//
//  Created by 김기영 on 2021/07/11.
//

import UIKit

class SignupViewController: UIViewController {
    
    @IBOutlet weak private var idTxt : UITextField!
    @IBOutlet weak private var psTxt : UITextField!
    @IBOutlet weak private var nameTxt : UITextField!
    @IBOutlet weak private var button : UIButton!
    
    private let httpClient = HTTPClient()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
            self.view.endEditing(true)
        }
    
    private func signUp(id : String, ps : String, name : String) {
        
        httpClient.post(url: AuthAPI.signUp.path(),
                        params: ["name": name, "id": id, "password": ps],
                        header: Header.tokenIsEmpty.header()).responseJSON { response in
                            switch response.response?.statusCode
                            {
                            case 200 :
                                self.errorAlert(title: "회원가입에\n성공했습니다.!!", action: {
                                        ACTION in self.popVC()})
                                
                            case 400 :
                                self.errorAlert(title: "비밀번호의 형식이\n알맞지 않습니다.", action: nil)
                                
                            case 409 :
                                self.errorAlert(title: "아이디가\n중복됩니다.", action: nil)
                                
                            default :
                                print(response.response?.statusCode ?? 0)
                            }
                        }
        
    }
    
    private func check(id : String) {
        httpClient.post(url: AuthAPI.auth.path(), params: ["id": id],
                       header: Header.tokenIsEmpty.header()).responseJSON { res in
                        switch res.response?.statusCode {
                        case 200 :
                            self.errorAlert(title: "사용할 수 있는\n아이디입니다.", action: nil)
                            
                        case 400 :
                            self.errorAlert(title: "아이디의 형식이\n알맞지 않습니다..", action: nil)
                            
                        case 409 :
                            self.errorAlert(title: "아이디가\n중복됩니다.", action: nil)
                            
                        default :
                            print(res.response?.statusCode ?? 0)
                        }
                       }
    }
    
    @IBAction private func signUpBtn(_ sender : UIButton) {
        signUp(id: idTxt.text!, ps: psTxt.text!, name: nameTxt.text!)
    }
    
    @IBAction private func checkBtn(_ sender : UIButton) {
        check(id: idTxt.text!)
    }
    
}

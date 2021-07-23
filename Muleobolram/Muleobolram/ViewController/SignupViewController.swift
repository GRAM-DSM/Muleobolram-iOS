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
        
        // Do any additional setup after loading the view.
    }
    
    private func signUp(id : String, ps : String, name : String){
        httpClient.post(url: AuthAPI.signUp.path(), params: ["name" : name, "id" : id, "password" : ps], header: Header.tokenIsEmpty.header()).responseJSON { response in
            switch response.response?.statusCode {
            
            case 201 :
                self.errorAlert(title: "회원가입에 성공하셨습니다.", action: {
                            ACTION in self.navigationController?.popViewController(animated: true)})
                
            case 400 :
                self.errorAlert(title: "아이디나 비밀번호 형식이 알맞지 않습니다.", action: nil)
                
            case 409 :
                self.errorAlert(title: "이미있는 아이디입니다.", action: nil)
                
            default :
             print(response.response?.statusCode)
            }
        }
        
    }
    
    private func check(id : String){
        httpClient.get(url: AuthAPI.auth.path(), params: ["id" : id], header: Header.tokenIsEmpty.header()).responseJSON {
            res in
            switch res.response?.statusCode {
            case 200 :
                self.errorAlert(title: "사용할 수 있는 아이디입니다.", action: nil)
                
            case 400 :
                self.errorAlert(title: "아이디나 비밀번호 형식이 알맞지 않습니다.", action: nil)
                
            case 409 :
                self.errorAlert(title: "이미 있는 아이디입니다.", action: nil)
                
            default :
                print(res.response?.statusCode)
            }
        }
    }
    
    @IBAction private func signUpBtn(_ sender : UIButton){
        signUp(id: idTxt.text!, ps: psTxt.text!, name: nameTxt.text!)
    }
    
    @IBAction private func checkBtn(_ sender : UIButton){
        check(id: idTxt.text!)
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

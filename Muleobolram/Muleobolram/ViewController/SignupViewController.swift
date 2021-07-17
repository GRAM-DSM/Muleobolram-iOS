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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    private func signUp(id : String, ps : String, name : String){
        let httpClient : HTTPClient
        httpClient.post(url: AuthAPI.signUp.path(), params: ["name" : name, "id" : id, "password" : ps], header: Header.tokenIsEmpty.header()).responseJSON { response in
            switch response.response?.statusCode {
            
            case 200 :
                let alert = UIAlertController(title: "회원가입에 성공하셨습니다.", message: nil, preferredStyle: UIAlertController.Style.alert)
                let okAction = UIAlertAction(title: "OK", style: .cancel, handler:{
                                                ACTION in self.navigationController?.popViewController(animated: true)})
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)
                
            case 400 :
                let Alert = UIAlertController(title: "아이디나 비밀번호에 형식이 맞지 않습니다.", message: nil, preferredStyle: UIAlertController.Style.alert)
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                Alert.addAction(defaultAction)
                self.present(Alert, animated: true, completion: nil)
                
            default :
             print(response.response?.statusCode)
            }
        }
        
    }
    
    private func check(id : String){
        let httpClient : HTTPClient
        httpClient.post(url: AuthAPI.auth.path(), params: ["id" : id], header: Header.tokenIsEmpty.header()).responseJSON {
            res in
            switch res.response?.statusCode {
            case 200 :
                let alert = UIAlertController(title: "사용할 수 있는 아이디입니다." , message: nil, preferredStyle: UIAlertController.Style.alert)
                let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)
                
            case 400 :
                let alert = UIAlertController(title: "이미 있는 아이디입니다.", message: nil, preferredStyle: UIAlertController.Style.alert)
                let okAction = UIAlertAction(title: "확인 ", style: .default, handler: nil)
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)
                
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

//
//  ViewController.swift
//  Muleobolram
//
//  Created by 김기영 on 2021/07/11.
//

import UIKit
import Alamofire

class LoginViewController: UIViewController{
    
    @IBOutlet weak private var idTxt : UITextField!
    @IBOutlet weak private var psTxt : UITextField!
    @IBOutlet weak private var failetxt : UILabel!
    
    private let httpClient = HTTPClient()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        failetxt.isHidden = true
        idTxt.text! = ""
        psTxt.text! = ""
    }
    
    @IBAction func logInDidTap(_ sender: UIButton){
        guard let id = idTxt.text, !id.isEmpty else {return}
        guard let ps = psTxt.text, !ps.isEmpty else {return}
        
        LogIn(id: id, password: ps)
    }   //로그인 버튼을 눌렀을 때
    
    private func LogIn(id : String, password : String) {
        httpClient.post(url: AuthAPI.login.path(), params: ["id" : id, "password" : password],
             header: Header.tokenIsEmpty.header()).responseJSON(completionHandler: { res in
            switch res.response?.statusCode {
            case 201 :
                do {                                                                               
                    print("okay")
                    let data = res.data
                    let model = try? JSONDecoder().decode(SignInModel.self, from: data!)
                    
                    Token.acesstoken = model?.acess_token
                    Token.refreshToken = model?.refresh_token
                    
                    guard let listVC = self.storyboard?.instantiateViewController(withIdentifier:
                                                                          "listVC") else {return}
                    self.navigationController?.pushViewController(listVC, animated: true)
                }
                catch {
                    print("Error \(error)")
                }
            case 400 :
                print("body 요청이 잘못됨")
                self.failetxt.isHidden = false
            case 404 :
                print("not found id, password")
                self.failetxt.isHidden = false  // 404가 뜨면 failtext는 화면에 나타남
            default :
                print(res.response?.statusCode)
            }
        }
        )
        
        
    }
    
    @IBAction private func idTxtDeleteDidTap(_ sender : UIButton)
    {
        idTxt.text! = ""
    }
    
    @IBAction private func psTxtDeleteDidTap(_ sender : UIButton)
    {
        psTxt.text! = ""
    }
    
    @IBAction private func signUpBtnDidTap(_ sender : UIButton){
        guard let signUpVC = self.storyboard?.instantiateViewController(withIdentifier:
                                                                        "signUpVC") else {return}
        self.navigationController?.pushViewController(signUpVC, animated: true)
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




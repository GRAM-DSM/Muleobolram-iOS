//
//  AddViewController.swift
//  Muleobolram
//
//  Created by 김기영 on 2021/07/13.
//

import UIKit

class AddViewController: UIViewController {
    
    @IBOutlet weak private var titleTxt : UITextField!
    @IBOutlet weak private var contentTxt : UITextView!
    
    let http = HTTPClient()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
            self.view.endEditing(true)
        }
    
    private func updateCommunity(title: String, content: String) {
        http.post(url: ListAPI.listWrite.path(), params: ["title": title, "content": content],
                  header: Header.accesstoken.header()).responseJSON(completionHandler: { res in
                    switch res.response?.statusCode{
                    case 201 :
                        self.Alert(title: "진짜 이 글을\n커뮤니티에 게시하겠습니까", action: {
                            ACTION in self.popVC()
                        })
                    case 400 :
                        print("바디 요청이 잘못됨")
                    case 401 :
                        print("토큰 오류")
                    default :
                        print(res.response?.statusCode ?? 0)
                    }
                  })
    }
    
    @IBAction private func addBtnDidTap(_ sender : UIBarButtonItem) {
        guard let title = titleTxt.text, !title.isEmpty else {return}
        guard let content = contentTxt.text, !content.isEmpty else {return}
        updateCommunity(title: title, content: content)
    }
    
}

//
//  CommentViewController.swift
//  Muleobolram
//
//  Created by 김기영 on 2021/07/13.
//

import UIKit

class CommentViewController: UIViewController{
    
    @IBOutlet weak private var titleTxt : UILabel!
    @IBOutlet weak private var contentTxt : UITextView!
    @IBOutlet weak private var tableView : UITableView!
    @IBOutlet weak private var commentTxt : UITextField!
    
    private var commentModel = CommentList()
    let http = HTTPClient()
    
    var Content = String()
    var Title = String()
    var id = Int()
        
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nibName = UINib(nibName: "CommentTableViewCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "commentCell")
       
        getComment(id: id)
        titleTxt.text! = Title
        contentTxt.text! = Content
    }
    
    override func viewDidAppear(_ animated: Bool) {
        getComment(id: id)
        titleTxt.text! = Title
        contentTxt.text! = Content
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
            self.view.endEditing(true)
        }
    
    private func getComment(id : Int) {
        http.get(url: CommentAPI.commentList(id).path(), params: nil,
                 header: Header.acesstoken.header()).responseJSON(completionHandler: { res in
            switch res.response?.statusCode{
            case 201 :
                let model = try? JSONDecoder().decode(CommentList.self, from: res.data!)
                self.commentModel.commentResponse.removeAll()
                self.commentModel.commentResponse.append(contentsOf: model!.commentResponse)
                self.tableView.reloadData()
            case 401 :
                print("token error")
            case 404 :
                print("not found")
            default :
                print(res.response?.statusCode ?? 0)
                
            }
        })
    }
    
    private func postComment(id : Int, content : String) {
        http.post(url: CommentAPI.commentWrite(id).path(), params: ["content" : content],
                   header: Header.acesstoken.header()).responseJSON(completionHandler: { res in
            switch res.response?.statusCode{
            case 200 :
                self.tableView.reloadData()
            case 400 :
                print("바디 요청이 잘못됨")
            case 401 :
                print("token error")
            case 404 :
                print("not found")
            default :
                print(res.response?.statusCode ?? 0)
            }
        })
    }
    
    private func deleteList(id : Int){
        http.delete(url: ListAPI.listDelete(id).path(), params: nil,
                    header: Header.acesstoken.header()).responseJSON(completionHandler: { res in
            switch res.response?.statusCode{
            case 200 :
                self.Alert(title: "이 게시물을\n정말 삭제하시겠습니까?", action: {
                    ACTION in self.popVC()
                })
            case 401 :
                print("token error")
            case 404 :
                print("not found")
            default :
                print(res.response?.statusCode ?? 0)
            }
        })
    }
    
    @IBAction private func postCommentBtnDidTap(_ sender : UIButton) {
        postComment(id: id, content: commentTxt.text!)
    }
    
    @IBAction private func deleteBtnDidTap(_ sender : UIBarButtonItem) {
        deleteList(id: id)
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension CommentViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commentModel.commentResponse.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "commentCell", for: indexPath) as! CommentTableViewCell
        cell.name.text = commentModel.commentResponse[indexPath.row].id
        cell.detail.text = commentModel.commentResponse[indexPath.row].content
        
        
        return cell
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

}

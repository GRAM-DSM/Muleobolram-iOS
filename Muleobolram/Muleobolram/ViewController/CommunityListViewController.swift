//
//  ListViewController.swift
//  Muleobolram
//
//  Created by 김기영 on 2021/07/14.
//

import UIKit

class CommunityListViewController: UIViewController{
    
    @IBOutlet weak var tableView : UITableView!
    
    private var communityModel = CommunityList()
    private var posts = [Community]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nibName = UINib(nibName: "TableViewCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "Cell")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        getList()
    }
    
    private func getList(){
        let http = HTTPClient()
        http.get(url: ListAPI.seeList.path(), params: nil,
                 header: Header.accesstoken.header()).responseJSON {[unowned self] response in
                    switch response.response?.statusCode{
                    case 200 :
                        do {
                            let model = try JSONDecoder().decode(CommunityList.self, from: response.data!)
                            communityModel.posts.removeAll()
                            communityModel.posts.append(contentsOf: model.posts)
                            tableView.reloadData()
                        } catch {
                            print(error)
                        }
                        
                    case 401 :
                        print("token error")
                    case 404 :
                        print("not found")
                    default :
                        print(response.response?.statusCode ?? 0)
                    }
                 }
    }
    
    @IBAction private func moveAddVCDidTap(_ sender : UIBarButtonItem) {
        presentVC(VCname: "addVC")
        
    }
    @IBAction private func moveLoginVCDidTap(_ sender : UIBarButtonItem) {
        Token.tokenRemove()
        popVC()
    }
}

extension CommunityListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return communityModel.posts.count
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell",
                                                 for: indexPath) as! TableViewCell
        
        cell.selectionStyle = .none
        cell.nameLabel.text = communityModel.posts[indexPath.row].name
        cell.titleLabel.text = communityModel.posts[indexPath.row].title
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let commentVC = storyboard?.instantiateViewController(withIdentifier: "CommentVC")
                as? CommentViewController else {return}
        
        commentVC.Title = communityModel.posts[indexPath.row].title
        commentVC.Content = communityModel.posts[indexPath.row].content
        commentVC.id = communityModel.posts[indexPath.row].id_pk
        
        navigationController?.pushViewController(commentVC, animated: true)
    }
}


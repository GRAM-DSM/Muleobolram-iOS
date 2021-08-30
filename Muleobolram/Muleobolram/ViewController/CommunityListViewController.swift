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
    private var community = [Community]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nibName = UINib(nibName: "TableViewCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "Cell")
        getList()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        getList()
    }
    
    private func getList(){
        let http = HTTPClient()
        http.get(url: ListAPI.seeList.path(), params: nil,
                 header: Header.acesstoken.header()).responseJSON { [self] response in
                    switch response.response?.statusCode{
                    case 200 :
                        let model = try? JSONDecoder().decode(CommunityList.self, from: response.data!)
                        self.communityModel.communityResponse.removeAll()
                        communityModel.communityResponse.append(contentsOf: model!.communityResponse)
                        tableView.reloadData()
                    case 401 :
                        print("token error")
                    case 404 :
                        print("not found")
                    default :
                        print(response.response?.statusCode ?? 0)
                    }
                 }
    }
    
    @IBAction private func moveAddVCDidTat(_ sender : UIBarButtonItem) {
        guard let addVC = self.storyboard?.instantiateViewController(withIdentifier: "addVC") else {return}
        self.navigationController?.pushViewController(addVC, animated: true)
        
    }
    
}

extension CommunityListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return communityModel.communityResponse.count
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell",
                                                 for: indexPath) as! TableViewCell
        
        cell.selectionStyle = .none
        cell.nameLabel.text = communityModel.communityResponse[indexPath.row].myName
        cell.titleLabel.text = communityModel.communityResponse[indexPath.row].title
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let commentVC = storyboard?.instantiateViewController(withIdentifier: "CommentVC")
                as? CommentViewController else {return}
        
        commentVC.Title = communityModel.communityResponse[indexPath.row].title
        commentVC.Content = communityModel.communityResponse[indexPath.row].content
        commentVC.id = communityModel.communityResponse[indexPath.row].id_pk
        
        navigationController?.pushViewController(commentVC, animated: true)
    }
}


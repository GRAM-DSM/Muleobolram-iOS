//
//  ListViewController.swift
//  Muleobolram
//
//  Created by 김기영 on 2021/07/14.
//

import UIKit

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView : UITableView!
    
    private var communityModel = CommunityList()
    private var community = [Community]()
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return communityModel.communityResponse.count
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
            
        cell.nameLabel.text = communityModel.communityResponse[indexPath.row].myName
        cell.titleLabel.text = communityModel.communityResponse[indexPath.row].title
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let commentVC = storyboard?.instantiateViewController(withIdentifier: "CommentVC") as? CommentViewController else {return}
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let nibName = UINib(nibName: "TableViewCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "Cell")
    }

    private func getList(){
        let http : HTTPClient
        http.get(url: ListAPI.seeList.path(), params: nil, header: Header.acesstoken.header()).responseJSON{ [self] response in
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
                print(response.response?.statusCode)
            }
        }
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

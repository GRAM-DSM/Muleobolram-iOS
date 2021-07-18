//
//  ListViewController.swift
//  Muleobolram
//
//  Created by 김기영 on 2021/07/14.
//

import UIKit

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView : UITableView!
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }



    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let nibName = UINib(nibName: "TableViewCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "Cell")
    }

    private func getList(){
        let http : HTTPClient
        http.get(url: ListAPI.seeList().path(), params: nil, header: Header.acesstoken.header()).responseJSON{ (response) in
            switch response.response?.statusCode{
            case 200 :
                
            case 401 :
                
            case 404 :
                print("not found")
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

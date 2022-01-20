//
//  TableViewController.swift
//  Public API App v2
//
//  Created by Дмитрий Чепанов on 19.01.2022.
//

import UIKit
import Alamofire

class TableViewController: UITableViewController {

    private let memesURL = "https://api.imgflip.com/get_memes"
    private var memes: [Memes] = []
    private var memModel: MemsModel? {
        didSet {
            self.memes = self.memModel?.data.memes ?? []
            
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 100
        tableView.backgroundColor = .black
//        NetworkingManager.shared.fetch(dataType: MemsModel.self, from: memesURL) { result in
//            switch result {
//            case .success(let mems):
//                self.memModel = mems
//                self.tableView.reloadData()
//            case .failure(let error):
//                print(error)
//            }
//        }
        fetchGetAlamofire()
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(memes.count)
        return memes.count
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        
        let mem = memes[indexPath.row]
        
        cell.configure(with: mem)

        return cell
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        let mems = memes[indexPath.row]
        let infoVC = segue.destination as! InfoViewController
        infoVC.memesInfo = mems
//        print("mems", mems)
    }
}


extension TableViewController {
    
    private func fetchGetAlamofire() {
        NetworkingManager.shared.fetchDataWithAlomafire(memesURL) { result in
            switch result {
            case .success(let mems):
                self.memes = mems
//                print(self.memes)
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func successAlert() {
    DispatchQueue.main.async {
        let alert = UIAlertController(
            title: "Success",
            message: "You can see the results in the Debug aria",
            preferredStyle: .alert
        )
        
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
            self.present(alert, animated: true)
    }
}

private func failedAlert() {
    DispatchQueue.main.async {
        let alert = UIAlertController(
            title: "Failed",
            message: "You can see error in the Debug aria",
            preferredStyle: .alert
        )
        
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
            self.present(alert, animated: true)
    }
}
}

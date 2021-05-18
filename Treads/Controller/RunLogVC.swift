//
//  SecondViewController.swift
//  Treads
//
//  Created by Massimiliano on 23/04/2019.
//  Copyright © 2019 Massimiliano Bonafede. All rights reserved.
//

import UIKit
import RealmSwift

class RunLogVC: UIViewController {
    
    //MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource

extension RunLogVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  Run.getAllRuns()?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RunLogCell", for: indexPath) as? RunLogCell else {
            return UITableViewCell()
        }
        
        let run = Run.getAllRuns()?[indexPath.row]
        cell.configure(run: run!)
        return cell
    }
}

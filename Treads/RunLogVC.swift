//
//  RunLogVC.swift
//  Treads
//
//  Created by Jacob Luetzow on 6/15/17.
//  Copyright © 2017 Jacob Luetzow. All rights reserved.
//

import UIKit

class RunLogVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        print("In ViewDidLoad in RunLogicVC")

        //super.viewDidLoad()
        //tableView.delegate = self
        //tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("In ViewWillAppear in RunLogicVC")
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self

    }
    
    
}

extension RunLogVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if Run.getAllRuns()?.count == 0{
            print("Run Count is now: \(String(describing: Run.getAllRuns()?.count)) in RunLogVC.swift")
            
        }
        return Run.getAllRuns()?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "RunLogCell") as? RunLogCell {
            print("cellForRowATtIndexPath row is now: \(indexPath.row) in RunLogicVC")

            guard let run = Run.getAllRuns()?[indexPath.row] else {
                return RunLogCell()
            }
            cell.configure(run: run)
            return cell
        } else {
            
            return RunLogCell()
        }
    }
}


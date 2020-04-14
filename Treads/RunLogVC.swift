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
    @IBAction func backbuttonpressed(_ sender: Any) {

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("In ViewDidLoad() in RunLogicVC")

        tableView.delegate = self           //required when extending class below
        tableView.dataSource = self         //required when extending class below
    }
    
    override func viewDidLayoutSubviews() {
        print("In viewDidLayoutSubviews in RunLogicVC")

        self.tableView.reloadData()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        print("In ViewDidAppear in RunLogicVC")
        //self.tableView.reloadData()
        //tableView.delegate = self
        //tableView.dataSource = self

    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("In ViewWillAppear in RunLogicVC")
        //self.tableView.reloadData()
        //tableView.delegate = self
        //tableView.dataSource = self

    }
    
    override func viewDidDisappear(_ animated: Bool) {
        print("In ViewDidDisAppear in RunLogicVC")
        //tableView.removeFromSuperview()

    }
    
    
}

extension RunLogVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return Run.getAllRuns()?.count ?? 0 //optional since inititally we have no runs. if no runs return 0
        return Run.getAllRuns()?.count ?? 0 //test optional since inititally we have no runs. if no runs return 1 as a test

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "RunLogCell") as? RunLogCell{
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


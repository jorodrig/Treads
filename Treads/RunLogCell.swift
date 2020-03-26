//
//  RunLogCell.swift
//  Treads
//
//  Created by Jacob Luetzow on 6/19/17.
//  Copyright © 2017 Jacob Luetzow. All rights reserved.
//

import UIKit

class RunLogCell: UITableViewCell {

    @IBOutlet weak var runDurationLbl: UILabel!
    @IBOutlet weak var totalDistanceLbl: UILabel!
    @IBOutlet weak var averagePaceLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        print("In RunLogCell.swift awakeFromNib")

    }
    
    func configure(run: Run) {
        print("In configure() in RunLogCell.swift View")
        runDurationLbl.text = run.duration.formatTimeDurationToString()
        totalDistanceLbl.text = "\(run.distance.metersToMiles(places: 2)) mi"
        averagePaceLbl.text = run.pace.formatTimeDurationToString()
        dateLbl.text = run.date.getDateString()
        
    }



}

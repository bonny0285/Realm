//
//  RunLogCell.swift
//  Treads
//
//  Created by Massimiliano on 01/05/2019.
//  Copyright © 2019 Massimiliano Bonafede. All rights reserved.
//

import UIKit
import RealmSwift

class RunLogCell: UITableViewCell {
    
    @IBOutlet weak var runDuarationLbl: UILabel!
    @IBOutlet weak var totalDistanceLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var avaragePaceLbl: UILabel!
    
    var runs = Run()
    

    override func awakeFromNib() {
        super.awakeFromNib()
    }

   
    
    func configure(run: Run){
        runDuarationLbl.text = run.duration.formatTimeDurationToString()
        totalDistanceLbl.text = "\(run.distance.metersToMiles(places: 2)) mi"
        avaragePaceLbl.text = run.pace.formatTimeDurationToString()
        dateLbl.text = run.date.getDateSting()
    }

}

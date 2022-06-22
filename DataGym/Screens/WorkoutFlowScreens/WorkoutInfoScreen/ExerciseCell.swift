//
//  ExerciseCell.swift
//  DataGym
//
//  Created by Ieda Xavier on 22/06/22.
//

import UIKit
import CoreData

class ExerciseCell: UITableViewCell {
    @IBOutlet weak var nomeExercise: UILabel!
    @IBOutlet weak var charge: UILabel!
    @IBOutlet weak var serie: UILabel!
    @IBOutlet weak var repetition: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

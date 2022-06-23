//
//  StudentExerciseCell.swift
//  DataGym
//
//  Created by Ieda Xavier on 23/06/22.
//

import UIKit

class StudentExerciseCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
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

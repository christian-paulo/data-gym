//
//  ClassCell.swift
//  DataGym
//
//  Created by Narely Lima on 21/06/22.

import UIKit

class ClassCell: UITableViewCell {
    @IBOutlet weak var nomeTurma: UILabel!
    @IBOutlet weak var diaSemana: UILabel!
    @IBOutlet weak var horario: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

//
//  CustomView.swift
//  DataGym
//
//  Created by Ieda Xavier on 09/06/22.
//

import UIKit

class CustomView: UIView {
    
    static let identifier = "CustomView"
    @IBOutlet var nomeTurma: UILabel!
    @IBOutlet var diaSemana: UILabel!
    @IBOutlet var horario: UILabel!
    @IBOutlet var treino: UILabel!
    @IBOutlet weak var chevron: UIImageView!
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
        initSubviews()
    }
    override init(frame: CGRect) {
            super.init(frame: frame)
            initSubviews()
        }
    func initSubviews() {

        let varNib = UINib(nibName: CustomView.identifier, bundle: .main)
        guard let view = varNib.instantiate(withOwner: self, options: nil).first as?
                            UIView else {fatalError("Unable to convert nib")}
        print(view)
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        addSubview(view)

    }
    func configureImageAndText(text : String, image: UIImage){
        nomeTurma.text = text
        diaSemana.text = text
        horario.text = text
        treino.text = text
        chevron.image = image
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

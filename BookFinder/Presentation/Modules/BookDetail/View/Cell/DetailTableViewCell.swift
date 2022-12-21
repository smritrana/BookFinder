//
//  DetailTableViewCell.swift
//  BookFinder
//
//  Created by Smriti Rana on 21/12/22.
//

import UIKit
import AlamofireImage

class DetailTableViewCell: UITableViewCell, ReusableViewNibLoading {

    @IBOutlet weak var seprator: UIView!
    @IBOutlet weak var title: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setDataToCell(_ info: String) {
        self.title.text = info
    }
}

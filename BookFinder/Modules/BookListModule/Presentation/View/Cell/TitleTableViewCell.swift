//
//  TitleTableViewCell.swift
//  BookFinder
//
//  Created by Smriti Rana on 13/12/22.
//

import UIKit
import AlamofireImage

class TitleTableViewCell: UITableViewCell, ReusableViewNibLoading {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subTitle: UILabel!
    @IBOutlet weak var bookImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setDataToCell(_ bookInfoMapper: BookViewModelMapper) {
        self.title.text = bookInfoMapper.title
        self.subTitle.text = bookInfoMapper.subTitle
        guard let imageURL = URL(string:bookInfoMapper.imageUrl.replacingOccurrences(of: "http", with: "https")) else { return }
        self.bookImageView.af.setImage(withURL: imageURL, placeholderImage: UIImage(named: defaultImageForBook))
    }
}

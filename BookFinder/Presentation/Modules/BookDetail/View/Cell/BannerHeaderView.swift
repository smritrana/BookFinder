//
//  BannerHeaderView.swift
//  BookFinder
//
//  Created by Smriti Rana on 21/12/22.
//

import UIKit

class BannerHeaderView: UITableViewHeaderFooterView, ReusableViewNibLoading {

    @IBOutlet weak var bookImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setBookImage(_ bookInfoMapper: BookViewModelMapper) {
        if let imageURL = getImageUrl(bookInfoMapper.smallImageUrl) {
            self.bookImageView.af.setImage(withURL: imageURL,
                                           placeholderImage: UIImage(named: defaultImageForBook))
        }
    }
}

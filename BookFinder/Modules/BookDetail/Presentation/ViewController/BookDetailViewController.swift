//
//  BookDetailViewController.swift
//  BookFinder
//
//  Created by Smriti Rana on 21/12/22.
//

import UIKit

class BookDetailViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    var viewModel: BookDetailViewModelType!

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
    }

    func setUpTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(DetailTableViewCell.nib, forCellReuseIdentifier: DetailTableViewCell.reuseIdentifier)
        tableView.register(BannerHeaderView.nib, forCellReuseIdentifier: BannerHeaderView.reuseIdentifier)
        showHeaderView()
    }

    private func showHeaderView() {
        guard let headerView = Bundle.main.loadNibNamed(BannerHeaderView.reuseIdentifier, owner: self, options: nil)?[0] as? BannerHeaderView else {
            return
        }
        headerView.setBookImage(viewModel.output.bookInfo)
        tableView.tableHeaderView = headerView
    }
}

extension BookDetailViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.output.getNumberOfRows()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let type = viewModel.output.checkForValues().cellType
        let detailInfo = viewModel.output.getSectionType(type[indexPath.row])
        if let cell = tableView.dequeueReusableCell(withIdentifier: DetailTableViewCell.reuseIdentifier) as? DetailTableViewCell {
            cell.setDataToCell(detailInfo.value)
            return cell
        }
        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

//
//  BookListViewController.swift
//  BookFinder
//
//  Created by Smriti Rana on 12/12/22.
//

import UIKit

final class BookListViewController: UIViewController, AlerView {
    
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var tableView: UITableView!
    
    @IBOutlet weak var hintLabel: UILabel!
    
    @IBOutlet weak var loader: UIActivityIndicatorView!
    var viewModel: BookListViewModelType!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = viewModel?.output.getScreenName
        setUpBindingObjects()
        setUpAlertViewController()
        setUpTableView()
        loader.isHidden = true

        view.accessibilityIdentifier = AccessibilityIdentifier.listView
        searchBar.searchTextField.accessibilityIdentifier = AccessibilityIdentifier.searchField
    }
    
    func setUpBindingObjects() {
        viewModel?.output.showLoader.bind {  [unowned self] _ in
            DispatchQueue.main.async {
                self.loader.startAnimating()
                self.loader.isHidden = false
            }
        }
        
        viewModel?.output.stopLoader.bind {  [unowned self] _ in
            DispatchQueue.main.async {
                self.loader.stopAnimating()
                self.loader.isHidden = true
            }
        }
        
        viewModel?.output.loadTable.bind {  [unowned self] (_) in
            DispatchQueue.main.async {
                self.tableView.isHidden = false
                self.hintLabel.isHidden = true
                self.tableView.reloadData()
            }
        }
        
        viewModel?.output.showHint.bind {  [unowned self] (_) in
            DispatchQueue.main.async {
                self.tableView.isHidden = true
                self.hintLabel.isHidden = false
            }
        }
    }

    func setUpAlertViewController() {
        viewModel?.output.showAlert.bind {  [unowned self] (_) in
            DispatchQueue.main.async {
                self.showAlert(title: viewModel.output.getAlertMessage.title,
                               message: viewModel.output.getAlertMessage.message)
            }
        }
    }
    
    func setUpTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(TitleTableViewCell.nib, forCellReuseIdentifier: TitleTableViewCell.reuseIdentifier)
    }
}

extension BookListViewController: UISearchBarDelegate {
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        return true
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel?.input.fetchResults(searchBar.text ?? "")
    }

    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        return true
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        viewModel?.input.fetchResults(searchBar.text ?? "")
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel?.input.fetchResults(searchBar.text ?? "")
        searchBar.resignFirstResponder()
    }
}

extension BookListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.output.bookInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCell.reuseIdentifier) as? TitleTableViewCell {
            cell.setDataToCell(viewModel.output.bookInfo[indexPath.row])
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

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Routing().showDetailViewController(viewModel.output.bookInfo[indexPath.row])
    }
}

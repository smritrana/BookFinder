//
//  BookListViewController.swift
//  BookFinder
//
//  Created by Smriti Rana on 12/12/22.
//

import UIKit

class BookListViewController: UIViewController {
    
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var tableView: UITableView!
    
    @IBOutlet weak var hintLabel: UILabel!
    
    @IBOutlet weak var loader: UIActivityIndicatorView!
    var viewModel: BookListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = viewModel?.getScreenName
        setUpBindingObjects()
        setUpTableView()
        loader.isHidden = true
    }
    
    func setUpBindingObjects() {
        viewModel?.output.showLoader.bind{  [unowned self] (_) in
            DispatchQueue.main.async {
                loader.startAnimating()
                loader.isHidden = false
            }
        }
        
        viewModel?.output.stopLoader.bind{  [unowned self] (_) in
            DispatchQueue.main.async {
                loader.stopAnimating()
                loader.isHidden = true
            }
        }
        
        viewModel?.output.loadTable.bind{  [unowned self] (_) in
            DispatchQueue.main.async {
                self.tableView.isHidden = false
                self.hintLabel.isHidden = true
                self.tableView.reloadData()
            }
        }
        
        viewModel?.output.showHint.bind{  [unowned self] (_) in
            DispatchQueue.main.async {
                self.tableView.isHidden = true
                self.hintLabel.isHidden = false
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
        viewModel?.fetchResults(searchBar.text ?? "")
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel?.fetchResults(searchBar.text ?? "")
        searchBar.resignFirstResponder()
    }
}


extension BookListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.bookInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "TitleTableViewCell") as? TitleTableViewCell {
            cell.setDataToCell(viewModel.bookInfo[indexPath.row])
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

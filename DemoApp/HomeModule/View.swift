//
//  View.swift
//  DemoApp
//
//  Created by Rafael Ortega on 11/05/22.
//

import Foundation
import UIKit

protocol AnyView {
    var presenter: AnyPresenter? { get set }
    
    func update(withData data: DataResponse)
}

class ImagesViewController: UIViewController, AnyView {
    
    var presenter: AnyPresenter?
    
    //MARK: - COMPONENTS
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.showsSearchResultsButton = true
        searchBar.delegate = self
        searchBar.backgroundColor = .clear
        return searchBar
    }()
    
    private lazy var stepper: PageStepperView = {
        let view = PageStepperView()
        return view
    }()
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.register(CustomCell.self, forCellReuseIdentifier: self.cellId)
        table.delegate = self
        table.dataSource = self
        table.backgroundColor = .clear
        return table
    }()
    
    //MARK: - PROPERTIES
    private let cellId = "CellId"
    
    var data: DataResponse?
    
    var searchText: String = ""
    var timer: Timer?
    
    //MARK: - LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(tableView)
        view.addSubview(searchBar)
        view.addSubview(stepper)
        self.stepper.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupViews()
    }
    
    //MARK: - BODY FUNCTIONS
    func update(withData data: DataResponse) {
        DispatchQueue.main.async {
            self.data = data
            self.tableView.reloadData()
        }
    }
    
    func setupViews() {
        searchBar.frame = .init(origin: self.view.safeAreaLayoutGuide.layoutFrame.origin,
                                size: .init(width: UIScreen.main.bounds.width,
                                            height: searchBar.searchTextField.bounds.height))
        stepper.frame = .init(origin: .init(x: view.frame.origin.x, y: searchBar.frame.maxY),
                              size: .init(width: UIScreen.main.bounds.width, height: 40))
        tableView.frame =  self.view.frame
        tableView.contentInset = .init(top: searchBar.bounds.height + 40, left: 0, bottom: 0, right: 0)
    }
}
//MARK: - TABLE VIEW
extension ImagesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data?.results.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellId, for: indexPath) as! CustomCell
        let user = data?.results[indexPath.row]
        cell.data = user
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

//MARK: - TABLEVIEW
extension ImagesViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        timer?.invalidate()
        self.searchText = searchText
        timer = Timer.scheduledTimer(timeInterval: 0.5,
                                     target: self,
                                     selector: #selector(performSearch),
                                     userInfo: nil,
                                     repeats: false)
    }
    
    @objc private func performSearch() {
        self.stepper.currentPage = 1
        presenter?.interactor?.fetchData(withText: searchText, page: self.stepper.currentPage)
    }
}

extension ImagesViewController: PageStepperDelegate {
    func setPage(_ pageNumber: Int) {
        self.presenter?.interactor?.fetchData(withText: self.searchText, page: pageNumber)
    }
}

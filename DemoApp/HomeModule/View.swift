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
    
    func update(withData data: [DataResult])
}

class ImagesViewController: UIViewController, AnyView {
    
    var presenter: AnyPresenter?
    
    //MARK: - COMPONENTS
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.register(CustomCell.self, forCellReuseIdentifier: self.cellId)
        table.delegate = self
        table.dataSource = self
        return table
    }()
    
    //MARK: - PROPERTIES
    var data: [DataResult] = []
    private let cellId = "CellId"
    
    //MARK: - LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.frame
    }
    
    //MARK: - BODY FUNCTIONS
    func update(withData data: [DataResult]) {
        self.data = data
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
}

extension ImagesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellId, for: indexPath) as! CustomCell
        let user = data[indexPath.row]
        cell.data = user
        return cell
    }
    
}

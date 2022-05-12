//
//  Interactor.swift
//  DemoApp
//
//  Created by Rafael Ortega on 11/05/22.
//

import Foundation

protocol AnyInteractor {
    var presenter: AnyPresenter? { get set }
    
    func fetchData(withText: String, page: Int)
}

class ImagesInteractor: AnyInteractor {
    
    var presenter: AnyPresenter?
    
    func fetchData(withText text: String, page: Int) {
        NetworkManager.shared.fetchData(query: text, page: page) { [weak self] error, data in
            if let error = error {
                self?.presenter?.interactorDidFetchData(withResul: .failure(error))
                return
            }
            guard let data = data else {
                self?.presenter?.interactorDidFetchData(withResul: .failure(NSError()))
                return
            }
            self?.presenter?.interactorDidFetchData(withResul: .success(data))
        }
    }
    
}

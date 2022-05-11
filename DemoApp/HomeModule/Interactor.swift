//
//  Interactor.swift
//  DemoApp
//
//  Created by Rafael Ortega on 11/05/22.
//

import Foundation

protocol AnyInteractor {
    var presenter: AnyPresenter? { get set }
    
    func fetchData()
}

class ImagesInteractor: AnyInteractor {
    
    var presenter: AnyPresenter?
    
    func fetchData() {
        NetworkManager.shared.fetchData { [weak self] error, data in
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

//
//  Presenter.swift
//  DemoApp
//
//  Created by Rafael Ortega on 11/05/22.
//

import Foundation

protocol AnyPresenter {
    var router: AnyRouter? { get set }
    var interactor: AnyInteractor? { get set }
    var view: AnyView? { get set }
    
    func interactorDidFetchData(withResul result: Result<DataResponse, Error>)
}

class ImagesPresenter: AnyPresenter {
    
    var router: AnyRouter?
    
    var view: AnyView?
    
    var interactor: AnyInteractor? {
        didSet {
            self.interactor?.fetchData(withText: "carros", page: 1)
        }
    }
    
    func interactorDidFetchData(withResul result: Result<DataResponse, Error>) {
        switch result {
        case .success(let data):
            view?.update(withData: data)
            break
        case .failure(let error):
            print(error.localizedDescription)
            break
        }
    }
    
    
}

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
    
    func interactorDidFetchData(withResul result: Result<[DataResult], Error>)
}

class ImagesPresenter: AnyPresenter {
    var router: AnyRouter?
    
    var interactor: AnyInteractor? {
        didSet {
            self.interactor?.fetchData()
        }
    }
    
    var view: AnyView?
    
    func interactorDidFetchData(withResul result: Result<[DataResult], Error>) {
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

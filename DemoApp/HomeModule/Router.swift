//
//  Router.swift
//  DemoApp
//
//  Created by Rafael Ortega on 11/05/22.
//

import Foundation
import UIKit

typealias EntryPoint = AnyView & UIViewController

protocol AnyRouter {
    var entry: EntryPoint? { get }
    
    static func start() -> AnyRouter
}

class ImagesRouter: AnyRouter {
    var entry: EntryPoint?
    
    static func start() -> AnyRouter {
        let router = ImagesRouter()
        
        var view: AnyView = ImagesViewController()
        var interactor: AnyInteractor = ImagesInteractor()
        var presenter: AnyPresenter = ImagesPresenter()
        
        view.presenter = presenter
        
        interactor.presenter = presenter
        
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        
        router.entry = view as? EntryPoint
        
        return router
    }
    
    
}

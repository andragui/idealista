//
//  DetailViewCoordinator.swift
//  iOSCodeChallenge
//
//  Created by Andres Aguirre Juarez on 5/10/21.
//

import UIKit

protocol DetailCoordinatorProtocol {
    var navigationController: UINavigationController? { get set }
    func start(configuration: PropertyDetailConfiguration, delegate: DetailViewDelegateProtocol?) -> DetailViewController
}

class DetailCoordinator {
    public var navigationController: UINavigationController?
}

extension DetailCoordinator: DetailCoordinatorProtocol {
    func start(configuration: PropertyDetailConfiguration, delegate: DetailViewDelegateProtocol?) -> DetailViewController {
        let presenter = DetailPresenter(configuration, delegate: delegate)
        let view = DetailViewController(presenter: presenter)
        presenter.view = view
        return view
    }
}

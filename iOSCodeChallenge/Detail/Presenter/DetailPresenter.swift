//
//  DetailPresenter.swift
//  iOSCodeChallenge
//
//  Created by Andres Aguirre Juarez on 5/10/21.
//

import Foundation

protocol DetailViewDelegateProtocol: class {
    func favouritePressed()
}

protocol DetailPresenterProtocol {
    var view: DetailViewControllerProtocol? { get set }
    func viewDidLoad()
    func favouritePressed()
}

final class DetailPresenter {
    weak var view: DetailViewControllerProtocol?
    var configuration: PropertyDetailConfiguration
    var entity: PropertyDetailEntity?
    var delegate: DetailViewDelegateProtocol?
    init(_ configuration: PropertyDetailConfiguration, delegate: DetailViewDelegateProtocol?) {
        self.configuration = configuration
        self.delegate = delegate
    }
}

extension DetailPresenter: DetailPresenterProtocol {
    func favouritePressed() {
        guard let entity = entity else { return }
        self.view?.configureView(DetailViewModel(entity, configuration: self.configuration))
        self.delegate?.favouritePressed()
    }
    
    func viewDidLoad() {
        getDetailInfo()
    }
}

private extension DetailPresenter {
    func getDetailInfo() {
        GenericServiceCall.makeServiceCall(withUrl: configuration.propertyEntity.detailUrl ?? "", andCodableObject: DetailDTO.self) { result in
            switch result {
            case .success(let dto):
                let entity = PropertyDetailEntity(dto)
                self.entity = entity
                self.view?.configureView(DetailViewModel(entity, configuration: self.configuration))
            case .failure(_):
                self.view?.configureError("Ops", message: "Ha ocurrido un error")
            }
        }
    }
}

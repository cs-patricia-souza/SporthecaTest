//
//  HomeViewModel.swift
//  SporthecaTest
//
//  Created by Patricia Cintia de Souza on 24/11/22.
//

import Foundation
import UIKit

protocol HomeViewModelProtocol {
    func showError()
}

class HomeViewModel {
    // MARK: - Initialization
    init(model: HomeResponse? = nil) {
        if let inputModel = model {
            response = inputModel
        }
    }
    
    var response = HomeResponse()
    private var view: HomeViewController?
    private var viewModelProtocol: HomeViewModelProtocol?
    
    public func configure(_ view: HomeViewController, viewModelProtocol: HomeViewModelProtocol) {
        self.view = view
        self.viewModelProtocol = viewModelProtocol
    }
    
    private func showErrorAlert() {
        viewModelProtocol?.showError()
    }
}

extension HomeViewModel {
    func fetchPlayerInfo(completion: @escaping (Result<HomeResponse, Error>) -> Void) {
        HTTPManager.shared.get(urlString: baseUrl + homeExtensionURL, completionBlock: { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .failure:
                self.showErrorAlert()
            case .success(let dta) :
                let decoder = JSONDecoder()
                do {
                    self.response = try decoder.decode(HomeResponse.self, from: dta)
                    completion(.success(try decoder.decode(HomeResponse.self, from: dta)))
                } catch let error {
                    print(error)
                    self.showErrorAlert()
                }
            }
        })
    }
}

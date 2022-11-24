//
//  HomeViewModel.swift
//  SporthecaTest
//
//  Created by Patricia Cintia de Souza on 24/11/22.
//

import Foundation

class HomeViewModel {
    // MARK: - Initialization
    init(model: TestResponse? = nil) {
        if let inputModel = model {
            response = inputModel
        }
    }
    
    var response = TestResponse()
    
    public func configure(_ view: HomeViewController) {
    }
}

extension HomeViewModel {
    func fetchResponse(completion: @escaping (Result<TestResponse, Error>) -> Void) {
        completion(.success(response))
    }
}

//
//  URLExtension.swift
//  SporthecaTest
//
//  Created by Patricia Cintia de Souza on 23/11/22.
//

import Foundation

extension URL {
    subscript(queryParam: String) -> String? {
        guard let url = URLComponents(string: self.absoluteString) else { return nil }
        return url.queryItems?.first(where: { $0.name == queryParam })?.value
    }
}

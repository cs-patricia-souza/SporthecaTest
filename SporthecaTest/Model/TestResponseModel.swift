//
//  Player.swift
//  SporthecaTest
//
//  Created by Patricia Cintia de Souza on 24/11/22.
//

import Foundation

struct TestResponse: Codable {
    let status: Int
    let object: Player
    
    enum CodingKeys: String, CodingKey {
        case object = "Object"
        case status = "Status"
    }
}

struct Player: Codable {
    let img: String
    let name: String
    let percentual: Double
    let pos: String
    let country: String
    let barras: Barra
    
    enum CodingKeys: String, CodingKey {
        case barras = "Barras"
        case img, name, percentual, pos, country
    }
}

struct Barra: Codable {
    let array: [BarrasItem]
}

struct BarrasItem: Codable {
    let max: Int
    let pla: Int
    let pos: Int
    let itemName: String
    
    enum CodingKeys: CodingKey {
        case max, pla, pos
    }
    
    init(from decoder: Decoder) throws {

        let container = try decoder.container(keyedBy: CodingKeys.self)

        max = try container.decode(Int.self, forKey: CodingKeys.max)
        pla = try container.decode(Int.self, forKey: CodingKeys.pla)
        pos = try container.decode(Int.self, forKey: CodingKeys.pos)

        itemName = container.codingPath.first!.stringValue
    }
}

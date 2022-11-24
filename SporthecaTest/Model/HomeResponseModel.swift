//
//  Player.swift
//  SporthecaTest
//
//  Created by Patricia Cintia de Souza on 24/11/22.
//

import Foundation

class HomeResponse: NSObject, Codable {
    var status: Int = 200
    var object: [Player]?
    
    enum CodingKeys: String, CodingKey {
        case object = "Object"
        case status = "Status"
    }
    
    init(status: Int, object: [Player]) {
        self.status = status
        self.object = object
    }
    
    override init() { }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        status = try container.decode(Int.self, forKey: CodingKeys.status)
        object = try container.decode([Player].self, forKey: CodingKeys.object)
    }
}

struct Player: Codable {
    var player: PlayerItem
    
    enum CodingKeys: String, CodingKey {
        case player = "Player"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        player = try container.decode(PlayerItem.self, forKey: CodingKeys.player)
    }
    
    func encode(to encoder: Encoder) throws { }
}

struct PlayerItem: Codable {
    var img: String
    var name: String
    var percentual: Double
    var pos: String
    var country: String
    var barras: Barras
    
    enum CodingKeys: String, CodingKey {
        case barras = "Barras"
        case img, name, percentual, pos, country
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        barras = try container.decode(Barras.self, forKey: CodingKeys.barras)
        img = try container.decode(String.self, forKey: CodingKeys.img)
        name = try container.decode(String.self, forKey: CodingKeys.name)
        percentual = try container.decode(Double.self, forKey: CodingKeys.percentual)
        pos = try container.decode(String.self, forKey: CodingKeys.pos)
        country = try container.decode(String.self, forKey: CodingKeys.country)
    }
    
    func encode(to encoder: Encoder) throws { }
}

struct Barras: Codable {
    var copasDoMundoVencidas: BarrasItem
    var copasDoMundoDisputadas: BarrasItem
    
    enum CodingKeys: String, CodingKey {
        case copasDoMundoVencidas = "Copas_do_Mundo_Vencidas"
        case copasDoMundoDisputadas = "Copas_do_Mundo_Disputadas"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        copasDoMundoVencidas = try container.decode(BarrasItem.self, forKey: CodingKeys.copasDoMundoVencidas)
        copasDoMundoDisputadas = try container.decode(BarrasItem.self, forKey: CodingKeys.copasDoMundoDisputadas)
    }
    
    func encode(to encoder: Encoder) throws { }
}

struct BarrasItem: Codable {
    var max: Int
    var pla: Int
    var pos: Int
    
    enum CodingKeys: CodingKey {
        case max, pla, pos
    }
    
    init(from decoder: Decoder) throws {

        let container = try decoder.container(keyedBy: CodingKeys.self)

        max = try container.decode(Int.self, forKey: CodingKeys.max)
        pla = try container.decode(Int.self, forKey: CodingKeys.pla)
        pos = try container.decode(Int.self, forKey: CodingKeys.pos)
    }
}

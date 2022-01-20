//
//  MemModel.swift
//  Public API App v2
//
//  Created by Дмитрий Чепанов on 19.01.2022.
//

import Foundation

struct MemsModel: Decodable {
    let success: Bool
    let data: DataMemes
}

struct DataMemes: Decodable {
    let memes: [Memes]
}

struct Memes: Decodable {
    let id: String
    let name: String
    let url: String
    let width: Int?
    let height: Int?
    let boxCount: Int?
}

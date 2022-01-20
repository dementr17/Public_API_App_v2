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
    let id: String?
    let name: String?
    let url: String?
    let width: Int?
    let height: Int?
    let box_count: Int?
    
    //инициализатор принимает словарь
    init(memsData: [String: Any]) {
        //инициализируем свойства
        id = memsData["id"] as? String
        name = memsData["name"] as? String
        url = memsData["url"] as? String
    width = memsData["width"] as? Int
        height = memsData["height"] as? Int
        box_count = memsData["box_count"] as? Int
    }
    //инициализатор для ручного парсинга. присваиваем значения для нового словаря, которые мы сюда передадим
    
    static func getMemes(from value: Any) -> [Memes] {
        guard let memesData = value as? [[String: Any]] else { return [] }
        
        var memes = [Memes]()
        //пустой массив
        for memData in memesData {
            let mem = Memes(memsData: memData)
            memes.append(mem)
        }
        //    наполняем его
        return memes
        //    возвращаем
    }
}


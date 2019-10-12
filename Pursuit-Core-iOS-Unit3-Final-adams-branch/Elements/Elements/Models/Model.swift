//
//  Model.swift
//  Elements
//
//  Created by God on 9/19/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import Foundation



struct Element: Codable {
    let name, appearance: String?
    let atomicMass, boil: Double?
    let category: String?
    let density: Double?
    let discoveredBy: String?
    let melt, molarHeat: Double?
    let namedBy: String?
    let number, period: Int?
    let phase: String?
    let source: String?
    let spectralImg: String?
    let summary, symbol: String?
    let xpos, ypos: Int?
    let shells: [Int]?
    
    enum CodingKeys: String, CodingKey {
        case name, appearance
        case atomicMass = "atomic_mass"
        case boil, category,  density
        case discoveredBy
        case melt
        case molarHeat
        case namedBy
        case number, period, phase, source
        case spectralImg
        case summary, symbol, xpos, ypos, shells
    }
}



class JSONNull: Codable, Hashable {
    
    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }
    
    public var hashValue: Int {
        return 0
    }
    
    public init() {}
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

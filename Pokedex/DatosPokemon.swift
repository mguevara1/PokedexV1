//
//  DatosPokemon.swift
//  Pokedex
//
//  Created by Marco Guevara on 13/08/22.
//

import Foundation

struct Pokemon: Decodable, Identifiable {
    let id: Int
    let attack: Int
    let defense: Int
    let description: String
    let name: String
    let imageUrl: String
    let type: String
}

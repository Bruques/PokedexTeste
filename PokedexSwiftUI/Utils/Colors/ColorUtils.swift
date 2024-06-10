//
//  ColorUtils.swift
//  PokedexSwiftUI
//
//  Created by Bruno Marques on 07/06/24.
//

import Foundation
import SwiftUI

public class ColorUtils {
    public static let typeColorMap: [String : String] = [
        "water" : "waterColor",
        "dragon" : "dragonColor",
        "electric" : "electricColor",
        "fairy" : "fairyColor",
        "ghost" : "ghostColor",
        "fire" : "fireColor",
        "ice" : "iceColor",
        "grass" : "grassColor",
        "bug" : "bugColor",
        "fighting" : "fightingColor",
        "normal" : "normalColor",
        "dark" : "darkColor",
        "steel" : "steelColor",
        "rock" : "rockColor",
        "psychic" : "psychicColor",
        "ground" : "groundColor",
        "poison" : "poisonColor",
        "flying" : "flyingColor"
    ]
    
    public static func getColorForPokemonType(type: String) -> Color {
        if let colorName = typeColorMap[type.lowercased()] {
            return Color(colorName)
        } else {
            return Color.normal
        }
    }
}

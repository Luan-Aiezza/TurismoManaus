//
//  IdString.swift
//  Turismo_Manaus
//
//  Created by Jorge Samuel Silva Coelho on 23/05/24.
//

import Foundation

public func removeAccents(from string: String) -> String {
    return string.applyingTransform(.stripCombiningMarks, reverse: false) ?? string
}

public func removeSymbols(from string: String) -> String {
    return string.replacingOccurrences(of: "'", with: "")
}

public func removeSpaces(from string: String) -> String {
    let newstring = string.replacingOccurrences(of: "(", with: "")
    let otherstring = newstring.replacingOccurrences(of: ")", with: "")
    return otherstring.replacingOccurrences(of: " ", with: "")
}

public func removeTrates(from string: String) -> String {
    return string.replacingOccurrences(of: "-", with: "")
}

public func convertToLowerCase(_ string: String) -> String {
    return string.lowercased()
}

public func transformString(_ string: String) -> String {
    let stringWithoutAccents = removeAccents(from: string)
    let stringWithoutSpaces = removeSpaces(from: stringWithoutAccents)
    let stringWithoutSymbols = removeSymbols(from: stringWithoutSpaces)
    let stringWithoutTrates = removeTrates(from: stringWithoutSymbols)
    let lowercasedString = convertToLowerCase(stringWithoutTrates)
    return lowercasedString
}

public func capitalizeFirstLetter(_ string: String) -> String {
    guard let firstLetter = string.first else {
        return string
    }
    return String(firstLetter).uppercased() + string.dropFirst()
}

//
//  Copyright (C) 2023 Trusted Shops AG
//
//  MIT License
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//
//  Created by Prem Pratap Singh on 29/03/23.
//


import Foundation

/**
 CurrencyCode enum contains details like currency code, symbol, etc
 */
enum CurrencyCode: String, Codable {
    case chf // Swiss Franc
    case eur // Euro
    case gbp // Pound Sterling
    case pln // Polish złoty
    case nok // Norwegian krone
    case sek // Swedish krona
    case dkk // Danish krone
    case ron // Romanian leu
    case czk // Czech koruna
    
    // MARK: Public properties
    
    /**
     Returns currency code
     */
    var code: String {
        switch self {
        case .chf: return "CHF"
        case .eur: return "EURO"
        case .gbp: return "GBP"
        case .pln: return "PLN"
        case .nok: return "NOK"
        case .sek: return "SEK"
        case .dkk: return "DKK"
        case .ron: return "RON"
        case .czk: return "CZK"
        }
    }
    
    /**
     Returns currency code
     */
    var symbol: String {
        switch self {
        case .chf: return "CHF"
        case .eur: return "€"
        case .gbp: return "£"
        case .pln: return "zł"
        case .nok, .sek, .dkk: return "kr"
        case .ron: return "L"
        case .czk: return "Kč"
        }
    }
}

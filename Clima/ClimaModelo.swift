//
//  ClimaModelo.swift
//  Clima
//
//  Created by marco rodriguez on 11/10/21.
//

import Foundation

struct ClimaModelo {
    let condicionID: Int
    let nombreCiudad: String
    let temperaturaCelcius: Double
    let descripcionClima: String
    
    
    var condicionClima: Array<Any> {
        switch condicionID {
        case 200...232:
            var condicion=["cloud.bolt", "tormenta"]
            return condicion
        case 500...531:
            var condicion=["cloud.rain.fill", "tormenta"]
            return condicion
        case 600...622:
            var condicion=["snow", "nevando"]
            return condicion
        case 800:
            var condicion=["sun.min.fill", "soleado"]
            return condicion
        case 801...804:
            var condicion=["cloud.fill", "nubes"]
            return condicion
        default:
            var condicion=["cloud.fill", "nubes"]
            return condicion
        }
        
    }

}

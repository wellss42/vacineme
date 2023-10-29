//
//  ModelViaCep.swift
//  vacineme
//
//  Created by wellington martins on 05/10/23.
//

import Foundation

struct ViaCep: Codable {
    let cep, logradouro, complemento, bairro: String
    let localidade, uf, ibge, gia: String
    let ddd, siafi: String
}

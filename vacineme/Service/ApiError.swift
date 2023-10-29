//
//  ApiError.swift
//  vacineme
//
//  Created by wellington martins on 05/10/23.
//

import Foundation

enum ApiError: Error {
     
     case invalidURL
     case invalidResponse
     case noData
     case failedRequest
     case invalidData
     case invalidParameters
     
     var description: String {
          switch self {
               
          case .invalidURL:
               return "URL inválida"
          case .invalidResponse:
               return "Resposta inválida"
          case .noData:
               return "Sem dados"
          case .failedRequest:
               return "Requisição falhou"
          case .invalidData:
               return "Dados inválidos"
          case .invalidParameters:
               return "Parâmetros inválidos"
          }
     }
}

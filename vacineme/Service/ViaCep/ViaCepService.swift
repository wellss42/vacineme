//
//  ViaCepService.swift
//  vacineme
//
//  Created by wellington martins on 05/10/23.
//

import Foundation

var dadosIbge: String?
var cidade: String?

protocol ViaCepServiceType {
    func getCep(cep: String, completion: @escaping (Result<ViaCep, ApiError>) -> Void)
}

class ViaCepService: ViaCepServiceType {
    
    func getCep(cep: String, completion: @escaping (Result<ViaCep, ApiError>) -> Void) {
        
        let url: String = "https://viacep.com.br/ws/\(cep)/json/"
        
        guard let url = URL(string: url) else {
            completion(.failure(.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(.failedRequest))
                return
            }
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            do {
                let viaCep = try JSONDecoder().decode(ViaCep.self, from: data)
                completion(.success(viaCep))
                dadosIbge = viaCep.ibge
                cidade = viaCep.localidade
            } catch {
                print("Error decoding ViaCep: \(error)")
                completion(.failure(.invalidData))
            }
        }.resume()
    }
}





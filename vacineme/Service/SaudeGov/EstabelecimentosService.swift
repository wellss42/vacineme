//
//  EstabelecimentosService.swift
//  vacineme
//
//  Created by wellington martins on 12/10/23.
//

import Foundation

protocol EstabelecimentoServiceType {
    func getEstabelecimentos(ibge: String, completion: @escaping (Result<EstabelecimentosSaude, ApiError>) -> Void)
}

class EstabelecimentosService: EstabelecimentoServiceType {
    
    func getEstabelecimentos(ibge: String, completion: @escaping (Result<EstabelecimentosSaude, ApiError>) -> Void) {
        
        let url: String = "https://apidadosabertos.saude.gov.br/cnes/estabelecimentos?codigo_municipio=\(ibge)&limit=50&codigo_tipo_unidade=2"
        
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
                completion(.failure(.invalidData))
                return
            }
            
            do {
                let estabelecimentos = try JSONDecoder().decode(EstabelecimentosSaude.self, from: data)
                completion(.success(estabelecimentos))
                print(estabelecimentos)
            } catch {
                print("Error decoding ViaCep: \(error)")
                completion(.failure(.invalidData))
            }
            
        }.resume()
        
    }
    
}

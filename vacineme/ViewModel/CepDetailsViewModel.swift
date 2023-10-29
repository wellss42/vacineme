//
//  CepDetailsViewModel.swift
//  vacineme
//
//  Created by wellington martins on 05/10/23.
//

import Foundation

protocol CepDetailsViewModelDelegate: AnyObject {
    func presentSuccess(success: EstabelecimentosSaude)
    func presentError(error: String)
}

var cepGlobal: String?

class CepDetailsViewModel {
    
    weak var delegate : CepDetailsViewModelDelegate?
    private let service: ViaCepServiceType
    private let serviceEstabelecimentos: EstabelecimentosService
    
    init(service: ViaCepServiceType,estabelecimentosService: EstabelecimentosService) {
        self.service = service
        self.serviceEstabelecimentos = estabelecimentosService
    }
    
    func getDadosCep(cep: String) {
        cepGlobal = cep
        service.getCep(cep: cep) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(_):
                    if let ibge = dadosIbge {
                        let ibgeFormated = String(ibge.prefix(6))
                        self.serviceEstabelecimentos.getEstabelecimentos(ibge: ibgeFormated) {
                            result in
                            DispatchQueue.main.async {
                                switch result {
                                case .success(let estabelecimentos):
                                    self.delegate?.presentSuccess(success: estabelecimentos)
                                case .failure(let error):
                                    self.delegate?.presentError(error: error.description)
                                }
                            }
                        }
                    }
                    
                case .failure(let error):
                    self.delegate?.presentError(error: error.description)
                }
            }
            
        }
    
    }
    
}


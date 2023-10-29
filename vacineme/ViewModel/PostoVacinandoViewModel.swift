//
//  PostoVacinandoViewModel.swift
//  vacineme
//
//  Created by wellington martins on 13/10/23.
//

import Foundation

protocol PostoVacinandoViewModelDelegate: AnyObject {
    func presentSuccess(success: [EstabelecimentoVacinando])
    func presentError(error: String)
}

class PostoVacinandoViewModel {
    
    weak var delegate : PostoVacinandoViewModelDelegate?
    private let serviceViaCep: ViaCepServiceType
    private let service: PostoVacinadoFireBaseServiceType
    
    init(serviceViaCep: ViaCepServiceType, service: PostoVacinadoFireBaseServiceType) {
        self.service = service
        self.serviceViaCep = serviceViaCep
    }
    
    func getPostosVacinando(cep: String) {
        serviceViaCep.getCep(cep: cep) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(_):
                    self.service.getPostosVacinado { result in
                        DispatchQueue.main.async {
                            switch result {
                            case .success(let postos):
                                self.delegate?.presentSuccess(success: postos)
                            case .failure(let error):
                                self.delegate?.presentError(error: error.description)
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

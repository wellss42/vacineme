//
//  DetalhesVacinandoViewModel.swift
//  vacineme
//
//  Created by wellington martins on 21/10/23.
//

import Foundation
import FirebaseFirestore

protocol DetalhesVacinandoViewDelegate: AnyObject{
    func presentSuccess()
    func presentError()
}

class DetalhesVacinandoViewModel {
    
    weak var delegate : DetalhesVacinandoViewDelegate?
    
    func deleteEstabelecimento(id: String, idMobile: String) {
        
        let device = UIDevice.current
        let identifier = device.identifierForVendor
        guard let idMobileAtual = identifier?.uuidString else {
            return
        }
        if(idMobile.elementsEqual(idMobileAtual)){
            Firestore.firestore().collection(cidade ?? "Outros").document(id).delete() { error in
                if let error = error {
                    print("Erro ao obter dados do firebase \(error)")
                } else {
                    self.delegate?.presentSuccess()
                }
            }
        } else {
            self.delegate?.presentError()
        }
    }
    
}

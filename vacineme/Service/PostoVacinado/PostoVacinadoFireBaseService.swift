//
//  PostoVacinadoFireBaseService.swift
//  vacineme
//
//  Created by wellington martins on 13/10/23.
//

import Foundation
import FirebaseFirestore

// Defina o protocolo PostoVacinadoFireBaseServiceType
protocol PostoVacinadoFireBaseServiceType {
    func getPostosVacinado(completion: @escaping (Result<[EstabelecimentoVacinando], ApiError>) -> Void)
}

class PostoVacinadoFireBaseService: PostoVacinadoFireBaseServiceType {
    
    func getPostosVacinado(completion: @escaping (Result<[EstabelecimentoVacinando], ApiError>) -> Void) {
        Firestore.firestore().collection(cidade ?? "Outros").getDocuments() { snapshot, error in
            if let error = error {
                print("Erro ao obter dados do firebase \(error)")
            }
            guard let snapshot = snapshot else {
                print("Dados vazios")
                return
            }
            self.mapResult(doc: snapshot.documents, completion: completion)
        }
    }
    
    func mapResult(doc: [QueryDocumentSnapshot], completion: @escaping (Result<[EstabelecimentoVacinando], ApiError>) -> Void) {
        var estabelecimento: [EstabelecimentoVacinando] = []
        for document in doc {
            let dados = EstabelecimentoVacinando(
                nome_razao_social: document["nome_razao_social"] as? String ?? "",
                nome_fantasia: document["nome_fantasia"] as? String ?? "",
                descricao_turno_atendimento: document["descricao_turno_atendimento"] as? String ?? "",
                numero_telefone_estabelecimento: document["numero_telefone_estabelecimento"] as? String ?? "",
                endereco_estabelecimento: document["endereco_estabelecimento"] as? String ?? "",
                numero_estabelecimento: document["numero_estabelecimento"] as? String ?? "",
                bairro_estabelecimento: document["bairro_estabelecimento"] as? String ?? "",
                codigo_cep_estabelecimento: document["codigo_cep_estabelecimento"] as? String ?? "",
                latitude_estabelecimento_decimo_grau: document["latitude_estabelecimento_decimo_grau"] as? Double ?? 0.0,
                longitude_estabelecimento_decimo_grau: document["longitude_estabelecimento_decimo_grau"] as? Double ?? 0.0,
                id_mobilde: document["id_mobile"] as? String ?? ""
            )
            estabelecimento.append(dados)
        }
        completion(.success(estabelecimento))
    }
    
}


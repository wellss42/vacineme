//
//  Coodinator.swift
//  vacineme
//
//  Created by wellington martins on 12/10/23.
//

import UIKit

enum Routes {
    case home
    case homeKill
    case postosDetalhes(detalhes: Estabelecimento)
    case postosVacinando
    case postosVacinandoKill
    case postosvacinandoDetalhes(detalhes: EstabelecimentoVacinando)
}

protocol Coordinator {
    var navigationController: UINavigationController? { get set }
    
    func start()
    func navigate(to route: Routes, data: Any?)
    
}

protocol Coordinating {
    var coordinator: Coordinator? { get set }
}

//
//  MainCoordinator.swift
//  vacineme
//
//  Created by wellington martins on 12/10/23.
//

import UIKit

class MainCoordinator: Coordinator {
    
    var navigationController: UINavigationController?
    
    
    func start() {
        startWithViewCode()
    }
    
    func navigate(to route: Routes, data: Any?) {
        switch route {
        case .home:
            let vc = HomeViewController()
            vc.coordinator = self
            navigationController?.pushViewController(vc, animated: true)
        case .homeKill:
            navigationController?.popViewController(animated: true)
        case .postosDetalhes(let details):
            let vc = PostosDetalhesViewController(detalhesPosto: details)
            vc.coordinator = self
            navigationController?.pushViewController(vc, animated: true)
        case .postosVacinando:
            let vc = PostosVacinandoViewController()
            vc.coordinator = self
            navigationController?.pushViewController(vc, animated: true)
        case .postosVacinandoKill:
            navigationController?.popViewController(animated: true)
        case .postosvacinandoDetalhes(let details):
            let vc = PostoVacinandoDetalhesViewController(detalhesPosto: details)
            vc.coordinator = self
            navigationController?.pushViewController(vc, animated: true)
        }

    }
    
    private func startWithViewCode() {
        let vc = HomeViewController()
        vc.coordinator = self
        navigationController?.setViewControllers([vc], animated: false)
    }
    
    
}

//
//  ViewCoding.swift
//  vacineme
//
//  Created by wellington martins on 01/10/23.
//

import Foundation

public protocol ViewCoding {
    
    func buildViewHerarchy()
    func setupContraints()
    
}

public extension ViewCoding {
    
    func setupView() {
        buildViewHerarchy()
        setupContraints()
    }
    
}

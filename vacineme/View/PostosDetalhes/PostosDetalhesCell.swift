//
//  PostosDetalhesCell.swift
//  vacineme
//
//  Created by wellington martins on 22/10/23.
//

import Foundation
import UIKit

class PostosDetalhesCell: UITableViewCell {
    
     lazy var detalhesView: UIView = {
        let detalhesView = UIView()
        let lightGray = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1.0)
        detalhesView.backgroundColor = lightGray
        detalhesView.layer.cornerRadius = 20.0
        detalhesView.layer.borderColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5).cgColor
        detalhesView.translatesAutoresizingMaskIntoConstraints = false
        return detalhesView
    }()
    
     lazy var enderecoLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica", size: 14)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
     lazy var numeroLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica", size: 14)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
     lazy var bairroLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica", size: 14)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
     lazy var cepLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica", size: 14)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
     lazy var telefoneLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica", size: 14)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

extension PostosDetalhesCell: ViewCoding {
    
    func buildViewHerarchy() {
        addSubview(detalhesView)
        detalhesView.addSubview(enderecoLabel)
        detalhesView.addSubview(numeroLabel)
        detalhesView.addSubview(bairroLabel)
        detalhesView.addSubview(cepLabel)
        detalhesView.addSubview(telefoneLabel)
        
    }
    
    func setupContraints() {
        NSLayoutConstraint.activate([
            
            detalhesView.heightAnchor.constraint(equalToConstant: 150),
            detalhesView.topAnchor.constraint(equalTo: bottomAnchor, constant: 8),
            detalhesView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            detalhesView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            
            enderecoLabel.topAnchor.constraint(equalTo: detalhesView.topAnchor, constant: 10),
            enderecoLabel.leadingAnchor.constraint(equalTo: detalhesView.leadingAnchor, constant: 8),
            enderecoLabel.trailingAnchor.constraint(equalTo: detalhesView.trailingAnchor, constant: -8),
            
            numeroLabel.topAnchor.constraint(equalTo: enderecoLabel.bottomAnchor, constant: 8),
            numeroLabel.leadingAnchor.constraint(equalTo: detalhesView.leadingAnchor, constant: 8),
            numeroLabel.trailingAnchor.constraint(equalTo: detalhesView.trailingAnchor, constant: -8),
            
            bairroLabel.topAnchor.constraint(equalTo: numeroLabel.bottomAnchor, constant: 8),
            bairroLabel.leadingAnchor.constraint(equalTo: detalhesView.leadingAnchor, constant: 8),
            bairroLabel.trailingAnchor.constraint(equalTo: detalhesView.trailingAnchor, constant: -8),
            
            cepLabel.topAnchor.constraint(equalTo: bairroLabel.bottomAnchor, constant: 8),
            cepLabel.leadingAnchor.constraint(equalTo: detalhesView.leadingAnchor, constant: 8),
            cepLabel.trailingAnchor.constraint(equalTo: detalhesView.trailingAnchor, constant: -8),
            
            telefoneLabel.topAnchor.constraint(equalTo: cepLabel.bottomAnchor, constant: 8),
            telefoneLabel.leadingAnchor.constraint(equalTo: detalhesView.leadingAnchor, constant: 8),
            telefoneLabel.trailingAnchor.constraint(equalTo: detalhesView.trailingAnchor, constant: -8),
        ])
    }
    
    
}

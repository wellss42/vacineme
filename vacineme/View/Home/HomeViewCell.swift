//
//  HomeViewCell.swift
//  vacineme
//
//  Created by wellington martins on 12/10/23.
//

import UIKit

class HomeViewCell: UITableViewCell {
    
     lazy var viewLine: UIView = {
        let view = UIView()
         let lightGray = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1.0)
         view.backgroundColor = lightGray
         view.layer.cornerRadius = 20.0
         view.layer.borderColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5).cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
     lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
     lazy var horarioAtendimentoLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
     lazy var telefoneLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .black
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
     lazy var disntaciaLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .black
        label.numberOfLines = 0
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

extension HomeViewCell: ViewCoding {
    
    func buildViewHerarchy() {
        addSubview(viewLine)
        viewLine.addSubview(titleLabel)
        viewLine.addSubview(horarioAtendimentoLabel)
        viewLine.addSubview(telefoneLabel)
        viewLine.addSubview(disntaciaLabel)
        
    }
    
    func setupContraints() {
        
        NSLayoutConstraint.activate([
            viewLine.topAnchor.constraint(equalTo: topAnchor),
            viewLine.leadingAnchor.constraint(equalTo: leadingAnchor),
            viewLine.trailingAnchor.constraint(equalTo: trailingAnchor),
            viewLine.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            
            titleLabel.topAnchor.constraint(equalTo: viewLine.topAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: viewLine.leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: viewLine.trailingAnchor, constant: -8),
            
            horarioAtendimentoLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            horarioAtendimentoLabel.leadingAnchor.constraint(equalTo: viewLine.leadingAnchor, constant: 8),
            horarioAtendimentoLabel.trailingAnchor.constraint(equalTo: viewLine.trailingAnchor, constant: -8),
            
            telefoneLabel.topAnchor.constraint(equalTo: horarioAtendimentoLabel.bottomAnchor, constant: 8),
            telefoneLabel.leadingAnchor.constraint(equalTo: viewLine.leadingAnchor, constant: 8),
            telefoneLabel.trailingAnchor.constraint(equalTo: viewLine.trailingAnchor, constant: -8),
            
            disntaciaLabel.topAnchor.constraint(equalTo: telefoneLabel.bottomAnchor, constant: 8),
            disntaciaLabel.leadingAnchor.constraint(equalTo: viewLine.leadingAnchor, constant: 8),
            disntaciaLabel.trailingAnchor.constraint(equalTo: viewLine.trailingAnchor, constant: -8),
            disntaciaLabel.bottomAnchor.constraint(equalTo: viewLine.bottomAnchor, constant: -8)
            
        ])
        
    }
    
    
}

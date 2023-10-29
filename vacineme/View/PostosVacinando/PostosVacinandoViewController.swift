//
//  PostosVacinandoViewController.swift
//  vacineme
//
//  Created by wellington martins on 13/10/23.
//

import UIKit

class PostosVacinandoViewController: UIViewController {
    
    var coordinator: Coordinator?
    private var data: [EstabelecimentoVacinando] = []
    
    lazy var viewModel: PostoVacinandoViewModel = {
        let viewModel = PostoVacinandoViewModel(serviceViaCep: ViaCepService(), service: PostoVacinadoFireBaseService())
        viewModel.delegate = self
        return viewModel
    }()
    
    let imageView: UIImageView = {
         let imageView = UIImageView()
         imageView.image = UIImage(named: "vaci")
         imageView.contentMode = .scaleAspectFill
         imageView.clipsToBounds = true
         imageView.layer.borderColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5).cgColor
         imageView.isUserInteractionEnabled = true
         imageView.translatesAutoresizingMaskIntoConstraints = false
         return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Postos vacinando"
        label.textAlignment = .center
        label.font = UIFont(name: "Helvetica", size: 40)
        label.font = UIFont.boldSystemFont(ofSize: 40)
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var searchCep: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = UIColor.white
        textField.layer.cornerRadius = 20.0
        textField.layer.borderWidth = 2.0
        textField.layer.borderColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5).cgColor
        textField.font = UIFont(name: "Helvetica", size: 16)
        textField.textColor = UIColor.black
        textField.tintColor = UIColor.gray
                  
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 40))
        textField.leftView = paddingView
        textField.leftViewMode = .always
                  
        let placeholderAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.gray,
            .font: UIFont(name: "Helvetica", size: 16)!
        ]
        textField.attributedPlaceholder = NSAttributedString(string: "Digite seu cep", attributes: placeholderAttributes)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var buttonSearch: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setTitle("Buscar", for: .normal)
        button.layer.cornerRadius = 20.0
        button.layer.borderColor = UIColor.gray.cgColor
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.addTarget(self, action: #selector(botaoBuscar), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var bodyView: UIView = {
        let bodyView = UIView()
        bodyView.backgroundColor = .white
        bodyView.layer.cornerRadius = 20.0
        bodyView.layer.borderColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5).cgColor
        bodyView.translatesAutoresizingMaskIntoConstraints = false
        return bodyView
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.layer.cornerRadius = 20.0
        tableView.layer.borderColor = UIColor.gray.cgColor
        tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 8))
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(HomeViewCell.self, forCellReuseIdentifier: "cell")
        setupView()
        
    }
    
    @objc func botaoBuscar() {
        let cep = searchCep.text ?? String()
        if cep.isEmpty {
                       let alert = UIAlertController(title: "Atenção", message: "Preencha todos os campos", preferredStyle: .alert)
                       let action = UIAlertAction(title: "OK", style: .default, handler: nil)
                       alert.addAction(action)
                       present(alert, animated: true, completion: nil)
                       return
                  } else {
                      viewModel.getPostosVacinando(cep: cep)
                      searchCep.resignFirstResponder()
            }
    }
    
    private func didTapCell(position: IndexPath) {
        coordinator?.navigate(to: .postosvacinandoDetalhes(detalhes: data[position.row]), data: nil)
    }
    
    func reloadTable() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension PostosVacinandoViewController: PostoVacinandoViewModelDelegate {
    
    func presentSuccess(success: [EstabelecimentoVacinando]) {
        data = success
        reloadTable()
        print(data)
    }
    
    
    func presentError(error: String){
              let alert = UIAlertController(title: "Atenção", message: error, preferredStyle: .alert)
              let action = UIAlertAction(title: "OK", style: .default, handler: nil)
              alert.addAction(action)
              present(alert, animated: true, completion: nil)
         }
}

extension PostosVacinandoViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didTapCell(position: indexPath)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HomeViewCell
        let estabelecimento = data[indexPath.row]
        cell.titleLabel.text = estabelecimento.nome_fantasia
        cell.horarioAtendimentoLabel.text = estabelecimento.descricao_turno_atendimento
        cell.telefoneLabel.text = estabelecimento.numero_telefone_estabelecimento
        return cell
        
    }
    
}

extension PostosVacinandoViewController: ViewCoding {
    
    func buildViewHerarchy() {
        view.addSubview(imageView)
        imageView.addSubview(titleLabel)
        imageView.addSubview(searchCep)
        imageView.addSubview(buttonSearch)
        view.addSubview(bodyView)
        bodyView.addSubview(tableView)
    }
    
    func setupContraints() {
        
        NSLayoutConstraint.activate([
            
            imageView.heightAnchor.constraint(equalToConstant: 330),
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 15),
            titleLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -8),
            
            searchCep.heightAnchor.constraint(equalToConstant: 55),
            searchCep.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -90),
            searchCep.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            searchCep.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            
            buttonSearch.topAnchor.constraint(equalTo: searchCep.topAnchor, constant: 3),
            buttonSearch.leadingAnchor.constraint(equalTo: searchCep.trailingAnchor, constant: -70),
            buttonSearch.trailingAnchor.constraint(equalTo: searchCep.trailingAnchor, constant: -8),
            buttonSearch.bottomAnchor.constraint(equalTo: searchCep.bottomAnchor, constant: -3),
        
            bodyView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -30),
            bodyView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bodyView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bodyView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            tableView.topAnchor.constraint(equalTo: bodyView.topAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: bodyView.leadingAnchor, constant: 8),
            tableView.trailingAnchor.constraint(equalTo: bodyView.trailingAnchor, constant: -8),
            tableView.bottomAnchor.constraint(equalTo: bodyView.bottomAnchor, constant: -8),
            
        ])
        
    }
}

//
//  ViewController.swift
//  vacineme
//
//  Created by wellington martins on 01/10/23.
//

import UIKit
import CoreLocation

class HomeViewController: UIViewController {
    
    var coordinator: Coordinator?
    private var data: [Estabelecimento] = []
    
    lazy var viewModel: CepDetailsViewModel = {
        let viewModel = CepDetailsViewModel(service: ViaCepService(), estabelecimentosService: EstabelecimentosService())
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
        label.text = "Vacine-me"
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
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.layer.cornerRadius = 20.0
        tableView.layer.borderColor = UIColor.gray.cgColor
        tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 8))
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var bodyView: UIView = {
        let bodyView = UIView()
        bodyView.backgroundColor = .white
        bodyView.layer.cornerRadius = 20.0
        bodyView.layer.borderColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5).cgColor
        bodyView.translatesAutoresizingMaskIntoConstraints = false
        return bodyView
    }()
    
    private lazy var postosAdicionadosButton: UIButton = {
        let button = UIButton()
        button.setTitle("Locais vacinando", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = UIColor(red: 0.6, green: 0.8, blue: 0.9, alpha: 1.2)
        button.layer.cornerRadius = 20.0
        button.titleLabel?.font = UIFont(name: "Helvetica", size: 16)
        button.tintColor = .gray
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 40))
        button.addSubview(paddingView)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(adicionados), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Initialize
    
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
                       viewModel.getDadosCep(cep: cep)
                      searchCep.resignFirstResponder()
            }
    }
    
    @objc func adicionados() {
        coordinator?.navigate(to: .postosVacinando, data: nil)
    }
    
    private func didTapCell(position: IndexPath) {
        coordinator?.navigate(to: .postosDetalhes(detalhes: data[position.row]), data: nil)
    }
    
    func reloadTable() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
    }

    // Função para calcular a distância entre duas coordenadas em metros
    func calcularDistanciaEntreCoordenadas(coord1: CLLocationCoordinate2D, coord2: CLLocationCoordinate2D) -> CLLocationDistance {
        let location1 = CLLocation(latitude: coord1.latitude, longitude: coord1.longitude)
        let location2 = CLLocation(latitude: coord2.latitude, longitude: coord2.longitude)
        return location1.distance(from: location2)
    }

    // Função para obter coordenadas a partir de um CEP
    func obterCoordenadasDoCEP(cep: String, completion: @escaping (CLLocationCoordinate2D?) -> Void) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(cep) { placemarks, error in
            if let error = error {
                print("Erro ao geocodificar o CEP: \(error.localizedDescription)")
                completion(nil)
            } else if let placemark = placemarks?.first, let location = placemark.location {
                completion(location.coordinate)
            } else {
                completion(nil)
            }
        }
    }
    
}

extension HomeViewController: CepDetailsViewModelDelegate {
    
    func presentSuccess(success: EstabelecimentosSaude) {
        data = success.estabelecimentos
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

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return 150
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HomeViewCell
        let estabelecimento = data[indexPath.row]
        cell.titleLabel.text = estabelecimento.nomeFantasia
        cell.horarioAtendimentoLabel.text = estabelecimento.descricaoTurnoAtendimento
        cell.telefoneLabel.text = estabelecimento.numeroTelefoneEstabelecimento
        
        let cep1 = searchCep.text ?? String()
        let cep2 = estabelecimento.codigoCepEstabelecimento
        // Executa a função para obter as coordenadas do CEP1
        obterCoordenadasDoCEP(cep: cep1) { coordenadas1 in
            // Executa a função para obter as coordenadas do CEP2
            self.obterCoordenadasDoCEP(cep: cep2) { coordenadas2 in
                // Verifica se as coordenadas foram obtidas com sucesso
                if let coord1 = coordenadas1, let coord2 = coordenadas2 {
                    // Calcula a distância entre os dois CEPs
                    let distancia = self.calcularDistanciaEntreCoordenadas(coord1: coord1, coord2: coord2)
                    let distanciaEmKm = distancia / 1000
                    let DistanciaString = String(distanciaEmKm)
                    cell.disntaciaLabel.text = DistanciaString.prefix(3) + " km"
                    print("A distância entre os CEPs \(cep1) e \(cep2) é de \(distancia) metros")
                } else {
                    print("Não foi possível obter as coordenadas para um dos CEPs.")
                }
            }
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didTapCell(position: indexPath)
    }
    
}

extension HomeViewController: ViewCoding {
    
    func buildViewHerarchy() {
        view.addSubview(imageView)
        imageView.addSubview(titleLabel)
        imageView.addSubview(searchCep)
        imageView.addSubview(buttonSearch)
        view.addSubview(bodyView)
        bodyView.addSubview(tableView)
        bodyView.addSubview(postosAdicionadosButton)
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
            tableView.bottomAnchor.constraint(equalTo: postosAdicionadosButton.topAnchor, constant: -8),
            
            postosAdicionadosButton.heightAnchor.constraint(equalToConstant: 50),
            postosAdicionadosButton.bottomAnchor.constraint(equalTo: bodyView.bottomAnchor, constant: -20),
            postosAdicionadosButton.leadingAnchor.constraint(equalTo: bodyView.leadingAnchor, constant: 8),
            postosAdicionadosButton.trailingAnchor.constraint(equalTo: bodyView.trailingAnchor, constant: -10)
            
        ])
    }
    
    
}


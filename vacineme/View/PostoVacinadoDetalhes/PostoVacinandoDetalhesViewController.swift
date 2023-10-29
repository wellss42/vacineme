//
//  PostosDetalhesViewController.swift
//  vacineme
//
//  Created by wellington martins on 13/10/23.
//

import MapKit
import UIKit
import CoreLocation

class PostoVacinandoDetalhesViewController: UIViewController, MKMapViewDelegate {
    
    var coordinator: Coordinator?
    let detalhesPosto: EstabelecimentoVacinando
    var locationManager: CLLocationManager?
    
    lazy var viewModel: DetalhesVacinandoViewModel = {
        let viewModel = DetalhesVacinandoViewModel()
        viewModel.delegate = self
        return viewModel
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "hospital")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.borderColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5).cgColor
        imageView.isUserInteractionEnabled = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .clear
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var stackView: UIStackView = {
            let stackView = UIStackView()
            stackView.axis = .vertical
            stackView.spacing = 16
            stackView.translatesAutoresizingMaskIntoConstraints = false
            return stackView
        }()
    
    private lazy var bodyView: UIView = {
        let bodyView = UIView()
        bodyView.backgroundColor = .white
        bodyView.layer.cornerRadius = 20.0
        bodyView.layer.borderColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5).cgColor
        bodyView.translatesAutoresizingMaskIntoConstraints = false
        return bodyView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica", size: 18)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var mapaView: UIView = {
        let mapView = UIView()
        mapView.backgroundColor = .darkGray
        mapView.layer.cornerRadius = 20.0
        mapView.layer.borderColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5).cgColor
        mapView.translatesAutoresizingMaskIntoConstraints = false
        return mapView
    }()
    
    private lazy var detalhesView: UIView = {
        let detalhesView = UIView()
        let lightGray = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1.0)
        detalhesView.backgroundColor = lightGray
        detalhesView.layer.cornerRadius = 20.0
        detalhesView.layer.borderWidth = 2.0
        detalhesView.layer.borderColor = UIColor(red: 0.0, green: 1.0, blue: 0.0, alpha: 0.5).cgColor
        detalhesView.translatesAutoresizingMaskIntoConstraints = false
        return detalhesView
    }()
    
    private lazy var enderecoLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica", size: 14)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var numeroLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica", size: 14)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var bairroLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica", size: 14)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var cepLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica", size: 14)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var telefoneLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica", size: 14)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var vacinandoLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica", size: 18)
        label.text = "Vacina Disponível"
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = UIColor(red: 0.0, green: 1.0, blue: 0.0, alpha: 0.5)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var deletarButton: UIButton = {
        let button = UIButton()
        button.setTitle("Deletar", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = UIColor(red: 0.6, green: 0.8, blue: 0.9, alpha: 1.2)
        button.layer.cornerRadius = 20.0
        button.titleLabel?.font = UIFont(name: "Helvetica", size: 16)
        button.tintColor = .gray
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 40))
        button.addSubview(paddingView)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(deletar), for: .touchUpInside)
        return button
    }()
    
    lazy var mapView: MKMapView = {
        let map = MKMapView()
        map.showsUserLocation = true
        map.layer.cornerRadius = 20.0
        map.layer.borderColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5).cgColor
        map.translatesAutoresizingMaskIntoConstraints = false
        return map
    }()
    
    init(detalhesPosto: EstabelecimentoVacinando) {
        self.detalhesPosto = detalhesPosto
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        
        locationManager?.requestWhenInUseAuthorization()
        locationManager?.requestAlwaysAuthorization()
        locationManager?.startUpdatingLocation()
        
        setupView()
        updateScreen()
    }
    
    func setupMap() {
        mapView.delegate = self
        mapView.showsUserLocation = true
        mapView.mapType = .standard

        // Obter a localização atual do dispositivo
        if (locationManager?.location?.coordinate) != nil {

            // Configurar a segunda coordenada (exemplo)
            let coordenadaLocal2 = CLLocationCoordinate2D(latitude: detalhesPosto.latitude_estabelecimento_decimo_grau, longitude: detalhesPosto.longitude_estabelecimento_decimo_grau)

            let annotation2 = MKPointAnnotation()
            annotation2.coordinate = coordenadaLocal2
            annotation2.title = "Local 2"

            // Adicione os objetos MKPointAnnotation ao mapa
            mapView.addAnnotations([annotation2])

            // Calcular a região com base nas coordenadas e na distância desejada
            let region = mapView.regionThatFits(region(for: [coordenadaLocal2], distance: 5000))
            mapView.setRegion(region, animated: true)
        }
    }

    func addAnnotations(_ coordinates: CLLocationCoordinate2D...) {
        for (index, coordinate) in coordinates.enumerated() {
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            annotation.title = "Local \(index + 1)"
            mapView.addAnnotation(annotation)
        }
    }

    func region(for coordinates: [CLLocationCoordinate2D], distance: CLLocationDistance) -> MKCoordinateRegion {
        var minLat = coordinates[0].latitude
        var maxLat = coordinates[0].latitude
        var minLon = coordinates[0].longitude
        var maxLon = coordinates[0].longitude
        
        for coordinate in coordinates {
            minLat = min(minLat, coordinate.latitude)
            maxLat = max(maxLat, coordinate.latitude)
            minLon = min(minLon, coordinate.longitude)
            maxLon = max(maxLon, coordinate.longitude)
        }
        
        // Calcula o centro das coordenadas
        let center = CLLocationCoordinate2D(latitude: (minLat + maxLat) / 2, longitude: (minLon + maxLon) / 2)
        
        // Calcula a exibição (span) com base na distância desejada
        let region = MKCoordinateRegion(
            center: center,
            latitudinalMeters: distance,
            longitudinalMeters: distance
        )
        
        return region
    }
    
    @objc func deletar() {
        viewModel.deleteEstabelecimento(id: self.detalhesPosto.nome_fantasia, idMobile: self.detalhesPosto.id_mobilde)
        coordinator?.navigate(to: .postosVacinandoKill, data: nil)
    }
    
    func updateScreen() {
        DispatchQueue.main.async{[ weak self] in
            self?.titleLabel.text = self?.detalhesPosto.nome_fantasia
            self?.enderecoLabel.text = "Endereço: \(self?.detalhesPosto.endereco_estabelecimento ?? "")"
            self?.numeroLabel.text = "Número: \(self?.detalhesPosto.numero_estabelecimento ?? "")"
            self?.bairroLabel.text = "Bairro: \(self?.detalhesPosto.bairro_estabelecimento ?? "")"
            self?.cepLabel.text = "Cep: \(self?.detalhesPosto.codigo_cep_estabelecimento ?? "")"
            self?.telefoneLabel.text = "Telefone: \(self?.detalhesPosto.numero_telefone_estabelecimento ?? "")"
        }
        titleLabel.text = detalhesPosto.nome_fantasia
    }
    
}

extension PostoVacinandoDetalhesViewController: DetalhesVacinandoViewDelegate {
    func presentError() {
        let alert = UIAlertController(title: "Atenção", message: "Você não pode deletar pontos não criados por você", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func presentSuccess() {
        let alert = UIAlertController(title: "Atenção", message: "Dados do posto deletados com sucesso", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
}

extension PostoVacinandoDetalhesViewController: CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        setupMap()
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

extension PostoVacinandoDetalhesViewController: ViewCoding {
    
    func buildViewHerarchy() {
        view.addSubview(imageView)
        view.addSubview(bodyView)
        bodyView.addSubview(scrollView)
        scrollView.addSubview(stackView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(mapaView)
        mapaView.addSubview(mapView)
        stackView.addArrangedSubview(detalhesView)
        detalhesView.addSubview(enderecoLabel)
        detalhesView.addSubview(numeroLabel)
        detalhesView.addSubview(bairroLabel)
        detalhesView.addSubview(cepLabel)
        detalhesView.addSubview(telefoneLabel)
        detalhesView.addSubview(vacinandoLabel)
        bodyView.addSubview(deletarButton)
    }
    
    func setupContraints() {
        
        NSLayoutConstraint.activate([
            
            imageView.heightAnchor.constraint(equalToConstant: 280),
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            bodyView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -30),
            bodyView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bodyView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bodyView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            scrollView.topAnchor.constraint(equalTo: bodyView.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: bodyView.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: bodyView.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: deletarButton.topAnchor, constant: -5),

            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20),
            
            titleLabel.topAnchor.constraint(equalTo: bodyView.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: bodyView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: bodyView.trailingAnchor, constant: -20),
            
            mapaView.heightAnchor.constraint(equalToConstant: 175),
            mapaView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            mapaView.leadingAnchor.constraint(equalTo: bodyView.leadingAnchor, constant: 8),
            mapaView.trailingAnchor.constraint(equalTo: bodyView.trailingAnchor, constant: -8),
            
            mapView.widthAnchor.constraint(equalTo: mapaView.widthAnchor),
            mapView.heightAnchor.constraint(equalTo: mapaView.heightAnchor),
            mapView.centerXAnchor.constraint(equalTo: mapaView.centerXAnchor),
            mapView.centerYAnchor.constraint(equalTo: mapaView.centerYAnchor),
            
            detalhesView.heightAnchor.constraint(equalToConstant: 150),
            detalhesView.topAnchor.constraint(equalTo: mapaView.bottomAnchor, constant: 8),
            detalhesView.leadingAnchor.constraint(equalTo: bodyView.leadingAnchor, constant: 8),
            detalhesView.trailingAnchor.constraint(equalTo: bodyView.trailingAnchor, constant: -8),
            
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
            
            vacinandoLabel.bottomAnchor.constraint(equalTo: detalhesView.bottomAnchor, constant: -6),
            vacinandoLabel.trailingAnchor.constraint(equalTo: detalhesView.trailingAnchor, constant: -12),
            
            deletarButton.heightAnchor.constraint(equalToConstant: 50),
            deletarButton.bottomAnchor.constraint(equalTo: bodyView.bottomAnchor, constant: -20),
            deletarButton.leadingAnchor.constraint(equalTo: bodyView.leadingAnchor, constant: 16),
            deletarButton.trailingAnchor.constraint(equalTo: bodyView.trailingAnchor, constant: -16),
            
            ])
        
    }
    
    
}

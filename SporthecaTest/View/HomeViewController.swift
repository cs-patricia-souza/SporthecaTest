//
//  HomeView.swift
//  SporthecaTest
//
//  Created by Patricia Cintia de Souza on 23/11/22.
//

import Foundation
import UIKit
import Kingfisher

class HomeViewController: UIViewController {
    // MARK: Variables
    let defaultPlayerImageURLPath = "https://cdn-icons-png.flaticon.com/512/3333/3333673.png"
    var homeViewModel = HomeViewModel()
    
    // MARK: Layout
    lazy var background: UIImageView = {
        let imageView = UIImageView()
        imageView.widthAnchor.constraint(equalToConstant: view.frame.height/2).isActive = true
        imageView.image = UIImage(named: "world-cup")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.tintColor = ConstantColors.redSportheca
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.alpha = 0.5
        return imageView
    }()
    
    lazy var playerPicture: UIImageView = {
        let imageView = UIImageView()
        imageView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        imageView.contentMode = .scaleAspectFit
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.cornerRadius = 40
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var playerNameLabel: UILabel = {
        let label = UILabel()
        label.heightAnchor.constraint(equalToConstant: 30).isActive = true
        label.textColor = .white
        label.backgroundColor = .clear
        label.isUserInteractionEnabled = false
        label.font = UIFont(name: "OpenSans-Bold", size: 18)
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var playerCountry: UILabel = {
        let label = UILabel()
        label.heightAnchor.constraint(equalToConstant: 20).isActive = true
        label.textColor = .white
        label.backgroundColor = .clear
        label.isUserInteractionEnabled = false
        label.font = UIFont(name: "OpenSans-Medium", size: 14)
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var playerPosition: UILabel = {
        let label = UILabel()
        label.heightAnchor.constraint(equalToConstant: 20).isActive = true
        label.textColor = .white
        label.backgroundColor = .clear
        label.isUserInteractionEnabled = false
        label.font = UIFont(name: "OpenSans-Medium", size: 14)
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    lazy var playerScore: UILabel = {
        let label = UILabel()
        label.widthAnchor.constraint(equalToConstant: 80).isActive = true
        label.heightAnchor.constraint(equalToConstant: 80).isActive = true
        label.textColor = ConstantColors.purpleSportheca
        label.backgroundColor = .white.withAlphaComponent(0.5)
        label.isUserInteractionEnabled = false
        label.font = UIFont(name: "OpenSans-ExtraBold", size: 14)
        label.numberOfLines = 1
        label.layer.cornerRadius = 40
        label.layer.masksToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        
        return label
    }()
    
    lazy var worldCupsWonView: WorldCupProgressView = {
        let progress = WorldCupProgressView()
        progress.heightAnchor.constraint(equalToConstant: 80).isActive = true
        progress.translatesAutoresizingMaskIntoConstraints = false
        progress.backgroundColor = .clear
        return progress
    }()
    
    lazy var worldCupsDisputedView: WorldCupProgressView = {
        let progress = WorldCupProgressView()
        progress.heightAnchor.constraint(equalToConstant: 80).isActive = true
        progress.translatesAutoresizingMaskIntoConstraints = false
        progress.backgroundColor = .clear
        return progress
    }()
    
    // MARK: View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        homeViewModel.configure(self, viewModelProtocol: self)
        setupViews()
        fetchInfo()
    }
    
    // MARK: Setup View
    private func setupViews() {
        view.backgroundColor = ConstantColors.darkPurpleSportheca
        
        view.addSubview(background)
        view.addSubview(playerPicture)
        view.addSubview(playerNameLabel)
        view.addSubview(playerCountry)
        view.addSubview(playerPosition)
        view.addSubview(playerScore)
        view.addSubview(worldCupsWonView)
        view.addSubview(worldCupsDisputedView)
        
        NSLayoutConstraint.activate([
            background.topAnchor.constraint(equalTo: view.topAnchor),
            background.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            background.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -(view.frame.width/2)),
            
            playerPicture.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            playerPicture.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            playerNameLabel.topAnchor.constraint(equalTo: playerPicture.bottomAnchor, constant: 10),
            playerNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            playerCountry.topAnchor.constraint(equalTo: playerNameLabel.bottomAnchor, constant: 30),
            playerCountry.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            playerPosition.topAnchor.constraint(equalTo: playerCountry.bottomAnchor, constant: 10),
            playerPosition.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            playerScore.topAnchor.constraint(equalTo: playerPosition.bottomAnchor, constant: 10),
            playerScore.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            worldCupsWonView.topAnchor.constraint(equalTo: playerScore.bottomAnchor, constant: 100),
            worldCupsWonView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            worldCupsWonView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -100),
            
            worldCupsDisputedView.topAnchor.constraint(equalTo: worldCupsWonView.bottomAnchor, constant: 10),
            worldCupsDisputedView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            worldCupsDisputedView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -100)
        ])
    }
    
    private func fetchInfo() {
        self.homeViewModel.fetchPlayerInfo { [weak self] _ in
            DispatchQueue.main.async {
                self?.updateUI()
            }
        }
    }
                                      
    private func updateUI() {
        let player = homeViewModel.response.object?.first?.player
        
        let url = URL(string: player?.img ?? defaultPlayerImageURLPath)
        self.playerPicture.kf.setImage(with: url)
        self.playerNameLabel.text = player?.name ?? "Jon"
        self.playerCountry.text = player?.country ?? "Nowhere"
        self.playerPosition.text = player?.pos ?? "Fan"
        self.playerScore.text = "\(Double(round(1000 * (player?.percentual ?? 0.0)) / 1000))"
        
        if let copasDoMundoVencidas = player?.barras.copasDoMundoVencidas {
            worldCupsWonView.params = WorldCupProgressViewParams(max: copasDoMundoVencidas.max,
                                                                 pla: copasDoMundoVencidas.pla,
                                                                 pos: copasDoMundoVencidas.pos,
                                                                 title: "Copas do Mundo Vencidas")
            worldCupsWonView.fillProgressView()
        }
        
        if let copasDoMundoDisputadas = player?.barras.copasDoMundoDisputadas {
            worldCupsDisputedView.params = WorldCupProgressViewParams(max: copasDoMundoDisputadas.max,
                                                                 pla: copasDoMundoDisputadas.pla,
                                                                 pos: copasDoMundoDisputadas.pos,
                                                                 title: "Copas do Mundo Disputadas")
            worldCupsDisputedView.fillProgressView()
        }
        self.view.layoutIfNeeded()
    }
}

extension HomeViewController: HomeViewModelProtocol {
    func showError() {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Oops",
                                          message: "Não foi possível carregar os dados.",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {_ in }))
            self.present(alert, animated: true, completion: nil)
        }
    }
}

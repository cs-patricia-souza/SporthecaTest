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
        return imageView
    }()
    
    lazy var playerPicture: UIImageView = {
        let imageView = UIImageView()
        imageView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        imageView.contentMode = .scaleAspectFit
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.cornerRadius = 30
        imageView.clipsToBounds = true
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
        
        return label
    }()
    
    lazy var worldCupsWonTitle: UILabel = {
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
    
    lazy var worldCupsProgress: WorldCupProgressView = {
        let progress = WorldCupProgressView()
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
        
        NSLayoutConstraint.activate([
            background.topAnchor.constraint(equalTo: view.topAnchor),
            background.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            background.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -(view.frame.width/2)),
            
            playerPicture.topAnchor.constraint(equalTo: view.topAnchor, constant: 90),
            playerPicture.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            playerNameLabel.topAnchor.constraint(equalTo: playerPicture.bottomAnchor, constant: 10),
            playerNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            playerCountry.topAnchor.constraint(equalTo: playerNameLabel.bottomAnchor, constant: 10),
            playerCountry.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            playerPosition.topAnchor.constraint(equalTo: playerCountry.bottomAnchor, constant: 10),
            playerPosition.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            playerScore.topAnchor.constraint(equalTo: playerPosition.bottomAnchor, constant: 10),
            playerScore.centerXAnchor.constraint(equalTo: view.centerXAnchor)
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
        let player = homeViewModel.response.object?.first
        
        let url = URL(string: player?.img ?? defaultPlayerImageURLPath)
        self.playerPicture.kf.setImage(with: url)
        self.playerNameLabel.text = player?.name ?? "Jon"
        self.playerCountry.text = player?.country ?? "Nowhere"
        self.playerPosition.text = player?.pos ?? "Fan"
        self.playerScore.text = "\(player?.percentual ?? 0.0)"
        
        if let statistics = player?.barras {
            for statistic in statistics.array.enumerated() {
                addStatistcOnView(statistic.element)
            }
        }
    }
    
    private func addStatistcOnView(_ statistic: BarrasItem) {
        setupStatisticView()
        
        worldCupsWonTitle.text = statistic.itemName
        
        worldCupsProgress.params = WorldCupProgressViewParams(max: statistic.max,
                                                              pla: statistic.pla,
                                                              pos: statistic.pos)
        worldCupsProgress.fillProgressView()
    }
    
    private func setupStatisticView() {
        view.addSubview(worldCupsWonTitle)
        view.addSubview(worldCupsProgress)
        
        NSLayoutConstraint.activate([
            worldCupsWonTitle.topAnchor.constraint(equalTo: playerScore.bottomAnchor, constant: 10),
            worldCupsWonTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            
            worldCupsProgress.topAnchor.constraint(equalTo: worldCupsWonTitle.bottomAnchor, constant: 10),
            worldCupsProgress.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
        
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

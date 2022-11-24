//
//  HomeView.swift
//  SporthecaTest
//
//  Created by Patricia Cintia de Souza on 23/11/22.
//

import Foundation
import UIKit

class HomeViewController: UIViewController {
    // MARK: Variables
    let flagURLPath = "https://countryflagsapi.com/png/"
    
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
        setupViews()
        configureProgress()
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
    
    private func configureProgress() {
        worldCupsProgress.params = WorldCupProgressViewParams(max: 3, pla: 1, pos: 18)
        worldCupsProgress.fillProgressView()
    }
}

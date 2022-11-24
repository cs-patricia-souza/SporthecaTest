//
//  WorldCupProgressView.swift
//  SporthecaTest
//
//  Created by Patricia Cintia de Souza on 24/11/22.
//

import Foundation
import UIKit

struct WorldCupProgressViewParams {
    let max: Int
    let pla: Int
    let pos: Int
    let title: String
}

@IBDesignable
class WorldCupProgressView: UIView {
    
    var params: WorldCupProgressViewParams!
    
    @IBInspectable var barHeight: CGFloat = 18.0 {
        didSet {
            self.setLayout()
        }
    }
    
    @IBInspectable var barCornerRadius: CGFloat = 9.0 {
        didSet {
            self.progressView.layer.cornerRadius = barCornerRadius
        }
    }
    
    @IBInspectable var barBackgroundColor: UIColor = .clear
    @IBInspectable var barForegroundColor: UIColor = ConstantColors.redSportheca
    
    lazy var progressTitle: UILabel = {
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
    
    private lazy var insideLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "OpenSans-Regular", size: 4)
        label.textColor = .white
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var outsideLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "OpenSans-Regular", size: 14)
        label.textColor = .white
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var progressView: UIProgressView = {
        let progressView = UIProgressView()
        progressView.translatesAutoresizingMaskIntoConstraints = false
        progressView.trackTintColor = self.barBackgroundColor
        progressView.progressTintColor = self.barForegroundColor
        progressView.layer.cornerRadius = self.barCornerRadius
        progressView.layer.borderWidth = 1
        progressView.layer.borderColor = UIColor.white.cgColor
        progressView.clipsToBounds = true
        progressView.isUserInteractionEnabled = true
        return progressView
    }()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupView()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    private func setupView() {
        self.barBackgroundColor = .clear
        
        self.addSubview(self.progressTitle)
        self.addSubview(self.progressView)
        self.addSubview(self.outsideLabel)
        self.progressView.addSubview(self.insideLabel)
        
        self.setupConstraints()
        self.setLayout()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            self.progressTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            self.progressTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 10),
            
            self.progressView.topAnchor.constraint(equalTo: progressTitle.bottomAnchor, constant: 10),
            self.progressView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            self.progressView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 10),
            
            self.insideLabel.leadingAnchor.constraint(equalTo: progressView.leadingAnchor, constant: 20),
            self.insideLabel.centerYAnchor.constraint(equalTo: progressView.centerYAnchor),
            
            self.outsideLabel.leadingAnchor.constraint(equalTo: progressView.trailingAnchor, constant: 5),
            self.outsideLabel.centerYAnchor.constraint(equalTo: self.progressView.centerYAnchor)
        ])
    }
    
    private func setLayout() {
        self.progressView.heightAnchor.constraint(equalToConstant: self.barHeight).isActive = true
        self.progressView.widthAnchor.constraint(equalToConstant: self.frame.width/4).isActive = true
    }
    
    func fillProgressView() {
        self.progressView.setProgress(Float(Float(params.pla) / Float(params.max)), animated: true)
        self.insideLabel.text = "\(Double(params.pla))"
        self.outsideLabel.text = "\(params.pos)º"
        self.progressTitle.text = params.title
        
        self.progressView.setNeedsLayout()
        self.progressView.layoutIfNeeded()
    }
}

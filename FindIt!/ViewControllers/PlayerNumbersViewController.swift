//
//  PlayerNumbersViewController.swift
//  FindIt!
//
//  Created by Christos Petrou on 05/03/2019.
//  Copyright © 2019 Christos Petrou. All rights reserved.
//

import UIKit
import DLRadioButton
import AVFoundation

class PlayerNumbersViewController: UIViewController {
    
    var radioButtonsArray: [DLRadioButton] = []
    private let backbuttonSize: CGFloat = 30
    var player: AVAudioPlayer?
    var language: Language = .Greek
    
    lazy var backButton: UIButton = {
        var back = UIButton()
        back.setTitle("←", for: .normal)
        back.backgroundColor = .FindOrange
        back.setTitleColor(.white, for: .normal)
        back.layer.cornerRadius = backbuttonSize * 0.5
        back.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 1)
        back.addTarget(self, action: #selector(goBackAction), for: .touchUpInside)
        back.translatesAutoresizingMaskIntoConstraints = false
        
        return back
    }()
    
    lazy var playersTitleLabel: UILabel = {
        var title = UILabel()
        if language == .Greek {
            title.text = "ΠΑΙΚΤΕΣ"
        } else {
            title.text = "PLAYERS"
        }
        title.font = UIFont.systemFont(ofSize: 30, weight: UIFont.Weight.bold)
        title.textColor = .white
        title.textAlignment = .center
        title.translatesAutoresizingMaskIntoConstraints = false
        
        return title
    }()
    
    let nextButton: UIButton = {
        var button = UIButton()
        button.setImage(UIImage(named: "nextIcon"), for: .normal)
        button.imageView!.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(goToNextPage), for: .touchUpInside)
        
        return button
    }()
    
    let radioButtonVerticalStackview: UIStackView = {
        var horizontalStackView = UIStackView()
        
        horizontalStackView.axis = .vertical
        horizontalStackView.distribution = .equalSpacing
        horizontalStackView.alignment = .center
        horizontalStackView.spacing = 2
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        
        return horizontalStackView
    }()
    
    lazy var twoPlayersRadioButton: DLRadioButton = {
        var radioButton = DLRadioButton()
        if language == .Greek {
            radioButton.setTitle("2 Παίκτες", for: .normal)
        } else {
            radioButton.setTitle("2 Players", for: .normal)
        }
        radioButton.setTitleColor(.FindOrange, for: .normal)
        radioButton.iconColor = .FindOrange
        radioButton.indicatorColor = .FindOrange
        radioButton.contentHorizontalAlignment = .center
        radioButton.iconSize = 30
        radioButton.isSelected = true
        radioButton.translatesAutoresizingMaskIntoConstraints = false
        
        return radioButton
    }()
    
    lazy var threePlayersRadioButton: DLRadioButton = {
        var radioButton = DLRadioButton()
        if language == .Greek {
            radioButton.setTitle("3 Παίκτες", for: .normal)
        } else {
            radioButton.setTitle("3 Players", for: .normal)
        }
        radioButton.setTitleColor(.FindOrange, for: .normal)
        radioButton.iconColor = .FindOrange
        radioButton.indicatorColor = .FindOrange
        radioButton.contentHorizontalAlignment = .center
        radioButton.iconSize = 30
        radioButton.translatesAutoresizingMaskIntoConstraints = false
        
        return radioButton
    }()
    
    lazy var fourPlayersRadioButton: DLRadioButton = {
        var radioButton = DLRadioButton()
        if language == .Greek {
            radioButton.setTitle("4 Παίκτες", for: .normal)
        } else {
            radioButton.setTitle("4 Players", for: .normal)
        }
        radioButton.setTitleColor(.FindOrange, for: .normal)
        radioButton.iconColor = .FindOrange
        radioButton.indicatorColor = .FindOrange
        radioButton.contentHorizontalAlignment = .center
        radioButton.iconSize = 30
        radioButton.translatesAutoresizingMaskIntoConstraints = false
        
        return radioButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .FindBlue
        setupBackButton()
        setupPlayersTitleLabel()
        setupRadioButtonVerticalStackView()
        setupRadioButtons()
        setupNextButton()
    }
    
    func setupBackButton() {
        view.addSubview(backButton)
        
        backButton.topAnchor.constraint(lessThanOrEqualToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 5).isActive = true
        backButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        backButton.widthAnchor.constraint(equalToConstant: backbuttonSize).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: backbuttonSize).isActive = true
    }
    
    func setupPlayersTitleLabel() {
        view.addSubview(playersTitleLabel)
        
        playersTitleLabel.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 5).isActive = true
        playersTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    func setupNextButton() {
        view.addSubview(nextButton)
        
        nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        nextButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        nextButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    func setupRadioButtonVerticalStackView() {
        view.addSubview(radioButtonVerticalStackview)
        
        radioButtonVerticalStackview.topAnchor.constraint(equalTo: playersTitleLabel.bottomAnchor, constant: 20).isActive = true
        radioButtonVerticalStackview.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    func setupRadioButtons() {
        
        radioButtonsArray.append(threePlayersRadioButton)
        radioButtonsArray.append(fourPlayersRadioButton)
        twoPlayersRadioButton.otherButtons = radioButtonsArray
        
        radioButtonVerticalStackview.addArrangedSubview(twoPlayersRadioButton)
        radioButtonVerticalStackview.addArrangedSubview(threePlayersRadioButton)
        radioButtonVerticalStackview.addArrangedSubview(fourPlayersRadioButton)
        
        twoPlayersRadioButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
        threePlayersRadioButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
        fourPlayersRadioButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
    }
}

extension PlayerNumbersViewController {
    @objc func goBackAction() {
        self.setupSound(soundFile: "backClick")?.play()
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func goToNextPage() {
        self.setupSound(soundFile: "click")?.play()
        let newViewController = PlayerNamesViewController()
        
        if language == .Greek {
            newViewController.language = .Greek
            
            switch twoPlayersRadioButton.selected()?.titleLabel?.text {
            case "2 Παίκτες":
                newViewController.playersNumber = 2
                break
            case "3 Παίκτες":
                newViewController.playersNumber = 3
                break
            case "4 Παίκτες":
                newViewController.playersNumber = 4
                break
            default:
                newViewController.playersNumber = 2
                break
            }
        } else {
            newViewController.language = .English
            
            switch twoPlayersRadioButton.selected()?.titleLabel?.text {
            case "2 Players":
                newViewController.playersNumber = 2
                break
            case "3 Players":
                newViewController.playersNumber = 3
                break
            case "4 Players":
                newViewController.playersNumber = 4
                break
            default:
                newViewController.playersNumber = 2
                break
            }
        }
        self.present(newViewController, animated: true, completion: nil)
    }
    
    func setupSound(soundFile: String) -> AVAudioPlayer?{
        if let asset = NSDataAsset(name: soundFile){
            do {
                try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
                try AVAudioSession.sharedInstance().setActive(true)
                
                player = try AVAudioPlayer(data: asset.data, fileTypeHint: AVFileType.mp3.rawValue)
                
                if let player = player {
                    player.play()
                    return player
                }
                
            } catch let error {
                print(error.localizedDescription)
            }
        }
        return player
    }
}

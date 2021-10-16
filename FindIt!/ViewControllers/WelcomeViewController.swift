//
//  WelcomeViewController.swift
//  FindIt!
//
//  Created by Christos Petrou on 05/03/2019.
//  Copyright © 2019 Christos Petrou. All rights reserved.
//

import UIKit
import AVFoundation

class WelcomeViewController: UIViewController {

    var player: AVAudioPlayer?
    var language: Language = .Greek
    
    lazy var welcomeLabel: UILabel = {
        let label = UILabel()
        if language == .Greek {
            label.text = "Καλωσορίσατε στο Βρές Το!"
        } else {
            label.text = "Welcome to Vres To!"
        }
        label.font = UIFont.systemFont(ofSize: 30, weight: UIFont.Weight.bold)
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let helpButton: UIButton = {
        let help = UIButton()
        help.setImage(UIImage(named: "helpIcon"), for: .normal)
        help.imageView!.contentMode = .scaleAspectFit
        help.translatesAutoresizingMaskIntoConstraints = false
        help.addTarget(self, action: #selector(readInstructions), for: .touchUpInside)
        
        return help
    }()
    
    let playButton: UIButton = {
        let play = UIButton()
        play.setImage(UIImage(named: "playIcon"), for: .normal)
        play.imageView!.contentMode = .scaleAspectFit
        play.translatesAutoresizingMaskIntoConstraints = false
        play.addTarget(self, action: #selector(playGame), for: .touchUpInside)
        
        return play
    }()
    
    lazy var playLabel: UILabel = {
        let label = UILabel()
        if language == .Greek {
            label.text = "Παίξε"
        } else {
            label.text = "Play"
        }
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.sizeToFit()
        
        return label
    }()
    
    lazy var helpLabel: UILabel = {
        let label = UILabel()
        if language == .Greek {
            label.text = "Οδηγίες"
        } else {
            label.text = "Read Instructions"
        }
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.sizeToFit()
        
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .FindBlue
        setupWelcomeLabel()
        setupHelpButton()
        setupPlayButton()
        setupHelpLabel()
        setupPlayLabel()
    }
    
    func setupWelcomeLabel() {
        view.addSubview(welcomeLabel)
        
        welcomeLabel.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 10).isActive = true
        welcomeLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 5).isActive = true
        welcomeLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 5).isActive = true
    }
    
    func setupHelpButton() {
        view.addSubview(helpButton)
        
        helpButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        helpButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -50).isActive = true
        helpButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        helpButton.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    func setupPlayButton() {
        view.addSubview(playButton)
        
        playButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        playButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50).isActive = true
        playButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        playButton.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    func setupHelpLabel() {
        view.addSubview(helpLabel)
        
        helpLabel.topAnchor.constraint(equalTo: helpButton.bottomAnchor, constant: 5).isActive = true
        helpLabel.centerXAnchor.constraint(equalTo: helpButton.centerXAnchor).isActive = true
    }
    
    func setupPlayLabel() {
        view.addSubview(playLabel)
        
        playLabel.topAnchor.constraint(equalTo: playButton.bottomAnchor, constant: 5).isActive = true
        playLabel.centerXAnchor.constraint(equalTo: playButton.centerXAnchor).isActive = true
    }
}

extension WelcomeViewController {
    @objc func readInstructions() {
        self.setupSound(soundFile: "click")?.play()
        let newViewController = InstructionsViewController()
        if language == .Greek {
            newViewController.language = .Greek
        } else {
            newViewController.language = .English
        }
        self.present(newViewController, animated: true, completion: nil)
    }
    
    @objc func playGame() {
        self.setupSound(soundFile: "click")?.play()
        let newViewController = PlayerNumbersViewController()
        if language == .Greek {
            newViewController.language = .Greek
        } else {
            newViewController.language = .English
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

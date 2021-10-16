//
//  InstructionsViewController.swift
//  FindIt!
//
//  Created by Christos Petrou on 05/03/2019.
//  Copyright © 2019 Christos Petrou. All rights reserved.
//

import UIKit
import AVFoundation

class InstructionsViewController: UIViewController {
    
    private let backbuttonSize: CGFloat = 30
    var player: AVAudioPlayer?
    var language: Language = .Greek
    
    lazy var backButton: UIButton = {
        var back = UIButton()
        back.setTitle("x", for: .normal)
        back.backgroundColor = .FindOrange
        back.setTitleColor(.white, for: .normal)
        back.layer.cornerRadius = backbuttonSize * 0.5
        back.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 1, right: 1)
        back.addTarget(self, action: #selector(goBackAction), for: .touchUpInside)
        back.translatesAutoresizingMaskIntoConstraints = false
        
        return back
    }()
    
    lazy var rulesTitleLabel: UILabel = {
        var title = UILabel()
        if language == .Greek {
            title.text = "ΚΑΝΟΝΕΣ"
        } else {
            title.text = "RULES"
        }
        title.font = UIFont.systemFont(ofSize: 30, weight: UIFont.Weight.bold)
        title.textColor = .white
        title.textAlignment = .center
        title.translatesAutoresizingMaskIntoConstraints = false
        
        return title
    }()
    
    lazy var instructionsLabel: UILabel = {
        var instructions = UILabel()
        if language == .Greek {
            instructions.text = "Σου λέει μία κατηγορία και ένα γράμμα, και από αυτό πρέπει να σκεφτείς μία λέξη. Όποιος πατήσει πιο γρήγορα το κουμπί, λέει αυτό που σκέφτηκε. Αν συμφωνούν οι άλλοι/ος παίκτες/ης, παίρνεις τον πόντο. Όποιος έχει τους περισσότερους πόντους στο τέλος του παιχνιδιού, κερδίζει."
        } else {
            instructions.text = "You are given a category and a letter, and from that you must think of a word. Whoever presses the buzzer faster, says what he/she thought. If the other players agree with the word, you get the point. Whoever has the most points until the end of the game wins."
        }
        instructions.numberOfLines = 0
        instructions.textColor = .white
        instructions.backgroundColor = UIColor(red: 00, green: 00, blue: 00, a: 0.2)
        instructions.textAlignment = .center
        instructions.translatesAutoresizingMaskIntoConstraints = false
        
        return instructions
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .FindBlue
        setupBackButton()
        setupRulesTitleLabel()
        setupInstructionsLabel()
    }
    
    func setupBackButton() {
        view.addSubview(backButton)
        
        backButton.topAnchor.constraint(lessThanOrEqualToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 10).isActive = true
        backButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        backButton.widthAnchor.constraint(equalToConstant: backbuttonSize).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: backbuttonSize).isActive = true
    }
    
    func setupRulesTitleLabel() {
        view.addSubview(rulesTitleLabel)
        
        rulesTitleLabel.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 10).isActive = true
        rulesTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    func setupInstructionsLabel() {
        view.addSubview(instructionsLabel)
        
        instructionsLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        instructionsLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        instructionsLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
    }
}

extension InstructionsViewController {
    @objc func goBackAction() {
        self.setupSound(soundFile: "backClick")?.play()
        self.dismiss(animated: true, completion: nil)
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

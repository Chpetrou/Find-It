//
//  LanguageViewController.swift
//  FindIt!
//
//  Created by Christos Petrou on 04/03/2019.
//  Copyright © 2019 Christos Petrou. All rights reserved.
//

import UIKit
import DropDown
import AVFoundation

class LanguageViewController: UIViewController {
    
    var player: AVAudioPlayer?
    
    let chooseLanguageButton: UIButton = {
        var button = UIButton()
        button.setImage(UIImage(named: "globeIcon"), for: .normal)
        button.backgroundColor = .FindOrange
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 7
        button.imageView?.contentMode = .scaleAspectFit
        button.imageEdgeInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        button.addTarget(self, action: #selector(touchDropDownButton), for: .touchUpInside)
        
        return button
    }()
    
    lazy var languageDropDown: DropDown = {
        var language = DropDown()
        language.anchorView = chooseLanguageButton
        language.dataSource = ["Ελληνικά", "English"]
        language.direction = .bottom
        language.width = 150
        language.bottomOffset = CGPoint(x: 0, y:(language.anchorView?.plainView.bounds.height)!)
        
        language.selectionAction = { [unowned self] (index: Int, item: String) in
            let newViewController = WelcomeViewController()
            if index == 0 {
                self.setupSound(soundFile: "click")?.play()
                newViewController.language = .Greek
            } else if index == 1 {
                self.setupSound(soundFile: "click")?.play()
                newViewController.language = .English
            }
            self.present(newViewController, animated: true, completion: nil)
        }
        
        return language
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .FindBlue
        setupLanguageButton()
    }
    
    func setupLanguageButton() {
        view.addSubview(chooseLanguageButton)
        
        chooseLanguageButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        chooseLanguageButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        chooseLanguageButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
        chooseLanguageButton.heightAnchor.constraint(equalToConstant: 150).isActive = true
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

extension LanguageViewController {
    @objc func touchDropDownButton() {
        self.setupSound(soundFile: "click")?.play()
        languageDropDown.show()
    }
}

//
//  PlayerNamesViewController.swift
//  FindIt!
//
//  Created by Christos Petrou on 05/03/2019.
//  Copyright © 2019 Christos Petrou. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import AVFoundation

class PlayerNamesViewController: UIViewController {

    var playersNumber = 0
    var allTextFields: [SkyFloatingLabelTextField] = []
    private let backbuttonSize: CGFloat = 30
    private let buzzerbuttonSize: CGFloat = 30
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
    
    lazy var namesTitleLabel: UILabel = {
        var title = UILabel()
        if language == .Greek {
            title.text = "ΟΝΟΜΑΤΑ"
        } else {
            title.text = "NAMES"
        }
        title.font = UIFont.systemFont(ofSize: 30, weight: UIFont.Weight.bold)
        title.textColor = .white
        title.textAlignment = .center
        title.translatesAutoresizingMaskIntoConstraints = false
        
        return title
    }()
    
    lazy var firstPlayerColor: UIButton = {
        var button = UIButton()
        button.backgroundColor = .BlueBuzzerColor
        button.layer.cornerRadius = buzzerbuttonSize * 0.5
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var secondPlayerColor: UIButton = {
        var button = UIButton()
        button.backgroundColor = .RedBuzzerColor
        button.layer.cornerRadius = buzzerbuttonSize * 0.5
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var thirdPlayerColor: UIButton = {
        var button = UIButton()
        button.backgroundColor = .YellowBuzzerColor
        button.layer.cornerRadius = buzzerbuttonSize * 0.5
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var fourthPlayerColor: UIButton = {
        var button = UIButton()
        button.backgroundColor = .GreenBuzzerColor
        button.layer.cornerRadius = buzzerbuttonSize * 0.5
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var firstPlayerTextfield: SkyFloatingLabelTextFieldWithIcon = {
        var textfield = SkyFloatingLabelTextFieldWithIcon()
        
        textfield.iconType = .font
        textfield.iconColor = .white
        textfield.iconFont = UIFont.systemFont(ofSize: 14)
        textfield.iconText = "1#"
        textfield.delegate = self;
        if language == .Greek {
            textfield.attributedPlaceholder = NSAttributedString(string: "Όνομα Παίκτη",
                                                                 attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        } else {
            textfield.attributedPlaceholder = NSAttributedString(string: "Player Name",
                                                             attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        }
        textfield.textColor = .white
        textfield.selectedTitleColor = .white
        textfield.selectedIconColor = .white
        textfield.lineColor = .white
        textfield.selectedLineColor = .white
        textfield.clearButtonMode = .unlessEditing
        textfield.textContentType = .username
        textfield.keyboardType  = .default
        textfield.returnKeyType = .next
        textfield.enablesReturnKeyAutomatically = true
//        textfield.tag = 0
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.sizeToFit()
        textfield.delegate = self
        
        return textfield
    }()
    
    lazy var secondPlayerTextfield: SkyFloatingLabelTextFieldWithIcon = {
        var textfield = SkyFloatingLabelTextFieldWithIcon()
        
        textfield.iconType = .font
        textfield.iconColor = .white
        textfield.iconFont = UIFont.systemFont(ofSize: 14)
        textfield.iconText = "2#"
        textfield.delegate = self;
        if language == .Greek {
            textfield.attributedPlaceholder = NSAttributedString(string: "Όνομα Παίκτη",
                                                                 attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        } else {
            textfield.attributedPlaceholder = NSAttributedString(string: "Player Name",
                                                             attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        }
        textfield.textColor = .white
        textfield.selectedTitleColor = .white
        textfield.selectedIconColor = .white
        textfield.lineColor = .white
        textfield.selectedLineColor = .white
        textfield.clearButtonMode = .unlessEditing
        textfield.textContentType = .username
        textfield.keyboardType  = .default
        textfield.returnKeyType = .next
        textfield.enablesReturnKeyAutomatically = true
//        textfield.tag = 1
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.sizeToFit()
        textfield.delegate = self
        
        return textfield
    }()
    
    lazy var thirdPlayerTextfield: SkyFloatingLabelTextFieldWithIcon = {
        var textfield = SkyFloatingLabelTextFieldWithIcon()
        
        textfield.iconType = .font
        textfield.iconColor = .white
        textfield.iconFont = UIFont.systemFont(ofSize: 14)
        textfield.iconText = "3#"
        textfield.delegate = self;
        if language == .Greek {
            textfield.attributedPlaceholder = NSAttributedString(string: "Όνομα Παίκτη",
                                                                 attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        } else {
            textfield.attributedPlaceholder = NSAttributedString(string: "Player Name",
                                                             attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        }
        textfield.textColor = .white
        textfield.selectedTitleColor = .white
        textfield.selectedIconColor = .white
        textfield.lineColor = .white
        textfield.selectedLineColor = .white
        textfield.clearButtonMode = .unlessEditing
        textfield.textContentType = .username
        textfield.keyboardType  = .default
        textfield.returnKeyType = .next
        textfield.enablesReturnKeyAutomatically = true
//        textfield.tag = 2
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.sizeToFit()
        textfield.delegate = self
        
        return textfield
    }()
    
    lazy var fourthPlayerTextfield: SkyFloatingLabelTextFieldWithIcon = {
        var textfield = SkyFloatingLabelTextFieldWithIcon()
        
        textfield.iconType = .font
        textfield.iconColor = .white
        textfield.iconFont = UIFont.systemFont(ofSize: 14)
        textfield.iconText = "4#"
        textfield.delegate = self;
        if language == .Greek {
            textfield.attributedPlaceholder = NSAttributedString(string: "Όνομα Παίκτη",
                                                                 attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        } else {
            textfield.attributedPlaceholder = NSAttributedString(string: "Player Name",
                                                             attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        }
        textfield.textColor = .white
        textfield.selectedTitleColor = .white
        textfield.selectedIconColor = .white
        textfield.lineColor = .white
        textfield.selectedLineColor = .white
        textfield.clearButtonMode = .unlessEditing
        textfield.textContentType = .username
        textfield.keyboardType  = .default
        textfield.returnKeyType = .next
        textfield.enablesReturnKeyAutomatically = true
//        textfield.tag = 3
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.sizeToFit()
        textfield.delegate = self
        
        return textfield
    }()
    
    let nextButton: UIButton = {
        var button = UIButton()
        button.setImage(UIImage(named: "nextIcon"), for: .normal)
        button.imageView!.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(goToNextPage), for: .touchUpInside)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .FindBlue
        
        hideKeyboardWhenTappedAround()
        
        setupBackButton()
        setupNamesTitleLabel()
        setupFirstPlayerTextfield()
        setupSecondPlayerTextfield()
        setupThirdPlayerTextfield()
        setupFourthPlayerTextfield()
        setupNextButton()
        setupDisplayedTextfields()
        setupBuzzerColors()
    }
    
    func setupBackButton() {
        view.addSubview(backButton)
        
        backButton.topAnchor.constraint(lessThanOrEqualToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 5).isActive = true
        backButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        backButton.widthAnchor.constraint(equalToConstant: backbuttonSize).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: backbuttonSize).isActive = true
    }
    
    func setupNamesTitleLabel() {
        view.addSubview(namesTitleLabel)
        
        namesTitleLabel.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 5).isActive = true
        namesTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    func setupBuzzerColors() {
        view.addSubview(firstPlayerColor)
        view.addSubview(secondPlayerColor)
        view.addSubview(thirdPlayerColor)
        view.addSubview(fourthPlayerColor)
        
        firstPlayerColor.trailingAnchor.constraint(equalTo: firstPlayerTextfield.leadingAnchor, constant: -20).isActive = true
        firstPlayerColor.topAnchor.constraint(equalTo: namesTitleLabel.bottomAnchor, constant: 30).isActive = true
        firstPlayerColor.widthAnchor.constraint(equalToConstant: buzzerbuttonSize).isActive = true
        firstPlayerColor.heightAnchor.constraint(equalToConstant: buzzerbuttonSize).isActive = true
        
        secondPlayerColor.trailingAnchor.constraint(equalTo: secondPlayerTextfield.leadingAnchor, constant: -20).isActive = true
        secondPlayerColor.topAnchor.constraint(equalTo: firstPlayerTextfield.bottomAnchor, constant: 30).isActive = true
        secondPlayerColor.widthAnchor.constraint(equalToConstant: buzzerbuttonSize).isActive = true
        secondPlayerColor.heightAnchor.constraint(equalToConstant: buzzerbuttonSize).isActive = true
        
        thirdPlayerColor.trailingAnchor.constraint(equalTo: thirdPlayerTextfield.leadingAnchor, constant: -20).isActive = true
        thirdPlayerColor.topAnchor.constraint(equalTo: secondPlayerTextfield.bottomAnchor, constant: 30).isActive = true
        thirdPlayerColor.widthAnchor.constraint(equalToConstant: buzzerbuttonSize).isActive = true
        thirdPlayerColor.heightAnchor.constraint(equalToConstant: buzzerbuttonSize).isActive = true
        
        fourthPlayerColor.trailingAnchor.constraint(equalTo: fourthPlayerTextfield.leadingAnchor, constant: -20).isActive = true
        fourthPlayerColor.topAnchor.constraint(equalTo: thirdPlayerTextfield.bottomAnchor, constant: 30).isActive = true
        fourthPlayerColor.widthAnchor.constraint(equalToConstant: buzzerbuttonSize).isActive = true
        fourthPlayerColor.heightAnchor.constraint(equalToConstant: buzzerbuttonSize).isActive = true
        
        switch playersNumber {
        case 2:
            firstPlayerColor.isHidden = false
            secondPlayerColor.isHidden = false
            thirdPlayerColor.isHidden = true
            fourthPlayerColor.isHidden = true
            break
        case 3:
            firstPlayerColor.isHidden = false
            secondPlayerColor.isHidden = false
            thirdPlayerColor.isHidden = false
            fourthPlayerColor.isHidden = true
            break
        case 4:
            firstPlayerColor.isHidden = false
            secondPlayerColor.isHidden = false
            thirdPlayerColor.isHidden = false
            fourthPlayerColor.isHidden = false
            break
        default:
            firstPlayerColor.isHidden = false
            secondPlayerColor.isHidden = false
            thirdPlayerColor.isHidden = true
            fourthPlayerColor.isHidden = true
            break
        }
    }
    
    func setupFirstPlayerTextfield() {
        view.addSubview(firstPlayerTextfield)
        
        firstPlayerTextfield.topAnchor.constraint(equalTo: namesTitleLabel.bottomAnchor, constant: 10).isActive = true
        firstPlayerTextfield.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    func setupSecondPlayerTextfield() {
        view.addSubview(secondPlayerTextfield)
        
        secondPlayerTextfield.topAnchor.constraint(equalTo: firstPlayerTextfield.bottomAnchor, constant: 10).isActive = true
        secondPlayerTextfield.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    func setupThirdPlayerTextfield() {
        view.addSubview(thirdPlayerTextfield)
        
        thirdPlayerTextfield.topAnchor.constraint(equalTo: secondPlayerTextfield.bottomAnchor, constant: 10).isActive = true
        thirdPlayerTextfield.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    func setupFourthPlayerTextfield() {
        view.addSubview(fourthPlayerTextfield)
        
        fourthPlayerTextfield.topAnchor.constraint(equalTo: thirdPlayerTextfield.bottomAnchor, constant: 10).isActive = true
        fourthPlayerTextfield.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    func setupNextButton() {
        view.addSubview(nextButton)
        
        nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        nextButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        nextButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    func setupDisplayedTextfields() {
        switch playersNumber {
        case 2:
            firstPlayerTextfield.isHidden = false
            secondPlayerTextfield.isHidden = false
            thirdPlayerTextfield.isHidden = true
            fourthPlayerTextfield.isHidden = true
            
            firstPlayerTextfield.delegate = self
            firstPlayerTextfield.tag = 0
            secondPlayerTextfield.delegate = self
            secondPlayerTextfield.tag = 1
            
            allTextFields = [firstPlayerTextfield, secondPlayerTextfield]
            secondPlayerTextfield.returnKeyType = .done
            break
        case 3:
            firstPlayerTextfield.isHidden = false
            secondPlayerTextfield.isHidden = false
            thirdPlayerTextfield.isHidden = false
            fourthPlayerTextfield.isHidden = true
            
            firstPlayerTextfield.delegate = self
            firstPlayerTextfield.tag = 0
            secondPlayerTextfield.delegate = self
            secondPlayerTextfield.tag = 1
            thirdPlayerTextfield.delegate = self
            thirdPlayerTextfield.tag = 2
            
            allTextFields = [firstPlayerTextfield, secondPlayerTextfield, thirdPlayerTextfield]
            thirdPlayerTextfield.returnKeyType = .done
            break
        case 4:
            firstPlayerTextfield.isHidden = false
            secondPlayerTextfield.isHidden = false
            thirdPlayerTextfield.isHidden = false
            fourthPlayerTextfield.isHidden = false
            
            firstPlayerTextfield.delegate = self
            firstPlayerTextfield.tag = 0
            secondPlayerTextfield.delegate = self
            secondPlayerTextfield.tag = 1
            thirdPlayerTextfield.delegate = self
            thirdPlayerTextfield.tag = 2
            fourthPlayerTextfield.delegate = self
            fourthPlayerTextfield.tag = 3
            
            allTextFields = [firstPlayerTextfield, secondPlayerTextfield, thirdPlayerTextfield, fourthPlayerTextfield]
            fourthPlayerTextfield.returnKeyType = .done
            break
        default:
            firstPlayerTextfield.isHidden = false
            secondPlayerTextfield.isHidden = false
            thirdPlayerTextfield.isHidden = true
            fourthPlayerTextfield.isHidden = true
            
            firstPlayerTextfield.delegate = self
            firstPlayerTextfield.tag = 0
            secondPlayerTextfield.delegate = self
            secondPlayerTextfield.tag = 1
            
            allTextFields = [firstPlayerTextfield, secondPlayerTextfield]
            secondPlayerTextfield.returnKeyType = .done
            break
        }
    }
}

extension PlayerNamesViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        _ = validateTextFieldsWithErrors(textField: textField)
        
        return true
    }
}

extension PlayerNamesViewController {
    @objc func goToNextPage() {
        self.setupSound(soundFile: "click")?.play()
        let isErrorFree = validateIfTextFieldsAreErrorLess()
        if isErrorFree {
            var playersArray: [Player]!
            let newViewController = MainGameViewController()
            switch playersNumber {
            case 2:
                playersArray = [Player(username: firstPlayerTextfield.text!), Player(username: secondPlayerTextfield.text!)]
                break
            case 3:
                playersArray = [Player(username: firstPlayerTextfield.text!), Player(username: secondPlayerTextfield.text!), Player(username: thirdPlayerTextfield.text!)]
                break
            case 4:
                playersArray = [Player(username: firstPlayerTextfield.text!), Player(username: secondPlayerTextfield.text!), Player(username: thirdPlayerTextfield.text!), Player(username: fourthPlayerTextfield.text!)]
                break
            default:
                playersArray = [Player(username: firstPlayerTextfield.text!), Player(username: secondPlayerTextfield.text!)]
                break
            }
            if language == .Greek {
                newViewController.language = .Greek
            } else {
                newViewController.language = .English
            }
            newViewController.players = playersArray
            self.present(newViewController, animated: true, completion: nil)
        }
    }
    
    @objc func goBackAction() {
        self.setupSound(soundFile: "backClick")?.play()
        self.dismiss(animated: true, completion: nil)
    }
    
    func validateIfTextFieldsAreErrorLess() -> Bool {
        var isErrorLess = true
        var tempErrorValue = true
        
        
        for txtfield in allTextFields {
            tempErrorValue = validateTextFieldsWithErrors(textField: txtfield)
            if tempErrorValue == false {
                isErrorLess = false
            }
        }
        
        return isErrorLess
    }
    
    func validateTextFieldsWithErrors(textField: UITextField) -> Bool {
        var isErrorLess = true
        
        if let text = textField.text {
            if let floatingLabelTextField = textField as? SkyFloatingLabelTextField {
                switch textField.tag {
                case firstPlayerTextfield.tag:
                    if text.count <= 0 {
                        if language == .Greek {
                            floatingLabelTextField.errorMessage = "Απαραίτητο όνομα!"
                        } else {
                            floatingLabelTextField.errorMessage = "Username required!"
                        }
                        isErrorLess = false
                    }
                    else if text.count > 15 {
                        if language == .Greek {
                            floatingLabelTextField.errorMessage = "<= 15 Χαρακτήρες"
                        } else {
                            floatingLabelTextField.errorMessage = "<= 15 Characters"
                        }
                        isErrorLess = false
                    }
                    else {
                        //The error message will only disappear when we reset it to nil or empty string
                        floatingLabelTextField.errorMessage = ""
                        
                        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
                            nextField.becomeFirstResponder()
                        } else {
                            textField.resignFirstResponder()
                        }
                    }
                    break
                case secondPlayerTextfield.tag:
                    if text.count <= 0 {
                        if language == .Greek {
                            floatingLabelTextField.errorMessage = "Απαραίτητο όνομα!"
                        } else {
                            floatingLabelTextField.errorMessage = "Username required!"
                        }
                        isErrorLess = false
                    }
                    else if text.count > 15 {
                        if language == .Greek {
                            floatingLabelTextField.errorMessage = "<= 15 Χαρακτήρες"
                        } else {
                            floatingLabelTextField.errorMessage = "<= 15 Characters"
                        }
                        isErrorLess = false
                    }
                    else {
                        //The error message will only disappear when we reset it to nil or empty string
                        floatingLabelTextField.errorMessage = ""
                        
                        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
                            nextField.becomeFirstResponder()
                        } else {
                            textField.resignFirstResponder()
                        }
                    }
                    break
                case thirdPlayerTextfield.tag:
                    if text.count <= 0 {
                        if language == .Greek {
                            floatingLabelTextField.errorMessage = "Απαραίτητο όνομα!"
                        } else {
                            floatingLabelTextField.errorMessage = "Username required!"
                        }
                        isErrorLess = false
                    }
                    else if text.count > 15 {
                        if language == .Greek {
                            floatingLabelTextField.errorMessage = "<= 15 Χαρακτήρες"
                        } else {
                            floatingLabelTextField.errorMessage = "<= 15 Characters"
                        }
                        isErrorLess = false
                    }
                    else {
                        //The error message will only disappear when we reset it to nil or empty string
                        floatingLabelTextField.errorMessage = ""
                        
                        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
                            nextField.becomeFirstResponder()
                        } else {
                            textField.resignFirstResponder()
                        }
                    }
                    break
                case fourthPlayerTextfield.tag:
                    if text.count <= 0 {
                        if language == .Greek {
                            floatingLabelTextField.errorMessage = "Απαραίτητο όνομα!"
                        } else {
                            floatingLabelTextField.errorMessage = "Username required!"
                        }
                        isErrorLess = false
                    }
                    else if text.count > 15 {
                        if language == .Greek {
                            floatingLabelTextField.errorMessage = "<= 15 Χαρακτήρες"
                        } else {
                            floatingLabelTextField.errorMessage = "<= 15 Characters"
                        }
                        isErrorLess = false
                    }
                    else {
                        //The error message will only disappear when we reset it to nil or empty string
                        floatingLabelTextField.errorMessage = ""
                        
                        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
                            nextField.becomeFirstResponder()
                        } else {
                            textField.resignFirstResponder()
                        }
                    }
                    break
                default:
                    break
                }
            }
        }
        return isErrorLess
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

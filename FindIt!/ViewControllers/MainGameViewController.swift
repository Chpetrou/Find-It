//
//  MainGameViewController.swift
//  FindIt!
//
//  Created by Christos Petrou on 06/03/2019.
//  Copyright © 2019 Christos Petrou. All rights reserved.
//

import UIKit
import AVFoundation

class MainGameViewController: UIViewController {

    var players: [Player] = []
    var player: AVAudioPlayer?
    var language: Language = .Greek
    
    let letterArray: [String] = ["Α", "Β", "Γ", "Δ", "Ε", "Ζ", "Η", "Θ", "Ι", "Κ", "Λ", "Μ", "Ν", "Ξ", "Ο", "Π", "Ρ", "Σ", "Τ", "Υ", "Φ", "Χ", "Ψ", "Ω"]
    var categoryArray: [String] = ["Μάρκα Αυτοκίνητου", "Άγριο Ζώο", "Πόλη", "Νησί", "Εργαλείο", "Ράτσα Σκύλου", "Μέρος Του Κεφαλιού", "Πρόσωπο Της Μυθολογίας", "Κάτι Που Διαβάζεις", "Κάτι Που Βάζεις Στο Ψυγείο", "Χωριό Της Κύπρου", "Πρωτεύουσα", "Εξάρτημα Αυτοκινήτου", "Πόλη Της Ελλάδας", "Γλυκό", "Επώνυμο Τραγουδιστή", "Ήρωας Παραμυθιού/ Κιν. Σχεδίων", "Πόλη της Κύπρου", "Χώρα", "Επώνυμο Πολιτικού", "Λέξη Με 4 Γράμματα", "Μπαχαρικό", "Χωριό Της Ελλάδας", "Μέρος Του Σώματος", "Φρούτο", "Ρούχο", "Ζώο Φάρμας ή Κατοικίδιο", "Κάτι Απο Ξύλο", "Ποδοσφαιρική Ομάδα", "Κάτι Κίτρινο", "Υλικά Για Σαλάτα", "Ανδρικό Όνομα", "Παιχνίδι", "Γυναικείο Όνομα", "Επάγγελμα", "Κάτι Που Αγοράζεις Απο Περίπτερο", "Είδος Χωρού", "Κάτι Σχετικό Με Τα Χριστούγεννα", "Κάτι Που Φοράς", "Μονάδα Μέτρησης", "Φυτό", "Είδος Ψαριού", "Χρώμα", "Μουσικό Συγκρότημα", "Λουλούδι", "Υγρό", "Επώνυμο Τηλεπαρουσιαστή", "Φαγητό", "Επώνυμο Ηθοποιού", "Βιβλίο", "Ποταμός", "Βουνό", "Θάλασσα", "Ωκεανός"]
    
    let letterArrayEnglish: [String] = ["A", "B", "C", "D", "Ε", "F", "G", "H", "Ι", "J", "K", "L", "M", "Ν", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "Χ", "Y", "Z"]
    var categoryArrayEnglish: [String] = ["Car Model", "Wild Animal", "Town", "Island", "Tool", "Dog Breed", "Part of Head", "Person of Mythology", "Something You Read", "Something You Put In The Fridge", "Village Of Cyprus", "Capital", "Part Of A Car", "Town Of Greece", "Desert", "Surname of Singer", "Hero Of A Book/Cartoon", "Town Of Cyprus", "Country", "Surname Of Politician", "Word With 4 Letters", "Spice", "Village Of Greece", "Part Of The Body", "Fruit", "Clothe", "Farm Animal Or Pet", "Something Out Of Wood", "Football Team", "Something Yellow", "Incredients For Salad", "Male Name", "Game", "Female Name", "Job", "Something You Buy From A Shop", "Type Of Dance", "Something Related To Christmas", "Something You Wear", "Measure Unit", "Plant", "Fish Species", "Color", "Music Band", "Flower", "Liquid", "Surname Of TV Presenter", "Food", "Surname Of Actor/Actress", "Book", "River", "Mountain", "Sea", "Ocean"]
    
    var finishedCategories = [String]()
    var finishedCategoriesEnglish = [String]()
    
    var seconds = 0
    var timer = Timer()
    
    var endGameTitle = ""
    var endGameDescription = ""
    
    lazy var categoryLabel: UILabel = {
        var category = UILabel()
        if language == .Greek {
            category.text = "ΚΑΤΗΓΟΡΙΑ"
        } else {
            category.text = "CATEGORY"
        }
        category.font = UIFont.systemFont(ofSize: 40, weight: UIFont.Weight.regular)
        category.textColor = .white
        category.textAlignment = .center
        category.numberOfLines = 0
        category.translatesAutoresizingMaskIntoConstraints = false
        
        return category
    }()
    
    var letterLabel: UILabel = {
        var letter = UILabel()
        letter.text = "Α"
        letter.font = UIFont.systemFont(ofSize: 100, weight: UIFont.Weight.regular)
        letter.textColor = .white
        letter.textAlignment = .center
        letter.translatesAutoresizingMaskIntoConstraints = false
        
        return letter
    }()
    
    var leftSideVerticalStackView: UIStackView = {
        var verticalStackView = UIStackView()
        
        verticalStackView.axis = .vertical
        verticalStackView.distribution = .equalSpacing
        verticalStackView.alignment = .center
        verticalStackView.spacing = 5
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        
        return verticalStackView
    }()
    
    var rightSideVerticalStackView: UIStackView = {
        var verticalStackView = UIStackView()
        
        verticalStackView.axis = .vertical
        verticalStackView.distribution = .equalSpacing
        verticalStackView.alignment = .center
        verticalStackView.spacing = 5
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        
        return verticalStackView
    }()
    
    var playerOneHorizontalStackView: UIStackView = {
        var horizontalStackView = UIStackView()
        
        horizontalStackView.axis = .horizontal
        horizontalStackView.distribution = .equalSpacing
        horizontalStackView.alignment = .center
        horizontalStackView.spacing = 2
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        
        return horizontalStackView
    }()
    
    var playerTwoHorizontalStackView: UIStackView = {
        var horizontalStackView = UIStackView()
        
        horizontalStackView.axis = .horizontal
        horizontalStackView.distribution = .equalSpacing
        horizontalStackView.alignment = .center
        horizontalStackView.spacing = 2
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        
        return horizontalStackView
    }()
    
    var playerThreeHorizontalStackView: UIStackView = {
        var horizontalStackView = UIStackView()
        
        horizontalStackView.axis = .horizontal
        horizontalStackView.distribution = .equalSpacing
        horizontalStackView.alignment = .center
        horizontalStackView.spacing = 2
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        
        return horizontalStackView
    }()
    
    var playerFourHorizontalStackView: UIStackView = {
        var horizontalStackView = UIStackView()
        
        horizontalStackView.axis = .horizontal
        horizontalStackView.distribution = .equalSpacing
        horizontalStackView.alignment = .center
        horizontalStackView.spacing = 2
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        
        return horizontalStackView
    }()
    
    lazy var playerOneNameLabel: UILabel = {
        var player = UILabel()
        player.text = "\(players[0].username): "
        player.textColor = .white
        player.textAlignment = .center
//        player.numberOfLines = 0
        player.translatesAutoresizingMaskIntoConstraints = false
        
        return player
    }()
    
    lazy var playerOnePointsLabel: UILabel = {
        var player = UILabel()
        player.text = String(players[0].points)
        player.textColor = .white
        player.textAlignment = .center
        player.translatesAutoresizingMaskIntoConstraints = false
        
        return player
    }()
    
    lazy var playerTwoNameLabel: UILabel = {
        var player = UILabel()
        player.text = "\(players[1].username): "
        player.textColor = .white
        player.textAlignment = .center
//        player.numberOfLines = 0
        player.translatesAutoresizingMaskIntoConstraints = false
        
        return player
    }()
    
    lazy var playerTwoPointsLabel: UILabel = {
        var player = UILabel()
        player.text = String(players[1].points)
        player.textColor = .white
        player.textAlignment = .center
        player.translatesAutoresizingMaskIntoConstraints = false
        
        return player
    }()
    
    lazy var playerThreeNameLabel: UILabel = {
        var player = UILabel()
        if players.count > 2 {
            player.text = "\(players[2].username): "
        }
        player.textColor = .white
        player.textAlignment = .center
//        player.numberOfLines = 0
        player.translatesAutoresizingMaskIntoConstraints = false
        
        return player
    }()
    
    lazy var playerThreePointsLabel: UILabel = {
        var player = UILabel()
        if players.count > 2 {
            player.text = String(players[2].points)
        }
        player.textColor = .white
        player.textAlignment = .center
        player.translatesAutoresizingMaskIntoConstraints = false
        
        return player
    }()
    
    lazy var playerFourNameLabel: UILabel = {
        var player = UILabel()
        if players.count > 3 {
            player.text = "\(players[3].username): "
        }
        player.textColor = .white
        player.textAlignment = .center
//        player.numberOfLines = 0
        player.translatesAutoresizingMaskIntoConstraints = false
        
        return player
    }()
    
    lazy var playerFourPointsLabel: UILabel = {
        var player = UILabel()
        if players.count > 3 {
            player.text = String(players[3].points)
        }
        player.textColor = .white
        player.textAlignment = .center
        player.translatesAutoresizingMaskIntoConstraints = false
        
        return player
    }()
    
    var itemsStackview: UIStackView = {
        var horizontalStackView = UIStackView()
        
        horizontalStackView.axis = .horizontal
        horizontalStackView.distribution = .equalSpacing
        horizontalStackView.alignment = .center
        horizontalStackView.spacing = 10
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        
        return horizontalStackView
    }()
    
    var skipButton: UIButton = {
        var button = UIButton()
        button.setImage(UIImage(named: "skipIcon"), for: .normal)
        button.imageView!.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(skipButtonAction), for: .touchUpInside)
        
        return button
    }()
    
    var stopButton: UIButton = {
        var button = UIButton()
        button.setImage(UIImage(named: "stopIcon"), for: .normal)
        button.imageView!.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(stopButtonAction), for: .touchUpInside)
        
        return button
    }()
    
    var playButton: UIButton = {
        var button = UIButton()
        button.setImage(UIImage(named: "playIcon"), for: .normal)
        button.imageView!.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(playButtonAction), for: .touchUpInside)
        
        return button
    }()
    
    var pauseButton: UIButton = {
        var button = UIButton()
        button.setImage(UIImage(named: "pauseIcon"), for: .normal)
        button.imageView!.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(pauseButtonAction), for: .touchUpInside)
        
        return button
    }()
    
    var topButtonsStackView: UIStackView = {
        var horizontalStackView = UIStackView()
        
        horizontalStackView.axis = .horizontal
        horizontalStackView.distribution = .equalSpacing
        horizontalStackView.alignment = .center
        horizontalStackView.spacing = 10
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        
        return horizontalStackView
    }()
    
    var bottomButtonsStackView: UIStackView = {
        var horizontalStackView = UIStackView()
        
        horizontalStackView.axis = .horizontal
        horizontalStackView.distribution = .equalSpacing
        horizontalStackView.alignment = .center
        horizontalStackView.spacing = 10
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        
        return horizontalStackView
    }()
    
    var generalButtonsStackView: UIStackView = {
        var horizontalStackView = UIStackView()
        
        horizontalStackView.axis = .vertical
        horizontalStackView.distribution = .equalSpacing
        horizontalStackView.alignment = .center
        horizontalStackView.spacing = 10
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        
        return horizontalStackView
    }()
    
    var playerOneBuzzer: UIButton = {
        var button = UIButton()
        button.backgroundColor = .BlueBuzzerColor
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(playerOneBuzzerAction), for: .touchUpInside)
        
        return button
    }()
    
    var playerTwoBuzzer: UIButton = {
        var button = UIButton()
        button.backgroundColor = .RedBuzzerColor
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(playerTwoBuzzerAction), for: .touchUpInside)
        
        return button
    }()
    
    var playerThreeBuzzer: UIButton = {
        var button = UIButton()
        button.backgroundColor = .YellowBuzzerColor
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(playerThreeBuzzerAction), for: .touchUpInside)
        
        return button
    }()
    
    var playerFourBuzzer: UIButton = {
        var button = UIButton()
        button.backgroundColor = .GreenBuzzerColor
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(playerFourBuzzerAction), for: .touchUpInside)
        
        return button
    }()
    
    lazy var timerLabel: UILabel = {
        var label = UILabel()
        if language == .Greek {
            label.text = "Χρόνος"
        } else {
            label.text = "Timer"
        }
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .FindBlue
        
        setupCategoryLabel()
        setupLetterLabel()
        setupHorizontalLabelStackViews()
        setupPlayerLabels()
        setupMenuButtonsAndStackview()
        setupTimerLabel()
        setupBuzzerButtonsAndStackViews()
        setupBuzzerButtonsAndLabelsPoints()
        updateLetterAndCategory()
        
        configureViewForSize(size: view.frame.size)
    }
    
    func setupCategoryLabel() {
        view.addSubview(categoryLabel)
        
        categoryLabel.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 1).isActive = true
        categoryLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 5).isActive = true
        categoryLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 5).isActive = true
    }
    
    func setupLetterLabel() {
        view.addSubview(letterLabel)
        
        letterLabel.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 1).isActive = true
        letterLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    func setupHorizontalLabelStackViews() {
        view.addSubview(leftSideVerticalStackView)
        view.addSubview(rightSideVerticalStackView)
        
        leftSideVerticalStackView.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 2).isActive = true
        leftSideVerticalStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 3).isActive = true
        leftSideVerticalStackView.trailingAnchor.constraint(equalTo: letterLabel.leadingAnchor, constant: -5).isActive = true
        
        rightSideVerticalStackView.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 2).isActive = true
        rightSideVerticalStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -3).isActive = true
        rightSideVerticalStackView.leadingAnchor.constraint(equalTo: letterLabel.trailingAnchor, constant: 5).isActive = true
        
        leftSideVerticalStackView.addArrangedSubview(playerOneHorizontalStackView)
        leftSideVerticalStackView.addArrangedSubview(playerThreeHorizontalStackView)
        rightSideVerticalStackView.addArrangedSubview(playerTwoHorizontalStackView)
        rightSideVerticalStackView.addArrangedSubview(playerFourHorizontalStackView)
    }
    
    func setupPlayerLabels() {
        playerOneHorizontalStackView.addArrangedSubview(playerOneNameLabel)
        playerOneHorizontalStackView.addArrangedSubview(playerOnePointsLabel)
        
        playerTwoHorizontalStackView.addArrangedSubview(playerTwoNameLabel)
        playerTwoHorizontalStackView.addArrangedSubview(playerTwoPointsLabel)
        
        playerThreeHorizontalStackView.addArrangedSubview(playerThreeNameLabel)
        playerThreeHorizontalStackView.addArrangedSubview(playerThreePointsLabel)
        
        playerFourHorizontalStackView.addArrangedSubview(playerFourNameLabel)
        playerFourHorizontalStackView.addArrangedSubview(playerFourPointsLabel)
    }
    
    func setupBuzzerButtonsAndLabelsPoints() {
        switch players.count {
        case 2:
            playerOneHorizontalStackView.isHidden = false
            playerTwoHorizontalStackView.isHidden = false
            playerThreeHorizontalStackView.isHidden = true
            playerFourHorizontalStackView.isHidden = true
            
            topButtonsStackView.axis = .vertical
            
            playerOneBuzzer.isHidden = false
            playerTwoBuzzer.isHidden = false
            playerThreeBuzzer.isHidden = true
            playerFourBuzzer.isHidden = true
        case 3:
            playerOneHorizontalStackView.isHidden = false
            playerTwoHorizontalStackView.isHidden = false
            playerThreeHorizontalStackView.isHidden = false
            playerFourHorizontalStackView.isHidden = true
            
            playerOneBuzzer.isHidden = false
            playerTwoBuzzer.isHidden = false
            playerThreeBuzzer.isHidden = false
            playerFourBuzzer.isHidden = true
        case 4:
            playerOneHorizontalStackView.isHidden = false
            playerTwoHorizontalStackView.isHidden = false
            playerThreeHorizontalStackView.isHidden = false
            playerFourHorizontalStackView.isHidden = false
            
            playerOneBuzzer.isHidden = false
            playerTwoBuzzer.isHidden = false
            playerThreeBuzzer.isHidden = false
            playerFourBuzzer.isHidden = false
        default:
            playerOneHorizontalStackView.isHidden = false
            playerTwoHorizontalStackView.isHidden = false
            playerThreeHorizontalStackView.isHidden = true
            playerFourHorizontalStackView.isHidden = true
            
            playerOneBuzzer.isHidden = false
            playerTwoBuzzer.isHidden = false
            playerThreeBuzzer.isHidden = true
            playerFourBuzzer.isHidden = true
        }
        
        playButton.isHidden = true
    }
    
    func setupMenuButtonsAndStackview() {
        view.addSubview(itemsStackview)
        
        itemsStackview.topAnchor.constraint(equalTo: letterLabel.bottomAnchor, constant: 1).isActive = true
        itemsStackview.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        let menuButtonsArray = [skipButton, stopButton, playButton, pauseButton]
        
        for menuButton in menuButtonsArray {
            itemsStackview.addArrangedSubview(menuButton)
            menuButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
            menuButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        }
    }
    
    func setupTimerLabel() {
        view.addSubview(timerLabel)
        
        timerLabel.topAnchor.constraint(equalTo: itemsStackview.bottomAnchor, constant: 10).isActive = true
        timerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    func setupBuzzerButtonsAndStackViews() {
        view.addSubview(generalButtonsStackView)
        
        generalButtonsStackView.topAnchor.constraint(equalTo: timerLabel.bottomAnchor, constant: 20).isActive = true
        generalButtonsStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        generalButtonsStackView.addArrangedSubview(topButtonsStackView)
        generalButtonsStackView.addArrangedSubview(bottomButtonsStackView)
        
        topButtonsStackView.addArrangedSubview(playerOneBuzzer)
        topButtonsStackView.addArrangedSubview(playerTwoBuzzer)
        bottomButtonsStackView.addArrangedSubview(playerThreeBuzzer)
        bottomButtonsStackView.addArrangedSubview(playerFourBuzzer)
        
        let buzzersArray = [playerOneBuzzer, playerTwoBuzzer, playerThreeBuzzer, playerFourBuzzer]
        let buzzersSize: CGFloat = 150
        
        for buzzer in buzzersArray {
            buzzer.widthAnchor.constraint(greaterThanOrEqualToConstant: buzzersSize).isActive = true
            buzzer.heightAnchor.constraint(greaterThanOrEqualToConstant: buzzersSize).isActive = true
            buzzer.layer.cornerRadius = 15
            buzzer.clipsToBounds = true
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        configureViewForSize(size: size)
    }
    
    private func configureViewForSize(size: CGSize) {
        if size.width > size.height {
            generalButtonsStackView.axis = .horizontal
            if players.count == 2 {
                topButtonsStackView.axis = .horizontal
            }
        } else {
            generalButtonsStackView.axis = .vertical
            if players.count == 2 {
                topButtonsStackView.axis = .vertical
            }
        }
    }
}

extension MainGameViewController {
    @objc func skipButtonAction() {
        self.setupSound(soundFile: "click")?.play()
        timer.invalidate()
        updateLetterAndCategory()
        
    }
    
    @objc func stopButtonAction() {
        self.setupSound(soundFile: "click")?.play()
        timer.invalidate()
        findPlayerWithHighestScore()
        showsAlertToEndGameAndConfirmationsWithOptions()
    }
    
    @objc func playButtonAction() {
        self.setupSound(soundFile: "click")?.play()
        pauseButton.isHidden = false
        playButton.isHidden = true
    }
    
    @objc func pauseButtonAction() {
        self.setupSound(soundFile: "click")?.play()
        pauseButton.isHidden = true
        playButton.isHidden = false
        
        timer.invalidate()
        if language == .Greek {
            let alertController = UIAlertController(title: "ΠΑΥΣΗ", message: "Το παιχνίδι είναι σε πάυση. Πατήστε το ΕΝΤΑΞΕΙ για να συνεχίσετε.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "ΕΝΤΑΞΕΙ", style: UIAlertAction.Style.default, handler: { action in
                self.setupSound(soundFile: "click")?.play()
                self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.subtractTime), userInfo: nil, repeats: true)
                
                self.pauseButton.isHidden = false
                self.playButton.isHidden = true
                
            })
            
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        } else {
            let alertController = UIAlertController(title: "PAUSE", message: "The game is paused. Please click OK to continue.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "ΟΚ", style: UIAlertAction.Style.default, handler: { action in
                self.setupSound(soundFile: "click")?.play()
                self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.subtractTime), userInfo: nil, repeats: true)
            
                self.pauseButton.isHidden = false
                self.playButton.isHidden = true
                
            })
            
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    @objc func playerOneBuzzerAction() {
        self.setupSound(soundFile: "buzzer")?.play()
        timer.invalidate()
        if language == .Greek {
            let alertController = UIAlertController(title: "Πόντος", message: "Συμφωνεί ο/οι άλλος/οι παίκτης/ες με τη απάντηση σου;", preferredStyle: UIAlertController.Style.alert)
            let yes = UIAlertAction(title: "Ναί", style: UIAlertAction.Style.default, handler: { action in
                self.setupSound(soundFile: "click")?.play()
                self.players[0].points += 1
                self.playerOnePointsLabel.text = String(self.players[0].points)
                self.updateLetterAndCategory()
            })
            
            let no = UIAlertAction(title: "Όχι", style: UIAlertAction.Style.default, handler: { action in
                self.setupSound(soundFile: "click")?.play()
                self.updateLetterAndCategory()
            })
            alertController.addAction(yes)
            alertController.addAction(no)
            self.present(alertController, animated: true, completion: nil)
        } else {
            let alertController = UIAlertController(title: "Point", message: "Does the other player agree with your answer?", preferredStyle: UIAlertController.Style.alert)
            let yes = UIAlertAction(title: "Yes", style: UIAlertAction.Style.default, handler: { action in
                self.setupSound(soundFile: "click")?.play()
                self.players[0].points += 1
                self.playerOnePointsLabel.text = String(self.players[0].points)
                self.updateLetterAndCategory()
            })
            
            let no = UIAlertAction(title: "No", style: UIAlertAction.Style.default, handler: { action in
                self.setupSound(soundFile: "click")?.play()
                self.updateLetterAndCategory()
            })
            alertController.addAction(yes)
            alertController.addAction(no)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    @objc func playerTwoBuzzerAction() {
        self.setupSound(soundFile: "buzzer")?.play()
        timer.invalidate()
        if language == .Greek {
            let alertController = UIAlertController(title: "Πόντος", message: "Συμφωνεί ο/οι άλλος/οι παίκτης/ες με τη απάντηση σου;", preferredStyle: UIAlertController.Style.alert)
            let yes = UIAlertAction(title: "Ναί", style: UIAlertAction.Style.default, handler: { action in
                self.setupSound(soundFile: "click")?.play()
                self.players[1].points += 1
                self.playerTwoPointsLabel.text = String(self.players[1].points)
                self.updateLetterAndCategory()
            })
            
            let no = UIAlertAction(title: "Όχι", style: UIAlertAction.Style.default, handler: { action in
                self.setupSound(soundFile: "click")?.play()
                self.updateLetterAndCategory()
            })
            alertController.addAction(yes)
            alertController.addAction(no)
            self.present(alertController, animated: true, completion: nil)
        } else {
            let alertController = UIAlertController(title: "Point", message: "Does the other player agree with your answer?", preferredStyle: UIAlertController.Style.alert)
            let yes = UIAlertAction(title: "Yes", style: UIAlertAction.Style.default, handler: { action in
                self.setupSound(soundFile: "click")?.play()
                self.players[1].points += 1
                self.playerTwoPointsLabel.text = String(self.players[1].points)
                self.updateLetterAndCategory()
            })
            
            let no = UIAlertAction(title: "No", style: UIAlertAction.Style.default, handler: { action in
                self.setupSound(soundFile: "click")?.play()
                self.updateLetterAndCategory()
            })
            alertController.addAction(yes)
            alertController.addAction(no)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    @objc func playerThreeBuzzerAction() {
        self.setupSound(soundFile: "buzzer")?.play()
        timer.invalidate()
        if language == .Greek {
            let alertController = UIAlertController(title: "Πόντος", message: "Συμφωνεί ο/οι άλλος/οι παίκτης/ες με τη απάντηση σου;", preferredStyle: UIAlertController.Style.alert)
            let yes = UIAlertAction(title: "Ναί", style: UIAlertAction.Style.default, handler: { action in
                self.setupSound(soundFile: "click")?.play()
                self.players[2].points += 1
                self.playerThreePointsLabel.text = String(self.players[2].points)
                self.updateLetterAndCategory()
            })
            
            let no = UIAlertAction(title: "Όχι", style: UIAlertAction.Style.default, handler: { action in
                self.setupSound(soundFile: "click")?.play()
                self.updateLetterAndCategory()
            })
            alertController.addAction(yes)
            alertController.addAction(no)
            self.present(alertController, animated: true, completion: nil)
        } else {
            let alertController = UIAlertController(title: "Point", message: "Does the other player agree with your answer?", preferredStyle: UIAlertController.Style.alert)
            let yes = UIAlertAction(title: "Yes", style: UIAlertAction.Style.default, handler: { action in
                self.setupSound(soundFile: "click")?.play()
                self.players[2].points += 1
                self.playerThreePointsLabel.text = String(self.players[2].points)
                self.updateLetterAndCategory()
            })
            
            let no = UIAlertAction(title: "No", style: UIAlertAction.Style.default, handler: { action in
                self.setupSound(soundFile: "click")?.play()
                self.updateLetterAndCategory()
            })
            alertController.addAction(yes)
            alertController.addAction(no)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    @objc func playerFourBuzzerAction() {
        self.setupSound(soundFile: "buzzer")?.play()
        timer.invalidate()
        if language == .Greek {
            let alertController = UIAlertController(title: "Πόντος", message: "Συμφωνεί ο/οι άλλος/οι παίκτης/ες με τη απάντηση σου;", preferredStyle: UIAlertController.Style.alert)
            let yes = UIAlertAction(title: "Ναί", style: UIAlertAction.Style.default, handler: { action in
                self.setupSound(soundFile: "click")?.play()
                self.players[3].points += 1
                self.playerFourPointsLabel.text = String(self.players[3].points)
                self.updateLetterAndCategory()
            })
            
            let no = UIAlertAction(title: "Όχι", style: UIAlertAction.Style.default, handler: { action in
                self.setupSound(soundFile: "click")?.play()
                self.updateLetterAndCategory()
            })
            alertController.addAction(yes)
            alertController.addAction(no)
            self.present(alertController, animated: true, completion: nil)
        } else {
            let alertController = UIAlertController(title: "Point", message: "Does the other player agree with your answer?", preferredStyle: UIAlertController.Style.alert)
            let yes = UIAlertAction(title: "Yes", style: UIAlertAction.Style.default, handler: { action in
                self.setupSound(soundFile: "click")?.play()
                self.players[3].points += 1
                self.playerFourPointsLabel.text = String(self.players[3].points)
                self.updateLetterAndCategory()
            })
            
            let no = UIAlertAction(title: "No", style: UIAlertAction.Style.default, handler: { action in
                self.setupSound(soundFile: "click")?.play()
                self.updateLetterAndCategory()
            })
            alertController.addAction(yes)
            alertController.addAction(no)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func updateLetterAndCategory() {
        
        if language == .Greek {
            if categoryArray.isEmpty {
                timer.invalidate()
                categoriesHaveEnded()
                return
            }
            
            let categoryRandomIndex = Int.random(in: 0 ..< categoryArray.count)
            let letterRandomIndex = Int.random(in: 0 ..< letterArray.count)
            
            setupTimer()
        
            categoryLabel.text = categoryArray[categoryRandomIndex]
            letterLabel.text = letterArray[letterRandomIndex]
            
            finishedCategories.append(categoryArray.remove(at: categoryRandomIndex))
        } else {
            if categoryArrayEnglish.isEmpty {
                timer.invalidate()
                categoriesHaveEnded()
                return
            }
            
            let categoryRandomIndex = Int.random(in: 0 ..< categoryArrayEnglish.count)
            let letterRandomIndex = Int.random(in: 0 ..< letterArrayEnglish.count)
            
            setupTimer()
            
            categoryLabel.text = categoryArrayEnglish[categoryRandomIndex]
            letterLabel.text = letterArrayEnglish[letterRandomIndex]
            
            finishedCategoriesEnglish.append(categoryArrayEnglish.remove(at: categoryRandomIndex))
        }
    }
    
    func setupTimer() {
        seconds = 20
        
        if language == .Greek {
            timerLabel.text = "Χρόνος: \(seconds)"
        } else {
            timerLabel.text = "Time: \(seconds)"
        }
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(MainGameViewController.subtractTime), userInfo: nil, repeats: true)
    }
    
    @objc func subtractTime() {
        self.seconds -= 1
        if language == .Greek {
            self.timerLabel.text = "Χρόνος: \(self.seconds)"
        } else {
            self.timerLabel.text = "Time: \(self.seconds)"
        }
        
        setupSound(soundFile: "backClick")?.play()
        
        if(self.seconds == 0)  {
            self.timer.invalidate()
            setupSound(soundFile: "timerUp")?.play()
            
            if language == .Greek {
                let alert = UIAlertController(title: "Χρόνος", message: "Ο χρόνος σας έληξε. Παρακαλώ προχωρήστε στην επόμενη κατηγορία.", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Επόμενη", style: .default, handler: { _ in
                    self.updateLetterAndCategory()
                }))
                
                self.present(alert, animated: true, completion:nil)
            } else {
                let alert = UIAlertController(title: "Time", message: "Your time is up. Continue to the next category.", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Next", style: .default, handler: { _ in
                    self.updateLetterAndCategory()
                }))
                
                self.present(alert, animated: true, completion:nil)
            }
        }
    }
    
    func findPlayerWithHighestScore() {
        
        var winnerPlayer = Player(username: "Username")
        
        for player in players {
            if player.points > winnerPlayer.points {
                winnerPlayer = player
            }
        }
        
        var isDraw = false
        for player in players {
            if (player.points == winnerPlayer.points) && (player.username != winnerPlayer.username) {
                isDraw = true
                break
            }
        }
        
        if language == .Greek {
            if isDraw == true {
                endGameTitle = "DRAW"
                endGameDescription = "Έχετε ισοπαλία, δέν υπάρχει νικητής!"
            } else {
                endGameTitle = "Ο/Η \(winnerPlayer.username)"
                endGameDescription = "είναι ο νικητής/τρια με \(winnerPlayer.points) πόντους!"
            }
        } else {
            if isDraw == true {
                endGameTitle = "DRAW"
                endGameDescription = "You have a draw, there is no winner!"
            } else {
                endGameTitle = winnerPlayer.username
                endGameDescription = "is the winner with \(winnerPlayer.points) points!"
            }
        }
    }
    
    func categoriesHaveEnded() {
        if language == .Greek {
            let alertController = UIAlertController(title: "ΤΕΛΟΣ", message: "Οι κατηγορίες έχουν τελιώσει. Μπορείτε να ξαναπαίξετε ή να σταματήσετε.", preferredStyle: .alert)
            let okButton = UIAlertAction(title: "ΕΝΤΑΞΕΙ", style: .cancel, handler: { _ in
                self.findPlayerWithHighestScore()
                let alertController = UIAlertController(title: self.endGameTitle, message: self.endGameDescription, preferredStyle: .alert)
                let playAgain = UIAlertAction(title: "Παίξτε Ξανά", style: UIAlertAction.Style.default, handler: { _ in
                    self.setupSound(soundFile: "click")?.play()
                    self.categoryArray = self.finishedCategories
                    self.finishedCategories.removeAll()
                    
                    var playersPointsLabelArray: [UILabel]!
                    
                    switch self.players.count {
                    case 2:
                        playersPointsLabelArray = [self.playerOnePointsLabel, self.playerTwoPointsLabel]
                        break
                    case 3:
                        playersPointsLabelArray = [self.playerOnePointsLabel, self.playerTwoPointsLabel, self.playerThreePointsLabel]
                        break
                    case 4:
                        playersPointsLabelArray = [self.playerOnePointsLabel, self.playerTwoPointsLabel, self.playerThreePointsLabel, self.playerFourPointsLabel]
                        break
                    default:
                        playersPointsLabelArray = [self.playerOnePointsLabel, self.playerTwoPointsLabel]
                        break
                    }
                    
                    for (index, player) in self.players.enumerated() {
                        player.points = 0
                        playersPointsLabelArray[index].text = String(player.points)
                    }
                    
                    self.updateLetterAndCategory()
                })
                let end = UIAlertAction(title: "Τέλος", style: UIAlertAction.Style.cancel, handler: { _ in
                    self.setupSound(soundFile: "click")?.play()
                    self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
                })
                alertController.addAction(playAgain)
                alertController.addAction(end)
                self.present(alertController, animated: true, completion: nil)
            })
            
            alertController.addAction(okButton)
            self.present(alertController, animated: true, completion: nil)
        } else {
            let alertController = UIAlertController(title: "END", message: "The categories have ended. You can play again or stop.", preferredStyle: .alert)
            let okButton = UIAlertAction(title: "OK", style: .cancel, handler: { _ in
                self.findPlayerWithHighestScore()
                let alertController = UIAlertController(title: self.endGameTitle, message: self.endGameDescription, preferredStyle: .alert)
                let playAgain = UIAlertAction(title: "Play Again", style: UIAlertAction.Style.default, handler: { _ in
                    self.setupSound(soundFile: "click")?.play()
                    self.categoryArrayEnglish = self.finishedCategoriesEnglish
                    self.finishedCategoriesEnglish.removeAll()
                    
                    var playersPointsLabelArray: [UILabel]!
                    
                    switch self.players.count {
                    case 2:
                        playersPointsLabelArray = [self.playerOnePointsLabel, self.playerTwoPointsLabel]
                        break
                    case 3:
                        playersPointsLabelArray = [self.playerOnePointsLabel, self.playerTwoPointsLabel, self.playerThreePointsLabel]
                        break
                    case 4:
                        playersPointsLabelArray = [self.playerOnePointsLabel, self.playerTwoPointsLabel, self.playerThreePointsLabel, self.playerFourPointsLabel]
                        break
                    default:
                        playersPointsLabelArray = [self.playerOnePointsLabel, self.playerTwoPointsLabel]
                        break
                    }
                    
                    for (index, player) in self.players.enumerated() {
                        player.points = 0
                        playersPointsLabelArray[index].text = String(player.points)
                    }
                    
                    self.updateLetterAndCategory()
                })
                let end = UIAlertAction(title: "End", style: UIAlertAction.Style.cancel, handler: { _ in
                    self.setupSound(soundFile: "click")?.play()
                    self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
                })
                alertController.addAction(playAgain)
                alertController.addAction(end)
                self.present(alertController, animated: true, completion: nil)
            })
            
            alertController.addAction(okButton)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func showsAlertToEndGameAndConfirmationsWithOptions() {
        if language == .Greek {
            let alertController = UIAlertController(title: "Επιβεβαίωση", message: "Είστε σίγουροι ότι θέλετε να τελειώσει το παιχνίδι;", preferredStyle: .alert)
            let yes = UIAlertAction(title: "Ναί", style: UIAlertAction.Style.destructive, handler: { _ in
                self.setupSound(soundFile: "click")?.play()
                let alertController = UIAlertController(title: self.endGameTitle, message: self.endGameDescription, preferredStyle: .alert)
                let playAgain = UIAlertAction(title: "Παίξτε Ξανά", style: UIAlertAction.Style.default, handler: { _ in
                    self.setupSound(soundFile: "click")?.play()
                    self.categoryArray = self.finishedCategories
                    self.finishedCategories.removeAll()
                    
                    var playersPointsLabelArray: [UILabel]!
                    
                    switch self.players.count {
                    case 2:
                        playersPointsLabelArray = [self.playerOnePointsLabel, self.playerTwoPointsLabel]
                        break
                    case 3:
                        playersPointsLabelArray = [self.playerOnePointsLabel, self.playerTwoPointsLabel, self.playerThreePointsLabel]
                        break
                    case 4:
                        playersPointsLabelArray = [self.playerOnePointsLabel, self.playerTwoPointsLabel, self.playerThreePointsLabel, self.playerFourPointsLabel]
                        break
                    default:
                        playersPointsLabelArray = [self.playerOnePointsLabel, self.playerTwoPointsLabel]
                        break
                    }
                    
                    for (index, player) in self.players.enumerated() {
                        player.points = 0
                        playersPointsLabelArray[index].text = String(player.points)
                    }
                    
                    self.updateLetterAndCategory()
                })
                let end = UIAlertAction(title: "Τέλος", style: UIAlertAction.Style.cancel, handler: { _ in
                    self.setupSound(soundFile: "click")?.play()
                    self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
                })
                alertController.addAction(playAgain)
                alertController.addAction(end)
                self.present(alertController, animated: true, completion: nil)
            })
            let no = UIAlertAction(title: "Όχι", style: UIAlertAction.Style.cancel, handler: { _ in
                self.setupSound(soundFile: "click")?.play()
                self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.subtractTime), userInfo: nil, repeats: true)
            })
            alertController.addAction(yes)
            alertController.addAction(no)
            self.present(alertController, animated: true, completion: nil)
        } else {
            let alertController = UIAlertController(title: "Comfirmation", message: "Are you sure you want to end the game?", preferredStyle: .alert)
            let yes = UIAlertAction(title: "Yes", style: UIAlertAction.Style.destructive, handler: { _ in
                self.setupSound(soundFile: "click")?.play()
                let alertController = UIAlertController(title: self.endGameTitle, message: self.endGameDescription, preferredStyle: .alert)
                let playAgain = UIAlertAction(title: "Play Again", style: UIAlertAction.Style.default, handler: { _ in
                    self.setupSound(soundFile: "click")?.play()
                    self.categoryArrayEnglish = self.finishedCategoriesEnglish
                    self.finishedCategoriesEnglish.removeAll()
                    
                    var playersPointsLabelArray: [UILabel]!
                    
                    switch self.players.count {
                    case 2:
                        playersPointsLabelArray = [self.playerOnePointsLabel, self.playerTwoPointsLabel]
                        break
                    case 3:
                        playersPointsLabelArray = [self.playerOnePointsLabel, self.playerTwoPointsLabel, self.playerThreePointsLabel]
                        break
                    case 4:
                        playersPointsLabelArray = [self.playerOnePointsLabel, self.playerTwoPointsLabel, self.playerThreePointsLabel, self.playerFourPointsLabel]
                        break
                    default:
                        playersPointsLabelArray = [self.playerOnePointsLabel, self.playerTwoPointsLabel]
                        break
                    }
                    
                    for (index, player) in self.players.enumerated() {
                        player.points = 0
                        playersPointsLabelArray[index].text = String(player.points)
                    }
                    
                    self.updateLetterAndCategory()
                })
                let end = UIAlertAction(title: "End", style: UIAlertAction.Style.cancel, handler: { _ in
                    self.setupSound(soundFile: "click")?.play()
                    self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
                })
                alertController.addAction(playAgain)
                alertController.addAction(end)
                self.present(alertController, animated: true, completion: nil)
            })
            let no = UIAlertAction(title: "No", style: UIAlertAction.Style.cancel, handler: { _ in
                self.setupSound(soundFile: "click")?.play()
                self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.subtractTime), userInfo: nil, repeats: true)
            })
            alertController.addAction(yes)
            alertController.addAction(no)
            self.present(alertController, animated: true, completion: nil)
        }
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

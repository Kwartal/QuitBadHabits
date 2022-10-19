//
//  WelcomeScreenViewController.swift.swift
//  QuitBadHabits
//
//  Created by Богдан Баринов on 12.09.2022.
//

import UIKit
import SnapKit
import AVFoundation
//import MediaPlayer

final class WelcomeScreenViewController: UIPageViewController, AVAudioPlayerDelegate {
    private var player: AVAudioPlayer?
    private var tracks = "Stallone"
    
    private var pages = [UIViewController]()
    private let pageControl = UIPageControl()
    private let initialPage = 0
    
    private var welcomeTextLabel = UILabel()
    private var playButton = UIButton()
    private var startButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.background
        addSubviews()
        setupSubviews()
        configureConstraints()
        
        let firstPage = ViewController1()
        let secondPage = ViewController2()
        let thirdPage = ViewController3()
        
        pages.append(firstPage)
        pages.append(secondPage)
        pages.append(thirdPage)

    }
    
    
}


extension WelcomeScreenViewController {
    
    private func addSubviews() {
        view.addSubview(welcomeTextLabel)
        view.addSubview(playButton)
        view.addSubview(startButton)
        view.addSubview(pageControl)
        
    }
    
    private func setupSubviews() {
        welcomeTextLabel.text = "Приветствую!Если ты здесь, значит ты принял решение бросить курить.Кликни по Сталоне, зарядись мотивацией и нажми на кнопку начать, для внесения данных!"
        welcomeTextLabel.numberOfLines = 0
        welcomeTextLabel.textColor = Colors.text
        welcomeTextLabel.font = .systemFont(ofSize: 20, weight: .bold)
        
        playButton.setImage(UIImage(named: "Rembo"), for: .normal)
        playButton.addTarget(self, action: #selector(playButtonDidTap), for: .touchUpInside)
        
        startButton.setTitle("Начать", for: .normal)
        startButton.addTarget(self, action: #selector(startButtonDidTap), for: .touchUpInside)
        startButton.backgroundColor = .systemMint
        startButton.layer.cornerRadius = 10
        

        
    }
    
    private func configureConstraints() {
        welcomeTextLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.top.equalToSuperview().offset(100)
        }
        
        playButton.snp.makeConstraints {
            $0.top.equalTo(welcomeTextLabel.snp.bottom).offset(10)
            $0.centerX.equalTo(view)
            $0.size.equalTo(200)
        }
        
        startButton.snp.makeConstraints {
            $0.top.equalTo(playButton.snp.bottom).offset(300)
            $0.centerX.equalTo(playButton)
            $0.height.equalTo(50)
            $0.width.equalTo(160)
        }
        
        NSLayoutConstraint.activate([
            pageControl.widthAnchor.constraint(equalTo: view.widthAnchor),
            pageControl.heightAnchor.constraint(equalToConstant: 20),
            view.bottomAnchor.constraint(equalToSystemSpacingBelow: pageControl.bottomAnchor, multiplier: 1)
        ])
        
        
    }
    //FIXME: - Исправить кнопку
    @objc private func playButtonDidTap() {
        print("privet1")
        if ((player?.isPlaying) != nil) {
            player?.stop()
        } else {
            playSound()
        }
    }
    
    @objc private func startButtonDidTap() {
        let userInfopage = UserInformationViewController()
        self.present(userInfopage, animated: true)
    }
    
    @objc private func pageControlTapped() {
        
    }
}


extension WelcomeScreenViewController {
    
    
    func playSound() {
        
        guard let path = Bundle.main.path(forResource: tracks, ofType: "m4a")   else { return }
        let url = URL(fileURLWithPath: path)
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch {
            print("error \(path)")
        }
    }
    
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if flag == true {
            exit(0)
        }
    }
    
}




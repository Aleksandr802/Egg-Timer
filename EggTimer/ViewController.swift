//
//  AppDelegate.swift
//  EggTimer
//
//  Created by Aleksandr Seminov on 08/09/2020.
//  Copyright © 2020 The Aleksandr802. All rights reserved.
//


import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var progressBar: UIProgressView!
    
    let aggTimes = ["Soft": 300, "Medium": 420, "Hard": 720]
    
    var timer = Timer()
    var totalTime = 0
    var secondsPassed = 0
    var player: AVAudioPlayer!
    
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        
        timer.invalidate()
        let hardness = sender.currentTitle!//Soft Medium Hard
        totalTime = aggTimes[hardness]!
        
        secondsPassed = 0
        titleLabel.text = hardness
        progressBar.setProgress(0.0, animated: true)
        
        UIView.animate(withDuration: Double(aggTimes[hardness]!)) {
            self.progressBar.setProgress(1.0, animated: true)
        }
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        if secondsPassed < totalTime {
            secondsPassed += 1
        } else {
            timer.invalidate()
            titleLabel.text = " DONE! "
            let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")

            player = try! AVAudioPlayer(contentsOf: url!)

            player.play()
        }
    }

    @IBOutlet weak var titleLabel: UILabel!
    
    
}


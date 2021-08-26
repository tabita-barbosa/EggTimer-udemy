//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    
    // 300, 420, 720
    let eggTime : [String : Int] = ["Soft": 4, "Medium": 5, "Hard": 6]
    var timer = Timer()
    var totalTime = 0
    var secondsPassed = 0
    
    var player: AVAudioPlayer!
    
    @IBAction func hardnessSelected(_ sender: UIButton) {

        timer.invalidate()
        let hardness = sender.currentTitle
        if hardness != nil{
            totalTime = eggTime[hardness!]!
        }
        progressBar.progress = 0.0
        secondsPassed = 0
        titleLabel.text = hardness
        // time interval = intervalo que queremos atualizar, queremos repetir a cada segundo, o selector é do objectiveC, aceita um nome de funcão como parametro
        timer = Timer.scheduledTimer(timeInterval: 1.0, target:self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    // cada vez que ativa a adiciona um segundo
    @objc func updateTimer(){
        if secondsPassed < totalTime {
            secondsPassed += 1
            progressBar.progress = Float(secondsPassed) / Float(totalTime)
        } else {
            timer.invalidate()
            titleLabel.text = "DONE!"
            alarm(soundName: "alarm_sound")
        }
    }
    
    func alarm (soundName: String){
        let url = Bundle.main.url(forResource: soundName, withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
    }
    
}

//
//  ViewController.swift
//  Music Player
//
//  Created by Enrique V. Kortright on 5/13/17.
//  Copyright © 2017 Enrique V. Kortright. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var positionSlider: UISlider!
    
    @IBOutlet weak var volumeSlider: UISlider!
    
    var player = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let audioPath = Bundle.main.path(forResource: "Dance Macabre", ofType: "mp3")
        do {
            try player = AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath!))
            player.volume = 0.5
            titleLabel.text = "Dance Macabre"
            positionSlider.value = Float(player.currentTime)
            volumeSlider.value = player.volume
            
            Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.updatePosition), userInfo: nil, repeats: true)
        } catch {
            print("Error loading mp3.")
        }
    }

    func updatePosition() {
        print(player.currentTime)
        let position = Float(player.currentTime) / Float(player.duration)
        positionSlider.value = position
    }
    
    @IBAction func playTapped(_ sender: Any) {
        player.play()
    }

    @IBAction func pauseTapped(_ sender: Any) {
        player.pause()
    }
    
    @IBAction func stopTapped(_ sender: Any) {
        player.currentTime = TimeInterval(0.0)
        positionSlider.value = 0.0
        player.stop()
    }
    
    @IBAction func positionSliderChanged(_ sender: Any) {
        print("positionSlider: \(positionSlider.value)")
        let position = Float(player.duration) * positionSlider.value
        player.currentTime = TimeInterval(position)
    }
    
    @IBAction func volumeSliderChanged(_ sender: Any) {
        player.volume = volumeSlider.value
    }
}


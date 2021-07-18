import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var boilingProgress: UIProgressView!

    let eggTimes = ["Soft" : 3, "Medium" : 4, "Hard" : 7]
    let totalProgress: Float = 1
    var secondsCounter = 0
    var unitProgress: Float = 0
    var timer = Timer()
    var player: AVAudioPlayer!
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        updateTimer()
        let hardness = sender.currentTitle!
        statusLabel.text = hardness
        secondsCounter = eggTimes[hardness]!
        unitProgress = totalProgress / Float(secondsCounter)
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
    }
    
    func updateTimer() {
        player?.stop()
        timer.invalidate()
        boilingProgress.progress = 0.0
    }
    
    @objc func updateCounter() {
        if secondsCounter > 0 {
            secondsCounter -= 1
            boilingProgress.progress += unitProgress
        } else {
            timeIsOver()
        }
    }
    
    func timeIsOver() {
        statusLabel.text = "Done!"
        timer.invalidate()
        playSound()
    }
    
    func playSound() {
        let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
    }
}

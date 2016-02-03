//
//  PlaySoundsViewController.swift
//  
//
//  Created by Matt Sommer on 7/9/15.
//
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    var audioPlayer:AVAudioPlayer!
    var receivedAudio:RecordedAudio!
    
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        audioEngine = AVAudioEngine()
        audioFile = try? AVAudioFile(forReading: receivedAudio.filePathUrl)
        
        audioPlayer = try? AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl)
        audioPlayer.enableRate = true;
    }

    @IBAction func playSlow(sender: UIButton) {
        print("in PlaySlow")
        playAudioWithVariableRate(0.5)
    }
    @IBAction func playFast(sender: UIButton) {
        print("in PlayFast")
        playAudioWithVariableRate(1.5)
    }
    @IBAction func stopPlay(sender: UIButton) {
        print("in StopPlay")
        stopRestAllAudio()
    }
    @IBAction func playChipmunkAudio(sender: UIButton) {
        print("in playChipmunkAudio")
        playAudioWithVariablePitch(1000)
    }
    
    @IBAction func playDarthvaderAudio(sender: UIButton) {
        print("in playDarthvaderAudio")
        playAudioWithVariablePitch(-1000)
    }
    
    func playAudioWithVariableRate(rate: Float){
        print("in playAudioWithVariableRate")
        stopRestAllAudio()
        audioPlayer.rate = rate
        audioPlayer.play()
    }
    
    func playAudioWithVariablePitch(pitch: Float){
        print("in playAudioWithVariablePitch")
        stopRestAllAudio()
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        do {
            try audioEngine.startAndReturnError()
        } catch _ {
        }
        
        audioPlayerNode.play()
    }
    
    func stopRestAllAudio()
    {
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        audioPlayer.currentTime = 0.0
    }
    
}

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
        audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error: nil)
        
        audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil)
        audioPlayer.enableRate = true;
    }

    @IBAction func playSlow(sender: UIButton) {
        println("in PlaySlow")
        playAudioWithVariableRate(0.5)
    }
    @IBAction func playFast(sender: UIButton) {
        println("in PlayFast")
        playAudioWithVariableRate(1.5)
    }
    @IBAction func stopPlay(sender: UIButton) {
        println("in StopPlay")
        stopRestAllAudio()
    }
    @IBAction func playChipmunkAudio(sender: UIButton) {
        println("in playChipmunkAudio")
        playAudioWithVariablePitch(1000)
    }
    
    @IBAction func playDarthvaderAudio(sender: UIButton) {
        println("in playDarthvaderAudio")
        playAudioWithVariablePitch(-1000)
    }
    
    func playAudioWithVariableRate(rate: Float){
        println("in playAudioWithVariableRate")
        stopRestAllAudio()
        audioPlayer.rate = rate
        audioPlayer.play()
    }
    
    func playAudioWithVariablePitch(pitch: Float){
        println("in playAudioWithVariablePitch")
        stopRestAllAudio()
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        
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

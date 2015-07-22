//
//  RecordSoundsViewController.swift
//  Pitch Perfect
//
//  Created by Matt Sommer on 7/8/15.
//  Copyright (c) 2015 Matt Sommer. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {

    @IBOutlet weak var infoUILabel: UILabel!
    @IBOutlet weak var stopRecordingUIButton: UIButton!
    @IBOutlet weak var recordUIButton: UIButton!
    
    var audioRecorder:AVAudioRecorder!
    var recordedAudio:RecordedAudio!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        stopRecordingUIButton.hidden = true;
        recordUIButton.enabled = true;
        infoUILabel.text = "Tap Microphone to Record Audio"
    }

    @IBAction func recordAudio(sender: UIButton) {
        println("in recordAudio")
        infoUILabel.text = "Recording Audio in Progress"
        stopRecordingUIButton.hidden = false;
        recordUIButton.enabled = false;
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as! String
        
        let recordingName = "my_audio.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        println(filePath)
        
        var session = AVAudioSession.sharedInstance()
        session.setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)
        
        audioRecorder = AVAudioRecorder(URL: filePath, settings: nil, error: nil)
        audioRecorder.delegate = self
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
        
    }
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!, successfully flag: Bool) {
        if(flag){
            recordedAudio = RecordedAudio(filePathUrl: recorder.url, title: recorder.url.lastPathComponent!)
            performSegueWithIdentifier("stopRecording", sender: recordedAudio)
        }else
        {
            println("Recording did not complete properly.")
            recordUIButton.enabled = true;
            stopRecordingUIButton.hidden = true;
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "stopRecording"){
            let playSoundsVC:PlaySoundsViewController = segue.destinationViewController as! PlaySoundsViewController
            
            let data = sender as! RecordedAudio
            playSoundsVC.receivedAudio = data
        }
    }
    
    @IBAction func stopRecording(sender: UIButton) {
        println("in stopRecording")
        stopRecordingUIButton.hidden = true;
        
        audioRecorder.stop()
        var audioSession = AVAudioSession.sharedInstance()
        audioSession.setActive(false, error: nil)
        
    }
}
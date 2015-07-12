//
//  RecordSoundsViewController.swift
//  Pitch Perfect
//
//  Created by Matt Sommer on 7/8/15.
//  Copyright (c) 2015 Matt Sommer. All rights reserved.
//

import UIKit

class RecordSoundsViewController: UIViewController {

    @IBOutlet weak var lbl_recording: UILabel!
    @IBOutlet weak var btn_stop_recording: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(animated: Bool) {
        lbl_recording.hidden = true;
        btn_stop_recording.hidden = true;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func recordAudio(sender: UIButton) {
        //TODO: Show text "recording in progress"
        //TODO: Record the user's Voice
        println("in recordAudio")
        lbl_recording.hidden = false
        btn_stop_recording.hidden = false;
    }
    @IBAction func stopRecording(sender: UIButton) {
        //TODO: Stop recording user's audio
        println("in stopRecording")
        lbl_recording.hidden = true
        btn_stop_recording.hidden = true;
    }
}
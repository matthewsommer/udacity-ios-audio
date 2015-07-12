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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if var filePath = NSBundle.mainBundle().pathForResource("movie_quote", ofType: "mp3"){
            var filePathURL = NSURL.fileURLWithPath(filePath)
            audioPlayer = AVAudioPlayer(contentsOfURL: filePathURL, error: nil)
            audioPlayer.enableRate = true;
        }else {
            println("the filepath is empty")
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func PlaySlow(sender: UIButton) {
        println("in PlaySlow")
        audioPlayer.stop()
        audioPlayer.rate = 0.5
        audioPlayer.play()
    }
    @IBAction func PlayFast(sender: UIButton) {
        println("in PlayFast")
        audioPlayer.stop()
        audioPlayer.rate = 1.5
        audioPlayer.play()
    }
    @IBAction func StopPlay(sender: UIButton) {
        println("in StopPlay")
        audioPlayer.stop()
        audioPlayer.currentTime = 0.0
    }
}

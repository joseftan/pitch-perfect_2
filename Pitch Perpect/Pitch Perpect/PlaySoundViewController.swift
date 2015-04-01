//
//  PlaySoundViewController.swift
//  Pitch Perpect
//
//  Created by Joseph Tan on 3/27/15.
//  Copyright (c) 2015 Joseph Tan. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundViewController: UIViewController {
    
    var audioPlayer:AVAudioPlayer!
    var receivedAudio:RecordedAudio!
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!
 
    func stopAllAudio(){
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
    }
    
    func playWithVariableRate(rateToSet: Float){
        audioPlayer.currentTime=0.0
        audioPlayer.rate=rateToSet
        audioPlayer.play()
    }
    
    
    func playAudioWithVariablePitch(pitch: Float){
        
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


    override func viewDidLoad() {
        super.viewDidLoad()
        audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil)
        audioPlayer.enableRate=true
        audioEngine=AVAudioEngine()
        audioFile=AVAudioFile(forReading: receivedAudio.filePathUrl, error: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func playSlow(sender: UIButton) {
        stopAllAudio()
        playWithVariableRate(0.5)
    }
    
    @IBAction func playFast(sender: UIButton) {
        stopAllAudio()
        playWithVariableRate(1.8)
    }
    
    
    
    @IBAction func playChipMunk(sender: UIButton) {
        stopAllAudio()
        playAudioWithVariablePitch(1000)
    }
    
    
    @IBAction func darthVader(sender: UIButton) {
        stopAllAudio()
        playAudioWithVariablePitch(-1000)
    }
    
    @IBAction func stopPlay(sender: UIButton) {
    stopAllAudio()
    }
    

}

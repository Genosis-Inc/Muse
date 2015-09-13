//
//  ViewController.swift
//  Muse
//
//  Created by Dongkyu Shin on 2015. 9. 3..
//  Copyright (c) 2015년 Genosis. All rights reserved.
//

import UIKit
import MediaPlayer


class ViewController: UIViewController {
    
    let MUSAudioMgr : MUSAudioManager = MUSAudioManager()   // 음악 관리자
    
    
    @IBAction func play(sender: UIButton)
    {
        MUSAudioMgr.play()
    }

    @IBAction func PlayPrev(sender: AnyObject)
    {
        MUSAudioMgr.playPrev()
    }
    
    @IBAction func PlayNext(sender: AnyObject)
    {
        MUSAudioMgr.playNext()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


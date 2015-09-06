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
    @IBAction func play(sender: UIButton) {
        let player = MPMusicPlayerController.systemMusicPlayer()
        player.setQueueWithItemCollection(MPMediaItemCollection(items: MPMediaQuery.songsQuery().items))
        
        player.play()
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


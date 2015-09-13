//
//  MUSAudioManager.swift
//  Muse
//
//  Created by Yuk Youngho on 2015. 9. 13..
//  Copyright (c) 2015년 Genosis. All rights reserved.
//

import Foundation
import MediaPlayer

class MUSAudioManager
{
    var sysMusicPlayer : MPMusicPlayerController! = nil
    var sysMediaQuery : MPMediaQuery! = nil
    
    
    init()
    {
        sysMusicPlayer = MPMusicPlayerController.systemMusicPlayer()
        
        if (nil != sysMusicPlayer)
        {
            sysMusicPlayer.setQueueWithItemCollection(MPMediaItemCollection(items: MPMediaQuery.songsQuery().items))
            sysMediaQuery = MPMediaQuery.songsQuery()
        }
    }
    
    deinit
    {
        
    }
    
    // @brief   현재 재생중인 곡의 다음 곡을 재생한다.
    // @param
    // @return  void
    func play()
    {
        if (nil != sysMusicPlayer)
        {
            sysMusicPlayer.play()
        }
    }
    
    // @brief   현재 재생중인 곡의 다음 곡을 재생한다.
    // @param   void
    // @return  void
    func playNext()
    {
        if (nil != sysMusicPlayer)
        {
            sysMusicPlayer.skipToNextItem()
            sysMusicPlayer.play()
        }
    }
    
    // @brief   현재 재생중인 곡의 이전 곡을 재생한다.
    // @param
    // @return  void
    func playPrev()
    {
        sysMusicPlayer.skipToPreviousItem()
        sysMusicPlayer.play()
    }
}

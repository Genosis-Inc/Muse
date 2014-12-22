//
//  MUSMediaItem.swift
//  Muse
//
//  Created by Yuk Youngho on 2014. 12. 7..
//  Copyright (c) 2014년 Genosis. All rights reserved.
//

/*
ETC.

1. 클래스의 각각의 속성은 선언과 동시에 초기화 해줘야 함. (컴파일 오류)

Import
    - Foundation    : Base
    - UIKit         : UIImage
*/



import Foundation
import UIKit



class MUSMediaItem
{
    var title   : String = String()   // 노래 제목
    var artist  : String = String()   // 가수 이름
    var album   : String = String()   // 앨범 이름
    var artwork : UIImage! = nil
}
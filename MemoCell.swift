//
//  MemoCell.swift
//  Memory
//
//  Created by SeungYeon Yoo on 2022/07/01.
//

import UIKit

class MemoCell: UITableViewCell {
    @IBOutlet weak var subject: UILabel!
    @IBOutlet weak var contents: UILabel!
    @IBOutlet weak var regdate: UILabel!
    @IBOutlet weak var img: UIImageView!
    
    //억지로 만든 부분인데
    //이상한 점: 스토리보드 상 '글의 제목'에서 Ctrl누르고 여기로 끌어오려는데 안 됨
    //예제 파일은 되는데 나만 안됨..
}

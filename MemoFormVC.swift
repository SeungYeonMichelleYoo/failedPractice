//
//  MemoFormVC.swift
//  Memory
//
//  Created by SeungYeon Yoo on 2022/07/01.
//

import UIKit

class MemoFormVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate {
    var subject: String!
    
    @IBOutlet weak var contents: UITextView!
    @IBOutlet weak var preview: UIImageView!
    
    //저장 버튼을 클릭했을 때 호출되는 메소드
    @IBAction func save(_ sender: Any) {
        //1) 내용을 입력하지 않았을 경우, 경고한다.
        guard self.contents.text?.isEmpty == false else {
            let alert = UIAlertController(title: nil, message: "내용을 입력해주세요.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            return
        }
        
        //2) MemoData 객체를 생성하고, 데이터를 담는다.
        let data = MemoData()
        
        data.title = self.subject //제목
        data.contents = self.contents.text //내용
        data.image = self.preview.image //이미지
        data.regdate = Date() //작성시각
        
        //3) 앱 델리게이트 객체를 읽어온다음, memolist 배열에 MemoData 객체를 추가한다.
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.memolist.append(data)
        
        //4) 작성폼 화면을 종료하고, 이전화면으로 돌아간다.
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    //카메라 버튼을 클릭했을 때 호출되는 메소드
    @IBAction func pick(_ sender: Any) {
        //이미지 피커 인스턴스 생성
        let picker = UIImagePickerController()
        
        picker.delegate = self
        picker.allowsEditing = true
        
        //이미지 피커 화면을 표시
        self.present(picker, animated: false)
    }
    
    //사용자가 이미지를 선택하면 자동으로 이 메소드가 호출됨
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        //선택된 이미지를 미리보기에 출력
        self.preview.image = info[.editedImage] as? UIImage
        
        //이미지 피커 컨트롤러를 닫는다.
        picker.dismiss(animated: false)
    }
    
    override func viewDidLoad() {
        self.contents.delegate = self
    }
    
    //사용자가 텍스트 뷰에 뭔가를 입력하면 자동으로 이 메소드가 호출된다.
    func textViewDidChange(_ textView: UITextView) {
        //내용의 최대 15자리까지 읽어 subject 변수에 저장.
        let contents = textView.text as NSString
        let length = ( (contents.length > 15) ? 15 : contents.length )
        self.subject = contents.substring(with: NSRange(location: 0, length: length) )
        
        //내비게이션 타이틀에 표시
        self.navigationItem.title = self.subject
    }
    
}

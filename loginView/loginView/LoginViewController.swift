//
//  LoginViewController.swift
//  loginView
//
//  Created by TJ on 2021/02/25.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var tfId: UITextField!
    @IBOutlet weak var tfPw: UITextField!
    @IBOutlet weak var btnTabAutoLogin: UIButton!
    @IBOutlet weak var btnLogin: UIButton!
    
    @IBOutlet weak var btnFindId: UIButton!
    @IBOutlet weak var btnFindPw: UIButton!
    @IBOutlet weak var btnSignIn: UIButton!
    
    @IBOutlet weak var btnGoogleLogin: UIButton!
    @IBOutlet weak var btnKakaoLogin: UIButton!
    @IBOutlet weak var btnNaverLogin: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func btnTabAutoLogin(_ sender: UIButton) {
        sender.isSelected.toggle()
        print(sender.isSelected)
        // true 일 때 : 색칠된 체크박스
        // false일 때 : 색칠안된 체크박스
    }
    
    // 로그인 버튼
    @IBAction func btnLogin(_ sender: UIButton) {
        let dbLoginCheck = DBLoginCheck()
        let result = dbLoginCheck.check(Id: "차종한", Pw: "산업공학")
        
        if result == 1 {
            let resultAlert = UIAlertController(title: "완료", message: "입력이 되었습니다.", preferredStyle: UIAlertController.Style.alert)
            let onAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {ACTION in
                self.navigationController?.popViewController(animated: true) // 화면 지워주기
            })
            resultAlert.addAction(onAction)
            present(resultAlert, animated: true, completion: nil)
        }else{
            let resultAlert = UIAlertController(title: "실패", message: "에러가 발생되었습니다.", preferredStyle: UIAlertController.Style.alert)
            let onAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
            resultAlert.addAction(onAction)
            present(resultAlert, animated: true, completion: nil)
        }
    }
    
    // 아이디 찾기
    @IBAction func btnFindId(_ sender: UIButton) {
    }
    
    // 비밀번호 찾기
    @IBAction func btnFindPw(_ sender: UIButton) {
    }
    
    // 회원가입
    @IBAction func btnSignIn(_ sender: UIButton) {
    }
    
    // 구글 로그인
    @IBAction func btnGoogleLogin(_ sender: UIButton) {
    }
    
    // 카카오 로그인
    @IBAction func btnKakaoLogin(_ sender: UIButton) {
    }
    
    // 네이버 로그인
    @IBAction func btnNaverLogin(_ sender: UIButton) {
    }
    
    
    
    
    
    
    
} // ----

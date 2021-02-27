//
//  LoginViewController.swift
//  loginView
//
//  Created by TJ on 2021/02/25.
//

import UIKit

class LoginViewController: UIViewController, DbLoginCheckProtocol{
    
    

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
        let inputId = tfId.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let inputPw = tfPw.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if isValidEmail(testStr: inputId){
            let dbLoginCheck = DBLoginCheck()
            dbLoginCheck.delegate = self
            dbLoginCheck.check(id: inputId, pw: inputPw)
        }else{
            let emailAlert = UIAlertController(title: "오류", message: "이메일 형식이 아닙니다.", preferredStyle: UIAlertController.Style.alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
            emailAlert.addAction(okAction)
            present(emailAlert, animated: true, completion: nil)
        }
    }
    
    
    func isValidEmail(testStr:String) -> Bool {
           let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
           let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
           return emailTest.evaluate(with: testStr)
    }
    
    
    func loginResult(result: Int) {
        print(result)
        switch result {
        case 1:
            print("로그인 성공")
            let resultAlert = UIAlertController(title: "완료", message: "로그인 성공", preferredStyle: UIAlertController.Style.alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
            resultAlert.addAction(okAction)
            present(resultAlert, animated: true, completion: nil)
            break
        case 0:
            print("비밀번호 틀림")
            break
        case -1:
            print("아이디 없음")
            break
        default:
            break
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

//
//  ViewController.swift
//  pickerRnD
//
//  Created by mini on 2021/02/14.
//

import UIKit
import SimpleAlertPickers // <------- AlertPicker

class ViewController: UIViewController {

    /////////////////////////////////////////////////////
    //
    // 버튼을 누르면 Alert형태로 팝업되는 picker입니다.
    // picker에서 선택한후 완료를 누르면 버튼에 선택한 값이 표시됩니다.
    //
    //
    /////////////////////////////////////////////////////
    
    // 피커에 들어갈 배열 구성.
    let times: [String] = (1...10).map { String($0) }
    // 피커에서 선택된 값 변수
    var pickedValue: String?
    
    
    // 버튼에 텍스트 띄우기 위해 잡아줌
    @IBOutlet weak var btnShowTime: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        pickedValue = times[0] // <-- 뷰가 생성될때 피커와 버튼에 값 주기
        //btnShowTime.setTitle = times[0]
        
    }

    
    
    // 버튼 클릭시 액션
    @IBAction func btnTime(_ sender: UIButton) {
        
        // Alert 형식
        let alert = UIAlertController( title: "시간을 정해주세요", message: nil, preferredStyle: UIAlertController.Style.alert)
        
        // 1~10까지를 String 타입 배열로 구성
//        let times: [String] = (1...10).map { String($0) }
        
        // addPickerView에 매개변수로 있는 values 자체가 [[String]] 형식이라 맞춰서 써야 될거같습니다.
        let pickerViewValues: [[String]] = [times]
        let pickerViewSelectedValue: PickerViewViewController.Index = (column: 0, row: times.firstIndex(of: pickedValue!) ?? 0) // picker가 생성될 때 pickedValue가 선택된 상태로 alert가 뜸.

        // alert에 picker 추가해주기 + async를 통해 버튼의 text 바꿔줌.
        // picker 선택시 action은 이 안에 써주시면 됩니다.
        alert.addPickerView(values: pickerViewValues, initialSelection: pickerViewSelectedValue) { vc, picker, index, values in
            DispatchQueue.main.async {
                UIView.animate(withDuration: 1) {
                    self.pickedValue = self.times[index.row] // 피커에서 선택한 값 변수에 저장해주기. 
                    self.btnShowTime.setTitle(self.pickedValue, for: .normal)
                }
            }
        }
        
        
        alert.addAction(title: "완료", style: .cancel)
        alert.show()
        
    }
    
} // ----


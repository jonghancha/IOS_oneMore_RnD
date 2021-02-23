//
//  TabataTimerSetViewController.swift
//  Tabata
//
//  Created by TJ on 2021/02/19.
//

import UIKit
import SimpleAlertPickers

class TabataTimerSetViewController: UIViewController {
    
    @IBOutlet weak var tabataUIView: UIView!
    @IBOutlet weak var tabataStartButton: UIButton!
    
    @IBOutlet weak var tabataRoundButton: UIButton!
    @IBOutlet weak var tabataWorkButton: UIButton!
    @IBOutlet weak var tabataRestButton: UIButton!
    
    
    @IBOutlet var labelTotalTime: UILabel!
    
    @IBOutlet weak var tabataRepButton: UIButton!
    
    @IBOutlet weak var tabataRepSetLabel: UILabel!
    @IBOutlet weak var tabataRepRestLabel: UILabel!
    @IBOutlet weak var tabataRepSetButton: UIButton!
    @IBOutlet weak var tabataRepRestButton: UIButton!
    
    /////////////////////////////////////////////////////
    //
    // 버튼을 누르면 Alert형태로 팝업되는 picker입니다.
    // picker에서 선택한후 완료를 누르면 버튼에 선택한 값이 표시됩니다.
    //
    //
    /////////////////////////////////////////////////////
    
    // 피커에 들어갈 배열 구성.
    var rounds = [String]() // = (1...10).map { String($0) }
    var times = [String]()  //= (5...100).map { String($0) }
    var rest = [String]() //= (1...10).map { String($0) }
    var setRounds = [String]()  //= (5...100).map { String($0) }
    var setRest = [String]() //= (1...10).map { String($0) }
    
    // 피커에서 선택된 값 변수
    var pickedRound: String?
    var pickedTime: String?
    var pickedRest: String?
    var pickedSetRound: String?
    var pickedSetRest: String?
    
    
    
    // 세트 횟수 보이기
    var isHidden: Bool = true
    
    var buttonRounds = [String]()
   
    var buttonTimes = [String]()
    var buttonRest = [String]()
    
    var buttonSetRounds = [String]()
    var buttonSetRest = [String]()
    
    
    // 보낼 값 배열
    var sendRound = [Int]()
    var sendTime = [Int]()
    var sendRest = [Int]()
    var sendSetRound = [Int]()
    var sendSetRest = [Int]()
    
    var indexRound = 0
    var indexWork = 0
    var indexRest = 0
    var indexSet = 0
    var indexSetRest = 0
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tabataUIView.layer.masksToBounds = true
        tabataUIView.layer.cornerRadius = 20
        
        tabataStartButton.layer.masksToBounds = true
        tabataStartButton.layer.cornerRadius = 20
        
        tabataRoundButton.layer.masksToBounds = true
        tabataRoundButton.layer.cornerRadius = 20
        tabataWorkButton.layer.masksToBounds = true
        tabataWorkButton.layer.cornerRadius = 20
        tabataRestButton.layer.masksToBounds = true
        tabataRestButton.layer.cornerRadius = 20
        
        tabataRepSetButton.layer.masksToBounds = true
        tabataRepSetButton.layer.cornerRadius = 20
        tabataRepRestButton.layer.masksToBounds = true
        tabataRepRestButton.layer.cornerRadius = 20
        
        
        // 피커, 버튼에 들어갈 배열 구성
        RoundInsert()
        WorkInsert()
        RestInsert()
        RepSetInsert()
        RepRestInsert()
        
        
        
        // 뷰가 생성될때 피커와 버튼에 값 주기
        pickedRound = rounds[0]
        pickedTime = times[0]
        pickedRest = rest[0]
        pickedSetRound = setRounds[0]
        pickedSetRest = setRest[0]
        
      
        
        
        tabataRoundButton.setTitle(rounds[0], for: .normal)
        tabataWorkButton.setTitle(times[0], for: .normal)
        tabataRestButton.setTitle(rest[0], for: .normal)
        tabataRepSetButton.setTitle(setRounds[0], for: .normal)
        tabataRepRestButton.setTitle(setRest[0], for: .normal)
        
  
        
        
        
        
        tabataRepSetLabel.isHidden = isHidden
        tabataRepSetButton.isHidden = isHidden
        tabataRepRestLabel.isHidden = isHidden
        tabataRepRestButton.isHidden = isHidden

        calculateTotal()
    } // viewDidLoad End.
    
    
    
    
    // Round 피커에 들어갈 배열
    func RoundInsert(){
        for i in 1...100 {
            rounds.append("\(i) 회")
            buttonRounds.append("\(i) 회")
            sendRound.append(i)
        }
    }
    // 얼마나 할까요? 피커에 들어갈 배열
    func WorkInsert(){
        var minute = 0
        var second = 0
        // Work picker에 들어갈 배열
        for i in 5...900{
            if i <= 30 {
                
                times.append("\(i) 초")
                buttonTimes.append("\(i) 초")
                sendTime.append(i)
                continue
            }else if i > 30 && i <= 55{
                if i % 5 == 0 {
                    
                    times.append("\(i) 초")
                    buttonTimes.append("\(i) 초")
                    sendTime.append(i)
                    continue
                }
            }else if i >= 60{
                minute = i / 60
                second = i % 60
                if i % 60 == 0 {
                    times.append("\(minute) 분")
                    buttonTimes.append("\(minute) 분")
                    sendTime.append(i)
                    continue
                }else{
                    if i < 600{
                        if i < 180 {
                            if i % 10 == 0 {
                                if second < 10 {
                                    times.append("0\(minute):0\(second) 분")
                                    buttonTimes.append("\(minute) 분 \(second) 초")
                                    sendTime.append(i)
                                    continue
                                }else{
                                    times.append("0\(minute):\(second) 분")
                                    buttonTimes.append("\(minute) 분 \(second) 초")
                                    sendTime.append(i)
                                    continue
                                }
                            }
                        }else if i < 420{
                            if i % 15 == 0 {
                                if second < 10 {
                                    times.append("0\(minute):0\(second) 분")
                                    buttonTimes.append("\(minute) 분 \(second) 초")
                                    sendTime.append(i)
                                    continue
                                }else{
                                    times.append("0\(minute):\(second) 분")
                                    buttonTimes.append("\(minute) 분 \(second) 초")
                                    sendTime.append(i)
                                    continue
                                }
                            }
                        }else{
                            if i % 30 == 0 {
                                if second < 10 {
                                    times.append("0\(minute):0\(second) 분")
                                    buttonTimes.append("\(minute) 분 \(second) 초")
                                    sendTime.append(i)
                                    continue
                                }else{
                                    times.append("0\(minute):\(second) 분")
                                    buttonTimes.append("\(minute) 분 \(second) 초")
                                    sendTime.append(i)
                                    continue
                                }
                            }
                        }
                        
                    }else{
                        if i % 60 == 0 {
                            if second < 10 {
                                times.append("\(minute):0\(second) 분")
                                buttonTimes.append("\(minute) 분 \(second) 초")
                                sendTime.append(i)
                            }else{
                                times.append("\(minute):\(second) 분")
                                buttonTimes.append("\(minute) 분 \(second) 초")
                                sendTime.append(i)
                            }
                        }
                    }
                }
            }
        }
    }
    
    
    // 얼마나 쉴까요? 피커에 들어갈 배열
    func RestInsert(){
        var minute = 0
        var second = 0
        // Work picker에 들어갈 배열
        for i in 0...900{
            if i <= 30 {
                rest.append("\(i) 초")
                buttonRest.append("\(i) 초")
                sendRest.append(i)
                continue
            }else if i > 30 && i <= 55{
                if i % 5 == 0 {
                    rest.append("\(i) 초")
                    buttonRest.append("\(i) 초")
                    sendRest.append(i)
                    continue
                }
            }else if i >= 60{
                minute = i / 60
                second = i % 60
                if i % 60 == 0 {
                    rest.append("\(minute) 분")
                    buttonRest.append("\(minute) 분")
                    sendRest.append(i)
                    continue
                }else{
                    if i < 600{
                        if i < 180 {
                            if i % 10 == 0 {
                                if second < 10 {
                                    rest.append("0\(minute):0\(second) 분")
                                    buttonRest.append("\(minute) 분 \(second) 초")
                                    sendRest.append(i)
                                    continue
                                }else{
                                    rest.append("0\(minute):\(second) 분")
                                    buttonRest.append("\(minute) 분 \(second) 초")
                                    sendRest.append(i)
                                    continue
                                }
                            }
                        }else if i < 420{
                            if i % 15 == 0 {
                                if second < 10 {
                                    rest.append("0\(minute):0\(second) 분")
                                    buttonRest.append("\(minute) 분 \(second) 초")
                                    sendRest.append(i)
                                    continue
                                }else{
                                    rest.append("0\(minute):\(second) 분")
                                    buttonRest.append("\(minute) 분 \(second) 초")
                                    sendRest.append(i)
                                    continue
                                }
                            }
                        }else{
                            if i % 30 == 0 {
                                if second < 10 {
                                    rest.append("0\(minute):0\(second) 분")
                                    buttonRest.append("\(minute) 분 \(second) 초")
                                    sendRest.append(i)
                                    continue
                                }else{
                                    rest.append("0\(minute):\(second) 분")
                                    buttonRest.append("\(minute) 분 \(second) 초")
                                    sendRest.append(i)
                                    continue
                                }
                            }
                        }
                        
                    }else{
                        if i % 60 == 0 {
                            if second < 10 {
                                rest.append("\(minute):0\(second) 분")
                                buttonRest.append("\(minute) 분 \(second) 초")
                                sendRest.append(i)
                            }else{
                                rest.append("\(minute):\(second) 분")
                                buttonRest.append("\(minute) 분 \(second) 초")
                                sendRest.append(i)
                            }
                        }
                    }
                }
            }
        }
    }
    
    // 반복세트 피커에 들어갈 배열
    func RepSetInsert(){
        for i in 1...10 {
            setRounds.append("\(i) 회")
            buttonSetRounds.append("\(i) 회")
            sendSetRound.append(i)
        }
    }
    // 세트 휴식시간 피커에 들어갈 배열
    func RepRestInsert(){
        var minute = 0
        var second = 0
        // Work picker에 들어갈 배열
        for i in 0...600{
             
            if i < 60{
                if i % 10 == 0 {
                    setRest.append("\(i) 초")
                    buttonSetRest.append("\(i) 초")
                    sendSetRest.append(i)
                    continue
                }
            }
            else if i >= 60{  // 1분 이상
                minute = i / 60
                second = i % 60
                if i % 60 == 0 {
                    setRest.append("\(minute) 분")
                    buttonSetRest.append("\(minute) 분")
                    sendSetRest.append(i)
                    continue
                }else{
                        if i < 300{
                            if i % 30 == 0 {
                                if second < 10 {
                                    setRest.append("0\(minute):0\(second) 분")
                                    buttonSetRest.append("\(minute) 분 \(second) 초")
                                    sendSetRest.append(i)
                                    continue
                                }else{
                                    setRest.append("0\(minute):\(second) 분")
                                    buttonSetRest.append("\(minute) 분 \(second) 초")
                                    sendSetRest.append(i)
                                    continue
                                }
                            }
                        }else {
                            if i % 60 == 0 {
                                if second < 10 {
                                    setRest.append("0\(minute):0\(second) 분")
                                    buttonSetRest.append("\(minute) 분 \(second) 초")
                                    sendSetRest.append(i)
                                    continue
                                }else{
                                    setRest.append("0\(minute):0\(second) 분")
                                    buttonSetRest.append("\(minute) 분 \(second) 초")
                                    sendSetRest.append(i)
                                    continue
                                }
                            }
                        }
                }
                            
                            
            }
        }
    }
    

    
    @IBAction func tabataRepButton(_ sender: UIButton) {
        tabataRepSetLabel.isHidden = true
        
        if isHidden {
            tabataRepSetLabel.isHidden = false
            tabataRepSetButton.isHidden = false
            tabataRepRestLabel.isHidden = false
            tabataRepRestButton.isHidden = false
        }else{
            tabataRepSetLabel.isHidden = true
            tabataRepSetButton.isHidden = true
            tabataRepRestLabel.isHidden = true
            tabataRepRestButton.isHidden = true
        }
        isHidden = !isHidden
        
    }
    
   
    
    @IBAction func tabataRoundButton(_ sender: UIButton) {
        // Alert 형식
        let alert = UIAlertController( title: "횟수를 정해주세요", message: nil, preferredStyle: UIAlertController.Style.alert)

        // 1~10까지를 String 타입 배열로 구성
//        let times: [String] = (1...10).map { String($0) }

        // addPickerView에 매개변수로 있는 values 자체가 [[String]] 형식이라 맞춰서 써야 될거같습니다.
        let pickerViewValues: [[String]] = [rounds]
        let pickerViewSelectedValue: PickerViewViewController.Index = (column: 0, row: indexRound ) // picker가 생성될 때 pickedValue가 선택된 상태로 alert가 뜸.
        
        
        // alert에 picker 추가해주기 + async를 통해 버튼의 text 바꿔줌.
        // picker 선택시 action은 이 안에 써주시면 됩니다.
        alert.addPickerView(values: pickerViewValues, initialSelection: pickerViewSelectedValue) { vc, picker, index, values in
            DispatchQueue.main.async {
                UIView.animate(withDuration: 1) {
                    self.pickedRound = self.rounds[index.row] // 피커에서 선택한 값 변수에 저장해주기.
                    self.tabataRoundButton.setTitle(self.pickedRound, for: .normal)
                    self.indexRound = index.row
                    self.calculateTotal()
                }
            }
        }


        alert.addAction(title: "완료", style: .cancel)
        alert.show()

    }
    
    @IBAction func tabataWorkButton(_ sender: UIButton) {
        // Alert 형식
        let alert = UIAlertController( title: "시간을 정해주세요", message: nil, preferredStyle: UIAlertController.Style.alert)

        // 1~10까지를 String 타입 배열로 구성
//        let times: [String] = (1...10).map { String($0) }

        // addPickerView에 매개변수로 있는 values 자체가 [[String]] 형식이라 맞춰서 써야 될거같습니다.
        let pickerViewValues: [[String]] = [times]
        let pickerViewSelectedValue: PickerViewViewController.Index = (column: 0, row: indexWork ) // picker가 생성될 때 pickedValue가 선택된 상태로 alert가 뜸.
        print("pickedTime = \(self.pickedTime!)")
        // alert에 picker 추가해주기 + async를 통해 버튼의 text 바꿔줌.
        // picker 선택시 action은 이 안에 써주시면 됩니다.
        alert.addPickerView(values: pickerViewValues, initialSelection: pickerViewSelectedValue) { vc, picker, index, values in
            DispatchQueue.main.async {
                UIView.animate(withDuration: 1) {
                    self.pickedTime = self.times[index.row] // 피커에서 선택한 값 변수에 저장해주기.
                    self.tabataWorkButton.setTitle(self.buttonTimes[index.row], for: .normal)
                    self.indexWork = index.row
                    self.calculateTotal()
                }
            }
        }


        alert.addAction(title: "완료", style: .cancel)
        alert.show()
    }
    
    @IBAction func tabataRestButton(_ sender: UIButton) {
        // Alert 형식
        let alert = UIAlertController( title: "시간을 정해주세요", message: nil, preferredStyle: UIAlertController.Style.alert)

        // 1~10까지를 String 타입 배열로 구성
//        let times: [String] = (1...10).map { String($0) }

        // addPickerView에 매개변수로 있는 values 자체가 [[String]] 형식이라 맞춰서 써야 될거같습니다.
        let pickerViewValues: [[String]] = [rest]
        let pickerViewSelectedValue: PickerViewViewController.Index = (column: 0, row: indexRest ) // picker가 생성될 때 pickedValue가 선택된 상태로 alert가 뜸.
        print("pickedRest = \(self.pickedRest!)")
        // alert에 picker 추가해주기 + async를 통해 버튼의 text 바꿔줌.
        // picker 선택시 action은 이 안에 써주시면 됩니다.
        alert.addPickerView(values: pickerViewValues, initialSelection: pickerViewSelectedValue) { vc, picker, index, values in
            DispatchQueue.main.async {
                UIView.animate(withDuration: 1) {
                    self.pickedRest = self.rest[index.row] // 피커에서 선택한 값 변수에 저장해주기.
                    self.tabataRestButton.setTitle(self.buttonRest[index.row], for: .normal)
                    self.indexRest = index.row
                    self.calculateTotal()
                }
            }
        }


        alert.addAction(title: "완료", style: .cancel)
        alert.show()
    }
    
    @IBAction func tabataRepSetButton(_ sender: UIButton) {
        // Alert 형식
        let alert = UIAlertController( title: "횟수를 정해주세요", message: nil, preferredStyle: UIAlertController.Style.alert)

        // 1~10까지를 String 타입 배열로 구성
//        let times: [String] = (1...10).map { String($0) }

        // addPickerView에 매개변수로 있는 values 자체가 [[String]] 형식이라 맞춰서 써야 될거같습니다.
        let pickerViewValues: [[String]] = [setRounds]
        let pickerViewSelectedValue: PickerViewViewController.Index = (column: 0, row: indexSet ) // picker가 생성될 때 pickedValue가 선택된 상태로 alert가 뜸.
        print("pickedSetRound = \(self.pickedSetRound!)")
        // alert에 picker 추가해주기 + async를 통해 버튼의 text 바꿔줌.
        // picker 선택시 action은 이 안에 써주시면 됩니다.
        alert.addPickerView(values: pickerViewValues, initialSelection: pickerViewSelectedValue) { vc, picker, index, values in
            DispatchQueue.main.async {
                UIView.animate(withDuration: 1) {
                    self.pickedSetRound = self.setRounds[index.row] // 피커에서 선택한 값 변수에 저장해주기.
                    self.tabataRepSetButton.setTitle(self.buttonSetRounds[index.row], for: .normal)
                    self.indexSet = index.row
                    self.calculateTotal()
                }
            }
        }


        alert.addAction(title: "완료", style: .cancel)
        alert.show()
    }
    
    @IBAction func tabataRepRestButton(_ sender: UIButton) {
        // Alert 형식
        let alert = UIAlertController( title: "시간을 정해주세요", message: nil, preferredStyle: UIAlertController.Style.alert)

        // 1~10까지를 String 타입 배열로 구성
//        let times: [String] = (1...10).map { String($0) }

        // addPickerView에 매개변수로 있는 values 자체가 [[String]] 형식이라 맞춰서 써야 될거같습니다.
        let pickerViewValues: [[String]] = [setRest]
        let pickerViewSelectedValue: PickerViewViewController.Index = (column: 0, row: indexSetRest ) // picker가 생성될 때 pickedValue가 선택된 상태로 alert가 뜸.
        print("pickedSetRest = \(self.pickedSetRest!)")
        // alert에 picker 추가해주기 + async를 통해 버튼의 text 바꿔줌.
        // picker 선택시 action은 이 안에 써주시면 됩니다.
        alert.addPickerView(values: pickerViewValues, initialSelection: pickerViewSelectedValue) { vc, picker, index, values in
            DispatchQueue.main.async {
                UIView.animate(withDuration: 1) {
                    self.pickedSetRest = self.setRest[index.row] // 피커에서 선택한 값 변수에 저장해주기.
                    self.tabataRepRestButton.setTitle(self.buttonSetRest[index.row], for: .normal)
                    self.indexSetRest = index.row
                    self.calculateTotal()
                }
            }
        }


        alert.addAction(title: "완료", style: .cancel)
        alert.show()
    }
    
    func calculateTotal(){
        var total = 1
        
        // total = 세트 수 * { 운동시간 * 라운드 수 + 쉬는시간 * (라운드 수 - 1) } + (세트 수 - 1) * 세트 휴식시간
        total =  sendSetRound[indexSet] * (sendRound[indexRound] * (sendTime[indexWork] + sendRest[indexRest]) - sendRest[indexRest]) + (sendSetRound[indexSet] - 1) * sendSetRest[indexSetRest]
        
        
        
        labelTotalTime.text = "\(total/60)분 \(total%60)초"
    }
    
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
         if segue.identifier == "tabataSegue"{
             let timerView = segue.destination as! TabataTimerViewController
        
            timerView.receiveItem(sendRound[indexRound], sendTime[indexWork], sendRest[indexRest], sendSetRound[indexSet], sendSetRest[indexSetRest])
            
            
         }
    

    }
    
}// ----

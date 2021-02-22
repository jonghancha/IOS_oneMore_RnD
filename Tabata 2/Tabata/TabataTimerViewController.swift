//
//  TabataTimerViewController.swift
//  Tabata
//
//  Created by TJ on 2021/02/19.
//

import UIKit

class TabataTimerViewController: UIViewController {

    @IBOutlet weak var tabataTimerUIView: UIView!
    
    @IBOutlet weak var tabataProgressBarUIView: UIView!
    @IBOutlet weak var buttonTabProgressBar: UIButton!
    @IBOutlet weak var labelTimer: UILabel!
 
    @IBOutlet weak var labelSet: UILabel!
    
    
    // segue를 통해 받아온 분
    var getRound: Int = 0
    var getWork: Int = 0
    var getRest: Int = 0
    var getSet: Int = 0
    var getSetRest: Int = 0
    

    
    // 프로그래스바 //
    var tabataProgressBar = TabataProgressBar()
    var radius: CGFloat!
    var progress: CGFloat!
    var answeredCorrect = 0
    var totalQuestions = 0
    
    
    
    // 타이머 //
    let countUpSelector: Selector = #selector(TabataTimerViewController.updateTime)
    let countDownSelector: Selector = #selector(TabataTimerViewController.countDownTime)
    static var timeOut = 0 // 시간 얼마나 가는지는 이 변수로 설정.
    let interval = 1.0// 시간 interval  1초
    var countUpTimer = Timer()
    var countDownTimer = Timer()
    var countDown = 10
    var countUp = 0 // 총 TIMER COUNT
    var minute = 0 // TIMER 분
    var second = 0 // TIMER 초
    var minuteText = ""
    var secondText = ""
    
    // button status //
    var countDownButtonStatus = true // 처음에는 카운트다운버튼 활성화
    var countUpButtonStatus = false // 처음에는 카운트업버튼 비활성화
    var countUpButtonOnOff = true // true 일때가 restart, false 일때가 pause
    let orangeColor = #colorLiteral(red: 1, green: 0.5215686275, blue: 0.2039215686, alpha: 1)                  // true 일때 누르면 false 로 바뀌면서 pause
    
    
    // 탭 카운트
    var tabCount = 0 // 초기값 설정
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        TabataTimerViewController.timeOut = getWork // timeOut 변수에 segue로 가져온 값 Int변환 및 초로 변환
    
        
        // Do any additional setup after loading the view.

        
        tabataTimerUIView.layer.masksToBounds = true
        tabataTimerUIView.layer.cornerRadius = 20
      
        
        labelSet.layer.masksToBounds = true
        labelSet.layer.cornerRadius = labelSet.frame.width/2
        
        
    }
    
    
    @IBAction func buttonTabProgressBar(_ sender: UIButton) {
        
        if countUpButtonStatus{
            // 카운트 업일때 버튼 ACTION
            // TRUE 일때 누르면 STOP
            if countUpButtonOnOff{
                progressCirclePause(nowTime: Double(countUp))
                countUpTimer.invalidate()
                labelTimer.text = "pause"
                countUpButtonOnOff = false
                
                
                
            // FALSE 일때 누르면 RESTART
            }else{
                labelTimer.text = "\(minuteText):\(secondText)"
                progressCircleRestart(nowTime: Double(countUp))
                countUpTimer = Timer.scheduledTimer(timeInterval: interval, target: self, selector: countUpSelector, userInfo: nil, repeats: true)
                countUpButtonOnOff = true
                
            }
           
            
        }else{
            // 카운트 다운일때 버튼 ACTION
            // 카운트다운 START
            if countDownButtonStatus{
                labelTimer.text = "\(countDown)"
                countDownTimer = Timer.scheduledTimer(timeInterval: interval, target: self, selector: countDownSelector, userInfo: nil, repeats: true)
                countDownButtonStatus = false
                
                //카운트다운 PAUSE
            }else{
                labelTimer.text = "Pause"
                countDownButtonStatus = true
                countDownTimer.invalidate()
            }
        }
    }

    
  // segue 연결
    func receiveItem(_ round: Int, _ work: Int, _ rest: Int, _ set: Int, _ setRest: Int) {
        getRound = round
        getWork = work
        getRest = rest
        getSet = set
        getSetRest = setRest
    }
    
    
    
    // COUNTDOWN
    @objc  func countDownTime(){
        labelTimer.text = "\(countDown)"
        countDown -= 1
        if countDown == -1{
            countDownTimer.invalidate()
            countUpButtonStatus = true
            labelTimer.text = "GO"
            countUpTimer = Timer.scheduledTimer(timeInterval: interval, target: self, selector: countUpSelector, userInfo: nil, repeats: true)
        }
    }

    
    
    
    
    // COUNTUP
    @objc func updateTime(){
        if countUp == 0{
            progressCircle()
            

        }else{
            
        }
        
        countUp += 1
        second += 1
        
        if second == 60 {
            minute += 1
            second = 0
        }
        
        if minute < 10{
            minuteText = "0\(minute)" // 분이 10보다 작으면 앞에 0을 붙여주므로 01:00을 완성
        }else{
            minuteText = "\(minute)"
        }
        if second < 10{
            secondText = "0\(second)"
        }else{
            secondText = "\(second)"
        }
        
        labelTimer.text = "\(minuteText):\(secondText)"
        
        if countUp == TabataTimerViewController.timeOut{
            countUpTimer.invalidate()
            buttonTabProgressBar.isEnabled = false
            labelTimer.text = "END"
           
            
        }
        
        

    }
    
    
    
    
    
    
    //처음 시작 프로그래스바 (기본)
    func progressCircle() {
        answeredCorrect = 100
        totalQuestions = 100

        //Configure Progress Bar
        radius = (tabataProgressBarUIView.frame.height)/2.60
        progress = CGFloat(answeredCorrect) / CGFloat (totalQuestions)
        tabataProgressBar.addProgressBar(radius: radius, progress: progress)
        tabataProgressBar.center = tabataProgressBarUIView.center

        //Adding view
        tabataProgressBarUIView.addSubview(tabataProgressBar)
        tabataProgressBar.loadProgress(percentage: progress)
    }
    
    
    
   


    // 프로그래스바 일시정지
    func progressCirclePause(nowTime: Double) {
        answeredCorrect = 100
        totalQuestions = 100

        //Configure Progress Bar
        radius = (tabataProgressBarUIView.frame.height)/2.60
        progress = CGFloat(answeredCorrect) / CGFloat (totalQuestions)
        tabataProgressBar.addProgressBar(radius: radius, progress: progress)
        tabataProgressBar.center = tabataProgressBarUIView.center


        //Adding view
        tabataProgressBarUIView.addSubview(tabataProgressBar)
        tabataProgressBar.loadProgressPause(percentage: progress,nowTime: nowTime)
    }

    
    
    // 프로그래스바 재시작
    func progressCircleRestart(nowTime: Double) {
        answeredCorrect = 100
        totalQuestions = 100

        //Configure Progress Bar
        radius = (tabataProgressBarUIView.frame.height)/2.60
        progress = CGFloat(answeredCorrect) / CGFloat (totalQuestions)
        tabataProgressBar.addProgressBar(radius: radius, progress: progress)
        tabataProgressBar.center = tabataProgressBarUIView.center

        //Adding view
        tabataProgressBarUIView.addSubview(tabataProgressBar)

        tabataProgressBar.loadProgressRestart(percentage: progress, nowTime: nowTime)
    }
      
    
    
    
     // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         //Get the new view controller using segue.destination.
         //Pass the selected object to the new view controller.
        
        
            
        }
    }
    


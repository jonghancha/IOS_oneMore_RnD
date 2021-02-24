//
//  TabataCommentViewController.swift
//  onemoretimer
//
//  Created by jonghan on 2021/02/24.
//

import UIKit


class TabataCommentViewController: UIViewController {

    @IBOutlet weak var labelResult: UILabel!
    @IBOutlet weak var textViewComment: UITextView!
    @IBOutlet weak var labelCurrentTime: UILabel!
    
    var db:DBHelper = DBHelper()
    
    var getRound = 0
    var getWork = 0
    var getSet = 0
    var insertExerciseComment = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        var minute = 0
        var second = 0
        
        minute = getWork / 60
        second = getWork % 60
        
        var stringWorkTime = ""
        
        if minute > 10 {
            if second < 10 {
                stringWorkTime = "\(minute):0\(second)"
            }else{
                stringWorkTime = "\(minute):\(second)"
            }
        }else{
            if second < 10 {
                stringWorkTime = "0\(minute):0\(second)"
            }else{
                stringWorkTime = "0\(minute):\(second)"
            }
        }
       
        
        
       
        let formatter_year = DateFormatter()
        formatter_year.dateFormat = "yy-MM-dd / HH:mm:ss"
        let current_year_string = formatter_year.string(from: Date())
       

        
        labelCurrentTime.text = current_year_string
        labelResult.text = "\(stringWorkTime) / \(getRound * getSet) 라운드"
    }
    
    // segue 연결
    func receiveItem(_ round: Int, _ work: Int, _ set: Int, _ time: String) {
        getRound = round
        getWork = work
        getSet = set
        insertExerciseComment = time
    }
    
    // comment 입력버튼 클릭 시 comment update
    @IBAction func buttonInsertComment(_ sender: UIButton) {
        
        let InsertExerciseComment: String = textViewComment.text!.trimmingCharacters(in: .whitespaces)
        
        // comment update
        db.updateByID(exerciseWhen: insertExerciseComment, exerciseComment: InsertExerciseComment)
        print(db.read())
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

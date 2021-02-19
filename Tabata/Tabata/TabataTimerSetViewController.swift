//
//  TabataTimerSetViewController.swift
//  Tabata
//
//  Created by TJ on 2021/02/19.
//

import UIKit

class TabataTimerSetViewController: UIViewController {
    
    @IBOutlet weak var tabataUIView: UIView!
    @IBOutlet weak var tabataStartButton: UIButton!
    
    @IBOutlet weak var tabataRoundButton: UIButton!
    @IBOutlet weak var tabataWorkButton: UIButton!
    @IBOutlet weak var tabataRestButton: UIButton!
    
    
    
    @IBOutlet weak var tabataRepButton: UIButton!
    
    @IBOutlet weak var tabataRepSetLabel: UILabel!
    @IBOutlet weak var tabataRepRestLabel: UILabel!
    @IBOutlet weak var tabataRepSetButton: UIButton!
    @IBOutlet weak var tabataRepRestButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tabataUIView.layer.masksToBounds = true
        tabataUIView.layer.cornerRadius = 20
        
        tabataStartButton.layer.masksToBounds = true
        tabataStartButton.layer.cornerRadius = 10
        
        tabataRoundButton.layer.masksToBounds = true
        tabataRoundButton.layer.cornerRadius = 10
        tabataWorkButton.layer.masksToBounds = true
        tabataWorkButton.layer.cornerRadius = 10
        tabataRestButton.layer.masksToBounds = true
        tabataRestButton.layer.cornerRadius = 10
        
        tabataRepSetButton.layer.masksToBounds = true
        tabataRepSetButton.layer.cornerRadius = 10
        tabataRepRestButton.layer.masksToBounds = true
        tabataRepRestButton.layer.cornerRadius = 10
        
    }
    
    @IBAction func tabataRepButton(_ sender: UIButton) {
        tabataRepSetLabel.isHidden = true
        print("pushed repButton")
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

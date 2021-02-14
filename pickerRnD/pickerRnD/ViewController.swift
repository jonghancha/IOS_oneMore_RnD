//
//  ViewController.swift
//  pickerRnD
//
//  Created by mini on 2021/02/14.
//

import UIKit
import SimpleAlertPickers

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        
        //let alert = UIAlertController(style: .actionSheet, title: "Picker View", message: "Preferred Content Height")

        let alert = UIAlertController( title: "Picker View", message: "Preferred Content Height", preferredStyle: UIAlertController.Style.alert)
        
        let frameSizes: [CGFloat] = (150...400).map { CGFloat($0) }
        let pickerViewValues: [[String]] = [frameSizes.map { Int($0).description }]
        let pickerViewSelectedValue: PickerViewViewController.Index = (column: 0, row: frameSizes.index(of: 216) ?? 0)

        alert.addPickerView(values: pickerViewValues, initialSelection: pickerViewSelectedValue) { vc, picker, index, values in
            DispatchQueue.main.async {
                UIView.animate(withDuration: 1) {
                    vc.preferredContentSize.height = frameSizes[index.row]
                }
            }
        }
        alert.addAction(title: "Done", style: .cancel)
        alert.show()
        //present(alert, animated: true, completion: nil)
        
        
        
        
    }


}


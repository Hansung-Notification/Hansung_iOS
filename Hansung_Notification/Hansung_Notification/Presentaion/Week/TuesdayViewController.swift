//
//  TuesdayViewController.swift
//  Hansung_Notification
//
//  Created by 김승찬 on 2022/08/01.
//

import UIKit

class TuesdayViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
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

}
extension TuesdayViewController: PageComponentProtocol {
    var pageTitle: String { "화" }
}

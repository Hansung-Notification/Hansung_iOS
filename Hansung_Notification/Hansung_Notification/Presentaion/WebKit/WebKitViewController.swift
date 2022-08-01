//
//  WebKitViewController.swift
//  Hansung_Notification
//
//  Created by 김승찬 on 2022/08/01.
//

import UIKit

class WebKitViewController: UIViewController {
    
    private let webView = WebKitView()
    
    var url: String = ""
    
    override func loadView() {
        self.view = webView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        print(url)
        openWebPage(to: "https://www.hansung.ac.kr/bbs/hansung/143/247692/artclView.do")
        print(url)
    }
    
    func openWebPage(to urlStr: String) {
          guard let url = URL(string: "https://www.hansung.ac.kr/bbs/hansung/143/247692/artclView.do") else { return }
          let request = URLRequest(url: url)
          webView.webView.load(request)
      }
  }



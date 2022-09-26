//
//  CafeteriaViewModel.swift
//  Hansung_Notification
//
//  Created by 김승찬 on 2022/07/25.
//

import Foundation

import SwiftSoup
import Alamofire

struct CafeteriaCrawlManager {
  static var cafeteriaDayArray = [String]()
  static var cafeteriaTypeArray = [String]()
  static var cafeteriaMenuArray = [String]()
  
  static func crawlCafeteria(viewController: MondayViewController) {
    let cafeteriaURL = URLs.baseURL + URLs.cafeteriaURL
    
    AF.request(cafeteriaURL).responseString { response in
      guard let html = response.value else { return }
      do {
        let doc: Document = try SwiftSoup.parse(html)
        let elements: Elements = try doc.select("#viewForm > div > table > tbody > tr")
        
        for (index, element) in elements.enumerated() {
          // 식단날짜
          self.cafeteriaDayArray.append(try element.select("th").text())
          // 식단구분, 메뉴
          if index % 2 == 0 {
            self.cafeteriaTypeArray.append(try element.select("td:nth-child(2)").text())
            var menuString = try element.select("td:nth-child(3)").toString()
            menuString = menuString.replacingOccurrences(of: "<br>", with: "\n")
            menuString = menuString.replacingOccurrences(of: "<td>", with: "")
            menuString = menuString.replacingOccurrences(of: "</td>", with: "")
            menuString = menuString.replacingOccurrences(of: "&amp;", with: "&")
            self.cafeteriaMenuArray.append(menuString)
          }
          if index % 2 == 1 {
            self.cafeteriaTypeArray.append(try element.select("td:nth-child(1)").text())
            var menuString = try element.select("td:nth-child(2)").toString()
            menuString = menuString.replacingOccurrences(of: "<br>", with: "\n")
            menuString = menuString.replacingOccurrences(of: "<td>", with: "")
            menuString = menuString.replacingOccurrences(of: "</td>", with: "")
            menuString = menuString.replacingOccurrences(of: "&amp;", with: "&")
            self.cafeteriaMenuArray.append(menuString)
          }
        }
        viewController.setCafeteriaData()
      } catch {
        print("cafeteria crawl error")
      }
    }
  }
}

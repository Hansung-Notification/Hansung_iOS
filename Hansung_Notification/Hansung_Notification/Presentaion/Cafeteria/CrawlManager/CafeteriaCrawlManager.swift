//
//  CafeteriaViewModel.swift
//  Hansung_Notification
//
//  Created by 김승찬 on 2022/07/25.
//

import Foundation

import SwiftSoup
import Alamofire
import UIKit

struct CafeteriaCrawlManager {
  
  static var cafeteriaDayArray = [String]()
  static var cafeteriaTypeArray = [String]()
  static var cafeteriaMenuNameArray = [String]()
  static var cafeteriaMenuPriceArray = [String]()
  
  static func crawlCafeteria(viewController: UIViewController) {
    let cafeteriaURL = URLs.baseURL + URLs.cafeteriaURL
    
    AF.request(cafeteriaURL).responseString { response in
      guard let html = response.value else { return }
      do {
        let doc: Document = try SwiftSoup.parse(html)
        let elements: Elements = try doc.select("#viewForm > div > table > tbody > tr")
        
        for (index, element) in elements.enumerated() {
          // 식단날짜
          self.cafeteriaDayArray.append(try element.select("th").text())
          self.cafeteriaDayArray = self.cafeteriaDayArray.filter {$0 != ""}
          
          // 식단구분, 메뉴
          if index % 2 == 0 {
            self.cafeteriaTypeArray.append(try element.select("td:nth-child(2)").text())
            var menuString = try element.select("td:nth-child(3)").toString()
            
            menuString = menuString.replacingOccurrences(of: "<br> <br> <br>볶음밥&amp;오므라이스&amp;돈까스 <br> <br>", with: "")
            menuString = menuString.replacingOccurrences(of: "<td>", with: "")
            menuString = menuString.replacingOccurrences(of: "</td>", with: "")
            menuString = menuString.replacingOccurrences(of: "<td colspan=\"3\">", with: "")
            menuString = menuString.replacingOccurrences(of: "&amp;", with: "&")
            
            var menuNames = ""
            var menuPrices = ""
            
            if menuString != "등록된 식단내용이(가) 없습니다." {
              let menus = menuString.components(separatedBy: "<br>")
              for menu in menus {
                let menu = menu.split(separator: " ")
                menuNames.append(menu[0]+"\n")
                menu[1] == "ⓣ" ? menuPrices.append(menu[2]+"원\n") : menuPrices.append(menu[1]+"원\n")
              }
            }
            else {
              menuNames = menuString
            }
            
            self.cafeteriaMenuNameArray.append(menuNames)
            self.cafeteriaMenuPriceArray.append(menuPrices)
            
          }
          if index % 2 == 1 {
            self.cafeteriaTypeArray.append(try element.select("td:nth-child(1)").text())
            var menuString = try element.select("td:nth-child(2)").toString()
            
            menuString = menuString.replacingOccurrences(of: "<br> <br> <br>볶음밥&amp;오므라이스&amp;돈까스 <br> <br>", with: "")
            menuString = menuString.replacingOccurrences(of: "<td>", with: "")
            menuString = menuString.replacingOccurrences(of: "</td>", with: "")
            menuString = menuString.replacingOccurrences(of: "<td colspan=\"3\">", with: "")
            menuString = menuString.replacingOccurrences(of: "&amp;", with: "&")
            
            var menuNames = ""
            var menuPrices = ""
            
            if menuString != "등록된 식단내용이(가) 없습니다." {
              let menus = menuString.components(separatedBy: "<br>")
              for menu in menus {
                let menu = menu.split(separator: " ")
                menuNames.append(menu[0]+"\n")
                menu[1] == "ⓣ" ? menuPrices.append(menu[2]+"원\n") : menuPrices.append(menu[1]+"원\n")
              }
            }
            else {
              menuNames = menuString
            }
            
            self.cafeteriaMenuNameArray.append(menuNames)
            self.cafeteriaMenuPriceArray.append(menuPrices)
            
          }
        }
        if viewController is MondayViewController {
          if let viewController = viewController as? MondayViewController {
            viewController.cafeteriaTableView.reloadData()
          }
        }
        else if viewController is TuesdayViewController {
          if let viewController = viewController as? TuesdayViewController {
            viewController.cafeteriaTableView.reloadData()
          }
        }
        else if viewController is WednesViewController {
          if let viewController = viewController as? WednesViewController {
            viewController.cafeteriaTableView.reloadData()
          }
        }
        else if viewController is ThursdayViewController {
          if let viewController = viewController as? ThursdayViewController {
            viewController.cafeteriaTableView.reloadData()
          }
        }
        else if viewController is FridayViewController {
          if let viewController = viewController as? FridayViewController {
            viewController.cafeteriaTableView.reloadData()
          }
        }
      } catch {
        print("cafeteria crawl error")
      }
    }
  }
}

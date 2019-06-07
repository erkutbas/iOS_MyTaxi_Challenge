//
//  WebSiteParser.swift
//  iOS_MyTaxi_Challenge
//
//  Created by Erkut Baş on 6/6/19.
//  Copyright © 2019 Erkut Baş. All rights reserved.
//

import Foundation
import Kanna

class WebsiteParser {
    public static let shared = WebsiteParser()
    
    func startToParseWebSite() throws {
        
        let urlString = "https://mytaxi.com/"
        
        guard let url = URL(string: urlString) else { throw ApiCallExceptions.notEligibleUrl }
        
        //let urlRequest = URLRequest(url: url)
        
        do {
            let httpString = try String(contentsOf: url)
            print("httpString: \(httpString)")
            self.parseHttpPagesToGetEligibleCountries(httpString: httpString)
        } catch let error as ApiCallExceptions {
            print("error : \(error)")
            throw error
        } catch let error {
            print("Something goes terribly wrong : \(error)")
            throw error
        }
        
        
    }
    
    func parseHttpPagesToGetEligibleCountries(httpString: String) {

        do {
            let doc = try Kanna.HTML(html: httpString, encoding: String.Encoding.utf8)
            print("doc : \(doc)")
            
            print("body : \(doc.body)")
            
        } catch let error {
            print("Error : \(error)")
        }

        /*
        if let doc = Kanna.HTML(html: html, encoding: String.Encoding.utf8) {
            
            // Search for nodes by CSS selector
            for show in doc.css("td[id^='Text']") {
                
                // Strip the string of surrounding whitespace.
                let showString = show.text!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
                
                // All text involving shows on this page currently start with the weekday.
                // Weekday formatting is inconsistent, but the first three letters are always there.
                let regex = try! NSRegularExpression(pattern: "^(mon|tue|wed|thu|fri|sat|sun)", options: [.caseInsensitive])
                
                if regex.firstMatch(in: showString, options: [], range: NSMakeRange(0, showString.characters.count)) != nil {
                    shows.append(showString)
                    print("\(showString)\n")
                }
            }
        }*/
        
    }
    
    
}

//
//  ViewController.swift
//  Sportify
//
//  Created by بسمله ابوزيد احمد on 19/05/2026.
//

import UIKit
import Alamofire // 1. Import the framework

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 2. Trigger the network test when the view loads
        runAlamofireTest()
    }

    func runAlamofireTest() {
        print("--- Starting Alamofire Test ---")
        
        // We use a public test URL that returns a simple JSON response
        let testURL = "https://httpbin.org/get"
        
        AF.request(testURL).responseJSON { response in
            print("\n--- Network Response Received ---")
            
            switch response.result {
            case .success(let value):
                print("Success! Alamofire is working perfectly.")
                print("Response Data: \(value)")
                
            case .failure(let error):
                print("Network Request Failed.")
                print("Error Details: \(error.localizedDescription)")
            }
            
            print("---------------------------------\n")
        }
    }
}


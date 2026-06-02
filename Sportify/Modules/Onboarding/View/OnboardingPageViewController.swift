//
//  OnboardingPageViewController.swift
//  Sportify
//
//  Created by بسمله ابوزيد احمد on 02/06/2026.
//

import UIKit

class OnboardingPageViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    var arr = [UIViewController]()
    override func viewDidLoad() {
        super.viewDidLoad()

        self.dataSource = self
        self.delegate = self
        
        let v1 = self.storyboard?.instantiateViewController(withIdentifier: "v1")
        let v2 = self.storyboard?.instantiateViewController(withIdentifier: "v2")
        
        arr.append(v1!)
        arr.append(v2!)
        
        if let v1 = arr.first {
            setViewControllers([v1], direction: .forward, animated: true, completion: nil)
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let curInd = arr.firstIndex(of: viewController) else{
            return nil
        }
        let ind = curInd - 1
        guard ind >= 0 else{
            return nil
        }
        
        return arr [ind]
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let curInd = arr.firstIndex(of: viewController) else{
            return nil
        }
        let ind = curInd + 1
        guard ind < arr.count else{
            return nil
        }
        
        return arr [ind]
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        arr.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
    

}

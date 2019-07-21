//
//  LGMAPageViewController.swift
//  BeMySight
//
//  Created by LGMA on 11/24/18.
//  Copyright © 2018 LGMA. All rights reserved.
//

import UIKit

class LGMAPageViewController: UIPageViewController {

    var pageControl = UIPageControl()
    
    lazy var viewControllersArray: [UIViewController] = {
        return [
            self.configureNewViewController(viewController: LGMAConstants.StoryboardID.WelcomeViewControllerID),
            self.configureNewViewController(viewController: LGMAConstants.StoryboardID.HelpViewControllerID),
            self.configureNewViewController(viewController: LGMAConstants.StoryboardID.ThanksViewControllerID)
        ]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Check if first time visit
        if !isFirstVisit() {
            performSegue(withIdentifier: "loginSegue", sender: self)
        }
        
        // Register fist visit
        registerFirstVisit()
        
        // Assign this class as delegate
        self.delegate = self
        self.dataSource = self
        
        configurePageControl()
        
        if let firstScreenViewController = viewControllersArray.first {
            setViewControllers([firstScreenViewController],
                               direction: .forward,
                               animated: true)
        }
    }
    
    private func isFirstVisit() -> Bool {
        return true
    }

    private func registerFirstVisit() {
        UserDefaults.standard.set(true, forKey: "Register")
    }
    
    private func configurePageControl() {
        let pageControllerFrame = CGRect(x: 0, y: Int(UIScreen.main.bounds.maxY) - 160, width: Int(UIScreen.main.bounds.width), height: 150)
        pageControl = UIPageControl(frame: pageControllerFrame)
        pageControl.numberOfPages = viewControllersArray.count
        pageControl.currentPage = 0
        pageControl.tintColor = #colorLiteral(red: 0.1437037587, green: 0.7184930444, blue: 0.9592192769, alpha: 1)
        pageControl.pageIndicatorTintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        pageControl.currentPageIndicatorTintColor = #colorLiteral(red: 0.1437037587, green: 0.7184930444, blue: 0.9592192769, alpha: 1)
        self.view.addSubview(pageControl)
    }
    
    private func configureNewViewController(viewController: String) -> UIViewController {
        return UIStoryboard(name: "Volunteer", bundle: nil).instantiateViewController(withIdentifier: viewController)
    }
}

extension LGMAPageViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = viewControllersArray.index(of: viewController)
            else {
                return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        guard previousIndex >= 0 else {
            return nil
        }
        
        guard viewControllersArray.count > previousIndex
            else {
                return nil
        }
        
        return viewControllersArray[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = viewControllersArray.index(of: viewController)
            else {
                return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        
        guard viewControllersArray.count != nextIndex
            else {
            return nil
        }
        
        guard viewControllersArray.count > nextIndex
            else {
            return nil
        }
        
        return viewControllersArray[nextIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            didFinishAnimating finished: Bool,
                            previousViewControllers: [UIViewController],
                            transitionCompleted completed: Bool) {
        let pageContentViewController = pageViewController.viewControllers![0]
        self.pageControl.currentPage = viewControllersArray.index(of: pageContentViewController)!
    }
    
}

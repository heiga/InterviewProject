//
//  MainScreenTabBarController.swift
//  InterviewProject
//
//  Created by Phillip Hoang on 2018-11-27.
//  Copyright © 2018 IC Heart Technologies. All rights reserved.
//

import UIKit
import PureLayout

class MainScreenTabBarController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.delegate = self
        self.view.backgroundColor = UIColor.white
        
        setupTabs()
        
        // breaks tab bar buttons
        // setupGestures()
    }
    
    func setupTabs() {
        let firstTab = AlphaViewController()
        let firstTabBarItem = UITabBarItem(title: "First", image: #imageLiteral(resourceName: "exploreIcon"), selectedImage: nil)
        firstTab.tabBarItem = firstTabBarItem
        
        let secondTab = BetaViewController()
        let secondTabBarItem = UITabBarItem(title: "Second", image: #imageLiteral(resourceName: "desktopIcon"), selectedImage: nil)
        secondTab.tabBarItem = secondTabBarItem
        
        let thirdTab = CharlieViewController()
        let thirdTabBarItem = UITabBarItem(title: "Third", image: #imageLiteral(resourceName: "settingsIcon"), selectedImage: nil)
        thirdTab.tabBarItem = thirdTabBarItem
        
        self.viewControllers = [firstTab, secondTab, thirdTab]
    }
    
    func setupGestures() {
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipe(gesture:)))
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipe(gesture:)))
        swipeLeft.direction = UISwipeGestureRecognizerDirection.left
        
        self.view.addGestureRecognizer(swipeRight)
        self.view.addGestureRecognizer(swipeLeft)
    }
    
    @objc func respondToSwipe(gesture: UISwipeGestureRecognizer) {
        if gesture.direction == .right {
            if self.selectedIndex > 0 {
                self.selectedIndex -= 1
            }
        } else if gesture.direction == .left {
            if let numberOfTabs = self.viewControllers?.count {
                if self.selectedIndex < numberOfTabs {
                    self.selectedIndex += 1
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

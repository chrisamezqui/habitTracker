//
//  MainTabBarViewController.swift
//  Habit Tracker
//
//  Created by Chris Amezquita on 7/27/23.
//

import UIKit

class MainTabBarViewController : UITabBarController {
    
    let apolloClient = ApolloClient(url: URL(string: APIConstants.localHostAdress)!)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let vc1 = UINavigationController(rootViewController: HabitListViewController(mode: .standardMode, apolloClient: apolloClient))
        let vc2 = UINavigationController(rootViewController:RoutinesViewController())
        
        vc1.tabBarItem.title = "My Habit Goals"
        vc2.tabBarItem.title = "My Routines"
        
        vc1.tabBarItem.image = UIImage(systemName:"list.bullet.clipboard")
        vc2.tabBarItem.image = UIImage(systemName: "square.stack.3d.up")
        
        
        tabBar.tintColor = .label
        setViewControllers([vc1, vc2], animated:true)
    }
}

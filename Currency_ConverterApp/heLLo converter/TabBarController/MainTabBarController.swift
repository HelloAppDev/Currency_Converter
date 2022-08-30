//
//  MainTabBarController.swift
//  heLLo converter
//
//  Created by Мария Изюменко on 17.08.2022.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    let dataLoaderNavigationVC = UINavigationController(rootViewController: CurrencyListTableViewController())
    let favouriteNavigationVC = UINavigationController(rootViewController: FavouriteCurrencyViewController())
    let calculatorNavigationVC = UINavigationController(rootViewController: CalculateViewController())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTabBarAppearance()
        generateTabBar()
    }
    
    func generateTabBar() {
        viewControllers = [
            generateVC(
                viewController: calculatorNavigationVC,
                title: "Калькулятор",
                image: UIImage(named: "calculator")
            ),
            generateVC(
                viewController: dataLoaderNavigationVC,
                title: "Валюты",
                image: UIImage(named: "wallet")
            ),
            generateVC(
                viewController: favouriteNavigationVC,
                title: "Избранное",
                image: UIImage(systemName: "star")
            )
        ]
    }
    
    func generateVC(viewController: UIViewController, title: String, image: UIImage?) -> UIViewController {
        
        viewController.tabBarItem.title = title
        viewController.tabBarItem.image = image
        return viewController
    }
    
    private func setTabBarAppearance() {
        let positionOnX: CGFloat = 16
        let positionOnY: CGFloat = 14
        let width = tabBar.bounds.width - positionOnX * 2
        let height = tabBar.bounds.height + positionOnY * 2
        
        let roundLayer = CAShapeLayer()
        
        let bezierPath = UIBezierPath(
            roundedRect: CGRect(
                x: positionOnX,
                y: tabBar.bounds.minY - positionOnY,
                width: width,
                height: height
            ),
            cornerRadius: height / 2
        )
        roundLayer.path = bezierPath.cgPath
        
        tabBar.layer.insertSublayer(roundLayer, at: 0)
        tabBar.itemWidth = width / 5
        tabBar.itemPositioning = .centered
        
        roundLayer.fillColor = UIColor.mainWhite.cgColor
        tabBar.tintColor = .tabBarItemAccent
        tabBar.unselectedItemTintColor = .tabBarItemLight
    }
}

//
//  ViewController.swift
//  NewTabBar
//
//  Created by Eric Dockery on 11/30/17.
//  Copyright © 2017 Eric Dockery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var containerView: UIView!

    private let heightFloat: CGFloat = 0.0
    private var tabs = [Tab]()

    override func viewDidLoad() {
        super.viewDidLoad()

        addTabs()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.frame = CGRect(x: 0, y: view.frame.maxY - 45 , width: view.frame.maxX, height: 45)
        if #available(iOS 11, *) {
            if (UIApplication.shared.keyWindow?.safeAreaInsets.top ?? 0.0 > heightFloat) {
                collectionView.frame = CGRect(x: 0, y: view.frame.maxY - 90 , width: view.frame.maxX, height: 90)
            }
        }

        //load viewcontroller in to containerview
        let viewControllerToAdd = UIViewController()
        let vc = UINib(nibName: tabs[0].tabViewControllerName, bundle: nil).instantiate(withOwner: viewControllerToAdd, options: nil)[0] as! UIView
        vc.frame = CGRect(x: 0, y: 0, width: containerView.frame.size.width, height: self.containerView.frame.size.height)
        containerView.addSubview(vc)
    }

    override func viewWillLayoutSubviews() {
        guard let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else {
            super.viewWillLayoutSubviews()
            return
        }
        flowLayout.invalidateLayout()
        super.viewWillLayoutSubviews()
    }

    private func addTabs() {
        let home = Tab(tabName: "Home", tabImageName: "home.png", tabViewControllerName: "GreenViewController")
        let shop = Tab(tabName: "Shop", tabImageName: "shop.png", tabViewControllerName: "BlueViewController")
        let cart = Tab(tabName: "Cart", tabImageName: "cart.png", tabViewControllerName: "GreenViewController")
        let quickPad = Tab(tabName: "QuickPad", tabImageName: "quickpad.png", tabViewControllerName: "BlueViewController")
        let groups = Tab(tabName: "Groups", tabImageName: "groups.png", tabViewControllerName: "GreenViewController")
        let reorderPad = Tab(tabName: "ReorderPad", tabImageName: "reorderPad.png", tabViewControllerName: "BlueViewController")
        let account = Tab(tabName: "Account", tabImageName: "account.png", tabViewControllerName: "GreenViewController")
        let branches = Tab(tabName: "Branches", tabImageName: "branches.png", tabViewControllerName: "BlueViewController")
        let photos = Tab(tabName: "Photos", tabImageName: "photos.png", tabViewControllerName: "GreenViewController")
        let videos = Tab(tabName: "Videos", tabImageName: "videos.png", tabViewControllerName: "BlueViewController")
        tabs.append(home)
        tabs.append(shop)
        tabs.append(cart)
        tabs.append(quickPad)
        tabs.append(groups)
        tabs.append(reorderPad)
        tabs.append(account)
        tabs.append(branches)
        tabs.append(photos)
        tabs.append(videos)
    }

}

extension ViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tabs.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let tabCell = collectionView.dequeueReusableCell(withReuseIdentifier: "tabCell", for: indexPath) as! TabCell
        tabCell.tabNameLabel.text = tabs[indexPath.row].tabName
        tabCell.updateWithImage(image: UIImage(named: tabs[indexPath.row].tabImageName))
        return tabCell
    }
}

extension ViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //load viewcontroller in to containerview
        let viewControllerToAdd = UIViewController()
        let vc = UINib(nibName: tabs[indexPath.row].tabViewControllerName, bundle: nil).instantiate(withOwner: viewControllerToAdd, options: nil)[0] as! UIView
        vc.frame = CGRect(x: 0, y: 0, width: containerView.frame.size.width, height: self.containerView.frame.size.height)
        containerView.addSubview(vc)
    }
}


extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if #available(iOS 11, *) {
            if (UIApplication.shared.keyWindow?.safeAreaInsets.top ?? 0.0 > heightFloat) {
                return CGSize(width: 60, height: 60)
            }
        }
        return CGSize(width: 60, height: 42)
    }
}

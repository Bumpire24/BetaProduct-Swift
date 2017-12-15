//
//  ProductsListView.swift
//  BetaProduct-Swift DEV
//
//  Created by User on 12/14/17.
//  Copyright © 2017 User. All rights reserved.
//

import UIKit

class ProductsListView: BaseView {
    @IBOutlet weak var productsListCollectionView: UICollectionView!
    @IBOutlet weak var deleteProductButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    
    var eventHandler : ProductInteractorInput?
    
    let cellScaling: CGFloat = 0.6
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTheme()
        
        let screenSize = UIScreen.main.bounds.size
        let cellWidth = floor(screenSize.width * cellScaling)
        let cellHeight = floor(screenSize.height * cellScaling)
        let insetX = (view.bounds.width - cellWidth) / 2.0
        let insetY = (view.bounds.height - cellHeight) / 2.0
        let layout = productsListCollectionView!.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        productsListCollectionView?.contentInset = UIEdgeInsets(top: insetY, left: insetX, bottom: insetY, right: insetX)
        productsListCollectionView?.dataSource = self
        productsListCollectionView?.delegate = self
        
        self.getAllProducts()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setupTheme() {
        BetaProductTheme.current.apply()
    }
    
    func getAllProducts() {
        eventHandler?.getProducts()
    }
}

extension ProductsListView : UICollectionViewDataSource
{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return interests.count
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductsListCollectionCell", for: indexPath) as! ProductsListCollectionViewCell
        
//        cell.interest = interests[indexPath.item]
        
        return cell
    }
}

extension ProductsListView : UIScrollViewDelegate, UICollectionViewDelegate
{
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>)
    {
        let layout = self.productsListCollectionView?.collectionViewLayout as! UICollectionViewFlowLayout
        let cellWidthIncludingSpacing = layout.itemSize.width + layout.minimumLineSpacing
        
        var offset = targetContentOffset.pointee
        let index = (offset.x + scrollView.contentInset.left) / cellWidthIncludingSpacing
        let roundedIndex = round(index)
        
        offset = CGPoint(x: roundedIndex * cellWidthIncludingSpacing - scrollView.contentInset.left, y: -scrollView.contentInset.top)
        targetContentOffset.pointee = offset
    }
}

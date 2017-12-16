//
//  ProductsListView.swift
//  BetaProduct-Swift DEV
//
//  Created by User on 12/14/17.
//  Copyright © 2017 User. All rights reserved.
//

import UIKit

class ProductsListView: BaseView, ProductsListViewProtocol {
    @IBOutlet weak var productsListCollectionView: UICollectionView!
    @IBOutlet weak var deleteProductButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    
    var eventHandler : ProductsModuleProtocol?
    var products : [ProductListItem]?
    
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.getAllProducts()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setupTheme() {
        BetaProductTheme.current.apply()
    }
    
    func getAllProducts() {
        eventHandler?.getAllProducts()
    }
    
    func displayProducts(_ products: [ProductListItem]) {
        self.products = products
        productsListCollectionView.reloadData()
    }
}

extension ProductsListView : UICollectionViewDataSource
{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let productCount = self.products?.count != nil ? self.products!.count : 0
        return productCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductsListCollectionCell", for: indexPath) as! ProductsListCollectionViewCell
        //cell.productImageView.image =
        let imageUrlString = products![indexPath.item].imageURL
        let imageUrl:URL = URL(string: imageUrlString!)!
        
        DispatchQueue.global(qos: .userInitiated).async {
            let imageData:NSData = NSData(contentsOf: imageUrl)!
//            let imageView = UIImageView(frame: CGRect(x:0, y:0, width:200, height:200))
//            imageView.center = self.view.center
            
            // When from background thread, UI needs to be updated on main_queue
            DispatchQueue.main.async {
                let image = UIImage(data: imageData as Data)
                cell.productImageView.image = image
                cell.productImageView.contentMode = UIViewContentMode.scaleAspectFit
                cell.productName.text = self.products![indexPath.item].name
                cell.productDescription.text = self.products![indexPath.item].description

            }
        }
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

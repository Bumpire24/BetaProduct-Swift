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
    
    var eventHandler : ProductListModuleProtocol?
    var productListWireframe : ProductListViewWireframe?
    var products : [ProductListItem]?
    var currentSelectedImageIndexPath : IndexPath?
    
    let cellScaling: CGFloat = 0.6
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTheme()
        enableTapGesture()
        
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
    
    func popProductItem() {
        
    }
    
    func deleteProductItemFromCollection() {
        getAllProducts()
    }
    
    // MARK: UI Actions
    override func enableTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.productItemTapped))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    @objc func productItemTapped() {
//        let productDetailPresenter = ProductDetailPresenter()
//        let productInteractor = ProductInteractor()
//        productDetailWireframe?.productDetailPresenter = productDetailPresenter
//        productDetailPresenter.interactor = productInteractor
//        productInteractor.outputDetail = productDetailPresenter
//        productDetailWireframe?.presentProductDetailViewFromViewController(self, productIndex: currentSelectedImageIndexPath!.item)
        productListWireframe?.displayProductDetail(withIndex: currentSelectedImageIndexPath!.item)
    }
    
    @IBAction func removeProductItemFromList(_ sender: Any) {
        eventHandler?.removeProductItem(withIndex: currentSelectedImageIndexPath!.item)
    }
    
    @IBAction func markProductItemAsFavorite(_ sender: Any) {
        
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
        
        return populateProductCell(withImageURL: products![indexPath.item].imageURL, forCell: cell, atIndex: indexPath)
    }
    
    func populateProductCell(withImageURL imageURLString: String? = nil, forCell cell: ProductsListCollectionViewCell, atIndex indexPath: IndexPath) -> ProductsListCollectionViewCell {
        guard imageURLString != nil else {
            return populateProductWithNoImageForCell(cell: cell, atIndex: indexPath)
        }
        
        let imageUrlString = imageURLString
        let imageUrl = URL(string: imageUrlString!)
        
        DispatchQueue.global(qos: .userInitiated).async {
            let imageData:NSData = NSData(contentsOf: imageUrl!)!
            
            // When from background thread, UI needs to be updated on main_queue
            DispatchQueue.main.async {
                let image = UIImage(data: imageData as Data)
                cell.productImageView.image = image
                cell.productImageView.contentMode = UIViewContentMode.scaleAspectFit
                cell.productName.text = self.products![indexPath.item].name
                cell.productDescription.text = self.products![indexPath.item].description
                
            }
        }
        
        return cell
    }
    
    func populateProductWithNoImageForCell(cell: ProductsListCollectionViewCell, atIndex indexPath: IndexPath) -> ProductsListCollectionViewCell {
        DispatchQueue.main.async {
            cell.productImageView.image = nil
            cell.productName.text = self.products![indexPath.item].name
            cell.productDescription.text = self.products![indexPath.item].description
        }
        
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
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        var visibleRect = CGRect()
        visibleRect.origin = productsListCollectionView.contentOffset
        visibleRect.size = productsListCollectionView.bounds.size
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        let visibleIndexPath: IndexPath = productsListCollectionView.indexPathForItem(at: visiblePoint)!
        currentSelectedImageIndexPath = visibleIndexPath
    }
}

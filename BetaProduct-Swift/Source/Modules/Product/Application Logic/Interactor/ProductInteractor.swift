//
//  ProductListInteractor.swift
//  BetaProduct-Swift
//
//  Created by User on 11/10/17.
//  Copyright © 2017 User. All rights reserved.
//

import Foundation

/// Interactor Class for Module `Product List`
class ProductInteractor: NSObject, ProductInteractorInput {
    var outputList: ProductListInteractorOutput?
    var outputDetail: ProductDetailInteractorOutput?
    var manager: ProductManager?
    var session: Session?
    var webservice: StoreWebClientProtocol?
    private var persistedProducts: [Product]?
    
    // MARK: ProductListInteractorInput
    
    // check if account has already synced
    // call WS and sync first if hasnt been synced yet and add items to Core Data
    // call Core Data to retrieve said products
    // persist retrieved Products
    // convert products to displayable
    // call output to display products
    
    func getProducts() {
        if let nonNilSession = session {
            if (nonNilSession.hasAlreadySynced()) {
                getProductToPersistAndToShowAsOutput()
            } else {
                webservice?.GET(BetaProduct.kBPWSProducts(), parameters: nil, block: { response in
                    switch response {
                    case .success(let value):
                        let products = value?.map({Product.init(dictionary: $0 as! [String: Any])})
                        if let nonNilProducts = products {
                            self.manager?.createProduct(withProducts: nonNilProducts,
                                                        WithUser: nonNilSession.getUserSessionAsUser(),
                                                        withCompletionBlock: { response in
                                                            switch response {
                                                            case .success(_):
                                                                nonNilSession.markSyncCompleted()
                                                                self.getProductToPersistAndToShowAsOutput()
                                                            case .failure(_):
                                                                self.outputList?.gotProducts([])
                                                            }
                            })
                        } else {
                            self.outputList?.gotProducts([])
                        }
                    case .failure(_):
                        self.outputList?.gotProducts([])
                    }
                })
            }
        } else {
            outputList?.gotProducts([])
        }
    }
    
    func deleteProductByIndex(_ index: Int) {
        if let nonNilPersistedProducts = persistedProducts, nonNilPersistedProducts.count > 0 {
            let productTobeDeleted = nonNilPersistedProducts[index]
            manager?.deleteProduct(product: productTobeDeleted, withCompletionBlock: { response in
                switch response {
                case .success(_): self.outputList?.productListDeleteComplete(wasSuccessful: true, withMessage: "Product Deleted!")
                case .failure(_): self.outputList?.productListDeleteComplete(wasSuccessful: false, withMessage: "Deletion Failed!")
                }
            })
        } else {
            outputList?.productListDeleteComplete(wasSuccessful: false, withMessage: "Deletion Failed!")
        }
    }
    
    func getProductDetailByIndex(_ index: Int) {
        if let nonNilPersistedProducts = persistedProducts, nonNilPersistedProducts.count > 0 {
            let productToBeDisplayed = nonNilPersistedProducts[index]
            outputDetail?.gotProduct(ProductDetailItem(name: productToBeDisplayed.name,
                                                       description: productToBeDisplayed.productDescription,
                                                       price: productToBeDisplayed.price,
                                                       priceDescription: productToBeDisplayed.priceDescription,
                                                       imageURL: productToBeDisplayed.imageUrl,
                                                       imageThumbURL: productToBeDisplayed.imageThumbUrl,
                                                       imageCompanyURL: productToBeDisplayed.imageCompanyUrl,
                                                       companyWeblink: productToBeDisplayed.weblink))
        } else {
            outputDetail?.gotProduct(nil)
        }
    }
    
    // MARK: Privates
    private func getProductToPersistAndToShowAsOutput() {
        manager?.retrieveProducts(withUser: session!.getUserSessionAsUser(), withCompletionBlock: { response in
            switch response {
            case .success(let value):
                self.persistedProducts = value
                self.outputList?.gotProducts(self.productDisplaysFromProducts(value!))
            case .failure(_): self.outputList?.gotProducts([])
            }
        })
    }
    
    private func productDisplaysFromProducts(_ products: [Product]) -> [ProductListItem] {
        let items = products.map { product in
            return ProductListItem(name: product.name,
                                   description: product.productDescription,
                                   imageURL: product.imageThumbUrl)
        }
        return items
    }
}

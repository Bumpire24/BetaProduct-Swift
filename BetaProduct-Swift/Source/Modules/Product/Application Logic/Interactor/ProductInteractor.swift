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
    var managerShopCart: ShopCartManager?
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
            outputDetail?.gotProduct(ProductDetailItem(id: productToBeDisplayed.productId,
                                                       name: productToBeDisplayed.name,
                                                       description: productToBeDisplayed.productDescription,
                                                       price: productToBeDisplayed.priceDescription + " " + String(describing: productToBeDisplayed.price),
                                                       priceDescription: productToBeDisplayed.priceDescription,
                                                       imageURL: productToBeDisplayed.imageUrl,
                                                       imageThumbURL: productToBeDisplayed.imageThumbUrl,
                                                       imageCompanyURL: productToBeDisplayed.imageCompanyUrl,
                                                       companyWeblink: productToBeDisplayed.weblink,
                                                       isAddedToShopCart: productToBeDisplayed.productAddedInCart))
        } else {
            outputDetail?.gotProduct(nil)
        }
    }
    
    func getProductDetailById(_ id: Int16) {
        manager?.retrieveProductById(id, withCompletionBlock: { response in
            switch response {
            case .success(let value):
                let productToBeDisplayed = value!
                self.outputDetail?.gotProduct(ProductDetailItem(id: productToBeDisplayed.productId,
                                                                                      name: productToBeDisplayed.name,
                                                                                      description: productToBeDisplayed.productDescription,
                                                                                      price: productToBeDisplayed.priceDescription + " " + String(describing: productToBeDisplayed.price),
                                                                                      priceDescription: productToBeDisplayed.priceDescription,
                                                                                      imageURL: productToBeDisplayed.imageUrl,
                                                                                      imageThumbURL: productToBeDisplayed.imageThumbUrl,
                                                                                      imageCompanyURL: productToBeDisplayed.imageCompanyUrl,
                                                                                      companyWeblink: productToBeDisplayed.weblink,
                                                                                      isAddedToShopCart: productToBeDisplayed.productAddedInCart))
            case .failure(_): self.outputDetail?.gotProduct(nil)
            }
        })
    }
    
    func addProductToCartByProductId(_ id: Int16) {
        if let user = session?.getUserSessionAsUser() {
            var shopCart = ShopCart()
            shopCart.userId = user.id
            shopCart.productId = id
            managerShopCart?.createShopCart(withCart: shopCart, withCompletionBlock: { response in
                switch response {
                case .success(_): self.outputDetail?.cartUpdateComplete(wasSuccessful: true, withMessage: "Product added")
                case .failure(_): self.outputDetail?.cartUpdateComplete(wasSuccessful: false, withMessage: "Unable to add Product")
                }
            })
        } else {
            outputDetail?.cartUpdateComplete(wasSuccessful: false, withMessage: "Unable to add Product")
        }
    }
    
    func removeProductFromCartByProductId(_ id: Int16) {
        if let user = session?.getUserSessionAsUser() {
            var shopCart = ShopCart()
            shopCart.userId = user.id
            shopCart.productId = id
            managerShopCart?.deleteShopCart(withCart: shopCart, withCompletionBlock: { response in
                switch response {
                case .success(_): self.outputDetail?.cartUpdateComplete(wasSuccessful: true, withMessage: "Product removed")
                case .failure(_): self.outputDetail?.cartUpdateComplete(wasSuccessful: false, withMessage: "Unable to remove Product")
                }
            })
        } else {
            outputDetail?.cartUpdateComplete(wasSuccessful: false, withMessage: "Unable to remove Product")
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

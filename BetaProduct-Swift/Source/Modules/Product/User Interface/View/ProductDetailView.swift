//
//  ProductDetailView.swift
//  BetaProduct-Swift DEV
//
//  Created by User on 12/18/17.
//  Copyright © 2017 User. All rights reserved.
//

import UIKit

class ProductDetailView: BaseView, ProductDetailViewProtocol {
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: BetaProductProductNameLabel!
    @IBOutlet weak var productDescription: BetaProductProductDescriptionLabel!
    @IBOutlet weak var productCurrency: BetaProductProductDescriptionLabel!
    @IBOutlet weak var productPrice: BetaProductProductDescriptionLabel!
    
    var eventHandler : ProductDetailModuleProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func fetchProductDetail(ofItemIndexAt itemIndex: Int) {
        eventHandler?.getProductItem(atIndex: itemIndex)
    }
    
    func fetchProductDetail(ofProductById id: Int16) {
        
    }
    
    func displayProductInformation(productItem: ProductDetailItem) {
        print(productItem)
    }
    
    func displayMessage(_ message: String) {
        displayDialogMessage(withTitle: "",
                             messageContent: message,
                             negativeButtonCaption: "Cancel",
                             affirmativeButtonCaption: "OK",
                             currentViewController: self,
                             messageStatus: false)
    }
}

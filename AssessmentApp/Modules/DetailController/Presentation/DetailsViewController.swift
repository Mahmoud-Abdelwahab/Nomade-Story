//
//  DetailController.swift
//  AssessmentApp
//
//  Created by Irfan Saeed on 19/01/2022.
//

import UIKit
import Combine

class DetailsViewController: UIViewController {

    //MARK: - Outlets
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var quantityLable: UILabel!
    @IBOutlet weak var productDescriptionLable: UILabel!
    @IBOutlet weak var productNameLable: UILabel!
    
    //MARK: - Variables
    var product: Product?
    var anyCancelable: AnyCancellable?

    //MARK: - Initialization
    init(){
          super.init(nibName: String(describing: type(of: self)), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
     bindUI()
    }
    
    private func  bindUI() {
        guard let product else{return}
        anyCancelable  =  ImageLoader(urlString: product.imageURL).didChange.sink(receiveValue: {[weak self] in
            guard let self else {return}
            self.productImage.image = UIImage(data: $0)
        })
        quantityLable.text           = "Quantity: \(product.quantity)"
        productDescriptionLable.text = product.description
        productNameLable.text        = product.name
    }
    
}

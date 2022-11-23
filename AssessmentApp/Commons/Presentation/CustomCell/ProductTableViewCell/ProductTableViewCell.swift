//
//  ProductTableViewCell.swift
//  AssessmentApp
//
//  Created by Mahmoud Abdul-wahab on 22/11/2022.
//

import UIKit
import Combine

class ProductTableViewCell: UITableViewCell {
    @IBOutlet weak var quantityLable: UILabel!
    @IBOutlet weak var retailPriceLable: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productDescriptionLable: UILabel!
    @IBOutlet weak var quantityStackView: UIStackView!
    @IBOutlet weak var productNameLable: UILabel!
    static var  identifier = "ProductTableViewCell"
    var anyCancelable: AnyCancellable?
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    func configureCell(product: Product, hidProductQuantity: Bool){
        anyCancelable =  ImageLoader(urlString: product.imageURL).didChange.sink(receiveValue: {[weak self] in
            guard let self else {return}
            self.productImage.image = UIImage(data: $0)
        })
        productNameLable.text = product.name
        productDescriptionLable.text = product.description
        if !hidProductQuantity{
            quantityStackView.isHidden = false
            quantityLable.text =  " Quantity: \( product.quantity)"
            retailPriceLable.text = "Retail Price for 1 Quantity: \(product.retailPrice) EGP"
        }
    }
}

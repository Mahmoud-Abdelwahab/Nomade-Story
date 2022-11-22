//
//  ProductTableViewCell.swift
//  AssessmentApp
//
//  Created by Mahmoud Abdul-wahab on 22/11/2022.
//

import UIKit
import Combine

class ProductTableViewCell: UITableViewCell {
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productDescriptionLable: UILabel!
    @IBOutlet weak var productNameLable: UILabel!
    static var  identifier = "ProductTableViewCell"
    var anyCancelable: AnyCancellable?
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    func configureCell(product: Product){
        anyCancelable =  ImageLoader(urlString: product.imageURL).didChange.sink(receiveValue: {[weak self] in
            guard let self else {return}
            self.productImage.image = UIImage(data: $0)
        })
        productNameLable.text = product.name
        productDescriptionLable.text = product.description
    }
}

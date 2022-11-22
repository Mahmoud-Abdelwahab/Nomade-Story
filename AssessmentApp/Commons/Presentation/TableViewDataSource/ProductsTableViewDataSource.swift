//
//  ProductsTableViewDataSource.swift
//  AssessmentApp
//
//  Created by Mahmoud Abdul-wahab on 22/11/2022.
//


import UIKit

class ProductsTableViewDataSource:NSObject, UITableViewDataSource,UITableViewDelegate {
 
    var productList: [Product]?
    var selectedProduct: ((Product)->())?
    var hideQuantity = true
     init(selectedProduct: @escaping ((Product)->()) ) {
        self.selectedProduct = selectedProduct
    }
    override init() {}
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        productList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProductTableViewCell.identifier, for: indexPath) as! ProductTableViewCell
        guard let product = productList?[indexPath.row] else {return UITableViewCell()}
                cell.configureCell(product: product,hidProductQuantity: hideQuantity)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard  let product = productList?[indexPath.row] else {return}
        selectedProduct?(product)
    }
    
}

//
//  AddNewProductViewController.swift
//  AssessmentApp
//
//  Created by Mahmoud Abdul-wahab on 22/11/2022.
//

import UIKit
import Combine

class AddNewProductViewController: UIViewController {
    
    @IBOutlet weak var productListTableVIewController: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var emptyStateLable: UILabel!
    
    private let dataSource: ProductsTableViewDataSource
    private let viewModel: AddProductsViewModel
    private var anyCancelable: Set<AnyCancellable>

    //MARK: - Initialization
    init(viewModel: AddProductsViewModel,
         dataSource: ProductsTableViewDataSource){
        self.viewModel  = viewModel
        self.dataSource = dataSource
        self.anyCancelable = Set<AnyCancellable>()
        super.init(nibName: String(describing: type(of: self)), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindUI()
        setupTableView()
        viewModel.getProductList()
    }
    
    private func bindUI() {
        viewModel.productListState.sink { [weak self] in
            guard let self  else {return}
            self.handleScreenState(state: $0)
        }.store(in: &anyCancelable)
        
        dataSource.selectedProduct = { [weak self]  in
            guard let self  else {return}
            self.handleNewSelectedProduct(product: $0)
        }
    }
    
    private func handleNewSelectedProduct(product: Product){
        print(product)
    }
    
    private func handleScreenState(state: ScreenState<[Product]>){
        switch state {
        case .startLoading:
            startLoding()
        case .stopLoading:
            stopLoading()
        case .result(let result):
            self.populateTableViewWith(products: result)
        case .showMessage(let error):
            self.showAlert(message: error)
        }
    }
    
    private func populateTableViewWith(products: [Product]) {
        self.emptyStateLable.isHidden = !products.isEmpty
        self.dataSource.productList = products
        self.productListTableVIewController.reloadData()
    }
    
    private func startLoding(){
        activityIndicator.startAnimating()
    }
    
    private func stopLoading(){
        activityIndicator.stopAnimating()
    }
    
    private func setupTableView() {
        productListTableVIewController.register(UINib(nibName: ProductTableViewCell.identifier, bundle: .main), forCellReuseIdentifier: ProductTableViewCell.identifier)
        productListTableVIewController.delegate   = dataSource
        productListTableVIewController.dataSource = dataSource
    }
}


extension AddNewProductViewController: Alertable{}

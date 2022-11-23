
//
//  MainController.swift
//  AssessmentApp
//
//  Created by Irfan Saeed on 19/01/2022.
//

import UIKit
import Combine

class MainScreenViewController: UIViewController {
    //MARK: - OutLets
    @IBOutlet weak var productListTableVIewController: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var emptyStateLable: UILabel!
    
    @IBOutlet weak var totalRetailLable: UILabel!
    //MARK: - Variables
    private var dataSource: ProductsTableViewDataSource
    private var anyCancelable: Set<AnyCancellable>
    
    let viewModel: MainScreenViewModel
    //MARK: - Initialization
    init(viewModel: MainScreenViewModel,dataSource: ProductsTableViewDataSource){
        self.viewModel     = viewModel
        self.dataSource    = dataSource
        self.anyCancelable = Set<AnyCancellable>()
        super.init(nibName: String(describing: type(of: self)), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindUI()
        setupNavigationController()
        setupTableView()
        viewModel.fechLocatProducts()
    }
    
    private func setupNavigationController(){
        let addButton = UIBarButtonItem(image: UIImage(systemName: "plus.circle"), style: .done, target: self, action: #selector(addNewProductdidTappped))
        addButton.tintColor = .black
        let clearAllButton = UIBarButtonItem(image: UIImage(systemName: "trash"), style: .done, target: self, action: #selector(clearAllButtondidTappped))
        clearAllButton.tintColor = .black
        navigationItem.rightBarButtonItems = [addButton,clearAllButton]
        title = "My Basket"
    }
    
    //MARK: - Actions
    @objc func addNewProductdidTappped(_ sender: UIBarButtonItem) {
        viewModel.openAddNewProductController()
    }
    
    @objc func clearAllButtondidTappped(_ sender: UIBarButtonItem) {
        if viewModel.isThereAnyProducts(){
            showTwoActionAlert(title: "Alert", message: "You Are About To Clear All Basket Products, Are you sure! 👀", okButtonTitle: "Confirm", cancelButtonTitle: "Cancel",okHandler : {[weak self] in
                guard let self else{return}
                self.viewModel.clearAll()
            })
        }else{
            showAlert(message: "Nothing To Delete 😁")
        }
    }
    
}
extension MainScreenViewController: Controllable {
    
    func bindUI() {
        viewModel.productListState.sink { [weak self] in
            guard let self  else {return}
            self.handleScreenState(state: $0)
        }.store(in: &anyCancelable)
        
        dataSource.selectedProduct = { [weak self]  in
            guard let self  else {return}
            self.handleSelectedProduct(product: $0)
        }

        viewModel.recalculateTotalRetailPrice.sink { [weak self] in
            guard let self  else {return}
            self.handleCalulatedRetailsPrices()
        }.store(in: &anyCancelable)
    }
    
   private func  handleCalulatedRetailsPrices() {
       totalRetailLable.text = self.viewModel.totalRetailPrices(productList: viewModel.productList)
    }
    
    func handleSelectedProduct(product: Product){
        viewModel.navigateToDetailsController(product: product)
    }
    
    func handleScreenState(state: ScreenState<[Product]>){
        switch state {
        case .startLoading:
            startLoding()
        case .stopLoading:
            stopLoading()
            break
        case .result(let result):
            self.populateTableViewWith(products: result)
        case .showMessage(let error):
            self.showAlert(message: error)
        }
    }
    
    func populateTableViewWith(products: [Product]) {
        self.emptyStateLable.isHidden = !products.isEmpty
        self.dataSource.productList?.removeAll()
        self.dataSource.productList = products
        self.productListTableVIewController.reloadData()
    }
    
    func startLoding(){
        activityIndicator.startAnimating()
    }
    
    func stopLoading(){
        activityIndicator.stopAnimating()
    }
    
    func setupTableView() {
        productListTableVIewController.register(UINib(nibName: ProductTableViewCell.identifier, bundle: .main), forCellReuseIdentifier: ProductTableViewCell.identifier)
        dataSource.hideQuantity                   = false
        productListTableVIewController.delegate   = dataSource
        productListTableVIewController.dataSource = dataSource
    }
    
}


extension MainScreenViewController: Alertable{}

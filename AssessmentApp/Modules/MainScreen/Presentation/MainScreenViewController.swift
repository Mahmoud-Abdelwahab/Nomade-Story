
//
//  MainController.swift
//  AssessmentApp
//
//  Created by Irfan Saeed on 19/01/2022.
//

import UIKit
#warning("""
The initial viewcontroller should show the shopping basket.
It should contain a 'Plus' button for adding new items to the basket.
It should contain a 'Clear' button for removing all items in the basket.
""")


class MainScreenViewController: UIViewController {

    ///TableView is embedded in the ScrollView.
    ///Set the Size of table view  on the basis of content in it.
    let viewModel: MainScreenViewModel
    //MARK: - Initialization
    init(viewModel: MainScreenViewModel){
        self.viewModel = viewModel
        super.init(nibName: String(describing: type(of: self)), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
         setupNavigationController()
    }
    
    private func setupNavigationController(){
        let addButton = UIBarButtonItem(image: UIImage(systemName: "plus.circle"), style: .done, target: self, action: #selector(addNewProductdidTappped))
        let clearAllButton = UIBarButtonItem(image: UIImage(systemName: "trash"), style: .done, target: self, action: #selector(clearAllButtondidTappped))
        navigationItem.rightBarButtonItems = [addButton,clearAllButton]
        title = "Local Products"
    }

    @objc func addNewProductdidTappped(_ sender: UIBarButtonItem) {
        viewModel.openAddNewProductController()
    }
    
    @objc func clearAllButtondidTappped(_ sender: UIBarButtonItem) {
        
    }
    
}





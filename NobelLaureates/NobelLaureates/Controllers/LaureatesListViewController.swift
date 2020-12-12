//
//  LaureatesListViewController.swift
//  NobelLaureates
//
//  Created by Karandeep Singh Bhatia on 12/12/20.
//

import Foundation
import UIKit
import CoreLocation

final class LaureatesListViewController: UIViewController, UITableViewDelegate {
  // MARK: Properties
  private var laureatesListViewModel = LaureatesListViewModel()
  @IBOutlet weak var laureatesListTableView: UITableView!
  private var datasource: TableViewDataSource<LaureatesTableViewCell,LaureatesModel>!
  var year: String?
  var latitude: Double?
  var longitude: Double?
  
  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
  }
  
  // MARK: - Layout Views
  private func configureUI() {
    self.datasource = TableViewDataSource(cellIdentifier: "LaureatesTableViewCell", items: self.laureatesListViewModel.laureatesModels) { cell, viewModel in
      let model = LaureatsDataModel(laureateName: viewModel.firstName.value + viewModel.lastName.value, awardCategory: viewModel.awardCategory.value, awardYear: viewModel.awardYear.value, country: viewModel.institutionCountry.value)
      cell.separatorInset = .zero
      cell.configure(model)
    }
    self.laureatesListTableView.dataSource = datasource
    self.laureatesListTableView.delegate = self
    self.laureatesListTableView.tableFooterView = UIView()
    loadLaureatesListData()
  }
  
  /// Method loads data for Laureates List.
  private func loadLaureatesListData() {
    guard let year = year, let latitude = latitude, let longitude = longitude else {
      fatalError("Need Year, Latitude & Longitude to proceed.")
    }
    let resource = Resource(jsonName: "nobel-prize-laureates")
    let laureatesParser = LaureatesParser()
    laureatesParser.parseLaureateResponse(resource: resource) { [weak self] (result) in
      guard let strongSelf = self else {
        return
      }
      switch result {
        case .success(let model):
          let dataModel = strongSelf.laureatesListViewModel.getHeighestRankedNobelLaureates(from: model, forYear: year, forLatitude: latitude, forLongitude: longitude)
          dataModel.forEach({
            strongSelf.laureatesListViewModel.addLaureatesListViewModel($0)
          })
          if dataModel.count == 0 {
            let alert = UIAlertController(title: "No Records Found!!", message: "Please try different combination", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
              strongSelf.navigationController?.popViewController(animated: true)
            }))
            strongSelf.present(alert, animated: true, completion: nil)
          } else {
            strongSelf.datasource.updateItems(strongSelf.laureatesListViewModel.laureatesModels)
          }
          strongSelf.laureatesListTableView.reloadData()
        case .failure(let error):
          print(error.localizedDescription)
      }
    }
  }
}

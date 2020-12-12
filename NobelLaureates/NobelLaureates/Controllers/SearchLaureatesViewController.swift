//
//  SearchLaureatesViewController.swift
//  NobelLaureates
//
//  Created by Karandeep Singh Bhatia on 12/12/20.
//

import UIKit

final class SearchLaureatesViewController: UIViewController {
  // MARK: Properties
  @IBOutlet weak var yearTextField: UITextField!
  @IBOutlet weak var latitudeTextField: UITextField!
  @IBOutlet weak var longitudeTextField: UITextField!
  private var yearsTillNow = [String]()
  
  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    createPickerView()
    dismissPickerView()
  }
  /// Method to add custom Picker View for Years between `1900` and `2020`.
  private func createPickerView() {
    for i in (1900...2020).reversed() {
      yearsTillNow.append("\(i)")
    }
    let pickerView = UIPickerView()
    pickerView.delegate = self
    pickerView.selectRow(0, inComponent: 0, animated: true)
    yearTextField.inputView = pickerView
  }
  /// Method to dismiss Picker view.
  private func dismissPickerView() {
    let toolBar: UIToolbar =  UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
    toolBar.sizeToFit()
    let button = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.action))
    toolBar.setItems([button], animated: true)
    toolBar.isUserInteractionEnabled = true
    yearTextField.inputAccessoryView = toolBar
    latitudeTextField.inputAccessoryView = toolBar
    longitudeTextField.inputAccessoryView = toolBar
    yearTextField.delegate = self
  }
  
  @objc func action() {
    view.endEditing(true)
  }
  /// Button Action for Search Button..
  @IBAction func searchLaureateButtonAction(_ sender: Any) {
    if let yearText = yearTextField.text, let latitudeText = latitudeTextField.text, let longitudeText = longitudeTextField.text {
      if yearText.isEmpty || latitudeText.isEmpty || longitudeText.isEmpty  {
       let alert = UIAlertController(title: "All Fields Are Mandatory!", message: "", preferredStyle: UIAlertController.Style.alert)
              alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
              self.present(alert, animated: true, completion: nil)
      } else {
        let laureatesListViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LaureatesListViewController") as! LaureatesListViewController
        laureatesListViewController.year = yearText
        laureatesListViewController.latitude = Double(latitudeText)
        laureatesListViewController.longitude = Double(longitudeText)
        self.navigationController?.pushViewController(laureatesListViewController, animated: true)
      }
    }
  }
}

// MARK: Picker View & TextField Delegate & Data Source.
extension SearchLaureatesViewController: UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
  
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return yearsTillNow.count
  }
  
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    return yearsTillNow[row]
    
  }
  
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    yearTextField.text = yearsTillNow[row]
  }
  
  func textFieldDidEndEditing(_ textField: UITextField) {
    if let text = textField.text, text.isEmpty {
      textField.text = yearsTillNow[0]
    }
  }
}

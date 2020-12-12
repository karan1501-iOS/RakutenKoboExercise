//
//  LaureatesListViewModel.swift
//  NobelLaureates
//
//  Created by Karandeep Singh Bhatia on 12/12/20.
//

import Foundation

struct LaureatesListViewModel {
  private(set) var laureatesModels = [LaureatesModel]()
  
  /// Method adds data for laureatesModels.
  mutating func addLaureatesListViewModel(_ vm: LaureatesModel) {
      self.laureatesModels.append(vm)
  }
  /// Method returns number of rows in section.
  func numberOfRows(_ section: Int) -> Int {
      return 20
  }

  /// Generates List of `Laureates` for given `year` `latitude` and  `longitude`
  /// - Parameters:
  ///    - model: A decodable object of type `LaureatesModel` which contains the metadata info of individual laureate.
  ///    - forYear: A string that contains input year.
  ///    - forLatitude: A double that contains input latitude.
  ///    - forLongitude: A double that contains input longitude.
  /// - Returns: List of Laureates .
    func getHeighestRankedNobelLaureates(from model: [LaureatesModel], forYear: String, forLatitude: Double, forLongitude: Double) -> [LaureatesModel] {
    
    var listFilteredByInputYear = [LaureatesModel]()
    
    var filteredLaureatesList = [LaureatesModel]()
    
    listFilteredByInputYear.append(contentsOf: model.filter({
      return $0.awardYear.value == forYear
    }))
    
    /// This has to be in the search result as this is filtered by inpur year and it should be of heighest rank.
    filteredLaureatesList.append(contentsOf: listFilteredByInputYear)
    
    /// Array of countries from the array filtered by input year.
    let listOfCountriesFromListFilteredByYear = listFilteredByInputYear.compactMap({
      $0.institutionCountry.value
    })
    
    /// Returns country which is repeated most or has heighest rank.
    guard let heighestRankedCountry = mostFrequentCountry(countryList: listOfCountriesFromListFilteredByYear) else {
      return listFilteredByInputYear
    }
    
    ///List of Lureates from the model filtered by heighest ranked country.
    let listFilteredBasedOnLocation = model.filter({
      return $0.institutionCountry.value == heighestRankedCountry
    })
    
    /// List of Laureates filtered by input location.
    let listOfLaureatesBasedOnLatLong = model.filter({
      return $0.location.latitude.value == forLatitude && $0.location.longitutde.value == forLongitude
    })
    
    ///List of Laureates based on input Latitude and Longitude.
    listOfLaureatesBasedOnLatLong.forEach({
      if !filteredLaureatesList.contains($0) {
        filteredLaureatesList.append($0)
      }
    })
    
    /// Add Remaing Laureates from List filtered by Heighest Rank Country.
    if filteredLaureatesList.count < 20 {
      for aModel in listFilteredBasedOnLocation {
        if filteredLaureatesList.count == 20 {
          break
        } else {
          filteredLaureatesList.append(aModel)
        }
      }
    }
    
   return filteredLaureatesList
  }
  
  func mostFrequentCountry(countryList: [String]) -> String? {

      let counts = countryList.reduce(into: [:]) { $0[$1, default: 0] += 1 }

      if let (value, _) = counts.max(by: { $0.1 < $1.1 }) {
          return value
      }
      return nil
  }
}

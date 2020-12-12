//
//  LaureatesParser.swift
//  NobelLaureates
//
//  Created by Karandeep Singh Bhatia on 12/12/20.
//

import Foundation

enum ParseError: Error {
  case decodingError
}

struct Resource {
  let jsonName: String
  var path: String? {
    let jsonPath: String? = Bundle.main.path(forResource: self.jsonName, ofType: "json")
    return jsonPath
  }
}

final class LaureatesParser {

  // MARK: - Parse Laureates data
  /// Parses all the fragments from the `LaureateResponse`
  func parseLaureateResponse(resource: Resource, completion: @escaping (Result<[LaureatesModel], ParseError>) -> Void) {
    if let path = resource.path {
      do {
        let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
        let result  = try? JSONDecoder().decode([LaureatesModel].self, from: data)
        if let laureate = result {
          DispatchQueue.main.async {
            completion(.success(laureate))
          }
        }
      } catch {
        completion(.failure(.decodingError))
      }
    }
  }
}

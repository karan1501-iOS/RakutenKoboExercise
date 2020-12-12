//
//  LaureatesModel.swift
//  NobelLaureates
//
//  Created by Karandeep Singh Bhatia on 12/12/20.
//

import Foundation


struct LaureatesModel: Decodable, Equatable {
  
  var id: Dynamic<Int64>
  var awardCategory: Dynamic<String>
  var diedDate: Dynamic<String>
  var diedCity: Dynamic<String>
  var bornCity: Dynamic<String>
  var bornDate: Dynamic<String>
  var lastName: Dynamic<String>
  var firstName: Dynamic<String>
  var motivation: Dynamic<String>
  var institutionCity: Dynamic<String>
  var bornCountry: Dynamic<String>
  var awardYear: Dynamic<String>
  var diedCountry: Dynamic<String>
  var institutionCountry: Dynamic<String>
  var gender: Dynamic<String>
  var institutionName: Dynamic<String>
  var location: Location
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    id = Dynamic(try container.decode(Int64.self, forKey: .id))
    awardCategory = Dynamic(try container.decode(String.self, forKey: .awardCategory))
    diedDate = Dynamic(try container.decode(String.self, forKey: .diedDate))
    diedCity = Dynamic(try container.decode(String.self, forKey: .diedCity))
    bornCity = Dynamic(try container.decode(String.self, forKey: .bornCity))
    bornDate = Dynamic(try container.decode(String.self, forKey: .bornDate))
    lastName = Dynamic(try container.decode(String.self, forKey: .lastName))
    firstName = Dynamic(try container.decode(String.self, forKey: .firstName))
    motivation = Dynamic(try container.decode(String.self, forKey: .motivation))
    institutionCity = Dynamic(try container.decode(String.self, forKey: .institutionCity))
    bornCountry = Dynamic(try container.decode(String.self, forKey: .bornCountry))
    awardYear = Dynamic(try container.decode(String.self, forKey: .awardYear))
    diedCountry = Dynamic(try container.decode(String.self, forKey: .diedCountry))
    institutionCountry = Dynamic(try container.decode(String.self, forKey: .institutionCountry))
    gender = Dynamic(try container.decode(String.self, forKey: .gender))
    institutionName = Dynamic(try container.decode(String.self, forKey: .institutionName))
    location = try container.decode(Location.self, forKey: .location)
  }

  private enum CodingKeys: String, CodingKey {
    case id
    case gender
    case location
    case awardCategory = "category"
    case diedDate = "died"
    case diedCity = "diedcity"
    case bornCity = "borncity"
    case bornDate = "born"
    case lastName = "surname"
    case firstName = "firstname"
    case motivation
    case institutionCity = "city"
    case bornCountry = "borncountry"
    case awardYear = "year"
    case diedCountry = "diedcountry"
    case institutionCountry = "country"
    case institutionName = "name"
  }
}

struct Location: Decodable {
  var latitude: Dynamic<Double>
  var longitutde: Dynamic<Double>
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    latitude = Dynamic(try container.decode(Double.self, forKey: .latitude))
    longitutde = Dynamic(try container.decode(Double.self, forKey: .longitutde))
  }
  
  private enum CodingKeys: String, CodingKey {
    case latitude = "lat"
    case longitutde = "lng"
  }
}

extension LaureatesModel {
  static func == (lhs: LaureatesModel, rhs: LaureatesModel) -> Bool {
    return lhs.id.value == rhs.id.value
  }
}

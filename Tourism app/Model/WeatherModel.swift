//
//  WeatherModel.swift
//  Tourism app
//
//  Created by MacBook Pro on 2/9/23.
//

import Foundation

struct WeatherModel : Codable {
    let headline : Headline?
    let dailyForecasts : [DailyForecasts]?

    enum CodingKeys: String, CodingKey {

        case headline = "Headline"
        case dailyForecasts = "DailyForecasts"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        headline = try values.decodeIfPresent(Headline.self, forKey: .headline)
        dailyForecasts = try values.decodeIfPresent([DailyForecasts].self, forKey: .dailyForecasts)
    }
}

struct DailyForecasts : Codable {
    let date : String?
    let epochDate : Int?
    let temperature : Temperature?
    let day : Day?
    let night : Night?
    let sources : [String]?
    let mobileLink : String?
    let link : String?

    enum CodingKeys: String, CodingKey {

        case date = "Date"
        case epochDate = "EpochDate"
        case temperature = "Temperature"
        case day = "Day"
        case night = "Night"
        case sources = "Sources"
        case mobileLink = "MobileLink"
        case link = "Link"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        date = try values.decodeIfPresent(String.self, forKey: .date)
        epochDate = try values.decodeIfPresent(Int.self, forKey: .epochDate)
        temperature = try values.decodeIfPresent(Temperature.self, forKey: .temperature)
        day = try values.decodeIfPresent(Day.self, forKey: .day)
        night = try values.decodeIfPresent(Night.self, forKey: .night)
        sources = try values.decodeIfPresent([String].self, forKey: .sources)
        mobileLink = try values.decodeIfPresent(String.self, forKey: .mobileLink)
        link = try values.decodeIfPresent(String.self, forKey: .link)
    }

}

struct Day : Codable {
    let icon : Int?
    let iconPhrase : String?
    let hasPrecipitation : Bool?
    let precipitationType : String?
    let precipitationIntensity : String?

    enum CodingKeys: String, CodingKey {

        case icon = "Icon"
        case iconPhrase = "IconPhrase"
        case hasPrecipitation = "HasPrecipitation"
        case precipitationType = "PrecipitationType"
        case precipitationIntensity = "PrecipitationIntensity"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        icon = try values.decodeIfPresent(Int.self, forKey: .icon)
        iconPhrase = try values.decodeIfPresent(String.self, forKey: .iconPhrase)
        hasPrecipitation = try values.decodeIfPresent(Bool.self, forKey: .hasPrecipitation)
        precipitationType = try values.decodeIfPresent(String.self, forKey: .precipitationType)
        precipitationIntensity = try values.decodeIfPresent(String.self, forKey: .precipitationIntensity)
    }

}

struct Headline : Codable {
    let effectiveDate : String?
    let effectiveEpochDate : Int?
    let severity : Int?
    let text : String?
    let category : String?
    let endDate : String?
    let endEpochDate : Int?
    let mobileLink : String?
    let link : String?

    enum CodingKeys: String, CodingKey {

        case effectiveDate = "EffectiveDate"
        case effectiveEpochDate = "EffectiveEpochDate"
        case severity = "Severity"
        case text = "Text"
        case category = "Category"
        case endDate = "EndDate"
        case endEpochDate = "EndEpochDate"
        case mobileLink = "MobileLink"
        case link = "Link"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        effectiveDate = try values.decodeIfPresent(String.self, forKey: .effectiveDate)
        effectiveEpochDate = try values.decodeIfPresent(Int.self, forKey: .effectiveEpochDate)
        severity = try values.decodeIfPresent(Int.self, forKey: .severity)
        text = try values.decodeIfPresent(String.self, forKey: .text)
        category = try values.decodeIfPresent(String.self, forKey: .category)
        endDate = try values.decodeIfPresent(String.self, forKey: .endDate)
        endEpochDate = try values.decodeIfPresent(Int.self, forKey: .endEpochDate)
        mobileLink = try values.decodeIfPresent(String.self, forKey: .mobileLink)
        link = try values.decodeIfPresent(String.self, forKey: .link)
    }

}

struct Maximum : Codable {
    let value : Int?
    let unit : String?
    let unitType : Int?

    enum CodingKeys: String, CodingKey {

        case value = "Value"
        case unit = "Unit"
        case unitType = "UnitType"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        value = try values.decodeIfPresent(Int.self, forKey: .value)
        unit = try values.decodeIfPresent(String.self, forKey: .unit)
        unitType = try values.decodeIfPresent(Int.self, forKey: .unitType)
    }

}

struct Minimum : Codable {
    let value : Int?
    let unit : String?
    let unitType : Int?

    enum CodingKeys: String, CodingKey {

        case value = "Value"
        case unit = "Unit"
        case unitType = "UnitType"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        value = try values.decodeIfPresent(Int.self, forKey: .value)
        unit = try values.decodeIfPresent(String.self, forKey: .unit)
        unitType = try values.decodeIfPresent(Int.self, forKey: .unitType)
    }

}

struct Night : Codable {
    let icon : Int?
    let iconPhrase : String?
    let hasPrecipitation : Bool?
    let precipitationType : String?
    let precipitationIntensity : String?

    enum CodingKeys: String, CodingKey {

        case icon = "Icon"
        case iconPhrase = "IconPhrase"
        case hasPrecipitation = "HasPrecipitation"
        case precipitationType = "PrecipitationType"
        case precipitationIntensity = "PrecipitationIntensity"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        icon = try values.decodeIfPresent(Int.self, forKey: .icon)
        iconPhrase = try values.decodeIfPresent(String.self, forKey: .iconPhrase)
        hasPrecipitation = try values.decodeIfPresent(Bool.self, forKey: .hasPrecipitation)
        precipitationType = try values.decodeIfPresent(String.self, forKey: .precipitationType)
        precipitationIntensity = try values.decodeIfPresent(String.self, forKey: .precipitationIntensity)
    }

}

struct Temperature : Codable {
    let minimum : Minimum?
    let maximum : Maximum?

    enum CodingKeys: String, CodingKey {

        case minimum = "Minimum"
        case maximum = "Maximum"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        minimum = try values.decodeIfPresent(Minimum.self, forKey: .minimum)
        maximum = try values.decodeIfPresent(Maximum.self, forKey: .maximum)
    }
}

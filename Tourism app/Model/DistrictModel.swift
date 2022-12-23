/* 
Copyright (c) 2022 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation

struct DistrictModel : Codable {
    let districts : Districts?

        enum CodingKeys: String, CodingKey {

            case districts = "districts"
        }

        init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            districts = try values.decodeIfPresent(Districts.self, forKey: .districts)
        }
}

struct Districts : Codable {
    let count : Int?
    let rows : [District]?

    enum CodingKeys: String, CodingKey {

        case count = "count"
        case rows = "rows"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        count = try values.decodeIfPresent(Int.self, forKey: .count)
        rows = try values.decodeIfPresent([District].self, forKey: .rows)
    }

}

struct District : Codable {
    let id : Int?
    let user_id : Int?
    let title : String?
    let slug : String?
    let geographical_area : String?
    let thumbnail_image : String?
    let preview_image : String?
    let location_title : String?
    let latitude : String?
    let longitude : String?
    let description : String?
    let featured : Bool?
    let is_top_destination : Bool?
    let views_counter : Int?
    let status : Int?
    let isDeleted : Int?
    let createdAt : String?
    let updatedAt : String?
    let district_category_id : Int?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case user_id = "user_id"
        case title = "title"
        case slug = "slug"
        case geographical_area = "geographical_area"
        case thumbnail_image = "thumbnail_image"
        case preview_image = "preview_image"
        case location_title = "location_title"
        case latitude = "latitude"
        case longitude = "longitude"
        case description = "description"
        case featured = "featured"
        case is_top_destination = "is_top_destination"
        case views_counter = "views_counter"
        case status = "status"
        case isDeleted = "isDeleted"
        case createdAt = "createdAt"
        case updatedAt = "updatedAt"
        case district_category_id = "district_category_id"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        user_id = try values.decodeIfPresent(Int.self, forKey: .user_id)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        slug = try values.decodeIfPresent(String.self, forKey: .slug)
        geographical_area = try values.decodeIfPresent(String.self, forKey: .geographical_area)
        thumbnail_image = try values.decodeIfPresent(String.self, forKey: .thumbnail_image)
        preview_image = try values.decodeIfPresent(String.self, forKey: .preview_image)
        location_title = try values.decodeIfPresent(String.self, forKey: .location_title)
        latitude = try values.decodeIfPresent(String.self, forKey: .latitude)
        longitude = try values.decodeIfPresent(String.self, forKey: .longitude)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        featured = try values.decodeIfPresent(Bool.self, forKey: .featured)
        is_top_destination = try values.decodeIfPresent(Bool.self, forKey: .is_top_destination)
        views_counter = try values.decodeIfPresent(Int.self, forKey: .views_counter)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        isDeleted = try values.decodeIfPresent(Int.self, forKey: .isDeleted)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
        district_category_id = try values.decodeIfPresent(Int.self, forKey: .district_category_id)
    }
}



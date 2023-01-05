//
//  GalleryModel.swift
//  Tourism app
//
//  Created by MacBook Pro on 1/4/23.
//

import Foundation


struct GalleryModel : Codable {
    let attraction : [GalleryAttraction]?
    let images : GalleryImages?
    let videos : Videos?
    let virtual_tours : VirtualTours?

    enum CodingKeys: String, CodingKey {

        case attraction = "attraction"
        case images = "images"
        case videos = "videos"
        case virtual_tours = "virtual_tours"
    }

}

struct GalleryAttraction : Codable {
    let id : Int?
    let title : String?
    let display_image : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case title = "title"
        case display_image = "display_image"
    }

}

struct GalleryImages : Codable {
    let count : Int?
    let rows : [GalleryRows]?

    enum CodingKeys: String, CodingKey {

        case count = "count"
        case rows = "rows"
    }


}

struct Videos : Codable {
    let count : Int?
    let rows : [GalleryRows]?

    enum CodingKeys: String, CodingKey {

        case count = "count"
        case rows = "rows"
    }

   
}

struct VirtualTours : Codable {
    let count : Int?
    let rows : [GalleryRows]?

    enum CodingKeys: String, CodingKey {

        case count = "count"
        case rows = "rows"
    }

  

}


struct GalleryRows : Codable {
    let id : Int?
    let attraction_id : Int?
    let sub_attraction_id : Int?
    let type : String?
    let title : String?
    let image_url : String?
    let video_url : String?
    let virtual_url : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case attraction_id = "attraction_id"
        case sub_attraction_id = "sub_attraction_id"
        case type = "type"
        case title = "title"
        case image_url = "image_url"
        case video_url = "video_url"
        case virtual_url = "virtual_url"
    }



}

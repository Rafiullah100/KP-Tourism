//
//  Networking.swift
//  Tourism app
//
//  Created by MacBook Pro on 3/2/23.
//

import Foundation
import UIKit
import Alamofire
import SVProgressHUD
class Networking{
    static let shared = Networking()
    
    func uploadMultipart(route: Route, imageParameter: String, image: UIImage, parameters: [String: Any], completion: @escaping (Result<SuccessModel, AppError>) -> Void) {
        
        let urlStr = Route.baseUrl + route.description
        //        let urlRequest: Alamofire.URLRequestConvertible = URLRequest(url: url)
        let imageData = image.jpegData(compressionQuality: 1.0)
        let headers: HTTPHeaders = [
            "Content-type": "multipart/form-data",
            "x-access-token": "\(UserDefaults.standard.accessToken ?? "")"
        ]
        //file name
        let date: Date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'_'HH:mm:ss"
        let imageName = "\(dateFormatter.string(from: date)).jpg"
//        let URL = try! URLRequest(url: url, method: .post, headers: headers)
        SVProgressHUD.show(withStatus: "Please Wait...")
        AF.upload(multipartFormData: { multipartFormData in
            for (key, value) in parameters {
                multipartFormData.append("\(value)".data(using: String.Encoding.utf8) ?? Data(), withName: key as String)
            }
            multipartFormData.append(imageData ?? Data(), withName: imageParameter, fileName: imageName, mimeType: "image/jpg")
        }, to: urlStr, headers: headers)
        .responseDecodable(of: SuccessModel.self) { (response) in
            SVProgressHUD.dismiss()
            switch response.result{
            case .success(let success):
                completion(.success(success))
            case .failure(let error):
                print(error)
                completion(.failure(AppError.unknownError))
            }
        }
    }
    
    
    func updateProfile(route: Route, imageParameter: String, image: UIImage, parameters: [String: Any], completion: @escaping (Result<ProfileUpdateModel, AppError>) -> Void) {
        
        let urlStr = Route.baseUrl + route.description
        //        let urlRequest: Alamofire.URLRequestConvertible = URLRequest(url: url)
        let imageData = image.jpegData(compressionQuality: 0.5)
        let headers: HTTPHeaders = [
            "Content-type": "multipart/form-data",
            "x-access-token": "\(UserDefaults.standard.accessToken ?? "")"
        ]
        //file name
        let date: Date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'_'HH:mm:ss"
        let imageName = "\(dateFormatter.string(from: date)).jpg"
//        let URL = try! URLRequest(url: url, method: .post, headers: headers)
        SVProgressHUD.show(withStatus: "Please Wait...")
        AF.upload(multipartFormData: { multipartFormData in
            for (key, value) in parameters {
                multipartFormData.append("\(value)".data(using: String.Encoding.utf8) ?? Data(), withName: key as String)
            }
            multipartFormData.append(imageData ?? Data(), withName: imageParameter, fileName: imageName, mimeType: "image/jpg")
        }, to: urlStr, headers: headers)
        .responseDecodable(of: ProfileUpdateModel.self) { (response) in
            SVProgressHUD.dismiss()
            switch response.result{
            case .success(let profile):
                completion(.success(profile))
            case .failure(let error):
                print(error)
                completion(.failure(AppError.unknownError))
            }
        }
    }
    
    func registerGroup(
        route: Route,
        files: [String: (data: Data, mimeType: String)],
        parameters: [String: Any],
        completion: @escaping (Result<SuccessModel, AppError>) -> Void
    ) {
        let urlStr = Route.baseUrl + route.description
        let headers: HTTPHeaders = [
            "Content-type": "multipart/form-data",
            "x-access-token": "\(UserDefaults.standard.accessToken ?? "")"
        ]
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'_'HH:mm:ss"
        let timestamp = dateFormatter.string(from: Date())
        
        SVProgressHUD.show(withStatus: "Please Wait...")
        
        AF.upload(multipartFormData: { multipartFormData in
            // Add text parameters
            for (key, value) in parameters {
                if let stringValue = "\(value)".data(using: .utf8) {
                    multipartFormData.append(stringValue, withName: key)
                }
            }
            
            // Add files (images or PDFs)
            for (parameterName, file) in files {
                let fileName = "\(timestamp)_\(parameterName).\(file.mimeType == "application/pdf" ? "pdf" : "jpg")"
                multipartFormData.append(file.data, withName: parameterName, fileName: fileName, mimeType: file.mimeType)
            }
            
        }, to: urlStr, headers: headers)
        .responseDecodable(of: SuccessModel.self) { response in
            SVProgressHUD.dismiss()
            switch response.result {
            case .success(let successModel):
                completion(.success(successModel))
            case .failure(let error):
                print(error)
                completion(.failure(AppError.unknownError))
            }
        }
    }
    
}

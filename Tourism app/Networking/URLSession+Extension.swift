//
//  URLSession+Extension.swift
//  Tourism app
//
//  Created by MacBook Pro on 12/20/22.
//

import Foundation
import UIKit
import SVProgressHUD
import Toast_Swift
extension URLSession{
    func request<T: Codable>(route: Route, method: Method, parameters: [String: Any]? = nil, model: T.Type, completion: @escaping (Result<T, AppError>) -> Void) {
        
        if !Reachability.isConnectedToNetwork() {
            completion(.failure(.noInternet))
        }
        guard let request = createRequest(route: route, method: method, parameters: parameters) else {
            completion(.failure(AppError.unknownError))
            return
        }
        SVProgressHUD.show(withStatus: "Please Wait...")
        let task = dataTask(with: request) { data, response, error in
            SVProgressHUD.dismiss()
            guard let data = data else {
                if let error = error{
                    print(error)
                    completion(.failure(.unknownError))
                }
                else{
                    completion(.failure(AppError.unknownError))
                }
                return
            }
            do {
                let result = try JSONDecoder().decode(model, from: data)
                completion(.success(result))
            } catch let error {
                print(error)
                completion(.failure(AppError.errorDecoding))
            }
        }
        task.resume()
    }
    
    func createRequest(route: Route,
                               method: Method,
                               parameters: [String: Any]? = nil) -> URLRequest? {
        let urlString = Route.baseUrl + route.description
        print(urlString)
        guard let url = urlString.asUrl else { return nil }
        var urlRequest = URLRequest(url: url)
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpMethod = method.rawValue
        
        if let params = parameters {
            switch method {
            case .get:
                var urlComponent = URLComponents(string: urlString)
                urlComponent?.queryItems = params.map { URLQueryItem(name: $0, value: "\($1)") }
                urlRequest.url = urlComponent?.url
            case .post, .delete, .patch:
                let bodyData = try? JSONSerialization.data(withJSONObject: params, options: [])
                urlRequest.httpBody = bodyData
            }
        }
        return urlRequest
    }

}

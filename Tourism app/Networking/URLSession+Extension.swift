//
//  URLSession+Extension.swift
//  Tourism app
//
//  Created by MacBook Pro on 3/27/23.
//
import Foundation
import UIKit
import SVProgressHUD
import Toast_Swift
extension URLSession{
    func request<T: Codable>(route: Route, method: Method, showLoader: Bool? = true, parameters: [String: Any]? = nil, model: T.Type, completion: @escaping (Result<T, AppError>) -> Void) -> URLSessionDataTask?  {
        var task: URLSessionDataTask?
        var showPrgoesshud: Bool?
        showPrgoesshud = showLoader
        if !Reachability.isConnectedToNetwork() {
            completion(.failure(.noInternet))
        }
        guard let request = createRequest(route: route, method: method, parameters: parameters) else {
            completion(.failure(AppError.unknownError))
            return task
        }
        
        if let value = parameters?["page"], value as? Int != 1 {
            showPrgoesshud = false
        }
        if showPrgoesshud == true {
            DispatchQueue.main.async {
                SVProgressHUD.show(withStatus: "Please Wait...")
                SVProgressHUD.setDefaultMaskType(.none)
                SVProgressHUD.setBackgroundColor(.lightGray)
            }
        }
        task = dataTask(with: request) { data, response, error in
            SVProgressHUD.dismiss()
            guard let data = data else {
                if let error = error{
                    print(error)
                    DispatchQueue.main.async {
                        completion(.failure(.serverError))
                    }
                }
                return
            }
            do {
                let result = try JSONDecoder().decode(model, from: data)
                print(result)
                DispatchQueue.main.async {
                    completion(.success(result))
                }
            } catch let error {
                print(error)
                DispatchQueue.main.async {
                    completion(.failure(AppError.errorDecoding))
                }
            }
        }
        task?.resume()
        return task
    }
    
    func createRequest(route: Route,
                               method: Method,
                               parameters: [String: Any]? = nil) -> URLRequest? {
        var urlString = ""
        switch route {
        case .weatherApi:
            urlString = route.description
        default:
            urlString = Route.baseUrl + route.description
        }
        print(urlString)
        guard let url = urlString.asUrl else { return nil }
        var urlRequest = URLRequest(url: url)
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue(UserDefaults.standard.accessToken ?? "", forHTTPHeaderField: "x-access-token")

        urlRequest.httpMethod = method.rawValue
        if let params = parameters {
            switch method {
            case .get:
                var urlComponent = URLComponents(string: urlString)
                urlComponent?.queryItems = params.map { URLQueryItem(name: $0, value: "\($1)") }
                urlRequest.url = urlComponent?.url
                print(urlRequest)
            case .post, .delete, .patch:
                let bodyData = try? JSONSerialization.data(withJSONObject: params, options: [])
                urlRequest.httpBody = bodyData
            }
        }
        return urlRequest
    }
}

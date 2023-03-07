//
//  ViewPDFViewController.swift
//  Tourism app
//
//  Created by MacBook Pro on 3/7/23.
//

import UIKit
import WebKit
class ViewPDFViewController: UIViewController, WKUIDelegate {

    var urlString: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createWebView()
    }

    private func createWebView() {
        let webView = WKWebView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height))
        webView.uiDelegate = self
        webView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        if let resourceUrl = URL(string: Route.baseUrl + (urlString ?? "")) {
            let request = URLRequest(url: resourceUrl)
            webView.load(request)
            view.addSubview(webView)
        }
    }

}

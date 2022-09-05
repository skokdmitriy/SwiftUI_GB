//
//  VKLoginWebView.swift
//  SwiftUI_GB
//
//  Created by Дмитрий Скок on 15.08.2022.
//

import SwiftUI
import WebKit

struct VKLoginWebView: UIViewRepresentable {
    
    @ObservedObject var session = Session.shared
    
    fileprivate let navigationDelegate = WebViewNavigationDelegate()
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = navigationDelegate
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        if let request = buildAuthRequest() {
            uiView.load(request)
        }
    }
    
    private func buildAuthRequest() -> URLRequest? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "oauth.vk.com"
        components.path = "/authorize"
        components.queryItems = [
            URLQueryItem(name: "client_id", value: session.clientId),
            URLQueryItem(name: "scope", value: "262150"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "v", value: session.versionApi)
        ]
        
        return components.url.map { URLRequest(url: $0) }
    }
}

class WebViewNavigationDelegate: NSObject, WKNavigationDelegate {
    
    @ObservedObject var session = Session.shared
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        guard let url = navigationResponse.response.url,
              url.path == "/blank.html",
              let fragment = url.fragment else {
            decisionHandler(.allow)
            return
        }
        
        let params = fragment
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=") }
            .reduce([String: String]()) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                
                return dict
            }
        
        guard let token = params["access_token"],
              let userIdString = params["user_id"],
              let _ = Int(userIdString)
        else {
            decisionHandler(.allow)
            return
        }

//        UserDefaults.standard.set(token, forKey: "vkToken")
//        NotificationCenter.default.post(name: NSNotification.Name("vkTokenSaved"), object: self)
        
        session.token = token
        session.userId = userIdString
        session.isAuthorized = true
        
        decisionHandler(.cancel)
        
    }
}

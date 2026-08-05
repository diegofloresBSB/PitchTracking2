import SwiftUI
import WebKit

struct ContentView: View {
    var body: some View {
        WebView()
    }
}

struct WebView: UIViewRepresentable {
    func makeUIView(context: Context) -> WKWebView {
        let config = WKWebViewConfiguration()
        config.websiteDataStore = .default()

        let webView = WKWebView(frame: .zero, configuration: config)
        webView.backgroundColor = UIColor(red: 0x0B/255, green: 0x14/255, blue: 0x10/255, alpha: 1)
        webView.isOpaque = false
        webView.scrollView.bounces = false
        webView.scrollView.contentInsetAdjustmentBehavior = .never

        if let url = Bundle.main.url(forResource: "index", withExtension: "html", subdirectory: "www") {
            let dir = url.deletingLastPathComponent()
            webView.loadFileURL(url, allowingReadAccessTo: dir)
        }
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {}
}

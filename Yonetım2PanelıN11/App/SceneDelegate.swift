import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else { return }

        let window = UIWindow(windowScene: windowScene)
        let loginVC = ModuleBuilder.build()
        let navController = UINavigationController(rootViewController: loginVC)
        window.rootViewController = navController
        self.window = window
        window.makeKeyAndVisible()

        // Eğer uygulama URL ile açılmışsa burada yakala
        if let urlContext = connectionOptions.urlContexts.first {
            handleDeepLink(url: urlContext.url)
        }
    }

    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        guard let url = URLContexts.first?.url else { return }
        handleDeepLink(url: url)
    }

    private func handleDeepLink(url: URL) {
        if url.scheme == "myapp",
           url.host == "oauth-callback",
           let components = URLComponents(url: url, resolvingAgainstBaseURL: false),
           let code = components.queryItems?.first(where: { $0.name == "code" })?.value,
           let nav = window?.rootViewController as? UINavigationController,
           let loginVC = nav.viewControllers.first(where: { $0 is LoginViewController }) as? LoginViewController {
            print("Authorization code alındı: \(code)")
            loginVC.handleGitHubCallback(code: code)
        } else {
            print("Geçersiz deeplink URL: \(url)")
        }
    }
}

import UIKit

class PSViewController: UIViewController {
    
    lazy var loadingView: PSLoading = {
        let loadingView = PSLoading()
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        return loadingView
    }()
    
    func configureLoadingView() {
        view.addSubview(loadingView)
        
        NSLayoutConstraint.activate([
            loadingView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    func startLoading() {
        configureLoadingView()
        loadingView.startLoading()
    }
    
    func stopLoading() {
        loadingView.stopLoading()
        loadingView.removeFromSuperview()
    }
    
    func showAlert(
        title: String,
        message: String,
        action: (() -> Void)?
    ) {
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        let alertAction = UIAlertAction(title: "Ok", style: .default) { _ in action?() }
        alertController.addAction(alertAction)
        present(alertController, animated: true)
    }
}

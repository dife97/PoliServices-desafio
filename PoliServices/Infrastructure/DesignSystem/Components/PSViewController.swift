import UIKit

class PSViewController: UIViewController {
    
    lazy var loadingView: PSLoading = {
        let loadingView = PSLoading()
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        return loadingView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
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
}

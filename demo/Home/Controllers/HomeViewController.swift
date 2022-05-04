//
//  ViewController.swift
//  demo
//
//  Created by Surya on 02/05/22.
//

import UIKit

class HomeViewController: UIViewController {
    
    //MARK: Outlets
    
    /// Image View
    @IBOutlet weak var pageImageView: UIImageView!
    
    /// Title Label
    @IBOutlet weak var pageTitle: UILabel!
    
    /// Description Label
    @IBOutlet weak var descriptionLabel: UITextView!
    
    /// Container View
    @IBOutlet weak var containerView: UIView!
    
    // MARK: View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPage()
        fetchData()
    }

    func setupPage() {
        containerView.isHidden = true
        descriptionLabel.isEditable = false
    }
    
    // MARK: API Call and Flow
    
    // Fetch API Data
    func fetchData() {
        
        var availableData: HomeAPIResponse?
        
        /// Set up activity Indicator
        view.addActivityIndicator()
        
        if let data = UserDefaultStorage.fetchObjectForKey(key: Constant.DataIdentifier.apiData.rawValue) {
            let decoder = JSONDecoder()
            if let unarchivedData = try? decoder.decode(HomeAPIResponse.self, from: data) {
                availableData = unarchivedData
            }
        }
        
        HomeRepository.shared.fetchImageAPIData {[weak self] result in
            
            /// Remove ActivityIndicator
            self?.view.removeActivityIndicator()
            
            /// Handle Response
            switch result {
            case .success(let response, let responseStatus):
                if let status = responseStatus, status == 200 {
                    UserDefaultStorage.setCodableObjectForKey(value: response, key: Constant.DataIdentifier.apiData.rawValue)
                    self?.showAvailableData(response)
                } else {
                    if let data = availableData {
                        self?.handleAPIFailure(data)
                    }
                }
            case .failure:
                if let data = availableData {
                    self?.handleAPIFailure(data)
                }
            }
        }
    }
    
    /// Handle API Failure
    func handleAPIFailure(_ cacheData: HomeAPIResponse) {
        let currentDate = Date.getFormattedDate(format: "yyyy-MM-dd")
        cacheData.date == currentDate ? showAvailableData(cacheData) : showAlert(cacheData)
    }
    
    /// Show Alert
    func showAlert(_ cacheData: HomeAPIResponse) {
        let controller = UIAlertController.init(title: nil, message: "We are not connected to the internet, showing you the last image we have.", preferredStyle: .alert)
        let dismiss = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {[weak self] _ in
            self?.showAvailableData(cacheData)
            controller.dismiss(animated: true, completion: nil)
        })
        controller.addAction(dismiss)
        present(controller, animated: true, completion: nil)
    }
    
    /// Show Data
    func showAvailableData(_ cacheData: HomeAPIResponse) {
        containerView.isHidden = false
        pageTitle.text = cacheData.title
        descriptionLabel.text = cacheData.explanation
        pageImageView.setImage(image: cacheData.url)
    }
    
}


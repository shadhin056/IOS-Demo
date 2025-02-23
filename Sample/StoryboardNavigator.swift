//
//  StoryboardNavigator.swift
//  Sample
//
//  Created by Moniruzzaman ShadhiN on 21/2/25.
//
import UIKit

enum StoryboardError: Error {
    case viewControllerNotFound(storyboard: String, identifier: String)
}

class StoryboardNavigator {
    
    static func instantiateViewController<T: UIViewController>(
        fromStoryboard storyboardName: String,
        withIdentifier identifier: String
    ) throws -> T {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        
        guard let viewController = storyboard.instantiateViewController(withIdentifier: identifier) as? T else {
            throw StoryboardError.viewControllerNotFound(storyboard: storyboardName, identifier: identifier)
        }
        
        return viewController
    }
    
    static func navigate<T: UIViewController>(
        to viewControllerType: T.Type,
        storyboard storyboardName: String,
        withIdentifier identifier: String,
        from sourceViewController: UIViewController,
        presentationStyle: UIModalPresentationStyle = .fullScreen,
        animated: Bool = true,
        completion: (() -> Void)? = nil
    ) {
        do {
            let destinationVC: T = try instantiateViewController(fromStoryboard: storyboardName, withIdentifier: identifier)
            
            if let navigationController = sourceViewController.navigationController {
                navigationController.pushViewController(destinationVC, animated: animated)
                completion?()
            } else {
                destinationVC.modalPresentationStyle = presentationStyle
                sourceViewController.present(destinationVC, animated: animated, completion: completion)
            }
        } catch {
            print("Navigation Error: \(error.localizedDescription)")
            let alertController = UIAlertController(title: "Error", message: "Unable to navigate to the requested screen.", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            sourceViewController.present(alertController, animated: true, completion: nil)
        }
    }
}

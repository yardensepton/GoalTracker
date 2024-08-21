//
//  UIView.swift
//  GoalTracker-iOS
//
//  Created by Student5 on 14/08/24
//

import Foundation
import UIKit

extension UIViewController {
    func showToast(message: String, duration: Double = 2.0) {
        // Create a label for the toast message
        let toastLabel = UILabel()
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center
        toastLabel.font = UIFont.systemFont(ofSize: 14.0)
        toastLabel.text = message
        toastLabel.alpha = 0.0
        toastLabel.numberOfLines = 0
        toastLabel.layer.cornerRadius = 15
        toastLabel.clipsToBounds = true
        
        // Calculate the size of the toast
        let maxSizeTitle = CGSize(width: self.view.bounds.size.width - 40, height: self.view.bounds.size.height - 40)
        var expectedSizeTitle = toastLabel.sizeThatFits(maxSizeTitle)
        expectedSizeTitle = CGSize(width: max(80, expectedSizeTitle.width + 20), height: max(35, expectedSizeTitle.height + 10))
        toastLabel.frame = CGRect(x: (self.view.frame.size.width - expectedSizeTitle.width) / 2, y: self.view.frame.size.height - expectedSizeTitle.height - 100, width: expectedSizeTitle.width, height: expectedSizeTitle.height)
        
        // Style the toast
        toastLabel.layer.shadowColor = UIColor.black.cgColor
        toastLabel.layer.shadowOpacity = 0.8
        toastLabel.layer.shadowOffset = CGSize(width: 2, height: 2)
        toastLabel.layer.shadowRadius = 4
        
        // Add the toast to the view
        self.view.addSubview(toastLabel)
        
        // Animate the toast
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseOut, animations: {
            toastLabel.alpha = 1.0
        }, completion: { isCompleted in
            UIView.animate(withDuration: 0.5, delay: duration, options: .curveEaseIn, animations: {
                toastLabel.alpha = 0.0
            }, completion: { isCompleted in
                toastLabel.removeFromSuperview()
            })
        })
    }
}

//
//  BackbaseUtils.swift
//  DemoTrie
//
//  Created by Gaurav Tiwari on 21/06/19.
//  Copyright © 2019 Gaurav Tiwari. All rights reserved.
//

import UIKit

class Utilities: NSObject {
    static let shared = Utilities()
    let activity = UIActivityIndicatorView(style: .gray)
    
    func showActivity(view:UIView){
        view.addSubview(activity)
        activity.frame = view.bounds
        activity.startAnimating()
    }
    
    func hideActivity(){
        self.activity.stopAnimating()
        self.activity.removeFromSuperview()
    }
}

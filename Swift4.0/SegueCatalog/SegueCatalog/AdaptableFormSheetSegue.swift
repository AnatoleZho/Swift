//
//  AdaptableFormSheetSegue.swift
//  SegueCatalog
//
//  Created by EastElsoft on 2017/4/18.
//  Copyright © 2017年 XiFeng. All rights reserved.
//

import UIKit

class AdaptableFormSheetSegue: UIStoryboardSegue, UIAdaptivePresentationControllerDelegate {

    override func perform() {
        destination.presentationController?.delegate = self
        super.perform()
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return traitCollection.horizontalSizeClass == .compact ? .fullScreen : .formSheet
    }
    
    func presentationController(_ controller: UIPresentationController, viewControllerForAdaptivePresentationStyle style: UIModalPresentationStyle) -> UIViewController? {
        let adaptableGormSheetSegueBundle = Bundle(for: AdaptableFormSheetSegue.self)
        return UIStoryboard(name: "Detail", bundle: adaptableGormSheetSegueBundle).instantiateViewController(withIdentifier: "Adapted")
    }
    
}

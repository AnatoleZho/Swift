//
//  DetailViewControllers.swift
//  SegueCatalog
//
//  Created by EastElsoft on 2017/4/18.
//  Copyright © 2017年 XiFeng. All rights reserved.
//

import UIKit

class DetailViewControllers: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

class NestedViewController: UIViewController {
    @IBAction func unwindToNested(_ segue: UIStoryboardSegue) {
    
    }
}

class OuterViewController: UIViewController {
    @IBAction func unwindToOuter(_ segue: UIStoryboardSegue) {
    
    }
}

class NonAnimatingSegue: UIStoryboardSegue {
    override func perform() {
        UIView.performWithoutAnimation {
            super.perform()
        }
    }
}

class CustomAnimationPresentationSegue: UIStoryboardSegue, UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning {
    override func perform() {
        /*
         Because this class is used for a Present Modally segue, UIKit will
         maintain a strong reference to this segue object for the duration of
         the presentation. That way, this segue object will still be around to
         provide an animation controller for the eventual dismissal, as well
         as for the initial presentation.
         */
        destination.transitioningDelegate = self
        
        super.perform()
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        
        let toView = transitionContext.view(forKey: UITransitionContextViewKey.to)!
        
        if transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) == destination {
            // Presenting.
            UIView.performWithoutAnimation {
                toView.alpha = 0
                containerView.addSubview(toView)
            }
            
            let transitionContextDuration = transitionDuration(using: transitionContext)
            
            UIView.animate(withDuration: transitionContextDuration, animations: {
                toView.alpha = 1
            }, completion: { success in
                transitionContext.completeTransition(success)
            })
        }
        else {
            // Dismissing.
            let fromView = transitionContext.view(forKey: UITransitionContextViewKey.from)!
            
            UIView.performWithoutAnimation {
                containerView.insertSubview(toView, belowSubview: fromView)
            }
            
            let transitionContextDuration = transitionDuration(using: transitionContext)
            
            UIView.animate(withDuration: transitionContextDuration, animations: {
                fromView.alpha = 0
            }, completion: { success in
                transitionContext.completeTransition(success)
            })
        }
    }

}

//
//  PopverAnimation.swift
//  Weibo
//
//  Created by Jentle on 2017/8/10.
//  Copyright © 2017年 Powonder. All rights reserved.
//

import UIKit

class PopverAnimation: NSObject {
    //MARK:是否为弹出动画
    var isPresented = false
    //弹出控制器的frame
    var presentedFrame = CGRect.zero
    //回调
    var animationCallBack : ((_ presented : Bool) -> ())?
    //当一个闭包当做一个参数传进函数里，这个闭包是在这个函数执行完后执行的，这个时候我们就说这个闭包从函数逃出来了（escape）
    init(callBack:@escaping (_ presented : Bool) -> ()) {
        animationCallBack = callBack
    }
    
    
}

//MARK:设置弹出控制器的frame
extension PopverAnimation :UIViewControllerTransitioningDelegate{
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        let presentVC = MaxPresentationController(presentedViewController: presented, presenting: presenting)
        presentVC.presentedFrame = presentedFrame
        return presentVC
    }
    //MARK:自定义弹出的动画
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresented = true
        animationCallBack!(isPresented)
        return self
    }
    //MARK:自定义消失的动画
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresented = false
        animationCallBack!(isPresented)
        return self
    }
    
}
//MARK:弹出和消失动画代理的方法
extension PopverAnimation : UIViewControllerAnimatedTransitioning{
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.25
    }
    //获取转场上下文，可以获取弹出的view和消失的view
    //UITransitionContextFromViewKey 获取消失的view
    //UITransitionContextToViewKey   获取弹出的view
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        isPresented ? animationForPresentView(transitionContext: transitionContext) : animationForDismissView(transitionContext: transitionContext)
    }
    
    private func animationForPresentView(transitionContext: UIViewControllerContextTransitioning){
        let presentedView = transitionContext.view(forKey: UITransitionContextViewKey.to)!
        transitionContext.containerView.addSubview(presentedView)
        //执行动画
        presentedView.layer.anchorPoint = CGPoint(x: 0.5, y: 0.0)
        presentedView.transform = CATransform3DGetAffineTransform(CATransform3DMakeScale(1.0, 0.0, 1.0))
        UIView.animate(withDuration: transitionDuration(using: self as? UIViewControllerContextTransitioning), animations: {
            presentedView.transform = CATransform3DGetAffineTransform(CATransform3DMakeScale(1.0, 1.0, 1.0))
        }) { (_) in
            //必须告诉转场上下文已完成动画
            transitionContext.completeTransition(true)
        }
    }
    
    private func animationForDismissView(transitionContext: UIViewControllerContextTransitioning){
        let dismissView = transitionContext.view(forKey: UITransitionContextViewKey.from)!
        transitionContext.containerView.addSubview(dismissView)
        //执行动画
        UIView.animate(withDuration: transitionDuration(using: self as? UIViewControllerContextTransitioning), animations: {
            dismissView.transform = CATransform3DGetAffineTransform(CATransform3DMakeScale(1.0, 0.0001, 1.0))
        }) { (_) in
            dismissView.removeFromSuperview()
            //必须告诉转场上下文已完成动画
            transitionContext.completeTransition(true)
        }
    }
}

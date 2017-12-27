//
//  AnimationController.swift
//  SwiftClassP2
//
//  Created by LiuMingYang on 14-10-29.
//  Copyright (c) 2014年 ___http://www.iphonetrain.com___. All rights reserved.
//

import UIKit

class AnimationController: UIViewController,CAAnimationDelegate {

    
    @IBOutlet var testImageView:UIImageView!
    
    
    // MARK: - UIView动画  -------------------------------------
    
    // MARK: - UIView动画-淡入
    @IBAction func simpleAnimationFadeIn()
    {
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(2.0)//设置动画时间
        testImageView.alpha = 0.0
        UIView.commitAnimations()
        
        
//        //通过闭包实现 UIView淡入小狗
//        UIView.animateWithDuration(0.3, animations: { () -> Void in
//            self.testImageView.alpha = 0.0
//        })
    }
    
    // MARK: - UIView动画-淡出
    @IBAction func simpleAnimationFadeOut()
    {
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(2.0)//设置动画时间
        testImageView.alpha = 1.0
        UIView.commitAnimations()
    }
    
    // MARK: - UIView动画-移动
    @IBAction func simpleAnimationMoveCenter()
    {
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(2.0)//设置动画时间
        testImageView.center = CGPoint(x: 300, y: 300)
        UIView.setAnimationCurve(UIViewAnimationCurve.easeOut)//设置动画相对速度
        UIView.commitAnimations()
    }
    
    // MARK: - UIView动画-大小调整
    @IBAction func simpleAnimationFrame()
    {
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(2.0)//设置动画时间
        testImageView.frame = CGRect(x: 100, y: 165, width: 60, height: 60)
        UIView.commitAnimations()
    }
    
    // MARK: - UIView动画-过度动画
    var redView:UIView?
    var blueView:UIView?
    
//    enum UIViewAnimationTransition : Int {
//        
//        case None
//        case FlipFromLeft
//        case FlipFromRight
//        case CurlUp
//        case CurlDown
//    }
    
    //上翻页
    @IBAction func excessiveAnimationRed()
    {
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(1.0)//设置动画时间
        UIView.setAnimationTransition(UIViewAnimationTransition.curlUp, for: self.view, cache: true)
        self.view.exchangeSubview(at: 1, withSubviewAt: 0)
        UIView.commitAnimations()
    }
    
    //下翻页
    @IBAction func excessiveAnimationBlue()
    {
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(1.0)//设置动画时间
        UIView.setAnimationTransition(UIViewAnimationTransition.curlDown, for: self.view, cache: true)
        self.view.exchangeSubview(at: 0, withSubviewAt: 1)
        UIView.commitAnimations()
    }
    
    
    // MARK: - UIView动画-翻转
    @IBAction func flipAnimation()
    {
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(1.0)//设置动画时间
        UIView.setAnimationTransition(UIViewAnimationTransition.flipFromLeft, for: testImageView, cache: true)
//        UIView.setAnimationTransition(UIViewAnimationTransition.FlipFromRight, forView: testImageView, cache: true)
        UIView.commitAnimations()
    }
    
    
    // MARK: - CATransition动画
    
//    /* 动画样式 */
//    let kCATransitionFade: NSString!    //翻页
//    let kCATransitionMoveIn: NSString!  //弹出
//    let kCATransitionPush: NSString!    //推出
//    let kCATransitionReveal: NSString!  //移出
//    
//    /* 动画执行的方向 */
//    let kCATransitionFromRight: NSString!   //右侧
//    let kCATransitionFromLeft: NSString!    //做成
//    let kCATransitionFromTop: NSString!     //上部
//    let kCATransitionFromBottom: NSString!  //底部
    
    /* 非公开动画效果 */
//    "cube"          //立方体
//    "suckEffect"    //吸收
//    "oglFlip"       //翻转
//    "rippleEffect"  //波纹
//    "pageCurl"      //卷页
//    "cameralrisHollowOpen"          //镜头开
//    "cameralrisHollowClose"          //镜头关
    
    //CATransition动画-揭开（Push动画）
    @IBAction func caAnimationChage1()
    {
        let transition = CATransition()
        transition.duration = 1.0
        transition.type = kCATransitionPush //推送类型
        transition.subtype = kCATransitionFromLeft//从左侧
        self.view.exchangeSubview(at: 1, withSubviewAt: 0)
        self.view.layer.add(transition, forKey: nil)
        
    }
    
    //CATransition动画-推出
    @IBAction func caAnimationChage2()
    {
        let transition = CATransition()
        transition.duration = 1.0
        transition.type = kCATransitionMoveIn
        transition.subtype = kCATransitionFromTop
        self.view.exchangeSubview(at: 0, withSubviewAt: 1)
        self.view.layer.add(transition, forKey: nil)
    }
    
    
    //CATransition动画-平移
    @IBAction func caTranatate()
    {
        //每次都是从前前位置平移
        self.testImageView.transform=self.testImageView.transform.translatedBy(x: -1.9, y: -1.9)//正负 代表方向

        //每次都从最开始的位置计算平移
//        self.testImageView.transform=CGAffineTransformMakeTranslation(1.2, 1.2)
    }
    
    //CATransition动画-旋转
    @IBAction func caRotate()
    {
        //连续旋转
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(2.0)//设置动画时间
        self.testImageView.transform=self.testImageView.transform.rotated(by: CGFloat(-M_PI/2))
        UIView.commitAnimations()
        
        //独立旋转，以初始位置旋转
//        self.testImageView.transform=CGAffineTransformMakeRotation(CGFloat(M_PI/6))
    }
    
    //CATransition动画-缩放
    @IBAction func caScale()
    {
        
        //连续缩放
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(2.0)//设置动画时间
        self.testImageView.transform=self.testImageView.transform.scaledBy(x: 1.5, y: 1.5);//1.0以下缩小,1.0以上放大
        UIView.commitAnimations()
        
        //独立缩放，以初始位置缩放
//        self.testImageView.transform=CGAffineTransformMakeScale(1.2, 1.2)

    }
    
    //CATransition动画-反转到某个状态
    @IBAction func caInvert()
    {
        self.testImageView.transform=CGAffineTransform.identity;//返回到初始状态
        
        //连续反转
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(2.0)//设置动画时间
        self.testImageView.transform=self.testImageView.transform.concatenating(self.testImageView.transform.inverted());
        UIView.commitAnimations()
        
        //独立反转，以初始位置反转
//        self.testImageView.transform=CGAffineTransformInvert(self.testImageView.transform)
    }


    //CABasicAnimation-不透明度
    @IBAction func cabOpacity()
    {
        let animation = CABasicAnimation(keyPath: "opacity")
        
        animation.fromValue = 1.0
        animation.toValue = 0.0
        animation.duration = 3.0
        self.testImageView.layer.add(animation, forKey: "Image-opacity")
        self.testImageView.alpha=0.0;
    }
    
    //开启 clip subview 属性
    @IBAction func cabExpend()
    {
        //从小到下（如果把Mode 属性改成 Center后，此效果为遮照）
        let animation = CABasicAnimation(keyPath: "bounds.size")
        animation.fromValue = NSValue(cgSize: CGSize(width: 2.0, height: 2.0))
        animation.toValue = NSValue(cgSize: self.testImageView.frame.size)
        animation.duration = 3.0
        self.testImageView.layer.add(animation, forKey: "Image-expen")
    }
    
    //CAKeyframeAnimation-关键针动画
    @IBAction func cakFly()
    {
        let animation = CAKeyframeAnimation(keyPath: "position")
        
        //设置5个位置点
        let p1 = CGPoint(x: 0.0, y: 0.0)
        let p2 = CGPoint(x: 320, y: 0.0)
        let p3 = CGPoint(x: 0, y: 460.0)
        let p4 = CGPoint(x: 320.0, y: 460.0)
        let p5 = CGPoint(x: 160.0, y: 200.0)
        
        //赋值
        animation.values = [NSValue(cgPoint: p1),NSValue(cgPoint: p2),NSValue(cgPoint: p3),NSValue(cgPoint: p4),NSValue(cgPoint: p5)]
        
        
        //每个动作的 时间百分比
        animation.keyTimes = [NSNumber(value: 0.0 as Float),NSNumber(value: 0.4 as Float),NSNumber(value: 0.6 as Float),NSNumber(value: 0.8 as Float),NSNumber(value: 1.0 as Float)]
      
        animation.delegate = self as! CAAnimationDelegate
        animation.duration = 5.0
        
        self.testImageView.layer.add(animation, forKey: "Image-Fly")
    }
    
    //动画代理
    
     func animationDidStart(_ anim: CAAnimation)
    {
        //动画开始
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool)
    {
        //动画结束
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        //过度动画 添加两个视图
        redView = UIView(frame: CGRect(x: 200, y: 70, width: 120, height: 400))
        redView?.backgroundColor = UIColor.red
        self.view.insertSubview(redView!, at: 0)
        
        blueView = UIView(frame: CGRect(x: 200, y: 70, width: 120, height: 400))
        blueView?.backgroundColor = UIColor.blue
        self.view.insertSubview(blueView!, at: 1)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

//
//  PicturePreviewController.swift
//  PhotoKitTest
//
//  Created by lmy on 16/1/27.
//  Copyright © 2016年 http://www.bjwxhl.com. All rights reserved.
//

import UIKit

class PicturePreviewController: UIViewController,UIScrollViewDelegate {

     @IBOutlet weak var receivedImageView:UIScrollView!
    
    var HandCurrentImageTag = 44
    
    var originalImgView:UIImageView!
    
    var image:UIImage!
    
    var curScale:CGFloat = 1.0
    


    @IBAction func backButtonClick()
    {
        self.dismiss(animated: false) { () -> Void in
            
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        
        receivedImageView.backgroundColor = UIColor.clear
        receivedImageView.alwaysBounceHorizontal = true
        receivedImageView.alwaysBounceVertical = true
        receivedImageView.indicatorStyle = UIScrollViewIndicatorStyle.default
        receivedImageView.minimumZoomScale = 0.5
        receivedImageView.maximumZoomScale = 3
        
        
        //加图片
        originalImgView = UIImageView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        originalImgView.tag = HandCurrentImageTag
        originalImgView.backgroundColor = UIColor.black
        receivedImageView.addSubview(originalImgView)
        
        
        // 加入手势
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(PicturePreviewController.handleSingleTap(_:)))
        singleTap.numberOfTapsRequired = 1
        receivedImageView.addGestureRecognizer(singleTap)
        
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(PicturePreviewController.handleDoubleTap(_:)))
        doubleTap.numberOfTapsRequired = 2
        receivedImageView.addGestureRecognizer(doubleTap)
        
        singleTap.require(toFail: doubleTap)
        
        //        UILongPressGestureRecognizer *aLongPress=[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
        //        aLongPress.minimumPressDuration=1;
        //        [receivedImageView addGestureRecognizer:aLongPress];
        
        
        
        self.setImageInitFrame(image!)
    }
    
    // 根据图片大小设定显示位置
    func setImageInitFrame(_ image:UIImage)
    {
        DispatchQueue.main.async(execute: { () -> Void in
            
            self.originalImgView.image = image
            
            var ivWidth = image.size.width
            var ivHeight = image.size.height
            
            
            if (ivWidth == 0) {
                ivWidth = screenWidth
            }
            if (ivHeight == 0) {
                ivHeight = 200
            }
            
            var scale:CGFloat = 0
            
            if (ivWidth > screenWidth)
            {
                scale = ivWidth / screenWidth
                ivWidth = screenWidth
                ivHeight = ivHeight / scale
                self.originalImgView.frame = CGRect(x: screenWidth/2 - ivWidth/2, y: screenHeight/2 - ivHeight/2, width: ivWidth, height: ivHeight);
            }
            else if(ivHeight > screenHeight)
            {
                scale = ivHeight / screenHeight;
                ivWidth = ivWidth / scale;
                ivHeight = screenHeight;
                self.originalImgView.frame = CGRect(x: screenWidth/2 - ivWidth/2, y: screenHeight/2 - ivHeight/2, width: ivWidth, height: ivHeight);
            }else
            {
                self.originalImgView.frame = CGRect(x: screenWidth/2 - ivWidth / 2, y: screenHeight/2 - ivHeight / 2, width: ivWidth, height: ivHeight);
            }
        })
    }
    
    
    
    
    //UIScrollViewDelegate
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return originalImgView
    }
    
    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        
        self.updateImageViewFrameInScrollView(originalImgView, scrollView: self.receivedImageView)
        
        self.curScale = scale
    }
    
    func updateImageViewFrameInScrollView(_ imageView:UIView,scrollView:UIScrollView)
    {
        let ivWidth = originalImgView.frame.size.width
        let ivHeight = originalImgView.frame.size.height
        let svWidth = receivedImageView.frame.size.width
        let svHeight = receivedImageView.frame.size.height
        
        
        //调整位置
        if(ivWidth < svWidth || ivHeight < svHeight) {
            let fX = svWidth > ivWidth ? (svWidth - ivWidth) / 2 : 0;
            let fY = svHeight > ivHeight ? (svHeight - ivHeight) / 2 : 0;
            originalImgView.frame = CGRect(x: fX, y: fY, width: ivWidth, height: ivHeight);
        } else {
            originalImgView.frame = CGRect(x: 0, y: 0, width: ivWidth, height: ivHeight);
        }
    }
    
    
    
    func handleSingleTap(_ gestureRecognizer:UIGestureRecognizer)
    {
        
    }
    
    func handleDoubleTap(_ gestureRecognizer:UIGestureRecognizer)
    {
        let maxScale = receivedImageView.maximumZoomScale
        
        UIView.animate(withDuration: 0.5, animations: { () -> Void in
            
            if(self.curScale == 1.0) {
                let zoomScale = self.receivedImageView.zoomScale
                if(zoomScale == maxScale) {
                    self.receivedImageView.setZoomScale(self.curScale, animated: true)
                } else {
                    self.receivedImageView.setZoomScale(maxScale, animated: true)
                }
            } else {
                self.curScale = 1.0
                self.receivedImageView.setZoomScale(self.curScale, animated: true)
            }
            
            self.updateImageViewFrameInScrollView(self.originalImgView, scrollView: self.receivedImageView)
            }, completion: { (isFinish:Bool) -> Void in
        }) 
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

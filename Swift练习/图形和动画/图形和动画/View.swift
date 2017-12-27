//
//  View.swift
//  图形和动画
//
//  Created by EastElsoft on 2017/6/14.
//  Copyright © 2017年 XiFeng. All rights reserved.
//

import UIKit

class View: UIView {

    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {

        /* 绘制图像 */
        let image = UIImage.init(named: "Safari")
        image?.draw(at: CGPoint.init(x: 0, y: 20))
        image?.draw(in: CGRect.init(x: 0, y: 180, width: 100, height: 100))
        
        
        /* 绘制文本 */
        let fontName = "HelveticaNeue-Bold"
        let helveticaBlod = UIFont.init(name: fontName, size: 40.0)
        let string = "Some String" as NSString
        if let font = helveticaBlod {
            string.draw(at: CGPoint.init(x: 40.0, y: 180.0), withAttributes: [NSFontAttributeName: font])
        }
        
       /* 构建可变尺寸图像 */
        let button = UIButton.init(type: .custom)
        button.frame = CGRect.init(x: 80, y: self.frame.size.height - 60, width: self.frame.size.width - 160, height: 44)
        button.setTitle("Stretched Image on Button", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        
        let buttonImage = UIImage.init(named: "zcsb_button_pre")
            
        let resizeableImage = buttonImage?.resizableImage(withCapInsets: UIEdgeInsets.init(top: 0, left: 35, bottom: 0, right: 35))
        
        button.setBackgroundImage(resizeableImage, for: .normal)
        self.addSubview(button)
        
        /* 画线 */
        //设置用来绘制线条的颜色
        UIColor.brown.set()
        //获取当前图形上下文
        let context = UIGraphicsGetCurrentContext()
        /* 设置结合点 .miter 斜接， .bevel 斜面, .round 圆*/
        context?.setLineJoin(.round)
        //设置线宽
        context?.setLineWidth(10)
        //以该点作为线的起点
        context?.move(to: CGPoint.init(x: 50, y: 10))
        //以该点作为线的终点
        context?.addLine(to: CGPoint.init(x: 100, y: 200))
        //将线延伸至另外一点
        context?.addLine(to: CGPoint.init(x: 300, y: 100))
        //画虚线
//        context?.setLineDash(phase: 0, lengths: [5,7])
        //使用上下文当前的颜色绘制线条
        context?.strokePath()
        
        
        /* 构造路径 */
        //创建路径
        let path = CGMutablePath()
        let screenBounds = UIScreen.main.bounds
        //从左上方开始
        path.move(to: CGPoint.init(x: screenBounds.origin.x, y: screenBounds.origin.y))
        //从屏幕左上方至右下方画一条直线
        path.addLine(to: CGPoint.init(x: screenBounds.size.width, y: screenBounds.size.height))
        //从右上方开始画另一条线
        path.move(to: CGPoint.init(x: screenBounds.size.width, y: screenBounds.origin.y))
        //从右上方至左下方画一条线
        path.addLine(to: CGPoint.init(x: screenBounds.origin.x, y: screenBounds.size.height))
        //将路径添加至上下文中
        context?.addPath(path)
        //设置描边颜色
        UIColor.blue.setStroke()
        //使用描边色绘制路径
        context?.drawPath(using: .stroke)
        
        
        /* 绘制两个矩形 */
        let rectPath = CGMutablePath()
        //设置第一个矩形的边界
        let rectangle1 = CGRect.init(x: self.center.x - 40, y: self.center.y - 40, width: 80, height: 80)
        //设置第二个矩形的边界
        let rectangle2 = CGRect.init(x: self.center.x, y: self.center.y, width: 20, height: 60)
        //将两个矩形放在一个数组中
        let rectangles = [rectangle1, rectangle2]
        //将两个矩形添加到路径中
        rectPath.addRects(rectangles)
        //添加路径至上下文
        context?.addPath(rectPath)
        //设置黑色为描边色
        UIColor.black.setStroke()
        //设置浅蓝色为填充色
        UIColor.init(red: 0.20, green: 0.60, blue: 0.80, alpha: 1.0).setFill()
        //设置线宽
        context?.setLineWidth(5)
        context?.drawPath(using: .fillStroke)
        
        
        /* 为形状添加阴影 */
        drawRectAtTopLeftOfScreen()
        /*?? 一般来说图形上下文的状态进行保存，之后在进行恢复，并不只局限于阴影中， 否则上下文会持有这个属性
            通过 saveGState() 来保存状态 和 restoreGState() 来恢复之前的状态
         ??*/
        drawRectAtTopRightOfScreen()
        
        
        /* 绘制渐变 轴向渐变和径向渐变*/
        drawGradientRectAtBottomOfScreen()
        
    }

    
    
    /* 为形状添加阴影 */
    func drawRectAtTopLeftOfScreen() {
        let currentContext = UIGraphicsGetCurrentContext()
        
        currentContext?.saveGState()
        
        //偏移量，形状的右下部算起，x值越大，右侧阴影越长，y值越大，下方阴影越长
        let offset = CGSize.init(width: 10, height: 10)
        currentContext?.setShadow(offset: offset, blur: 20, color: UIColor.gray.cgColor)
        let path = CGMutablePath()
        let rect = CGRect.init(x: 80, y: 10, width: 80, height: 80)
        path.addRect(rect)
        currentContext?.addPath(path)
        UIColor.init(red: 0.20, green: 0.60, blue: 0.80, alpha: 1.0).setFill()
        currentContext?.drawPath(using: .fill)
        
        currentContext?.restoreGState()
    }
    
    //没有添加阴影
    func drawRectAtTopRightOfScreen() {
        let currentContext = UIGraphicsGetCurrentContext()
        let path = CGMutablePath()
        let rect = CGRect.init(x: 200, y: 10, width: 80, height: 80)
        path.addRect(rect)
        currentContext?.addPath(path)
        UIColor.init(red: 0.20, green: 0.60, blue: 0.80, alpha: 1.0).setFill()
        currentContext?.drawPath(using: .fill)
    }
    
    //轴向渐变
    func drawGradientRectAtBottomOfScreen() {
        
        //1.创建颜色空间
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        //2.选择蓝色作为开始点（左）以及红色作为结束点（右）。
        
        // 4
        let startColor = UIColor.red;
        var startColorComponents = startColor.cgColor.components!
        let endColor = UIColor.blue;
        var endColorComponens = endColor.cgColor.components!
        
        // 5
        var colorComponents
            = [startColorComponents[0], startColorComponents[1], startColorComponents[2], startColorComponents[3], endColorComponens[0], endColorComponens[1], endColorComponens[2], endColorComponens[3]]
        
        // 6
        var locations:[CGFloat] = [0.0, 1.0]
        
        // 7
        let gradient = CGGradient(colorSpace: colorSpace,colorComponents: &colorComponents,locations: &locations,count: 2)
        let currentContext = UIGraphicsGetCurrentContext()
        currentContext?.saveGState()
        
        let path = CGMutablePath()
        let rect = CGRect.init(x: 90, y: self.frame.size.height - 150, width: 190, height: 80)
        
        let startPoint = CGPoint(x:rect.origin.x, y:self.frame.size.height - 150)
        let endPoint = CGPoint(x:rect.size.width + 90, y:self.frame.size.height - 150)
        
        // 8
        currentContext!.drawLinearGradient(gradient!,start: startPoint,end: endPoint, options: CGGradientDrawingOptions(rawValue: 0))
        path.addRect(rect)
        currentContext?.addPath(path)
        UIColor.init(red: 0.20, green: 0.60, blue: 0.80, alpha: 1.0).setStroke()
        currentContext?.drawPath(using: .stroke)
        
        currentContext?.restoreGState()
    }
    
    
}

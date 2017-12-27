//
//  TableViewCell.swift
//  MVC
//
//  Created by EastElsoft on 2017/5/12.
//  Copyright © 2017年 XiFeng. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    var iconImageView: UIImageView!
    var appNameLabel: UILabel!
    var decLabel: UILabel!
    
    //赋值方法 - 显示 cell 内容方法
    func showAppInfo(with model: AppsModel) {
        //获取 model 中的图片
        iconImageView.image = UIImage(named: model.imageName)
        appNameLabel.text = model.appName
        decLabel.text = model.appDescription
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        //创建iconImageView
        iconImageView = UIImageView(frame: CGRect(x: 10, y: 5, width: 40, height: 40))
        self.addSubview(iconImageView)
        
        //创建appNameLabel
        appNameLabel = UILabel(frame: CGRect(x: 60, y: 0, width: 220, height: 15))
        appNameLabel.font = UIFont.systemFont(ofSize: 16)
        self.addSubview(appNameLabel)
        
        //创建decLabel
        decLabel = UILabel(frame: CGRect(x: 60, y: 15, width: 200, height: 35))
        decLabel.font = UIFont.systemFont(ofSize: 12)
        decLabel.numberOfLines = 2
        decLabel.textColor = UIColor.lightGray
        self.addSubview(decLabel)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

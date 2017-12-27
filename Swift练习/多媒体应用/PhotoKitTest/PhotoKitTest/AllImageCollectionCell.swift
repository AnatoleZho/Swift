//
//  AllImageCollectionCell.swift
//  TestUICollectionView
//
//  Created by lmy on 15/10/26.
//  Copyright © 2015年 TTTT. All rights reserved.
//

import UIKit
import Photos



class AllImageCollectionCell: UICollectionViewCell {

    @IBOutlet weak var oneImageView: UIImageView!
    
    
    func showCollectionCell(_ asset:PHAsset)
    {
        //获取缩略图
        getAssetThumbnail(asset)
    }
    
    //获取缩略图方法
    func getAssetThumbnail(_ asset: PHAsset) -> Void {
        
        //并获取其中的缩略图
        let manager = PHImageManager.default()
        let option = PHImageRequestOptions()
        option.isSynchronous = true
        manager.requestImage(for: asset, targetSize: CGSize(width: screenWidth/4, height: screenWidth/4), contentMode: .aspectFit, options: option, resultHandler: {(result, info)->Void in
            
            
            self.oneImageView.image = result!
        })
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}

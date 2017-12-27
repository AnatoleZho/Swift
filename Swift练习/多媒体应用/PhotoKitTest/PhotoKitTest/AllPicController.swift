//
//  AllPicController.swift
//  AmigoConsultant
//
//  Created by lht on 15/3/13.
//  Copyright (c) 2015年 ___http://www.LMY.com___. All rights reserved.
//

import UIKit
import Photos


/*屏幕宽度*/
let screenWidth = UIScreen.main.bounds.width


/*屏幕高度*/
let screenHeight = UIScreen.main.bounds.height



class AllPicController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {


    
    @IBOutlet weak var oneCollectionView: UICollectionView!

    var assetArray:[PHAsset] = [PHAsset]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //注册Cell
        self.oneCollectionView.register(UINib(nibName: "AllImageCollectionCell", bundle: Bundle.main), forCellWithReuseIdentifier: "allImageCollectionCell")
        
        
        /*************************  列出所有系统智能相册  **********************************/
        
        let smartAlbums:PHFetchResult = PHAssetCollection.fetchAssetCollections(with: PHAssetCollectionType.smartAlbum, subtype: PHAssetCollectionSubtype.albumRegular, options: nil)
        print("智能\(smartAlbums.count)个")
        //smartAlbums中保存的是各个智能相册对应的PHAssetCollection
        for i in 0..<smartAlbums.count
        {
            // 获取一个相册（PHAssetCollection）
            let collection = smartAlbums[i]
           
            if collection.isKind(of: PHAssetCollection.classForCoder())
            {
                //类型强制转换
                let assetCollection = collection 
                
                // 从每一个智能相册中获取到的 PHFetchResult 中包含的才是真正的资源（PHAsset）
                let assetsFetchResults:PHFetchResult = PHAsset.fetchAssets(in: assetCollection, options: nil)
                
                print("\(String(describing: assetCollection.localizedTitle))相册，共有照片数：\(assetsFetchResults.count)")
                
                for i in 0 ..< assetsFetchResults.count {
                    
                    // 获取一个资源（PHAsset）
                    let asset = assetsFetchResults[i] ;
 
                }
            }
        }
        
        
        
        
        /****************************  列出所有用户创建的相册  ******************************/
        
        let topLevelUserCollections:PHFetchResult = PHCollectionList.fetchTopLevelUserCollections(with: nil)
        
        
        //topLevelUserCollections中保存的是各个用户创建的相册对应的PHAssetCollection
        print("用户创建相册\(topLevelUserCollections.count)个")
        for i in 0..<topLevelUserCollections.count
        {
            // 获取一个相册（PHAssetCollection）
            let collection = topLevelUserCollections[i]
            
            if collection.isKind(of: PHAssetCollection.classForCoder())
            {
                //类型强制转换
                let assetCollection = collection as! PHAssetCollection
                
                
                // 从每一个智能相册中获取到的 PHFetchResult 中包含的才是真正的资源（PHAsset）
                let assetsFetchResults:PHFetchResult = PHAsset.fetchAssets(in: assetCollection, options: nil)
                
                
                print("\(String(describing: assetCollection.localizedTitle))相册，共有照片数：\(assetsFetchResults.count)")
                
                for i in 0 ..< assetsFetchResults.count {
                    
                    // 获取一个资源（PHAsset）
                    let asset = assetsFetchResults[i] ;
                    
                }
            }
        }
        
        
        
        
        //获取所有资源的集合，并按资源的创建时间排序
        let options:PHFetchOptions = PHFetchOptions.init()
        options.sortDescriptors = [NSSortDescriptor.init(key: "creationDate", ascending: true)]
        let assetsFetchResults:PHFetchResult = PHAsset.fetchAssets(with: options)
        for i in 0 ..< assetsFetchResults.count {
            
            // 获取一个资源（PHAsset）
            let asset = assetsFetchResults[i] as! PHAsset;
            
            //添加到数组
            assetArray.append(asset)
            
        }
        
        //刷新界面
        self.oneCollectionView?.reloadData()
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - UICollectionViewDataSource
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int
    {
        return 1 //返回几组
    }
    
    // CollectionView行数
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int)
        -> Int {
            return self.assetArray.count;//返回每组的cell数
    }
    
    // 获取单元格
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        //从队列中取出一个Cell使用
        let cell:AllImageCollectionCell = (collectionView.dequeueReusableCell(withReuseIdentifier: "allImageCollectionCell", for: indexPath) as? AllImageCollectionCell)!
        
        //cell显示内容
        let asset = self.assetArray[indexPath.row]
        cell.showCollectionCell(asset)
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        //返回cell大小，每行4个cell，cell间隔2像素
        //screenWidth是屏幕宽度
        return CGSize(width: (screenWidth - 6)/4, height: (screenWidth - 6)/4)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize{
        
        //返回HeaderView大小
        return CGSize(width: 0, height: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize{
        
        //FooterView大小
        return CGSize(width: 0, height: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets
    {
        //设置每个section的偏移
        return UIEdgeInsetsMake(2, 0, 0, 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat
    {
        return 2 //设定指定区内Cell的最小行距
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat
    {
        return 2 //设定指定区内Cell的最小间距
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView
    {
        let reusableView = UICollectionReusableView(frame: CGRect(x: 0,y: 0,width: 100,height:
            200))
        reusableView.backgroundColor = UIColor.red
        return reusableView
    }
    
    //func UIEdgeInsetsMake(top: CGFloat, _ left: CGFloat, _ bottom: CGFloat, _ right: CGFloat) -> UIEdgeInsets
    //func UIEdgeInsetsMake(top: CGFloat, _ left: CGFloat, _ bottom: CGFloat, _ right: CGFloat) -> UIEdgeInsets
    
    
    // MARK: - UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        print("点击cell坐标：\(indexPath.section)-\(indexPath.row)")
        
        
        //获取对象
        let asset = self.assetArray[indexPath.row]
        
        //并获取其中的原图
        let manager = PHImageManager.default()
        let option = PHImageRequestOptions()
        option.isSynchronous = true
        manager.requestImage(for: asset, targetSize: PHImageManagerMaximumSize, contentMode: .aspectFit, options: option, resultHandler: {(result, info)->Void in
            
            let viewCtl  = PicturePreviewController(nibName: "PicturePreviewController", bundle: Bundle.main)
            
            
            viewCtl.image = result!
            
            self.present(viewCtl, animated: false, completion: { () -> Void in
                
            })
        })
        
        
        
    }
    
}

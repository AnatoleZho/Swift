//
//  ViewController.swift
//  摄像头和图片库
//
//  Created by EastElsoft on 2017/6/9.
//  Copyright © 2017年 XiFeng. All rights reserved.
//

import UIKit
import MobileCoreServices
import AssetsLibrary
import Photos

/* UIView 的便捷扩展永凯获取高度和宽度 */
extension UIView {
    var width: CGFloat {
      return self.bounds.width
    }
    
    var height: CGFloat {
       return self.bounds.height
    }
    
}

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, PHPhotoLibraryChangeObserver{

    var assetsLibrary: ALAssetsLibrary?
    
    /* 用来展示库中最新照片 */
    var lastPhoto: PHAsset?
    /* 按下按钮会反转资源的 hidden 标识 */
    var buttonChange: UIButton!
    /* 用来展示最新照片的图像视图 */
    var imageView: UIImageView?
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        buttonChange = UIButton.init(type: .system)
        buttonChange.setTitle("ChangePhoto", for: .normal)
        buttonChange.addTarget(self, action: #selector(performChangePhoto), for: .touchUpInside)
        PHPhotoLibrary.shared().register(self)
    }
    
    deinit {
        PHPhotoLibrary.shared().unregisterChangeObserver(self)
    }
    
    //MARK: 1
    func isCameraAvailable() -> Bool {
        return UIImagePickerController.isSourceTypeAvailable(.camera)
    }
    
    //前置摄像头是否可用
    func isFrontCameraAvailable() -> Bool {
        return UIImagePickerController.isCameraDeviceAvailable(.front)
    }
    
    //后置摄像头是否可用
    func isRearCameraAvailable() -> Bool {
        return UIImagePickerController.isCameraDeviceAvailable(.rear)
    }
    
    //闪光灯是否可用
    func isFlashAvailableOnFrontCamera() -> Bool {
        return UIImagePickerController.isFlashAvailable(for: .front)
    }
    
    func isFlashAvailableOnRearCamera() -> Bool {
        return UIImagePickerController.isFlashAvailable(for: .rear)
    }
    
    /* 是否可以访问摄像机 */
    /*
     public enum UIImagePickerControllerSourceType : Int {
     
     case photoLibrary //照片库
     
     case camera       //摄像头
     
     case savedPhotosAlbum   //照片目录下的相机胶卷
     }
     **/
    
    /*
     
     UIImagePickerController 的 isSourceTypeAvailable: 和 availableMediaTypesForSourceType: 类方法来确定
      首先媒体来源（摄像头、照片库等）是否可用，如果可用，那么此媒体来源上的媒体类型，如图像和视频，是否可用：
     
     */
    
    func cameraSupportsMedia(mediaType: String, sourceType: UIImagePickerControllerSourceType) -> Bool {
        
        let availableMediaTypes = UIImagePickerController.availableMediaTypes(for: sourceType)!
        for type in availableMediaTypes {
            if type == mediaType {
                return true
            }
        }
        
        return false
    }
    
    func doesCameraSupportShootingVideos() -> Bool {
        return cameraSupportsMedia(mediaType: kUTTypeMovie as String, sourceType: .camera)
    }
    
    func doesCameraSupportTakingPhotos() -> Bool {
        return cameraSupportsMedia(mediaType: kUTTypeImage as String, sourceType: .camera)
    }
    
    //MARK: 2
    /* 使用此变量确定视图控制器的 viewDidAppear 方法是否被调用。 如果没有，则展示拍照视图 */
    var beenHereBefore = false
    
    var controller: UIImagePickerController?
    
   
    //MARK: ViewController
    override func viewDidLoad() {
        super.viewDidLoad()

        //1.1 在 info.plist 文件中添加隐私设置
        //1.2. 检验是否可以访问摄像机
        print("Camera is ")
        if isCameraAvailable() == false {
            print("not")
        } else {
           print("available")
        }
        
        //1.3. 是否支持拍照和录像
        if doesCameraSupportTakingPhotos() {
            print("The camera supports taking photos")
        } else {
            print("The camera does not support taking photos")
        }
        
        if doesCameraSupportShootingVideos() {
            print("The camera supports shooting videos")
        } else {
            print("The camera does not support shooting videos")
        }
        
        //1.4. 前置、后置摄像头和闪光灯是否可用
        if isFrontCameraAvailable() {
            print("The front camera is available")
            if isFlashAvailableOnFrontCamera() {
                print("The front camera is equipped with a flash")
            } else {
                print("The front camera is not equipped with a flash")
            }
        } else {
            print("The front camera is not available")
        }
        
        if isRearCameraAvailable() {
            print("The rear camera is available")
            if isFlashAvailableOnRearCamera() {
                print("The rear camera is equipped with a flash")
            } else {
                print("The rear camera is not equipped with a flash")
            }
        } else {
            print("The rear camera is not available")
        }

        //检验用于是否允许访问资源库
        PHPhotoLibrary.requestAuthorization { [weak self](status: PHAuthorizationStatus) in
            DispatchQueue.main.async {
                [weak self] in
                switch status {
                case .authorized:
                    self?.displayAlertWithTitle(title: "Access", message: "I could access the photo library")
                    self?.retrieveImage()
                    //MARK: 5 响应视频和图像中的变化
                    self?.retrieveAndDisplayNewestImage()
                default:
                    self?.displayAlertWithTitle(title: "Access", message: "I could not access the photo library")
                
                }
            }
        }
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if beenHereBefore {
            /* 由于viewDidAppear: 方法无论何时在试图控制器被展现时都会被调用，所以只显示选择器一次 */
            return;
        } else {
           beenHereBefore = true
        }
    
    }
    
    //MARK:2. 用摄像头拍摄照片
    @IBAction func useCameraTakePhotos(_ sender: UIButton) {
        
        if isCameraAvailable() && doesCameraSupportTakingPhotos() {
            controller = UIImagePickerController()
            
            if let theController = controller {
                theController.sourceType = .camera
                theController.mediaTypes = [kUTTypeImage as String]
                
                theController.allowsEditing = true
                theController.delegate = self
                
                present(theController, animated: true, completion: nil)
            }
        } else {
            print("Camera is not available")
        }
            }
    
    //MARK:3. 用摄像头录像

    @IBAction func useCameraTakeVideos(_ sender: UIButton) {
        if isCameraAvailable() && doesCameraSupportShootingVideos() {
            controller = UIImagePickerController()
            
            if let theController = controller {
                theController.sourceType = .camera
                theController.mediaTypes = [kUTTypeMovie as String]
                theController.allowsEditing = true
                
                /* 以高质量录制 */
                theController.videoQuality = .typeHigh
                /* 只允许30秒录制时间 */
                theController.videoMaximumDuration = 30.0
                
                theController.delegate = self
                
                present(theController, animated: true, completion: nil)
            }
        } else {
          print("Camera is not available")
        }
    }
    
    //MARK: 5在照片库中存储视频
    @IBAction func saveVideoToAlbum(_ sender: UIButton) {
        assetsLibrary = ALAssetsLibrary()
        let videoURL = Bundle.main.url(forResource: "一样爱着你", withExtension: "mp3") as NSURL?
        if let library = assetsLibrary {
            if let url = videoURL {
                library.writeVideoAtPath(toSavedPhotosAlbum: url as URL!, completionBlock: { (url, error) in
                    if let theError = error {
                       print(theError)
                    } else {
                       print("no error happened")
                    }
                })
            } else {
               print("Could not fund the video in the app bundle")
            }
        }
    }
    
    @IBAction func getVideoAction(_ sender: UIButton) {
        retrieveVideo()
    }
    
    //MARK: UIImagePickerControllerDelegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        print("Picker returned successfully")
        
        let mediaType: AnyObject? = info[UIImagePickerControllerMediaType] as AnyObject
        
        if let type: AnyObject = mediaType {
            if type is String {
                let stringType = type as! String
                
                if stringType == kUTTypeMovie as String {
                    let urlOfVideo = info[UIImagePickerControllerMediaURL] as? NSURL
                    
                    if let url = urlOfVideo {
                        print("Video URL = \(url)")
                        do {
                           let videoData = try NSData.init(contentsOf: url as URL, options: NSData.ReadingOptions.mappedRead)
                            if videoData.length != 0 {
                                /* 可以读取数据 */
                                print("Successfully loaded the data")
                            }
                        } catch let error as NSError {
                            print(error)
                        }
                    }
                } else if stringType == kUTTypeImage as String {
                    /* 获取元数据，只能为图像，而非视频 */
                    let metadata = info[UIImagePickerControllerMediaMetadata] as? NSDictionary
                    
                    var theImage: UIImage!
                    if picker.allowsEditing {
                        theImage = info[UIImagePickerControllerEditedImage] as! UIImage
                    } else {
                       theImage = info[UIImagePickerControllerOriginalImage] as! UIImage
                    }
                    
                   
                    //MARK: 4.1 在照片库中存储照片
                    UIImageWriteToSavedPhotosAlbum(theImage, self, #selector(imageWasSavedSuccessfully(image:error:contextInfo:)), nil)
                    
                    if let theMetaData = metadata {
                        let image = info[UIImagePickerControllerOriginalImage] as? UIImage
                        if let theIamge = image {
                            print("Image Metadata = \(theMetaData)")
                            print("Image = \(theIamge)")
                        }
                    }
                }
            }
        }
        picker.dismiss(animated: true, completion: nil)

    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("Picker was cancelled")
        picker.dismiss(animated: true, completion: nil)
    }
    
    //4.2
    func imageWasSavedSuccessfully(image: UIImage, error: NSError!, contextInfo: UnsafeMutableRawPointer) {
        if let theError = error {
            print("An error happened while saving the image = \(theError)")
        } else {
            print("Image was saved successfully")
        }
    }
    
    func displayAlertWithTitle(title: String, message: String) {
        let controller = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        controller.addAction(UIAlertAction.init(title: "OK", style: .default, handler: nil))
        present(controller, animated: true, completion: nil)
    }
    
    func retrieveImage() {
        /* 按照修改日期升序排序获取结果 */
        let options = PHFetchOptions()
        options.sortDescriptors = [NSSortDescriptor.init(key: "modificationDate", ascending: true)]
        
        /* 得到一个包含所有图片资源的 PHFetchResult 类型的对象 */
        let assetResults = PHAsset.fetchAssets(with: .image, options: options) as PHFetchResult<PHAsset>
        if assetResults.count == 0 {
            print("Found no results")
            return
        } else {
            print("Found \(assetResults.count) results")
            /*  PHCachingImageManager 类实例来获取每一个资源所关联的图像数据 */
            let imageManager = PHCachingImageManager()
            assetResults.enumerateObjects({ (object: PHAsset, count: Int, stop:UnsafeMutablePointer<ObjCBool>) in
                let imageSize = CGSize.init(width: object.pixelWidth, height: object.pixelHeight)
                
                /* 为了更快的性能，可以降低图像 */
                let imageRequestOptions = PHImageRequestOptions()
                imageRequestOptions.deliveryMode = .fastFormat
                imageManager.requestImage(for: object, targetSize: imageSize, contentMode: .aspectFill, options: imageRequestOptions, resultHandler: { (image:UIImage?, info:[AnyHashable : Any]?) in
                    /* 现在可以使用图像了 */
                    
                })
            })
            
        }
    }
    
    func retrieveVideo() {
        /* 按照修改日期升序排序获取结果 */
        let options = PHFetchOptions()
        options.sortDescriptors = [NSSortDescriptor.init(key: "modificationDate", ascending: true)]
        
        /* 得到一个包含所有图片资源的 PHFetchResult 类型的对象 */
        let assetResults = PHAsset.fetchAssets(with: .video, options: options) as PHFetchResult<PHAsset>
        if assetResults.count == 0 {
            print("Found no results")
            return
        } else {
            print("Found \(assetResults.count) results")
            /*  PHCachingImageManager 类实例来获取每一个资源所关联的图像数据 */
            let imageManager = PHCachingImageManager()
            assetResults.enumerateObjects({ (object: PHAsset, count: Int, stop:UnsafeMutablePointer<ObjCBool>) in
                
                /* 为了更快的性能，可以降低图像 */
                let videoRequestOptions = PHVideoRequestOptions()
                videoRequestOptions.deliveryMode = .automatic
                videoRequestOptions.isNetworkAccessAllowed = true
                videoRequestOptions.version = .current
                videoRequestOptions.progressHandler = {(progress, error, stop, info) in
                    /* 可以在此编码向用户展示进度条，并使用 block 对象的进度参数更新进度条*/
                    DispatchQueue.main.async(execute: {
                    print(progress)
                    })
                  }
               
                
                imageManager.requestAVAsset(forVideo: object, options: videoRequestOptions, resultHandler: {[weak self] (asset:AVAsset?, audioMix:AVAudioMix?, info:[AnyHashable : Any]?) in
                    DispatchQueue.main.async {
                        if let theAsset = asset as! AVURLAsset? {
                            let player = AVPlayer.init(url: theAsset.url)
                            
                            let layer = AVPlayerLayer.init(player: player)
                            layer.frame = (self?.view.frame)!
                            self?.view.layer.addSublayer(layer)
                            player.play()
                        } else {
                            print("This is not a URL asset. Cannot play")
                        }
                    }
                })
            })
            
        }
    }
    
    func retrieveAndDisplayNewestImage() {
        /* 按照日期的顺序获取，最新的在最上面 */
        let options = PHFetchOptions()
        options.sortDescriptors = [NSSortDescriptor.init(key: "creationDate", ascending: false)]

        let assetResults = PHAsset.fetchAssets(with: .image, options: options)
        if assetResults.count == 0 {
            print("Found no results")
            return
        } else {
            print("Found \(assetResults.count) results")
        }
        
        let lastPhoto = assetResults[0] as PHAsset
        
        self.lastPhoto = lastPhoto
        
        retrieveImageForAsset(asset: lastPhoto)
    }
    
    func imageFetchingOptions() -> PHImageRequestOptions {
        let options = PHImageRequestOptions()
        options.deliveryMode = .highQualityFormat
        options.resizeMode = .exact
        options.version = .current
        
        return options
    }
    
    func retrieveImageForAsset(asset: PHAsset) {
        let imageSize = CGSize.init(width: view.width, height: view.height)
        
        PHCachingImageManager().requestImage(for: asset, targetSize: imageSize, contentMode: .aspectFit, options: imageFetchingOptions()) { [weak self](image:UIImage?, info:[AnyHashable : Any]?) in
            DispatchQueue.main.async {
                if let theImageView = self?.imageView {
                  theImageView.removeFromSuperview()
                }
                if let theImage = image {
                   self?.imageView = UIImageView.init(image: theImage)
                    if let theImageView = self?.imageView {
                        
                        theImageView.contentMode = .scaleAspectFit
                        theImageView.frame = (self?.view.bounds)!
                        self?.view.addSubview(theImageView)
                        self?.buttonChange.frame = CGRect.init(x: 0, y: (self?.view.height)! - 100, width: 200, height: 50)
                        theImageView.image = theImage
                        
                        self?.buttonChange.center = (self?.view.center)!
                        self?.view.addSubview((self?.buttonChange)!)

                    }
                } else {
                  print("No image data came back")
                }
            }
        }
        
    }
    
    func performChangePhoto()  {
        if let asset = lastPhoto {
            /* 该 hidden 标识是资产的属性，因此是 .properties 值 */
            if asset.canPerform(.properties) {
                /* 这里做出变化 */
                PHPhotoLibrary.shared().performChanges({ 
                    /* 反转 hidden 标识 */
                    let request = PHAssetChangeRequest.init(for: asset)
                    request.isHidden = !asset.isHidden
                }, completionHandler: { [weak self](success: Bool, error: Error?) in
                    if success {
                      print("Successfully changed the photo")
                    } else {
                        DispatchQueue.main.async {
                            self?.displayAlertWithTitle(title: "Faild", message: "Faild to change the photo properties")
                        }
                    }
                })
            } else {
              displayAlertWithTitle(title: "Editing", message: "Could not change the photo")
            }
        }
    }
   
    
    func photoLibraryDidChange(_ changeInstance: PHChange) {
        print("Image is changed now")
        DispatchQueue.main.async {[weak self] in
            let change = changeInstance.changeDetails(for: (self?.lastPhoto)!)
            if let theChange = change {
               self?.lastPhoto = theChange.objectAfterChanges as? PHAsset
                if theChange.assetContentChanged {
                  self?.retrieveImageForAsset(asset: (self?.lastPhoto)!)
                }
            }
        }
    }
    
    
}



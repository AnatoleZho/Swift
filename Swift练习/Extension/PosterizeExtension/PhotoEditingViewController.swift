//
//  PhotoEditingViewController.swift
//  PosterizeExtension
//
//  Created by EastElsoft on 2017/5/9.
//  Copyright © 2017年 XiFeng. All rights reserved.
//

import UIKit
import Photos
import PhotosUI
import OpenGLES


class PhotoEditingViewController: UIViewController, PHContentEditingController {
    //图片视图，首先显示原始图片，在应用了对图片的编辑效果之后，显示编辑之后的图片
    @IBOutlet weak var imageView: UIImageView!

    //系统提供的输入
    var input: PHContentEditingInput?
    
    //以这种方式，将编辑结果提供给用户
    var outPut: PHContentEditingOutput?
    
    //将要应用于输入图片的图片滤镜的名称
    let filterName = "CIColorPosterize"

    //这两个变量，用于提供给照片框架，识别对照片的变更的唯一标识
    let editFormatIdentifier = Bundle.main.bundleIdentifier!
    
    //只是用于指定编辑的版本
    let editFormatVersion = "0.1"
    
    //一个队列，用于背景中执行编辑
    let operationQueue = OperationQueue()
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - PHContentEditingController
    
    func canHandle(_ adjustmentData: PHAdjustmentData) -> Bool {
        // Inspect the adjustmentData to determine whether your extension can work with past edits.
        // (Typically, you use its formatIdentifier and formatVersion properties to do this.)
        return false
    }
    
    func startContentEditing(with contentEditingInput: PHContentEditingInput, placeholderImage: UIImage) {
        // Present content for editing, and keep the contentEditingInput for use when closing the edit session.
        // If you returned true from canHandleAdjustmentData:, contentEditingInput has the original image and adjustment data.
        // If you returned false, the contentEditingInput has past edits "baked in".
        input = contentEditingInput
    }
    
    func finishContentEditing(completionHandler: @escaping ((PHContentEditingOutput?) -> Void)) {
        // Update UI to reflect that editing has finished and output is being rendered.
        
        // Render and provide output on a background queue.
        DispatchQueue.global().async {
            // Create editing output from the editing input.
            let output = PHContentEditingOutput(contentEditingInput: self.input!)
            
            // Provide new adjustments and render output to given location.
            // output.adjustmentData = <#new adjustment data#>
            // let renderedJPEGData = <#output JPEG#>
            // renderedJPEGData.writeToURL(output.renderedContentURL, atomically: true)
            
            // Call completion handler to commit edit to Photos.
            completionHandler(output)
            
            // Clean up temporary files, etc.
        }
    }
    
    var shouldShowCancelConfirmation: Bool {
        // Determines whether a confirmation to discard changes should be shown to the user on cancel.
        // (Typically, this should be "true" if there are any unsaved changes.)
        return false
    }
    
    func cancelContentEditing() {
        // Clean up temporary files, etc.
        // May be called after finishContentEditingWithCompletionHandler: while you prepare output.
    }

    func dataFromCiImage(image: CIImage) -> Data {
        let glContext = EAGLContext(api: .openGLES2)
        let context = CIContext(eaglContext: glContext!)
        
        let imageRef = context.createCGImage(image, from: image.extent)

        let image = UIImage(cgImage:imageRef!, scale: 1.0, orientation: .up)
        
        return UIImageJPEGRepresentation(image, 1.0)!
    }
    
}

//
//  MultimediaController.swift
//  SwiftClassP2
//
//  Created by LiuMingYang on 14-10-29.
//  Copyright (c) 2014年 ___http://www.iphonetrain.com___. All rights reserved.
//

import UIKit
import AVFoundation //播放声音使用的框架
import MediaPlayer  //播放视频媒体使用的框架
import MobileCoreServices
import AudioToolbox

class MultimediaController: UIViewController,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,AVAudioPlayerDelegate {
    
    @IBOutlet var picView:UIImageView!
    
    /*   MP3   */
    @IBOutlet var aLabel:UILabel! //
    
    @IBOutlet var timeLabel:UILabel!//播放的时间／总时间
    @IBOutlet var jinDuSlider:UISlider!//进度条
    var _timer:Timer!//定时器线程， 刷新进度条
    
    var audioPlayer:AVAudioPlayer!
    
    
    
    
    
    //返回按钮事件
    @IBAction func backButtonClick()
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - 选择照片
    /*----- 选择照片 ------*/
    @IBAction func addImageButtonClick()
    {
        let actionSheet = UIActionSheet(title: "请选择", delegate: self, cancelButtonTitle: "取消", destructiveButtonTitle: nil, otherButtonTitles: "从相册选","拍照")
        actionSheet.show(in: self.view)
    }
    
    // MARK: - 选取相册
    func fromAlbum()
    {
        //判断设置是否支持图片库
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary)
        {
            //初始化图片控制器
            let picker = UIImagePickerController()
            
            //设置代理
            picker.delegate = self
            
            //设置媒体类型
            picker.mediaTypes = [kUTTypeImage as String,kUTTypeVideo as String]
            
            //设置允许编辑
            picker.allowsEditing = true
            
            //指定图片控制器类型
            picker.sourceType = UIImagePickerControllerSourceType.photoLibrary
            
            //弹出控制器，显示界面
            self.present(picker, animated: true, completion: { () -> Void in
                
            })
            
        }
        else
        {
            let aler = UIAlertView(title: "读取相册错误!", message: nil, delegate: nil, cancelButtonTitle: "确定")
            aler.show()
        }
    }
    
    // MARK: - 拍照
    func fromPhotograph()
    {
        if UIImagePickerController.isSourceTypeAvailable(.camera)
        {
            //创建图片控制器
            let picker = UIImagePickerController()
            
            //设置代理
            picker.delegate = self
            
            //设置来源
            picker.sourceType = UIImagePickerControllerSourceType.camera
            
            
            //设置镜头
            if UIImagePickerController.isCameraDeviceAvailable(UIImagePickerControllerCameraDevice.front)
            {
                picker.cameraDevice = UIImagePickerControllerCameraDevice.front
            }
            
            //设置闪光灯
            picker.cameraFlashMode = UIImagePickerControllerCameraFlashMode.on
            
            //允许编辑
            picker.allowsEditing = true;
            
            //打开相机
            self.present(picker, animated: true, completion: { () -> Void in
                
            })
            
        }
        else
        {
            let aler = UIAlertView(title: "找不到相机!", message: nil, delegate: nil, cancelButtonTitle: "确定")
            aler.show()
        }
    }
    
    // MARK: - UIImagePickerControllerDelegate
    
    //选择图片成功之后代理
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        //查看info对象
        print(info)
        
        //获取选择的原图
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        //赋值，图片视图显示图片
        picView.image = image
        
        //图片控制器退出
        picker.dismiss(animated: true, completion: { () -> Void in
            
        })
    }
    
    //取消图片控制器代理
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
    {
        //图片控制器退出
        picker.dismiss(animated: true, completion: { () -> Void in
            
        })
    }
    
    
    // MARK: - UIActionSheetDelegate
    func actionSheet(_ actionSheet: UIActionSheet, clickedButtonAt buttonIndex: Int)
    {
        if buttonIndex != actionSheet.cancelButtonIndex
        {
            if buttonIndex == 1  //从相册选
            {
                self.fromAlbum()
            }else if buttonIndex == 2 //拍照
            {
                self.fromPhotograph()
            }
        }
    }
    
    /*-----相册 end ------*/
    
    
    
    // MARK: - 播放MP3
    /*----- mp3 ------*/
    //定时器-
    func updateTime()
    {
        //获取音频播放器播放的进度，单位秒
        let cuTime:Float = Float(audioPlayer.currentTime)
        
        //更新进度条
        jinDuSlider.value = cuTime
        
        //获取总时间
        let duTime:Float = Float(audioPlayer.duration)
        
        //播放时间秒数，换算成：时、分、秒
        let hour1:Int = Int(cuTime/(60*60))
        let minute1:Int = Int(cuTime/60)
        let second1:Int = Int(cuTime.truncatingRemainder(dividingBy: 60))
        
        //总时间秒数，换算成：时、分、秒
        let hour2:Int = Int(duTime/(60*60))
        let minute2:Int = Int(duTime/60)
        let second2:Int = Int(duTime.truncatingRemainder(dividingBy: 60))
        
        
        //label显示
        timeLabel.text = NSString(format: "%.2d:%.2d:%.2d / %.2d:%.2d:%.2d",hour1,minute1,second1,hour2,minute2,second2) as String
    }
  
    //播放按钮事件
    @IBAction func audioPlayButton()
    {
        if audioPlayer.isPlaying
        {
            return;//如果已在播放，跳出
        }
        
        //开始播放音频文件
        audioPlayer.play()
        
        //设置进图条最小是=0
        jinDuSlider.minimumValue = 0.0;
        
        //设置进度条最大值等于声音的描述
        jinDuSlider.maximumValue = Float(audioPlayer.duration)
        
        //启动定时器 定时更新进度条和时间label 在updateTime方法中实现
        _timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(MultimediaController.updateTime), userInfo: nil, repeats: true)
    }
    
    //暂停
    @IBAction func audioPauseButton(_ sender:UIButton)
    {
        let title = sender.title(for: UIControlState())
        if  title == "Pause" && audioPlayer.isPlaying
        {
            audioPlayer.pause()
            sender.setTitle("Continue", for: UIControlState())
        }
        else if title == "Continue"
        {
            sender.setTitle("Pause", for: UIControlState())
            audioPlayer.play()
        }
    }
    
    //停止
    @IBAction func audioStopButton(_ sender:UIButton)
    {
        if(audioPlayer.isPlaying)
        {
            audioPlayer.stop()
            audioPlayer.currentTime=0;
            timeLabel.text = "";
        }
    }
    
    //调 进度
    @IBAction func jinDuChange(_ sender:UISlider)
    {
        //获取jinDuSlider的值来设置音频播放器进度
        print("当前进度：\(jinDuSlider.value)")
        audioPlayer.currentTime = TimeInterval(jinDuSlider.value)
        
        //播放器播放
        audioPlayer.play()
    }

    //控制声音
    @IBAction func audioSoundChange(_ sender:UISlider)
    {
        //获取UISlider对象的值，并设置audioPlayer.volume
        audioPlayer.volume = sender.value
        
        aLabel.text = "\(sender.value)"
    }
    
    //播放代理 AVAudioPlayerDelegate
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool)
    {
        //成功播放完毕结束
    }
    
    func audioPlayerDecodeErrorDidOccur(_ player: AVAudioPlayer, error: Error?)
    {
        //音频播放器的解码错误
    }
    
    //@availability(iOS, introduced=2.2, deprecated=8.0)
    func audioPlayerBeginInterruption(_ player: AVAudioPlayer)
    {
        //音频播放器开始中断
    }
    
    
    //@availability(iOS, introduced=6.0, deprecated=8.0)
    func audioPlayerEndInterruption(_ player: AVAudioPlayer, withOptions flags: Int)
    {
        //音频播放结束中断
    }
    
    
    /*-----mp3 end------*/
    
    
    
    
    
    
    
    
    
    
    
    
    // MARK: - 录音
    /*----- 录音 ------*/
    
    var recorder:AVAudioRecorder?   //录音器
    var player:AVAudioPlayer?   //播放器
    var recorderSettingsDic:[String : AnyObject]!   //录音器设置参数数组
    var volumeTimer:Timer!//定时器线程， 刷新音量
    var aacPath:String! //录音存储路径
    
     @IBOutlet var soundLodingImageView:UIImageView!//录音音量显示视图
    
    
    //按下录音
    @IBAction func downAction()
    {
        
        //初始化录音器
        do
        {
            recorder = try AVAudioRecorder(url: URL(string: aacPath)!, settings: recorderSettingsDic)
            
            //开启仪表计数功能
            recorder!.isMeteringEnabled = true;
            
            //准备录音
            recorder!.prepareToRecord()
            
            //开始录音
            recorder!.record()
            
            //启动定时器 定时更新录音音量
            volumeTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(MultimediaController.levelTimer), userInfo: nil, repeats: true)
        }
        catch let error as NSError {
            print("初始化录音器失败：\(error)")//如果失败，error 会返回错误信息
        }
    }

    
     //松开 结束录音
    @IBAction func upAction()
    {
        //停止录音
        recorder?.stop()
        
        //录制器释放
        recorder = nil
        
        //暂停定时器
        volumeTimer.invalidate()
        volumeTimer = nil
        
        //界面音量归0现实
        soundLodingImageView.image = UIImage(named: "RecordingSignal001")
    }
    
    //播放录制的声音
    @IBAction func playAction()
    {
        //播放
        player = nil;
        do
        {
            player = try AVAudioPlayer(contentsOf: URL(string: aacPath)!)
        }
        catch let error as NSError {
            print("初始化播放器失败：\(error)")//如果失败，error 会返回错误信息
        }
        
        if (player != nil)
        {
            player?.play()
        }
    }
    
    
    //定时器方法--检测录音音量
    func levelTimer()
    {
        recorder!.updateMeters()//刷新音量数据
        
        let averageV:Float = recorder!.averagePower(forChannel: 0)//获取音量的平均值
        print(averageV)
        
        let maxV:Float = recorder!.peakPower(forChannel: 0)//获取音量的最大值
        
        let lowPassResults:Double = pow(Double(10), Double(0.05 * maxV))
        print("\(lowPassResults)")
        
        
        if (lowPassResults>=0.8) {
            soundLodingImageView.image = UIImage(named: "RecordingSignal8.png")
        }else if(lowPassResults>=0.7){
            soundLodingImageView.image = UIImage(named: "RecordingSignal7.png")
        }else if(lowPassResults>=0.6){
            soundLodingImageView.image = UIImage(named: "RecordingSignal6.png")
        }else if(lowPassResults>=0.5){
            soundLodingImageView.image = UIImage(named: "RecordingSignal5.png")
        }else if(lowPassResults>=0.4){
            soundLodingImageView.image = UIImage(named: "RecordingSignal4.png")
        }else if(lowPassResults>=0.3){
            soundLodingImageView.image = UIImage(named: "RecordingSignal3.png")
        }else if(lowPassResults>=0.2){
            soundLodingImageView.image = UIImage(named: "RecordingSignal2.png")
        }else if(lowPassResults>=0.1){
            soundLodingImageView.image = UIImage(named: "RecordingSignal1.png")
        }else{
            soundLodingImageView.image = UIImage(named: "RecordingSignal1.png")
        }
        
    }
     /*----- 录音 end ------*/
    
    
    
    
    
    
    
    
    
    
    
    
    // MARK: - 播放视频
    /*----- 播放视频 ------*/
    
    
    func moviePlayerPreloadFinish(_ notification:Notification)
    {
        moviePlayer?.view.removeFromSuperview()
        print("播放完毕")
    }
    
    //声明一个媒体播放器
    var moviePlayer:MPMoviePlayerController?
    
    @IBAction func playMV()
    {
        let filePath:String? = Bundle.main.path(forResource: "namingRule", ofType: "mp4")
        
        //本地文件，使用fileURLWithPath来声明NSURL对象
        moviePlayer = MPMoviePlayerController(contentURL: URL(fileURLWithPath: filePath!))
        
        //如果播放网上视频，需要通过string方法来声明NSURL对象
//        moviePlayer = MPMoviePlayerController(contentURL: NSURL(string: "视频网址"))
        
        //用MPMoviePlayerController做在线音乐播放
//        moviePlayer = MPMoviePlayerController(contentURL: NSURL(string: "http://swift.leadingdo.com/Track08.mp3"))
        
        moviePlayer!.view.frame = self.view.frame;
        
        
        //设置播放器样式
        moviePlayer!.controlStyle = MPMovieControlStyle.fullscreen
        self.view.addSubview(moviePlayer!.view)
        moviePlayer!.play()
        
        //需要使用 NSNotificationCenter 类，为电影播放器添加一个观察者(observer):
        
        NotificationCenter.default.addObserver(self, selector: #selector(MultimediaController.moviePlayerPreloadFinish(_:)), name: NSNotification.Name.MPMoviePlayerPlaybackDidFinish, object: nil)
    }
    /*----- 播放视频 ------*/
    
    
     // MARK: - 系统声音
    /*----- 系统声音 ------*/
    @IBAction func systemSound()
    {
        //建立的SystemSoundID对象
        var soundID: SystemSoundID = 0
        
        //获取声音文件地址
        let path = Bundle.main.path(forResource: "SaoMa", ofType: "wav")
        
        //地址转换
        let baseURL = URL(fileURLWithPath: path!)
        
        //赋值
        AudioServicesCreateSystemSoundID(baseURL as CFURL , &soundID)
        
        //使用AudioServicesPlaySystemSound播放
        AudioServicesPlaySystemSound(soundID)
    }
    
    /*----- 系统提醒 ------*/
    @IBAction func systemAlert()
    {
        //建立的SystemSoundID对象
        var soundID: SystemSoundID = 0
        
        //获取声音文件地址
        let path = Bundle.main.path(forResource: "SaoMa", ofType: "wav")
        
        //地址转换
        let baseURL = URL(fileURLWithPath: path!)
        
        //赋值
        AudioServicesCreateSystemSoundID(baseURL as CFURL , &soundID)
        
        //使用AudioServicesPlayAlertSound播放
        AudioServicesPlayAlertSound(soundID)

    }
    
    /*----- 系统震动 ------*/
    @IBAction func systemVibration()
    {
         //建立的SystemSoundID对象
        let soundID = SystemSoundID(kSystemSoundID_Vibrate)
        
        //使用AudioServicesPlaySystemSound播放
        AudioServicesPlaySystemSound(soundID)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let mp3Path = Bundle.main.path(forResource: "xiaoPingGuo", ofType: "mp3")
        
        let fileUrl = URL(fileURLWithPath: mp3Path!)
        
        do
        {
            audioPlayer = try AVAudioPlayer(contentsOf: fileUrl)
        }
        catch let error as NSError {
            print("初始化播放器失败：\(error)")//如果失败，error 会返回错误信息
        }
        audioPlayer.prepareToPlay()
        
        
        //以下录音使用
        //初始化录音器
        let session:AVAudioSession = AVAudioSession.sharedInstance()
        
        //设置录音类型
        do
        {
            try session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        }
        catch let error as NSError {
            print("失败：\(error)")//如果失败，error 会返回错误信息
        }
        
        
        
        //设置支持后台
        do
        {
            try session.setActive(true)
        }
        catch let error as NSError {
            print("失败：\(error)")//如果失败，error 会返回错误信息
        }
        
        //获取Document目录
        let docDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        
        //组合录音文件路径
        aacPath = docDir + "/play.aac"
        
        //初始化字典
        recorderSettingsDic = Dictionary()
        
        //字典添加设置参数
        recorderSettingsDic!.updateValue(NSNumber(value: kAudioFormatMPEG4AAC as UInt32), forKey: AVFormatIDKey)
        recorderSettingsDic!.updateValue(NSNumber(value: 1000 as Int), forKey: AVSampleRateKey)
        recorderSettingsDic!.updateValue(NSNumber(value: 2 as Int), forKey: AVNumberOfChannelsKey)
        recorderSettingsDic!.updateValue(NSNumber(value: 8 as Int), forKey: AVLinearPCMBitDepthKey)
        recorderSettingsDic!.updateValue(NSNumber(value: false as Bool), forKey: AVLinearPCMIsBigEndianKey)
        recorderSettingsDic!.updateValue(NSNumber(value: false as Bool), forKey: AVLinearPCMIsFloatKey)

        
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

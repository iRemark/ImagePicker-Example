//
//  ImagePicker.swift
//  ImagePicker-Example
//
//  Created by chuck lee on 2019/4/26.
//  Copyright © 2019年 chuck. All rights reserved.
//

import UIKit
import TZImagePickerController

protocol ImagePickerProtocol {
    func didFinishPickPhoto(images: [UIImage]);
}

extension ImagePickerProtocol  {
    func didFinishPickPhoto(images: [UIImage]) { }
}


class ImagePicker: NSObject {
    
    
    private var maxPictureCount: Int = 0;
    private var fromController: UIViewController?
    
    private var pickerDelegate: ImagePickerProtocol?
    
    
    //进入照相
    public func show(from controller: UIViewController, maxCount: Int, delegate: ImagePickerProtocol) {
        fromController = controller;
        maxPictureCount = maxCount;
        pickerDelegate = delegate;
        self.takePhoto();
    }
    
    
    //显示底部弹框
    public func presentSheet(from controller: UIViewController, maxCount: Int, delegate: ImagePickerProtocol) {
        fromController = controller;
        maxPictureCount = maxCount;
        pickerDelegate = delegate;
        
        let optionMenu = UIAlertController(title: nil, message: "Choose Option", preferredStyle: .actionSheet)
        
        let saveAction = UIAlertAction(title: "Take Photo", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            print("Take Photo")
            self.takePhoto();
        })
        
        let deleteAction = UIAlertAction(title: "Pick Photo", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            print("Pick Photo")
            self.pickPhoto();
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {
            (alert: UIAlertAction!) -> Void in
            print("Cancelled")
        })
        
        optionMenu.addAction(deleteAction)
        optionMenu.addAction(saveAction)
        optionMenu.addAction(cancelAction)
        controller.present(optionMenu, animated: true, completion: nil);
        
    }

    
    //照相
    private func takePhoto() {
        if let pickerVC = TZImagePickerController.init(maxImagesCount: maxPictureCount, delegate: self) {
            
            //在内部显示拍照
            pickerVC.allowTakePicture = true;
            
            // imagePickerVc.isSelectOriginalPhoto = _isSelectOriginalPhoto;
            
            // 1.如果你需要将拍照按钮放在外面，不要传这个参数
            // pickerVC? = _selectedAssets; // optional, 可选的
            pickerVC.allowTakePicture = true; // 在内部显示拍照按钮
            
            // 2. Set the appearance
            // 2. 在这里设置imagePickerVc的外观
            //     imagePickerVc.navigationBar.barTintColor = [UIColor greenColor];
            //     imagePickerVc.oKButtonTitleColorDisabled = [UIColor lightGrayColor];
            //     imagePickerVc.oKButtonTitleColorNormal = [UIColor greenColor];
            
            // 3. Set allow picking video & photo & originalPhoto or not
            // 3. 设置是否可以选择视频/图片/原图
            pickerVC.allowPickingVideo = false;
            pickerVC.allowPickingImage = true;
            pickerVC.allowPickingOriginalPhoto = false;
            
            // 4. 照片排列按修改时间升序
            pickerVC.sortAscendingByModificationDate = true;
            
            fromController?.present(pickerVC, animated: true, completion: nil);
        }
    }
    
    //选取手机图片
    private let pickerVC = UIImagePickerController()
    private func pickPhoto() {
        let authStatus: AVAuthorizationStatus = AVCaptureDevice.authorizationStatus(for: .video);
        
        if authStatus == .restricted || authStatus == .denied {
            let optionMenu = UIAlertController(title: nil, message: "Choose Option", preferredStyle: .alert)
            
            let saveAction = UIAlertAction(title: "Save", style: .default, handler: {
                (alert: UIAlertAction!) -> Void in
                print("Saved")
            })
            optionMenu.addAction(saveAction)
            fromController?.present(optionMenu, animated: true, completion: nil);
            
        }else {
            // 调用相机
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                pickerVC.sourceType = .camera
                pickerVC.delegate = self
                pickerVC.allowsEditing = true
                fromController?.present(pickerVC, animated: true)
                
            }else {
                print("模拟器中无法打开照相机,请在真机中使用");
            }
        }
    }
}


extension ImagePicker: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//        if picker.mediaTypes?.contains(kUTTypeImage) ?? false {
//            DispatchQueue.global(qos: .default).async(execute: {
        
//                DispatchQueue.main.async(execute: {
//
//                    self.fromController?.view.showHUD(withText: "处理中...")
//                })
//                // 原图/编辑后的图片
//                // UIImagePickerControllerOriginalImage/UIImagePickerControllerEditedImage
//                var image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
//                // 1. 处理图片
//                image = self.imageProcessing(image)
//                // 2. 写入缓存
//                var filePath = self.imageDataWrite(toFile: image)
//                // 3. 加入数组、返回数组、重置数组
//                self.imagesURL.append(filePath)
                
                
//                DispatchQueue.main.async(execute: {
////                    self.finish(self.imagesURL)
////                    self.imagesURL = nil
////                    self.superViewController.view.hideHUD()
//                })
//            })
//        }
//        fromController?.dismiss(animated: true, completion: nil);

    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        fromController?.dismiss(animated: true, completion: nil);
    }
}


extension ImagePicker: TZImagePickerControllerDelegate {
    func imagePickerController(_ picker: TZImagePickerController!, didFinishPickingPhotos photos: [UIImage]!, sourceAssets assets: [Any]!, isSelectOriginalPhoto: Bool) {
        DispatchQueue.main.async(execute: {
            self.pickerDelegate?.didFinishPickPhoto(images: photos);
        })
    }
    
    func imagePickerController(_ picker: TZImagePickerController!, didFinishPickingPhotos photos: [UIImage]!, sourceAssets assets: [Any]!, isSelectOriginalPhoto: Bool, infos: [[AnyHashable : Any]]!) {
        
    }
}

extension ImagePicker: UINavigationControllerDelegate {
    
}

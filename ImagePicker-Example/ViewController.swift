//
//  ViewController.swift
//  ImagePicker-Example
//
//  Created by chuck lee on 2019/4/26.
//  Copyright © 2019年 chuck. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        self.oimagePicker = OriginalImagePicker(presentationController: self, delegate: self)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
//        let image = info[UIImagePickerControllerOriginalImage]
//        headImage.image = image as! UIImage?
//        print(info)
//        self.dismiss(animated: true, completion: nil)
    }
    
    var oimagePicker: OriginalImagePicker!
    var imagePicker: ImagePicker = ImagePicker();
    
    @IBAction func pickAction(_ sender: UIButton) {
//        imagePicker.show(from: self, maxCount: 1, delegate: self);
        
        self.oimagePicker.present(from: sender)
    }
    
    @IBAction func lookAction(_ sender: Any) {
    }
    
    
    
    @IBAction func showImagePicker(_ sender: UIButton) {
        
    }
}


extension ViewController: OriginalImagePickerDelegate {
    
    func didSelect(image: UIImage?) {
//        self.imageView.image = image
    }
}



extension ViewController: ImagePickerProtocol {
    func didFinishPickPhoto(images: [UIImage]) {
        
    }
    
    
}


extension ViewController: (UIImagePickerControllerDelegate & UINavigationControllerDelegate) {
    
}






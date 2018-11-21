//
//  LoginViewController.swift
//  CommponentLearnPath
//
//  Created by TRS on 2018/11/20.
//  Copyright © 2018年 TRS. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa


class LoginViewController: BaseViewController {

    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let r = String.randomString(16)
        print("密钥: \(r)")
        let en = NSString.des("513127199312212222", key: r, isEncrypt: true)
        print("密文:\(en ?? "")")
        let de = NSString.des(en ?? "", key: r, isEncrypt: false)
        print("原文:\(de ?? "")")
        
        setupUI()
        
    }
    
    private func setupUI() {
        
        view.backgroundColor = .white
        for index in 0..<4 {
            let imageView = UIImageView(frame: .zero)
            imageView.clipsToBounds  = true
            view.addSubview(imageView)
            let oringin = UIImage(named: "左上") ?? UIImage()
            let cgImage = oringin.cgImage!
            let size = ScaleSize(CGSize(width: 32, height: 32))
            let vMargin: CGFloat = ScaleH(40.0)
            let hMargin: CGFloat = ScaleW(20.0)
            switch index {
            case 0://左上
                imageView.image = oringin
                imageView.snp.makeConstraints { (make) in
                    make.top.equalTo(view).offset(vMargin)
                    make.left.equalTo(view).offset(hMargin)
                    make.size.equalTo(size)
                }
            case 1://右上
                imageView.image = UIImage(cgImage: cgImage, scale: 1, orientation: UIImage.Orientation.right)
                imageView.snp.makeConstraints { (make) in
                    make.top.equalToSuperview().offset(vMargin)
                    make.right.equalToSuperview().offset(-hMargin)
                    make.size.equalTo(size)
                }
            case 2:
                imageView.image = UIImage(cgImage: cgImage, scale: 1, orientation: .downMirrored)
                imageView.snp.makeConstraints { (make) in
                    make.bottom.equalToSuperview().offset(-vMargin)
                    make.left.equalToSuperview().offset(hMargin)
                    make.size.equalTo(size)
                }
            case 3:
                imageView.image = UIImage(cgImage: cgImage, scale: 1, orientation: UIImage.Orientation.rightMirrored)
                imageView.snp.makeConstraints { (make) in
                    make.bottom.equalToSuperview().offset(-vMargin)
                    make.right.equalToSuperview().offset(-hMargin)
                    make.size.equalTo(size)
                }
            default: break
            }
        }
        
        let logo = UIImageView(image: UIImage(named: "珠宝防伪logo"))
        view.addSubview(logo)
        logo.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(ScaleH(150))
            make.size.equalTo(ScaleSize(CGSize(width: 508/2, height: 227/2)))
        }
        
        let loginBt = UIButton(type: UIButton.ButtonType.system)
        loginBt.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        loginBt.setTitleColor(UIColor.white, for: .normal)
        loginBt.setTitle("登 录", for: .normal)
        loginBt.setBackgroundImage(UIImage(named: "登录"), for: .normal)
        view.addSubview(loginBt)
        
        loginBt.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(ScaleH(-72))
            make.left.equalToSuperview().offset(ScaleW(30))
            make.right.equalToSuperview().offset(ScaleW(-30))
            make.height.equalTo(ScaleH(41))
        }
        
        loginBt.rx
            .tap
            .subscribe(onNext: { (_) in
                print("Tap")
            })
            .disposed(by: disposeBag)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

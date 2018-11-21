//
//  YHMarkInputView.swift
//  CommponentLearnPath
//
//  Created by TRS on 2018/11/20.
//  Copyright © 2018年 TRS. All rights reserved.
//

import UIKit

struct MarkInputViewModel {
    var isHidenMark: Bool = false
    var markImageName: String = ""
    var placeHolder: String = ""
    var isHidenBottomLine: Bool = false
    var textMaxLength: Int = Int.max
    var text: String = ""
}

/// 带图标的输入框 🚩 XXXXXXXX
///             ------------
class YHMarkInputView: UIView {
    
    var viewModel: MarkInputViewModel!
    
    var markImageView: UIImageView?
    var bottomLine: UIView?
    var textField: UITextField!
    
    init(frame: CGRect, _ viewModel: MarkInputViewModel = MarkInputViewModel()) {
        super.init(frame: frame)
        self.viewModel = viewModel
    }
    
    func setupUI() -> Void {
        if !viewModel.isHidenMark {
            markImageView = UIImageView()
            markImageView?.contentMode = .scaleAspectFit
            markImageView?.image = UIImage(named: viewModel.markImageName)
            addSubview(markImageView!)
            markImageView?.snp.makeConstraints({ (make) in
                make.left.equalToSuperview()
                make.centerY.equalToSuperview()
                make.size.equalTo(ScaleSize(CGSize(width: 15, height: 15)))
            })
        }
        if !viewModel.isHidenBottomLine {
            bottomLine = UIView(frame: .zero)
            addSubview(bottomLine!)
            bottomLine?.snp.makeConstraints({ (make) in
                make.left.right.bottom.equalToSuperview()
                make.height.equalTo(0.5)
            })
            bottomLine?.backgroundColor = .gray
        }
        
        textField = UITextField(frame: .zero)
        addSubview(textField)
        textField.snp.makeConstraints { (make) in
            make.right.top.equalToSuperview()
            make.bottom.equalToSuperview().offset(-1)
            if viewModel.isHidenMark {
                make.left.equalToSuperview()
            }else {
                make.left.equalTo(markImageView!.snp.right)
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

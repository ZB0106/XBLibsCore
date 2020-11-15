//
//  XBDownLineBtn.swift
//  DuoBaan
//
//  Created by rongzebing on 2019/4/25.
//  Copyright © 2019 rongzebing. All rights reserved.
//

import UIKit

public enum XBDownLineType {
    case short
    case long
}

public struct XBMenuButtonComponents {
    var title: String?
    var downlineType = XBDownLineType.long
    var titleColor = UIColor.black
    var _selTitleColor: UIColor?
    var selTitleColor: UIColor? {
        get {_selTitleColor != nil ? _selTitleColor : titleColor}
        set {_selTitleColor = newValue}
    }
    var imgName: String?
    var _selImgName: String?
    var selImgName: String? {
        get {_selImgName != nil ? _selImgName : imgName}
        set {_selImgName = newValue}
    }
    var downLineColor = UIColor.clear
    var downLineSelColor = UIColor.clear
    var font = UIFont.systemFont(ofSize: 16.0, weight: .regular)
    var _selFont: UIFont?
    var selFont: UIFont? {
        get {_selFont != nil ? _selFont : font}
        set {_selFont = newValue}
    }
    var downLineWidth: CGFloat = 0.0
    var downLineHeight: CGFloat = 2.0
    var target: Any?
    var action: Selector?
    var event: UIControl.Event = .touchUpInside
    var horiAliment: UIControl.ContentHorizontalAlignment = .center
    var verAliment: UIControl.ContentVerticalAlignment = .center
    
}


public class XBDownLineBtn: UIButton {
    
    private var components: XBMenuButtonComponents!
    
    public init(components: XBMenuButtonComponents) {
        super.init(frame: .zero)
        self.components = components
        self.layer.addSublayer(downLine)
        titleLabel?.font = components.font
        setTitleColor(components.titleColor, for: .normal)
        setTitleColor(components.selTitleColor, for: .selected)
        setTitle(components.title, for: .normal)
        setTitle(components.title, for: .selected)
        if components.imgName != nil {
            setImage(UIImage(named: components.imgName!), for: .normal)
        }
        if components.selImgName != nil {
            setImage(UIImage(named: components.selImgName!), for: .selected)
        }
        self.contentHorizontalAlignment = components.horiAliment
        self.contentVerticalAlignment = components.verAliment
        self.adjustsImageWhenHighlighted = false
        guard components.target != nil, components.action != nil else {
            return
        }
        self.addTarget(components.target!, action: components.action!, for: components.event)
    }
    lazy var downLine: CALayer = {
        let view = CALayer()
        return view
    }()
    public override var isSelected: Bool {
        didSet {
            if isSelected {
                self.downLine.backgroundColor = components.downLineSelColor.cgColor
                self.titleLabel?.font = components.selFont
            } else {
                self.downLine.backgroundColor = components.downLineColor.cgColor
                self.titleLabel?.font = components.font
            }
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func layoutSubviews() {
        
        super.layoutSubviews()
        if components.downlineType == .long {
            downLine.frame = CGRect(x: 0, y: self.frame.size.height-components.downLineHeight, width: self.frame.size.width, height: components.downLineHeight)
        } else {
            if components.downLineWidth > 0 {
                downLine.frame = CGRect(x: (self.frame.width-components.downLineWidth)/2.0, y: self.frame.height-components.downLineHeight, width: components.downLineWidth, height: components.downLineHeight)
            } else if (currentImage != nil && currentTitle != nil) {
                let minX = self.titleLabel!.frame.minX < self.imageView!.frame.minX ? self.titleLabel!.frame.minX : self.imageView!.frame.minX
                let maxX = self.titleLabel!.frame.maxX > self.imageView!.frame.maxX ? self.titleLabel!.frame.maxX : self.imageView!.frame.maxX
                downLine.frame = CGRect(x: minX, y: self.frame.height-components.downLineHeight, width: maxX-minX, height: components.downLineHeight)
            } else if currentTitle == nil {
                downLine.frame = CGRect(x: self.imageView!.frame.minX, y: self.frame.height-components.downLineHeight, width: self.imageView!.frame.width, height: components.downLineHeight)
            } else if currentImage == nil {
                downLine.frame = CGRect(x: self.titleLabel!.frame.minX, y: self.frame.height-components.downLineHeight, width: self.titleLabel!.frame.width, height: components.downLineHeight)
            }
             
        }
        
    }

}

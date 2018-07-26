//
//  SwiGradientTransitionView.swift
//  MyTest
//
//  Created by Elroy on 2018/7/26.
//  Copyright © 2018年 es. All rights reserved.
//

import UIKit
import EasyPeasy

class SwiGradientTransitionView: UIView {

    /**
     *  MARK: - 圆缩放比例
     */
    var cirlcePercentage: CGFloat = 0 {
        didSet {
            let value = cirlcePercentage

            let a_per = averageColor(fromColor: colorA1, toColor: colorA, percent: value)
            let b_per = averageColor(fromColor: colorB1, toColor: colorB, percent: value)

            gradientLayer1.colors = [a_per.cgColor, b_per.cgColor]

            let sizePercent1: CGFloat = 1.0 - (1.0 - (circle1MinSize / circle1MaxSize)) * value
            gradientLayer1.transform = CATransform3DMakeScale(sizePercent1, sizePercent1, 1)

            gradientLayer2.colors = [a_per.cgColor, b_per.cgColor]

            let sizePercent2: CGFloat = 1.0 + ((circle2MaxSize / circle2MinSize) - 1.0) * value
            gradientLayer2.transform = CATransform3DMakeScale(sizePercent2, sizePercent2, 1)
        }
    }

    /**
     * MARK: - 颜色过渡
     * 颜色从左到右a ——> b, a1 ——> b1
     * 颜色切换 a ——> a1, b ——> b1
     */
    var colorA: UIColor = UIColor(red: 56 / 255.0, green: 160 / 255.0, blue: 226 / 255.0, alpha: 1)
    var colorB: UIColor = UIColor(red: 101 / 255.0, green: 86 / 255.0, blue: 239 / 255.0, alpha: 1)
    var colorA1: UIColor = UIColor(red: 87 / 255.0, green: 126 / 255.0, blue: 240 / 255.0, alpha: 1)
    var colorB1: UIColor = UIColor(red: 144 / 255.0, green: 135 / 255.0, blue: 255 / 255.0, alpha: 1)

    /**
     * 两个圆的大小，最大和最小
     */
    private var _cirlce1MaxSize: CGFloat = 370.0
    var circle1MaxSize: CGFloat {
        set {
            let screenWidth = UIScreen.main.bounds.size.width
            _cirlce1MaxSize = newValue * screenWidth / 375.0
        }
        get {
            return _cirlce1MaxSize
        }
    }

    private var _cirlce1MinSize: CGFloat = 280.0
    var circle1MinSize: CGFloat {
        set {
            let screenWidth = UIScreen.main.bounds.size.width
            _cirlce1MinSize = newValue * screenWidth / 375.0
        }
        get {
            return _cirlce1MinSize
        }
    }

    private var _cirlce2MaxSize: CGFloat = 310.0
    var circle2MaxSize: CGFloat {
        set {
            let screenWidth = UIScreen.main.bounds.size.width
            _cirlce2MaxSize = newValue * screenWidth / 375.0
        }
        get {
            return _cirlce2MaxSize
        }
    }

    private var _cirlce2MinSize: CGFloat = 190.0
    var circle2MinSize: CGFloat {
        set {
            let screenWidth = UIScreen.main.bounds.size.width
            _cirlce2MinSize = newValue * screenWidth / 375.0
        }
        get {
            return _cirlce2MinSize
        }
    }

    /**
     * 两个过渡色的圆，只显示圆的一部分，切换过程圆的大小以及颜色变化
     */
    private lazy var circle1View: UIView = {
        let circle = UIView()
        circle.backgroundColor = UIColor.clear
        return circle
    }()

    private lazy var circle2View: UIView = {
        let circle = UIView()
        circle.backgroundColor = UIColor.clear
        return circle
    }()


    private lazy var gradientLayer1: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.locations = [0.0, 1.0]

        //设置渲染的起始结束位置（横向渐变）
        layer.startPoint = CGPoint(x: 0, y: 0)
        layer.endPoint = CGPoint(x: 1, y: 0)

        layer.type = kCAGradientLayerAxial
        return layer
    }()

    private lazy var gradientLayer2: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.locations = [0.0, 1.0]

        //设置渲染的起始结束位置（横向渐变）
        layer.startPoint = CGPoint(x: 0, y: 0)
        layer.endPoint = CGPoint(x: 1, y: 0)

        layer.type = kCAGradientLayerAxial
        return layer
    }()

    override init(frame: CGRect) {
        super.init(frame: CGRect.zero)

        backgroundColor = UIColor.clear
        clipsToBounds = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 初始化两个圆
    func drawCircles() {
        let widthRate: CGFloat = UIScreen.main.bounds.size.width / 375.0

        // 右边圆
        addSubview(circle2View)
        circle2View.easy.layout( Top(-circle2MinSize / 2.0), Right(-(circle2MinSize / 2.0 - 63 * widthRate)), Width(circle2MinSize), Height(circle2MinSize) )

        // 左边圆
        addSubview(circle1View)
        circle1View.easy.layout( Top(-circle1MaxSize / 2.0), Left(-(circle1MaxSize / 2.0 - 80 * widthRate)), Width(circle1MaxSize), Height(circle1MaxSize) )

        self.layoutIfNeeded()

        let a_per = averageColor(fromColor: colorA1, toColor: colorA, percent: 0)
        let b_per = averageColor(fromColor: colorB1, toColor: colorB, percent: 0)

        gradientLayer1.colors = [a_per.cgColor, b_per.cgColor]
        gradientLayer1.frame = circle1View.bounds
        gradientLayer1.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        circle1View.layer.insertSublayer(gradientLayer1, at: 0)
        gradientLayer1.cornerRadius = circle1MaxSize / 2.0

        gradientLayer2.colors = [a_per.cgColor, b_per.cgColor]
        gradientLayer2.frame = circle2View.bounds
        gradientLayer2.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        circle2View.layer.insertSublayer(gradientLayer2, at: 0)
        gradientLayer2.cornerRadius = circle2MinSize / 2.0
    }

}

extension SwiGradientTransitionView {

    // 计算颜色的过度
    func averageColor(fromColor: UIColor, toColor: UIColor, percent: CGFloat) -> UIColor {
        var fromRed: CGFloat = 0
        var fromGreen: CGFloat = 0
        var fromBlue: CGFloat = 0
        var fromAlpha: CGFloat = 0
        fromColor.getRed(&fromRed, green: &fromGreen, blue: &fromBlue, alpha: &fromAlpha)

        var toRed: CGFloat = 0
        var toGreen: CGFloat = 0
        var toBlue: CGFloat = 0
        var toAlpha: CGFloat = 0
        toColor.getRed(&toRed, green: &toGreen, blue: &toBlue, alpha: &toAlpha)

        let nowRed = fromRed + (toRed - fromRed) * percent
        let nowGreen = fromGreen + (toGreen - fromGreen) * percent
        let nowBlue = fromBlue + (toBlue - fromBlue) * percent
        let nowAlpha = fromAlpha + (toAlpha - fromAlpha) * percent

        return UIColor(red: nowRed, green: nowGreen, blue: nowBlue, alpha: nowAlpha)
    }
}

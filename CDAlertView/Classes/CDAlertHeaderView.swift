//
//  CDAlertHeaderView.swift
//  CDAlertView
//
//  Created by Candost Dagdeviren on 10/30/2016.
//  Copyright (c) 2016 Candost Dagdeviren. All rights reserved.
//

import Foundation

internal class CDAlertHeaderView: UIView {

    internal var circleFillColor: UIColor? {
        didSet {
            if let cfc = circleFillColor {
                fillColor = cfc
            }
        }
    }
    internal var isIconFilled: Bool = false
    internal var alertBackgroundColor: UIColor = UIColor.white.withAlphaComponent(0.9)
    internal var hasShadow: Bool = true
    internal var headerCircleImage: UIImage? {
        didSet {
            if let hci = headerCircleImage {
                imageView.image = hci
            }
        }
    }
    private var fillColor: UIColor!
    private var type: CDAlertViewType?
    private var imageView: UIImageView!

    convenience init(type: CDAlertViewType, isIconFilled: Bool) {
        self.init(frame: .zero)
        self.type = type
        self.isIconFilled = isIconFilled
        backgroundColor = UIColor.clear
        imageView = createImageView()
    }
    
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath(roundedRect: CGRect(x: 0, y: 16, width: rect.size.width, height: rect.size.height-16),
                                byRoundingCorners: [.topLeft, .topRight],
                                cornerRadii: CGSize(width: 8, height: 8))
        alertBackgroundColor.setFill()
        path.fill()

        let curve = UIBezierPath(arcCenter: CGPoint(x: rect.size.width/2, y: 28),
                                 radius: 28,
                                 startAngle:6.84 * CGFloat.pi / 6,
                                 endAngle: 11.155 * CGFloat.pi / 6,
                                 clockwise: true)
        alertBackgroundColor.setFill()
        curve.fill()

        let innerCircle = UIBezierPath(arcCenter: CGPoint(x: rect.size.width/2, y: 28),
                                       radius: 24,
                                       startAngle:0,
                                       endAngle: 2 * CGFloat.pi,
                                       clockwise: true)
        fillColor.setFill()
        innerCircle.fill()

        if hasShadow {
            layer.shadowColor = UIColor.black.cgColor
            layer.shadowOpacity = 0.2
            layer.shadowRadius = 4
            layer.shadowOffset = CGSize.zero
            layer.masksToBounds = false
            let shadowPath = UIBezierPath()
            shadowPath.move(to: CGPoint(x: 0.0, y: rect.size.height))
            shadowPath.addLine(to: CGPoint(x: 0, y: 16))
            shadowPath.addLine(to: CGPoint(x: (rect.size.width/2)-15, y: 16))
            shadowPath.addArc(withCenter: CGPoint(x: rect.size.width/2, y: 28),
                              radius: 28,
                              startAngle: 6.84 * CGFloat.pi / 6,
                              endAngle: 11.155 * CGFloat.pi / 6,
                              clockwise: true)
            shadowPath.addLine(to: CGPoint(x: rect.size.width, y: 16))
            shadowPath.addLine(to: CGPoint(x: rect.size.width, y: rect.size.height))
            shadowPath.addLine(to: CGPoint(x: rect.size.width-10, y: rect.size.height-5))
            shadowPath.addLine(to: CGPoint(x: 10, y: rect.size.height-5))
            shadowPath.close()
            layer.shadowPath = shadowPath.cgPath
        }
    }

    private func createImageView() -> UIImageView {
        let imageView = UIImageView(frame: .zero)
        var imageName: String?
        if let t = type {
            switch t {
            case .error:
                imageName = "error"
                fillColor = UIColor(red: 235/255, green: 61/255, blue: 65/255, alpha: 1)
            case .success:
                imageName = "check"
                fillColor = UIColor(red: 65/255, green: 158/255, blue: 57/255, alpha: 1)
            case .warning:
                imageName = isIconFilled ? "warningFilled" : "warningOutline"
                fillColor = UIColor(red: 255/255, green: 149/255, blue: 0/255, alpha: 1)
            case .notification:
                imageName = isIconFilled ? "notificationFilled" : "notificationOutline"
                fillColor = UIColor(red: 27/255, green: 169/255, blue: 225/255, alpha: 1)
            case .alarm:
                imageName = isIconFilled ? "alarmFilled" : "alarmOutline"
                fillColor = UIColor(red: 196/255, green: 52/255, blue: 46/255, alpha: 1)
            default:
                imageView.image = nil
                fillColor = UIColor.white.withAlphaComponent(0.9)
            }
            imageView.image = ImageHelper.loadImage(name: imageName)
        }

        imageView.contentMode = .center
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.centerHorizontally()

        imageView.alignToTop(of: self, margin: 12, multiplier: 1)
        imageView.setHeight(32)
        imageView.setWidth(32)


        
        return imageView
    }
}

//
//  Extension.swift
//  Mowza3
//
//  Created by Rafi on 22/08/2022.
//

import Foundation
import UIKit
import Toast_Swift

import MapboxDirections
import MapboxCoreNavigation
import MapboxNavigation
import MapboxMaps
import SVProgressHUD
extension NSMutableAttributedString {
    public func setAsLink(textToFind:String, linkURL:String) -> Bool {
        let foundRange = self.mutableString.range(of: textToFind)
        if foundRange.location != NSNotFound {
           self.addAttribute(.link, value: linkURL, range: foundRange)
            return true
        }
        return false
    }
}


extension UIView {
    
    func addRippleAnimation(withColor color: UIColor, duration: TimeInterval = 0.5) {
            // Create the ripple layer
            let rippleLayer = CAShapeLayer()
            rippleLayer.fillColor = UIColor.clear.cgColor
            rippleLayer.strokeColor = color.cgColor
            rippleLayer.lineWidth = 2.0
            rippleLayer.path = UIBezierPath(ovalIn: bounds).cgPath
            
            // Add the ripple layer to the view's layer
            layer.addSublayer(rippleLayer)
            
            // Create the ripple animation
            let animation = CABasicAnimation(keyPath: "transform.scale")
            animation.fromValue = 0.0
            animation.toValue = 1.0
            animation.duration = duration
            animation.timingFunction = CAMediaTimingFunction(name: .easeOut)
            
            // Add the animation to the ripple layer
            rippleLayer.add(animation, forKey: nil)
        }

    
    func addGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.colors = [UIColor(named: "#084F24")?.cgColor ?? UIColor(), UIColor(named: "#327425")?.cgColor ?? UIColor()]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        self.layer.addSublayer(gradientLayer)
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.masksToBounds = true
        self.clipsToBounds = true
        layer.mask = mask
    }
    
    
    func addTopBorder(with color: UIColor?, andWidth borderWidth: CGFloat) {
        let border = UIView()
        border.backgroundColor = color
        border.autoresizingMask = [.flexibleWidth, .flexibleBottomMargin]
        border.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: borderWidth)
        addSubview(border)
    }

    func addBottomBorder(with color: UIColor?, andWidth borderWidth: CGFloat) {
        let border = UIView()
        border.backgroundColor = color
        border.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
        border.frame = CGRect(x: 0, y: frame.size.height - borderWidth, width: frame.size.width, height: borderWidth)
        addSubview(border)
    }

    func addLeftBorder(with color: UIColor?, andWidth borderWidth: CGFloat) {
        let border = UIView()
        border.backgroundColor = color
        border.frame = CGRect(x: 0, y: 0, width: borderWidth, height: frame.size.height)
        border.autoresizingMask = [.flexibleHeight, .flexibleRightMargin]
        addSubview(border)
    }

    func addRightBorder(with color: UIColor?, andWidth borderWidth: CGFloat) {
        let border = UIView()
        border.backgroundColor = color
        border.autoresizingMask = [.flexibleHeight, .flexibleLeftMargin]
        border.frame = CGRect(x: frame.size.width - borderWidth, y: 0, width: borderWidth, height: frame.size.height)
        addSubview(border)
    }
    
    func showWithAnimation(delegate: UIViewController) {
        self.alpha = 0.0
        UIView.animate(withDuration: 0.5) {
            self.alpha = 1
            delegate.view.addSubview(self)
        }
    }
    
    func hideWithAnimation() {
        UIView.animate(withDuration: 0.5) {
            self.alpha = 0
        }
    }
    
    func addBottomShadow() {
        layer.masksToBounds = false
        layer.shadowRadius = 2
        layer.shadowOpacity = 0.5
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOffset = CGSize(width: 0 , height: 2)
        layer.shadowPath = UIBezierPath(rect: CGRect(x: 0,
                                                     y: bounds.maxY - layer.shadowRadius,
                                                     width: bounds.width,
                                                     height: layer.shadowRadius)).cgPath
    }
    
    func edges(_ edges: UIRectEdge, to view: UIView, offset: UIEdgeInsets) {
        if edges.contains(.top) || edges.contains(.all) {
            self.topAnchor.constraint(equalTo: view.topAnchor, constant: offset.top).isActive = true
        }
        
        if edges.contains(.bottom) || edges.contains(.all) {
            self.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: offset.bottom).isActive = true
        }
        
        if edges.contains(.left) || edges.contains(.all) {
            self.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: offset.left).isActive = true
        }
        
        if edges.contains(.right) || edges.contains(.all) {
            self.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: offset.right).isActive = true
        }
    }
    
    func edges(_ edges: UIRectEdge, to layoutGuide: UILayoutGuide, offset: UIEdgeInsets) {
        if edges.contains(.top) || edges.contains(.all) {
            self.topAnchor.constraint(equalTo: layoutGuide.topAnchor, constant: offset.top).isActive = true
        }
        
        if edges.contains(.bottom) || edges.contains(.all) {
            self.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor, constant: offset.bottom).isActive = true
        }
        
        if edges.contains(.left) || edges.contains(.all) {
            self.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor, constant: offset.left).isActive = true
        }
        
        if edges.contains(.right) || edges.contains(.all) {
            self.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor, constant: offset.right).isActive = true
        }
    }
    
//    func addGradient() {
//        let gradientLayer = CAGradientLayer()
//        gradientLayer.frame = self.bounds
//        gradientLayer.colors = [UIColor(hex: "#327425"), UIColor(hex: "#084F24")]
//        self.layer.addSublayer(gradientLayer)
//    }
    
    func viewShadow() {
       layer.masksToBounds = false
        layer.shadowColor = UIColor(named: "ShadowColor")?.cgColor
       layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
       layer.shadowOpacity = 0.5
    }
}

extension UILabel {
    func applyGradientText(colors: [UIColor]) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.colors = colors.map { $0.cgColor }
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        
        let textMaskLayer = CALayer()
        textMaskLayer.frame = self.bounds
        textMaskLayer.contents = self.text?.renderToImage(from: self.font, textColor: UIColor.black).cgImage
        gradientLayer.mask = textMaskLayer
        
        self.layer.addSublayer(gradientLayer)
    }
}

extension UIColor{
    func rgbColor() -> UIColor {
       return UIColor(red: 255/229, green: 255/130, blue: 52/255, alpha: 1)
    }
    
    convenience init(hexString: String) {
            let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
            var int = UInt64()
            Scanner(string: hex).scanHexInt64(&int)
            let a, r, g, b: UInt64
            switch hex.count {
            case 3: // RGB (12-bit)
                (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
            case 6: // RGB (24-bit)
                (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
            case 8: // ARGB (32-bit)
                (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
            default:
                (a, r, g, b) = (255, 0, 0, 0)
            }
            self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
        }
    
    convenience init(hex: String) {
            let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
            var int = UInt64()
            Scanner(string: hex).scanHexInt64(&int)
            let a, r, g, b: UInt64
            switch hex.count {
            case 3: // RGB (12-bit)
                (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
            case 6: // RGB (24-bit)
                (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
            case 8: // ARGB (32-bit)
                (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
            default:
                (a, r, g, b) = (255, 0, 0, 0)
            }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(50) / 255)
        }
    
    
}


extension UIImage {
    func scalePreservingAspectRatio(targetSize: CGSize) -> UIImage {
        // Determine the scale factor that preserves aspect ratio
        let widthRatio = targetSize.width / size.width
        let heightRatio = targetSize.height / size.height
        
        let scaleFactor = min(widthRatio, heightRatio)
        
        // Compute the new image size that preserves aspect ratio
        let scaledImageSize = CGSize(
            width: size.width * scaleFactor,
            height: size.height * scaleFactor
        )

        // Draw and return the resized UIImage
        let renderer = UIGraphicsImageRenderer(
            size: scaledImageSize
        )

        let scaledImage = renderer.image { _ in
            self.draw(in: CGRect(
                origin: .zero,
                size: scaledImageSize
            ))
        }
        
        return scaledImage
    }
}

extension UIApplication {
    var keywindow: UIWindow? {
        let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        return scene?.windows.filter({ $0.isKeyWindow }).first
    }
    
    func setRoot(vc: UIViewController) {
        keywindow?.rootViewController = vc
    }
}

extension String{
    
    func renderToImage(from font: UIFont, textColor: UIColor) -> UIImage {
            let attributes: [NSAttributedString.Key: Any] = [
                .font: font,
                .foregroundColor: textColor
            ]
            
            let size = self.size(withAttributes: attributes)
            let rect = CGRect(origin: .zero, size: size)
            
            UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
            
            self.draw(in: rect, withAttributes: attributes)
            
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            return image ?? UIImage()
        }
    
    func isValidEmail() -> Bool {
        // here, `try!` will always succeed because the pattern is valid
        let emailRegEx = "(?:[a-z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-z0-9!#$%\\&'*+/=?\\^_`{|}"+"~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\"+"x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-"+"z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5"+"]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-"+"9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21"+"-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
        
        let emailTest = NSPredicate(format:"SELF MATCHES[c] %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    
    var asUrl: URL? {
        return URL(string: self)
    }
    
    //    func stripOutHtml() -> String? {
    //        do {
    //            guard let data = self.data(using: .unicode) else {
    //                return nil
    //            }
    //            let attributed = try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
    //            return attributed.string
    //        } catch {
    //            return nil
    //        }
    //    }
    
    
    func stripOutHtml() -> String {
        guard let data = self.data(using: .utf8) else {
            return self
        }
        
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]
        
        if let attributedString = try? NSAttributedString(data: data, options: options, documentAttributes: nil) {
            var plainText = attributedString.string
            plainText = plainText.trimmingCharacters(in: .whitespacesAndNewlines)
            return plainText
        } else {
            return self
        }
    }





    
    func removeSpaces() -> String {
        let trimmedStr = self.trimmingCharacters(in: .whitespacesAndNewlines)
        return trimmedStr
    }
     
}

extension UIApplication {
    
    class func topViewController(_ viewController: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = viewController as? UINavigationController {
            return topViewController(nav.visibleViewController)
        }
        if let tab = viewController as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(selected)
            }
        }
        if let presented = viewController?.presentedViewController {
            return topViewController(presented)
        }
        
        return viewController
    }
}


public extension UITableView {
    
    func didScrolled() {
        print(self.contentOffset.y < self.contentInset.top)
        if self.contentOffset.y < self.contentInset.top{
            print(self.contentOffset.y)
            if self.contentOffset.y < Constants.tableViewOffset {
                self.isScrollEnabled = false
            }
        }
    }
    
    func reloadWithoutScrolling() {
        let contentOffset = self.contentOffset
        self.reloadData()
        self.layoutIfNeeded()
        self.setContentOffset(contentOffset, animated: false)
    }
    
    func setEmptyView(_ message: String? = nil) {
        let image = UIImage(named: "")
        let emptyImageView = UIImageView(image: image)
        emptyImageView.contentMode = .scaleAspectFit
        if let _ = image {
            emptyImageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        } else {
            emptyImageView.heightAnchor.constraint(equalToConstant: 0).isActive = true
        }
        let titleLabel = UILabel()
        let messageLabel = UILabel()
        
        titleLabel.textColor = Helper.shared.textColor()
        titleLabel.font = UIFont(name: "Poppins-regular", size: 16)
        messageLabel.textColor = Helper.shared.textColor()
        messageLabel.font = UIFont(name: "Poppins-regular", size: 14)
        titleLabel.text = message ?? "No Data!"
        messageLabel.text = ""
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        
        let containerStack = UIStackView(arrangedSubviews: [emptyImageView, titleLabel, messageLabel])
        containerStack.alignment = .center
        containerStack.axis = .vertical
        containerStack.distribution = .fill
        containerStack.spacing = 10
        
        let containerView = UIView()
        containerView.addSubview(containerStack)
        containerStack.translatesAutoresizingMaskIntoConstraints = false
        containerStack.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.7, constant: 0).isActive = true
        containerStack.centerYAnchor.constraint(equalTo: containerView.centerYAnchor, constant: -20).isActive = true
        containerStack.centerXAnchor.constraint(equalTo: containerView.centerXAnchor, constant: 0).isActive = true
        self.backgroundView = containerView
    }
    
    func noInternet() {
        let image = UIImage(named: "no-internet")
        let emptyImageView = UIImageView(image: image)
        emptyImageView.contentMode = .scaleAspectFit
        if let _ = image {
            emptyImageView.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
        } else {
            emptyImageView.heightAnchor.constraint(equalToConstant: 0).isActive = true
        }
        let titleLabel = UILabel()
        let messageLabel = UILabel()
        
        titleLabel.textColor = Helper.shared.textColor()
        titleLabel.font = UIFont(name: "Poppins-Medium", size: 16)
        messageLabel.textColor = Helper.shared.textColor()
        messageLabel.font = UIFont(name: "Poppins-Light", size: 14)
        titleLabel.text = "No Internet"
        messageLabel.text = "You're currently offline. Please connect with Wifi and try again later."
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        
        let containerStack = UIStackView(arrangedSubviews: [emptyImageView, titleLabel, messageLabel])
        containerStack.alignment = .center
        containerStack.axis = .vertical
        containerStack.distribution = .fill
        containerStack.spacing = 10
        
        let containerView = UIView()
        containerView.addSubview(containerStack)
        containerStack.translatesAutoresizingMaskIntoConstraints = false
        containerStack.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.7, constant: 0).isActive = true
        containerStack.centerYAnchor.constraint(equalTo: containerView.centerYAnchor, constant: 0).isActive = true
        containerStack.centerXAnchor.constraint(equalTo: containerView.centerXAnchor, constant: 0).isActive = true
        self.backgroundView = containerView
    }
    
    func restore() {
        self.backgroundView = nil
    }
    
    func registerNibForCellClass(_ cellClass: UITableViewCell.Type) {
        let cellReuseIdentifier = cellClass.cellReuseIdentifier()
        let nibCell = UINib(nibName: cellReuseIdentifier, bundle: nil)
        register(nibCell, forCellReuseIdentifier: cellReuseIdentifier)
    }
}

extension UITableViewCell{
    class func cellReuseIdentifier() -> String {
        return "\(self)"
    }
}

extension UICollectionViewCell{
    class func cellReuseIdentifier() -> String {
        return "\(self)"
    }
}



extension CGRect {
    var center: CGPoint {
        return CGPoint(x: self.midX, y: self.midY)
    }
}


extension UIViewController {
    
    func add(_ child: UIViewController, in container: UIView) {
        addChild(child)
        container.addSubview(child.view)
        child.view.frame = container.bounds
        child.didMove(toParent: self)
//        child.viewWillAppear(false)
        //due to this viewWillAppear call two time
    }
    
    func add(_ child: UIViewController) {
        add(child, in: view)
    }
    
    func remove(from view: UIView) {
        guard parent != nil else {
            return
        }
        
        willMove(toParent: nil)
        removeFromParent()
        view.removeFromSuperview()
    }
    
    func remove() {
        remove(from: view)
    }
    
    class func identifier() -> String {
        return String(describing: self)
    }
   
    public func showAlert(title: String = "", message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        self.present(alert, animated: true, completion: nil)
    }
    
    public func share(title: String, text: String, image: UIImage){
        print(text)
        let activityViewController: UIActivityViewController = UIActivityViewController(activityItems: [image, text], applicationActivities: nil)
        activityViewController.excludedActivityTypes = [
                    .addToReadingList,
                    .assignToContact,
                    .print
                ]
        activityViewController.title = title
        DispatchQueue.main.async {
            self.present(activityViewController, animated: true, completion: nil)
        }
    }
    
    func showAlert(error: AppError) {
        let alert = UIAlertController(title: title, message: error.errorDescription,         preferredStyle: UIAlertController.Style.alert)

//        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: { _ in
//             //Cancel Action
//         }))
         alert.addAction(UIAlertAction(title: "OK",
                                       style: UIAlertAction.Style.default,
                                       handler: {(_: UIAlertAction!) in
                                         //Sign out action
         }))
         self.present(alert, animated: true, completion: nil)
     }
    
    func actionSheet(title:String = "", message:String, buttonTitles:[String], completion: @escaping (_ responce: String) -> Void) {
                let actionSheet = UIAlertController(title: "", message: "choose action", preferredStyle: .actionSheet)
                actionSheet.addAction(UIAlertAction(title: "Edit", style: .default, handler: { action in
                }))
                actionSheet.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { action in
                }))
                present(actionSheet, animated: true)
    }
}

extension UICollectionView{
    func setEmptyView(_ message: String? = nil) {
        self.backgroundView = nil
        let image = UIImage(named: "")
        let emptyImageView = UIImageView(image: image)
        emptyImageView.contentMode = .scaleAspectFit
        if let _ = image {
            emptyImageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        } else {
            emptyImageView.heightAnchor.constraint(equalToConstant: 0).isActive = true
        }
        let titleLabel = UILabel()
        let messageLabel = UILabel()
        
        titleLabel.textColor = Helper.shared.textColor()
        titleLabel.font = UIFont(name: "Poppins-regular", size: 16)
        messageLabel.textColor = Helper.shared.textColor()
        messageLabel.font = UIFont(name: "Poppins-regular", size: 14)
        titleLabel.text = message ?? "No Data!"
        messageLabel.text = ""
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        
        let containerStack = UIStackView(arrangedSubviews: [emptyImageView, titleLabel, messageLabel])
        containerStack.alignment = .center
        containerStack.axis = .vertical
        containerStack.distribution = .fill
        containerStack.spacing = 10
        
        let containerView = UIView()
        containerView.addSubview(containerStack)
        containerStack.translatesAutoresizingMaskIntoConstraints = false
        containerStack.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.7, constant: 0).isActive = true
        containerStack.centerYAnchor.constraint(equalTo: containerView.centerYAnchor, constant: -20).isActive = true
        containerStack.centerXAnchor.constraint(equalTo: containerView.centerXAnchor, constant: 0).isActive = true
        self.backgroundView = containerView
    }
    
    func noInternet() {
        self.backgroundView = nil
        let image = UIImage(named: "no-internet")
        let emptyImageView = UIImageView(image: image)
        emptyImageView.contentMode = .scaleAspectFit
        if let _ = image {
            emptyImageView.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
        } else {
            emptyImageView.heightAnchor.constraint(equalToConstant: 0).isActive = true
        }
        let titleLabel = UILabel()
        let messageLabel = UILabel()
        
        titleLabel.textColor = Helper.shared.textColor()
        titleLabel.font = UIFont(name: "Poppins-Medium", size: 16)
        messageLabel.textColor = Helper.shared.textColor()
        messageLabel.font = UIFont(name: "Poppins-Light", size: 14)
        titleLabel.text = "No Internet"
        messageLabel.text = "You're currently offline. Please connect with Wifi and try again later."
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        
        let containerStack = UIStackView(arrangedSubviews: [emptyImageView, titleLabel, messageLabel])
        containerStack.alignment = .center
        containerStack.axis = .vertical
        containerStack.distribution = .fill
        containerStack.spacing = 10
        
        let containerView = UIView()
        containerView.addSubview(containerStack)
        containerStack.translatesAutoresizingMaskIntoConstraints = false
        containerStack.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.7, constant: 0).isActive = true
        containerStack.centerYAnchor.constraint(equalTo: containerView.centerYAnchor, constant: 0).isActive = true
        containerStack.centerXAnchor.constraint(equalTo: containerView.centerXAnchor, constant: 0).isActive = true
        self.backgroundView = containerView
    }
    
    func emptyView() {
        self.backgroundView = nil
    }
}


extension String {
    
    func specialPriceAttributedStringWith(_ color: UIColor) -> NSMutableAttributedString {
        let attributes = [NSAttributedString.Key.strikethroughStyle: NSNumber(value: NSUnderlineStyle.single.rawValue as Int),
                          .foregroundColor: color, .font: fontForPrice()]
        return NSMutableAttributedString(attributedString: NSAttributedString(string: self, attributes: attributes))
    }
    
    func priceAttributedStringWith(_ color: UIColor) -> NSAttributedString {
        let attributes = [NSAttributedString.Key.foregroundColor: color, .font: fontForPrice()]
        
        return NSAttributedString(string: self, attributes: attributes)
    }
    
    func priceAttributedString(_ color: UIColor) -> NSAttributedString {
        let attributes = [NSAttributedString.Key.foregroundColor: color]
        
        return NSAttributedString(string: self, attributes: attributes)
    }
    
    fileprivate func fontForPrice() -> UIFont {
        return Constants.MediumFont ?? UIFont()
    }
}

extension UIWindow {
    static var key: UIWindow! {
        if #available(iOS 13, *) {
            return UIApplication.shared.windows.first { $0.isKeyWindow }
        } else {
            return UIApplication.shared.keyWindow
        }
    }
}

extension UITextField{
    func useUnderline() {
        let border = CALayer()
        let borderWidth = CGFloat(1.0)
        border.borderColor = UIColor.lightGray.cgColor
        border.frame = CGRectMake(0, self.frame.size.height - borderWidth, self.frame.size.width, self.frame.size.height)
        border.borderWidth = borderWidth
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
}


extension UIViewController{
    func getDirection(originCoordinate: CLLocationCoordinate2D, destinationCoordinate: CLLocationCoordinate2D) {
        let origin = Waypoint(coordinate: originCoordinate, name: "")
        let destination = Waypoint(coordinate: destinationCoordinate, name: "")

        let routeOptions = NavigationRouteOptions(waypoints: [origin, destination])
        SVProgressHUD.show(withStatus: "Please wait...")
        Directions(credentials: Credentials(accessToken: Constants.mapboxPublicKey)).calculate(routeOptions) { [weak self] (session, result) in
            SVProgressHUD.dismiss()
            switch result {
            case .failure(let error):
                SVProgressHUD.showError(withStatus: error.localizedDescription)
            case .success(let response):
                guard let self = self else { return }
                let viewController = NavigationViewController(for: response, routeIndex: 0, routeOptions: routeOptions)
                viewController.modalPresentationStyle = .fullScreen
                self.present(viewController, animated: true, completion: nil)
            }
        }
    }
}

extension UILabel {
    func applyShadowEffect() {
        // Set shadow properties
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOffset = CGSize(width: 2, height: 2)
        layer.shadowOpacity = 0.8
        layer.shadowRadius = 4
    }
}


extension String {
    var htmlToAttributedString: String? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
                .documentType: NSAttributedString.DocumentType.html,
                .characterEncoding: String.Encoding.utf8.rawValue
            ]
            let attributedString = try NSAttributedString(data: data, options: options, documentAttributes: nil)
            let mutableAttributedString = NSMutableAttributedString(attributedString: attributedString)
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .justified
            mutableAttributedString.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: mutableAttributedString.length))
            let font = UIFont(name: "Poppins", size: 14.0)
            mutableAttributedString.addAttribute(.font, value: font ?? UIFont(), range: NSRange(location: 0, length: mutableAttributedString.length))
            let string = mutableAttributedString.string
            
            return string.trimmingCharacters(in: .whitespacesAndNewlines)
        } catch {
            return nil
        }
    }
    
//    var htmlToString: String {
//        return htmlToAttributedString?.string ?? ""
//    }
}

//
//  Extensions.swift
//  News Hunt
//
//  Created by MacBook Pro on 7/27/23.
//

import Foundation
import UIKit
//import SpinKit
extension UIView {
    
    func addGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.colors = [UIColor(named: "#084F24")?.cgColor ?? UIColor(), UIColor(named: "#327425")?.cgColor ?? UIColor()]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        self.layer.addSublayer(gradientLayer)
        self.layer.insertSublayer(gradientLayer, at: 0)
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
        layer.shadowColor = UIColor.lightGray.cgColor
       layer.shadowOffset = CGSize(width: 1.0, height: 2.0)
       layer.shadowOpacity = 0.5
    }
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        self.layer.mask = maskLayer
    }
    
    func removeShadow() {
            layer.shadowOffset = CGSize.zero
            layer.shadowColor = nil
            layer.shadowRadius = 0
            layer.shadowOpacity = 0
        }
    
//    func setLanguage(code: AppLanguagecode, language: AppLanguage, isRTL: Int) {
//        UserDefaults.standard.isRTL = isRTL
//        UserDefaults.standard.selectedLanguage = language.rawValue
//        UserDefaults.standard.languageCode = code.rawValue
//        UIView.appearance().semanticContentAttribute = isRTL == 1 ? .forceRightToLeft : .forceLeftToRight
//    }
}

extension UIColor {
    convenience init(hex: UInt32, alpha: CGFloat = 1.0) {
        let red = CGFloat((hex & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((hex & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(hex & 0x0000FF) / 255.0
        self.init(red: red, green: green, blue: blue, alpha: alpha)
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

extension UIViewController {

    func isChildViewControllerPresent() -> Bool {
        return children.contains(self)
    }
    
    func hasNotch() -> Bool {
        if #available(iOS 11.0, *) {
            let window = UIApplication.shared.windows.first
            if let safeAreaInsets = window?.safeAreaInsets {
                return safeAreaInsets.top > 20 // Check if the top safe area inset is greater than 20 points
            }
        }
        return false
    }
    
//    public func showAlert(title: String = "", message: String){
//        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: LocalizationKeys.ok.rawValue.localizeString(), style: .default))
//        self.present(alert, animated: true, completion: nil)
//    }
//
//    
//    func showAlertWithbuttton(title: String = "", message: String,  okAction: @escaping () -> Void) {
//        let alert = UIAlertController(title: title, message: message,         preferredStyle: UIAlertController.Style.alert)
//
////        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: { _ in
////             //Cancel Action
////         }))
//        alert.addAction(UIAlertAction(title: LocalizationKeys.ok.rawValue.localizeString(), style: .default, handler: { _ in
//                // OK action passed from the caller
//                okAction()
//            }))
//         self.present(alert, animated: true, completion: nil)
//     }
//    
//    func showAlertWithbutttons(title: String = "", message: String,  okAction: @escaping () -> Void) {
//        let alert = UIAlertController(title: title, message: message,         preferredStyle: UIAlertController.Style.alert)
//
//        alert.addAction(UIAlertAction(title: LocalizationKeys.cancel.rawValue.localizeString(), style: UIAlertAction.Style.default, handler: { _ in
//            alert.dismiss(animated: true)
//         }))
//        alert.addAction(UIAlertAction(title: LocalizationKeys.ok.rawValue.localizeString(), style: .default, handler: { _ in
//                // OK action passed from the caller
//                okAction()
//            }))
//         self.present(alert, animated: true, completion: nil)
//     }
    
    func actionSheet(title:String = "", message:String, buttonTitles:[String], completion: @escaping (_ responce: String) -> Void) {
                let actionSheet = UIAlertController(title: "", message: "choose action", preferredStyle: .actionSheet)
                actionSheet.addAction(UIAlertAction(title: "Edit", style: .default, handler: { action in
                }))
                actionSheet.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { action in
                }))
                present(actionSheet, animated: true)
    }

    
    func add(_ child: UIViewController, in container: UIView) {
        addChild(child)
        container.addSubview(child.view)
        child.view.frame = container.bounds
        child.didMove(toParent: self)
        child.viewWillAppear(false)
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

extension UICollectionViewFlowLayout {
    open override var flipsHorizontallyInOppositeLayoutDirection: Bool {
        return true
    }
}

extension String{
    var asUrl: URL? {
        return URL(string: self)
    }
}


//extension UITableView{
//    func setEmptyView(_ message: String? = nil) {
//        let image = UIImage(named: "empty")
//        let emptyImageView = UIImageView(image: image)
//        emptyImageView.contentMode = .scaleAspectFit
//        if let _ = image {
//            emptyImageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
//        } else {
//            emptyImageView.heightAnchor.constraint(equalToConstant: 0).isActive = true
//        }
//        let titleLabel = UILabel()
//        let messageLabel = UILabel()
//        
//        titleLabel.textColor = .label
//        titleLabel.font = UIFont(name: "Outfit-regular", size: 16)
//        messageLabel.textColor = .label
//        messageLabel.font = UIFont(name: "Outfit-regular", size: 14)
////        titleLabel.text = message ?? LocalizationKeys.noRecordFound.rawValue.localizeString()
////        titleLabel.text =
//
//        messageLabel.text = message ?? LocalizationKeys.noComplaintstoShow.rawValue.localizeString()
//        messageLabel.numberOfLines = 0
//        messageLabel.textAlignment = .center
//        
//        let containerStack = UIStackView(arrangedSubviews: [emptyImageView, titleLabel, messageLabel])
//        containerStack.alignment = .center
//        containerStack.axis = .vertical
//        containerStack.distribution = .fill
//        containerStack.spacing = 10
//        
//        let containerView = UIView()
//        containerView.addSubview(containerStack)
//        containerStack.translatesAutoresizingMaskIntoConstraints = false
//        containerStack.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.7, constant: 0).isActive = true
//        containerStack.centerYAnchor.constraint(equalTo: containerView.centerYAnchor, constant: -70).isActive = true
//        containerStack.centerXAnchor.constraint(equalTo: containerView.centerXAnchor, constant: 0).isActive = true
//        self.backgroundView = containerView
//    }
//    
//}

//extension UICollectionView{
//    func setEmptyView(_ message: String? = nil) {
//        let image = UIImage(named: "empty")
//        let emptyImageView = UIImageView(image: image)
//        emptyImageView.contentMode = .scaleAspectFit
//        if let _ = image {
//            emptyImageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
//        } else {
//            emptyImageView.heightAnchor.constraint(equalToConstant: 0).isActive = true
//        }
//        let titleLabel = UILabel()
//        let messageLabel = UILabel()
//        
//        titleLabel.textColor = .label
//        titleLabel.font = UIFont(name: "Outfit-regular", size: 16)
//        messageLabel.textColor = .label
//        messageLabel.font = UIFont(name: "Outfit-regular", size: 14)
////        titleLabel.text = message ?? LocalizationKeys.noRecordFound.rawValue.localizeString()
////        titleLabel.text =
//
//        messageLabel.text = message ?? LocalizationKeys.noComplaintstoShow.rawValue.localizeString()
//        messageLabel.numberOfLines = 0
//        messageLabel.textAlignment = .center
//        
//        let containerStack = UIStackView(arrangedSubviews: [emptyImageView, titleLabel, messageLabel])
//        containerStack.alignment = .center
//        containerStack.axis = .vertical
//        containerStack.distribution = .fill
//        containerStack.spacing = 10
//        
//        let containerView = UIView()
//        containerView.addSubview(containerStack)
//        containerStack.translatesAutoresizingMaskIntoConstraints = false
//        containerStack.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.7, constant: 0).isActive = true
//        containerStack.centerYAnchor.constraint(equalTo: containerView.centerYAnchor, constant: -70).isActive = true
//        containerStack.centerXAnchor.constraint(equalTo: containerView.centerXAnchor, constant: 0).isActive = true
//        self.backgroundView = containerView
//    }
//    
//}


extension UITextField {

    enum PaddingSide {
        case left(CGFloat)
        case right(CGFloat)
        case both(CGFloat)
    }

    func addPadding(_ padding: PaddingSide) {

        self.leftViewMode = .always
        self.layer.masksToBounds = true


        switch padding {

        case .left(let spacing):
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: spacing, height: self.frame.height))
            self.leftView = paddingView
            self.rightViewMode = .always

        case .right(let spacing):
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: spacing, height: self.frame.height))
            self.rightView = paddingView
            self.rightViewMode = .always

        case .both(let spacing):
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: spacing, height: self.frame.height))
            // left
            self.leftView = paddingView
            self.leftViewMode = .always
            // right
            self.rightView = paddingView
            self.rightViewMode = .always
        }
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

//extension String {
//    var htmlToAttributedString: NSAttributedString? {
//        guard let data = data(using: .utf8) else { return nil }
//        do {
//            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue,], documentAttributes: nil)
//        } catch {
//            return nil
//        }
//    }
//    var htmlToString: String {
//        return htmlToAttributedString?.string ?? ""
//    }
//}

extension String {
    var htmlToAttributedString: NSAttributedString? {
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
            let font = UIFont(name: "Ebrima", size: 16.0)
            mutableAttributedString.addAttribute(.font, value: font ?? UIFont(), range: NSRange(location: 0, length: mutableAttributedString.length))
            return mutableAttributedString
        } catch {
            return nil
        }
    }
    
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
}



extension String{
    func localizeString() -> String {
        var loc = ""
        let language: AppLanguage = AppLanguage(rawValue: UserDefaults.standard.selectedLanguage ?? "") ?? .english
        print(language)
        
        switch language {
        case .english:
            loc = "en"
        case .arabic:
            loc = "ar"
        }
        let path = Bundle.main.path(forResource: loc, ofType: "lproj")
        let bundle = Bundle(path: path!)
        return NSLocalizedString(self, tableName: nil, bundle: bundle!, value: "", comment: "")
    }
}

enum AppLanguage: String, CaseIterable {
    case english = "English"
    case arabic = "Arabic"
    
    var isLTR: Bool {
        return self == .english
    }
}

enum AppLanguagecode: String {
    case en
    case ar
}



//
//  MarkerView.swift
//  Tourism app
//
//  Created by MacBook Pro on 2/22/23.
//

import UIKit
import Mapbox
class MarkerView: UIView, MGLCalloutView {
    
    var representedObject: MGLAnnotation
    var annotationPoint: CGPoint?

    // Required views but unused for now, they can just relax
    lazy var leftAccessoryView = UIView()
    lazy var rightAccessoryView = UIView()

    weak var delegate: MGLCalloutViewDelegate?
    
    //MARK: Subviews -
    let titleLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Poppins-Medium", size: 15.0)
        return label
    }()
    
    let subtitleLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Poppins-Light", size: 15.0)
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    let imageView:UIImageView = {
        let imageview = UIImageView()
        imageview.translatesAutoresizingMaskIntoConstraints = false
        imageview.contentMode = .scaleToFill
        return imageview
    }()
    
    let button:UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "direction-green"), for: .normal)
        return button
    }()
    
//    let bgImgView:UIImageView = {
//        let bgImgView = UIImageView()
//        bgImgView.image = UIImage(named: "rectangular-map-bg")
//        bgImgView.translatesAutoresizingMaskIntoConstraints = false
//        bgImgView.contentMode = .scaleToFill
//        return bgImgView
//    }()
    
    required init(annotation: CustomAnnotation, annotationPoint: CGPoint) {
        self.representedObject = annotation
        self.annotationPoint = annotationPoint
        // init with 75% of width and 120px tall
        super.init(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: UIScreen.main.bounds.width * 0.9, height: 100.0)))
        
        self.titleLabel.text = self.representedObject.title ?? ""
        self.subtitleLabel.text = self.representedObject.subtitle ?? ""
        self.imageView.image = annotation.image
        setup()
    }
        
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        // setup this view's properties
        self.backgroundColor = UIColor.white
        
        // And their Subviews
//        self.addSubview(bgImgView)
        self.addSubview(titleLabel)
        self.addSubview(subtitleLabel)
        self.addSubview(imageView)
        self.addSubview(button)
        // Add Constraints to subviews
        let spacing:CGFloat = 8.0
        
//        bgImgView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
//        bgImgView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
//        bgImgView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
//        bgImgView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true

        button.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        button.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        button.widthAnchor.constraint(equalToConstant: 40.0).isActive = true
        button.heightAnchor.constraint(equalToConstant: 40.0).isActive = true

        imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        imageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 120.0).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: spacing).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: self.imageView.rightAnchor, constant: spacing).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -spacing).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 15.0).isActive = true
        
        subtitleLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 0).isActive = true
        subtitleLabel.leftAnchor.constraint(equalTo: self.imageView.rightAnchor, constant: spacing).isActive = true
        subtitleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: spacing).isActive = true
        subtitleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: spacing).isActive = true
    }
    
    
    func presentCallout(from rect: CGRect, in view: UIView, constrainedTo constrainedRect: CGRect, animated: Bool) {
        //Always, Slightly above centerd
        dismissCallout(animated: true)
        self.center = annotationPoint?.applying(CGAffineTransform(translationX: 0, y: -self.frame.height - 70.0)) ?? CGPoint(x: 0, y: 0)
        view.addSubview(self)
    }
    
    func dismissCallout(animated: Bool) {
        if (animated){
            //do something cool
            removeFromSuperview()
        } else {
            removeFromSuperview()
        }
        
    }
}


class CustomAnnotation: NSObject, MGLAnnotation {
    
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    var image: UIImage

    init(coordinate: CLLocationCoordinate2D, title: String, subtitle: String, image: UIImage) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
        self.image = image
    }
}

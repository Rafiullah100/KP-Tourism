//
//  CustomMakerView.swift
//  Tourism app
//
//  Created by Rafi on 01/11/2022.
//

import UIKit
import Mapbox

//class CustomMakerView: UIView {
//
//    @IBOutlet weak var locationLabel: UILabel!
//    @IBOutlet weak var imageView: UIImageView!
//    @IBOutlet weak var titleLabel: UILabel!
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        commoninit()
//    }
//
//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//        commoninit()
//    }
//
//    private func commoninit(){
//        let customMarkerView = Bundle.main.loadNibNamed("CustomMarkerView", owner: self, options: nil)![0] as! UIView
//        customMarkerView.frame = self.bounds
//        customMarkerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        addSubview(customMarkerView)
//    }
//}
//
//import Mapbox

class CustomMakerView: UIView, MGLCalloutView {
    
    // Your IBOutlets //
    @IBOutlet var contentView: UIView! // The custom callout's view.
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var representedObject: MGLAnnotation!
    var annotationPoint: CGPoint!
    // Required views but unused for this implementation.
    lazy var leftAccessoryView = UIView()
    lazy var rightAccessoryView = UIView()
    
    weak var delegate: MGLCalloutViewDelegate?
    
    // MARK: - init methods
    
    required init(annotation: CustomAnnotation, frame: CGRect, annotationPoint: CGPoint) {
        self.representedObject = annotation
        self.annotationPoint = annotationPoint
        
        super.init(frame: frame)
        
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("CustomMakerView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
    }
    
    // MARK: - MGLCalloutView methods
    
    func presentCallout(from rect: CGRect, in view: UIView, constrainedTo constrainedRect: CGRect, animated: Bool) {
        // Present the custom callout slightly above the annotation's view. Initially invisble.
        self.center = annotationPoint.applying(CGAffineTransform(translationX: 0, y: -self.frame.height - 20.0))
        
        // I have logic here for setting the correct image and button states //
    }
    
    func dismissCallout(animated: Bool) {
        removeFromSuperview()
    }
}

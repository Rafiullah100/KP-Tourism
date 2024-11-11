//
//  CustombgView.swift
//  Happy Home
//
//  Created by MacBook Pro on 11/4/24.
//

import UIKit

class CustombgView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        // Clear background to see the custom shape more clearly
        self.backgroundColor = .clear
    }
    
    override func draw(_ rect: CGRect) {
        // Define properties for the shape
        let cornerRadius: CGFloat = 15
        let notchWidth: CGFloat = 40
        let notchHeight: CGFloat = 10

        // Create a new path
        let path = UIBezierPath()
        
        // Start at the top-left corner, accounting for corner radius
        path.move(to: CGPoint(x: cornerRadius, y: 0))
        
        // Draw the top edge
        path.addLine(to: CGPoint(x: rect.width - cornerRadius, y: 0))
        path.addArc(withCenter: CGPoint(x: rect.width - cornerRadius, y: cornerRadius),
                    radius: cornerRadius,
                    startAngle: -.pi / 2,
                    endAngle: 0,
                    clockwise: true)
        
        // Draw the right edge
        path.addLine(to: CGPoint(x: rect.width, y: rect.height - cornerRadius))
        path.addArc(withCenter: CGPoint(x: rect.width - cornerRadius, y: rect.height - cornerRadius),
                    radius: cornerRadius,
                    startAngle: 0,
                    endAngle: .pi / 2,
                    clockwise: true)
        
        // Draw the bottom edge with the notch
        path.addLine(to: CGPoint(x: rect.width / 2 + notchWidth / 2, y: rect.height))
        path.addQuadCurve(to: CGPoint(x: rect.width / 2 - notchWidth / 2, y: rect.height),
                          controlPoint: CGPoint(x: rect.width / 2, y: rect.height + notchHeight))
        path.addLine(to: CGPoint(x: cornerRadius, y: rect.height))
        
        // Draw the left edge
        path.addArc(withCenter: CGPoint(x: cornerRadius, y: rect.height - cornerRadius),
                    radius: cornerRadius,
                    startAngle: .pi / 2,
                    endAngle: .pi,
                    clockwise: true)
        path.addLine(to: CGPoint(x: 0, y: cornerRadius))
        path.addArc(withCenter: CGPoint(x: cornerRadius, y: cornerRadius),
                    radius: cornerRadius,
                    startAngle: .pi,
                    endAngle: .pi * 1.5,
                    clockwise: true)
        
        // Close the path
        path.close()
        
        // Set fill color and draw the shape
        UIColor.white.setFill()
        path.fill()
        
        // Optional shadow
        self.layer.shadowPath = path.cgPath
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.1
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowRadius = 6
    }
}

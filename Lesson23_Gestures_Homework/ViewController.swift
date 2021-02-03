//
//  ViewController.swift
//  Lesson23_Gestures_Homework
//
//  Created by user173093 on 7/30/20.
//  Copyright © 2020 Alexander Germek. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet weak var myView: UIView!
    
    var myViewScale = CGFloat()
    var myViewRotation = CGFloat()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backgroundImage = UIImageView(frame: self.myView.bounds)
        backgroundImage.image = UIImage(named: "joker")
        backgroundImage.contentMode =  .scaleAspectFill
        self.myView.insertSubview(backgroundImage, at: 0)
        
        //TAP GESTURES
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        self.view.addGestureRecognizer(tapGesture)
        
        let doubleTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap))
        doubleTapGesture.numberOfTapsRequired = 2
        doubleTapGesture.numberOfTouchesRequired = 2
        self.view.addGestureRecognizer(doubleTapGesture)
        
        
        //SWIPE GESTURES
        let rightSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleRightSwipe))
        rightSwipeGesture.direction = .right
        self.view.addGestureRecognizer(rightSwipeGesture)
        
        let leftSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleLeftSwipe))
        leftSwipeGesture.direction = .left
        self.view.addGestureRecognizer(leftSwipeGesture)
        
        //PINCH GESTURE
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(handlePinch))
        pinchGesture.delegate = self
        self.view.addGestureRecognizer(pinchGesture)
        
        //ROTATION GESTURE
        let rotationGesture = UIRotationGestureRecognizer(target: self, action: #selector(handleRotation))
         rotationGesture.delegate = self
        self.view.addGestureRecognizer(rotationGesture) 
    }
    
    
    //MARK: GESTURES
    @objc func handleTap(tapGesture: UITapGestureRecognizer){
        UIView.animate(withDuration: 2, delay: 0,
                       options: [.beginFromCurrentState],
            animations: {
            let point = tapGesture.location(in: self.view)
            self.myView.center = point
        },
        completion: nil)
    }
    
    @objc func handleDoubleTap(doubleTapGesture: UITapGestureRecognizer){
        self.myView.layer.removeAllAnimations()
    }
    
    @objc func handleRightSwipe(rightSwipeGesture: UISwipeGestureRecognizer){
        for _ in 1...2{
            rotation(angle: CGFloat.pi)
        }
    }
    
    @objc func handleLeftSwipe(leftSwipeGesture: UISwipeGestureRecognizer){
        for _ in 1...2{
            rotation(angle: -(CGFloat.pi * 0.999))
        }
    }
    
    func rotation(angle: CGFloat){
        UIView.animateKeyframes(withDuration: 2, delay: 0,
                                options: .beginFromCurrentState,
                                animations: {
        self.myView.transform = self.myView.transform.rotated(by:angle)
        },
            completion: nil)
    }
    
    @objc func handlePinch(pinchGesture: UIPinchGestureRecognizer){
        if pinchGesture.state == .began{
            self.myViewScale = 1.0
        }
        
        let newScale = 1.0 + pinchGesture.scale - self.myViewScale

        self.myView.transform = self.myView.transform.scaledBy(x: newScale, y: newScale)
        
        self.myViewScale = pinchGesture.scale
        
    }
    
    @objc func handleRotation(rotationGesture: UIRotationGestureRecognizer){
        if rotationGesture.state == .began{
            self.myViewRotation = 0
        }
        
        let newRotation = rotationGesture.rotation - self.myViewRotation
        self.myView.transform = self.myView.transform.rotated(by: newRotation)
        self.myViewRotation  = rotationGesture.rotation
    }

       func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                              shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer
    ) -> Bool {
      return true
    }

}


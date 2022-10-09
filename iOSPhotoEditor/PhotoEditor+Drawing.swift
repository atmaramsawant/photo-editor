//
//  PhotoEditor+Drawing.swift
//  Photo Editor
//
//  Created by Mohamed Hamed on 6/16/17.
//
//
import UIKit

extension PhotoEditorViewController {
    
    override public func touchesBegan(_ touches: Set<UITouch>,
                                      with event: UIEvent?){
        if isDrawing {
            swiped = false
            if let touch = touches.first {
                lastPoint = touch.location(in: self.canvasImageView)
            }
        }
            //Hide stickersVC if clicked outside it
        else if stickersVCIsVisible == true {
            if let touch = touches.first {
                let location = touch.location(in: self.view)
                if !stickersViewController.view.frame.contains(location) {
                    removeStickersView()
                }
            }
        }else if isTyping == true{
            if let touch = touches.first {
                let touchedView = touch.view
                if touchedView == canvasImageView {
                    let location = touch.location(in: self.canvasImageView)
                    let myView = UITextView.init(frame: CGRect(x: location.x - 10, y: location.y - 10, width: 100, height: 25))
                    myView.delegate = self
                    myView.textAlignment = .center
                    myView.font = UIFont(name: "Helvetica", size: 18)
                    myView.layer.backgroundColor = UIColor.clear.cgColor
                    myView.textColor = textColor
                    myView.backgroundColor = UIColor.clear
                    myView.layer.shadowColor = UIColor.black.cgColor
                    myView.layer.shadowOffset = CGSize(width: 1.0, height: 0.0)
                    myView.layer.shadowOpacity = 0.2
                    myView.layer.shadowRadius = 1.0
                    myView.autocorrectionType = .no
                    myView.isScrollEnabled = false
                    addGestures(view: myView)
                    myView.text = currentTextValue
                    self.canvasImageView.addSubview(myView)
                    myView.sizeToFit()
                }
            }
        }
        else if isMarking == true{
            if let touch = touches.first {
                let touchedView = touch.view
                if touchedView == canvasImageView {
                    let location = touch.location(in: self.canvasImageView)
                    let label = UILabel.init(frame: CGRect(x: location.x - 15, y: location.y - 15, width: 30, height: 30))
                    label.font =  UIFont.boldSystemFont(ofSize: 25.0)  //UIFont(name: "Helvetica", size: 25)
                    label.layer.backgroundColor = UIColor.clear.cgColor
                    label.textColor = UIColor.black
                    label.backgroundColor = UIColor.clear
                    addGestures(view: label)
                    self.canvasImageView.addSubview(label)
                    label.text = "X"
                }
            }
        }
        
        lines.append([CGPoint]())
        
    }
    
    override public func touchesMoved(_ touches: Set<UITouch>,
                                      with event: UIEvent?){
        if isDrawing {
            // 6
            swiped = true
            if let touch = touches.first {
                let currentPoint = touch.location(in: canvasImageView)
                drawLineFrom(lastPoint, toPoint: currentPoint)
//                guard var lastLine = lines.popLast() else {return}
//                lastLine.append(currentPoint)
//                lines.append(lastLine)
//                // 7
                lastPoint = currentPoint
            }
            canvasImageView.setNeedsDisplay()
        }
    }
    
    override public func touchesEnded(_ touches: Set<UITouch>,
                                      with event: UIEvent?){
        if isDrawing {
            if !swiped {
                // draw a single point
                drawLineFrom(lastPoint, toPoint: lastPoint)
            }
        }
        
    }
    
    
    func drawLineFrom(_ fromPoint: CGPoint, toPoint: CGPoint) {
        // 1
        let canvasSize = canvasImageView.frame.integral.size
        UIGraphicsBeginImageContextWithOptions(canvasSize, false, 0)
        if let context = UIGraphicsGetCurrentContext() {
            canvasImageView.image?.draw(in: CGRect(x: 0, y: 0, width: canvasSize.width, height: canvasSize.height))
            // 2
            context.move(to: CGPoint(x: fromPoint.x, y: fromPoint.y))
            context.addLine(to: CGPoint(x: toPoint.x, y: toPoint.y))
            // 3
            context.setLineCap( CGLineCap.round)
            context.setLineWidth(5.0)
            context.setStrokeColor(drawColor.cgColor)
            context.setBlendMode( CGBlendMode.normal)
            // 4
            
            
            context.strokePath()
            
            let image  = UIGraphicsGetImageFromCurrentImageContext()
            
            imagesArray.append(image!)
            // 5
           // canvasImageView.image = image
            canvasImageView.addSubview(InvisibleView(frame: CGRect(x: 0, y: 0, width: 0, height: 0)))
        }
        UIGraphicsEndImageContext()
    }
    
}

//extension UIImageView{
//
//    public var lines = [[CGPoint]]()
//
//    open override func draw(_ rect: CGRect) {
//        super.draw(rect)
//
//        guard let context = UIGraphicsGetCurrentContext() else {return}
//
//        context.setStrokeColor(UIColor.red.cgColor)
//        context.setLineWidth(5.0)
//        context.setLineCap(.butt)
//
//        lines.forEach { (line) in
//            for (i,p) in line.enumerated(){
//                if i == 0 {
//                    context.move(to: p)
//                }else{
//                    context.addLine(to: p)
//                }
//            }
//
//        }
//
//        context.strokePath()
//
//    }
//
//}




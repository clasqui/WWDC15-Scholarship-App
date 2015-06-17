//
//  ContentController.swift
//  Marc Clascà
//
//  Created by Marc Clascà on 15/4/15.
//  Copyright (c) 2015 Marc Clascà. All rights reserved.
//

import UIKit


class ContentController: UIViewController, UIContentContainer {
    
    // Array of controllers that this content controller will manage
    let controllers = [UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("home") as! ViewController, UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("student") as! StudentViewController, UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("developer") as! MusicianViewController, UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("wwdc") as! DeveloperViewController]
    
    // Current child controller
    var currentControllerID: Int?
    
    var modalController: UIViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        displayContentController(controllers[0])

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func displayContentController(content: UIViewController){

        currentControllerID = 0

        self.addChildViewController(content)
        content.view.frame = self.view.frame
        view.addSubview(content.view)
        
        view.autoresizingMask = UIViewAutoresizing.FlexibleHeight | UIViewAutoresizing.FlexibleWidth
        
        content.didMoveToParentViewController(self)
        
        
    }
    
    //Presents a view controller that is not in the menu
    func showViewControllerInScreen(newController: UIViewController, fromController: UIViewController, event: UIEvent) {
        
        var touch: UITouch = event.allTouches()?.first as! UITouch
        var touchPoint: CGPoint = touch.locationInView(self.view)
        
        println("TOuch point x: \(touchPoint.x), y: \(touchPoint.y)")
        
        fromController.willMoveToParentViewController(nil)
        
        
        self.addChildViewController(newController)
        self.modalController = newController
        
        newController.view.frame = self.view.frame
        self.view.addSubview(fromController.view)
        
        // Configures the mask animation
        var circleMaskPathInitial = UIBezierPath(ovalInRect: CGRectMake(touchPoint.x, touchPoint.y, 1, 1))
        var extremePoint = CGPoint(x: touchPoint.x - 0, y: CGRectGetHeight(newController.view.bounds))
        
        var radius = sqrt((extremePoint.x * extremePoint.x) + (extremePoint.y * extremePoint.y)) + 50
        var circleMaskPathFinal = UIBezierPath(ovalInRect: CGRectInset(CGRectMake(touchPoint.x, touchPoint.y, 1, 1), -radius, -radius))
        
        var maskLayer = CAShapeLayer()
        maskLayer.path = circleMaskPathFinal.CGPath
        newController.view.layer.mask = maskLayer
        
        self.view.addSubview(newController.view)
        
        UIView.transitionWithView(self.view, duration: 2.5, options: nil, animations: { () -> Void in
            
            // Perform the circle mask animation
            
            var maskLayerAnimation = CABasicAnimation(keyPath: "path")
            maskLayerAnimation.fromValue = circleMaskPathInitial.CGPath
            maskLayerAnimation.toValue = circleMaskPathFinal.CGPath
            maskLayerAnimation.duration = 1
            maskLayerAnimation.delegate = self
            maskLayer.addAnimation(maskLayerAnimation, forKey: "path")
            
        }) { (finished) -> Void in
            
            newController.didMoveToParentViewController(self)
            
        }
        
    }
    

    
    
    func hideController() {

        
        modalController!.willMoveToParentViewController(nil)
        
        
        // Configures the mask animation
        var circleMaskPathFinal = UIBezierPath(ovalInRect: CGRectMake(view.frame.width / 2, view.frame.height / 2, 1, 1))
        var extremePoint = CGPoint(x: view.frame.width / 2, y: CGRectGetHeight(modalController!.view.bounds))
        
        var radius = sqrt((extremePoint.x * extremePoint.x) + (extremePoint.y * extremePoint.y)) + 50
        var circleMaskPathInitial = UIBezierPath(ovalInRect: CGRectInset(CGRectMake(view.frame.width / 2, view.frame.height / 2, 1, 1), -radius, -radius))
        
        var maskLayer = CAShapeLayer()
        maskLayer.path = circleMaskPathFinal.CGPath
        modalController!.view.layer.mask = maskLayer
        
        UIView.transitionWithView(self.view, duration: 2.5, options: nil, animations: { () -> Void in
            
            // Perform the circle mask animation
            
            var maskLayerAnimation = CABasicAnimation(keyPath: "path")
            maskLayerAnimation.fromValue = circleMaskPathInitial.CGPath
            maskLayerAnimation.toValue = circleMaskPathFinal.CGPath
            maskLayerAnimation.duration = 1
            maskLayerAnimation.delegate = self
            maskLayer.addAnimation(maskLayerAnimation, forKey: "path")
            
            }) { (finished) -> Void in
                
                self.modalController!.removeFromParentViewController()
                self.modalController = nil
                self.controllers[self.currentControllerID!].didMoveToParentViewController(self)
                
        }

    }

    
    func cycleFromViewController(oldC: UIViewController, toViewController newCID: Int, sender: UIButton, img: UIImageView, event: UIEvent) {
        
        self.currentControllerID = newCID

        //Get the touch ponit just before transforming the button
        var touch: UITouch = event.allTouches()?.first as! UITouch
        var touchPoint: CGPoint = touch.locationInView(touch.view)
        
        var scale = CGAffineTransformMakeScale(0.6, 0.6)
        
        //First we play the little "button pressed" animation, then we go with the real stuff
        UIView.animateWithDuration(0.2, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.5, options: nil, animations: { () -> Void in
            
            sender.transform = scale
            img.transform = scale
            
            }) { (finished) -> Void in
                
                UIView.animateWithDuration(0, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1, options: nil, animations: { () -> Void in
                    
                    // sender.transform = CGAffineTransformIdentity
                    // img.transform = CGAffineTransformIdentity
                    
                    }, completion: { (finished) -> Void in
                        
                        
                        //Finished, now the translation
                        
                        println("Cycle")
                        
                        oldC.willMoveToParentViewController(nil)
                        
                        var newC = self.controllers[newCID]
                        
                        self.addChildViewController(newC)
                        
                        newC.view.frame = self.view.frame
                        self.view.addSubview(oldC.view)
                        
                        let zeroScale = CGAffineTransformMakeScale(0, 0)
                        
                        // Scales buttons of new view to 0 so they don't show
                        switch newCID {
                        case 0:
                            (newC as! ViewController).aBtn!.transform = zeroScale
                            (newC as! ViewController).bBtn!.transform = zeroScale
                            (newC as! ViewController).cBtn!.transform = zeroScale
                            
                            (newC as! ViewController).aImg!.transform = zeroScale
                            (newC as! ViewController).bImg!.transform = zeroScale
                            (newC as! ViewController).cImg!.transform = zeroScale
                            break
                        case 1:
                            (newC as! StudentViewController).aBtn!.transform = zeroScale
                            (newC as! StudentViewController).bBtn!.transform = zeroScale
                            (newC as! StudentViewController).cBtn!.transform = zeroScale
                            
                            (newC as! StudentViewController).aImg!.transform = zeroScale
                            (newC as! StudentViewController).bImg!.transform = zeroScale
                            (newC as! StudentViewController).cImg!.transform = zeroScale
                            break
                        case 2:
                            (newC as! MusicianViewController).aBtn!.transform = zeroScale
                            (newC as! MusicianViewController).bBtn!.transform = zeroScale
                            (newC as! MusicianViewController).cBtn!.transform = zeroScale
                            
                            (newC as! MusicianViewController).aImg!.transform = zeroScale
                            (newC as! MusicianViewController).bImg!.transform = zeroScale
                            (newC as! MusicianViewController).cImg!.transform = zeroScale

                            break
                        case 3:
                            (newC as! DeveloperViewController).aBtn!.transform = zeroScale
                            (newC as! DeveloperViewController).bBtn!.transform = zeroScale
                            (newC as! DeveloperViewController).cBtn!.transform = zeroScale
                            
                            (newC as! DeveloperViewController).aImg!.transform = zeroScale
                            (newC as! DeveloperViewController).bImg!.transform = zeroScale
                            (newC as! DeveloperViewController).cImg!.transform = zeroScale

                            break
                        default:
                            break
                            
                        }
                        
                        // Configures the mask animation
                        var circleMaskPathInitial = UIBezierPath(ovalInRect: sender.frame)
                        var extremePoint = CGPoint(x: touchPoint.x - 0, y: touchPoint.y - CGRectGetHeight(newC.view.bounds))
                        
                        var radius = sqrt((extremePoint.x * extremePoint.x) + (extremePoint.y * extremePoint.y)) + 40
                        var circleMaskPathFinal = UIBezierPath(ovalInRect: CGRectInset(sender.frame, -radius, -radius))
                        
                        var maskLayer = CAShapeLayer()
                        maskLayer.path = circleMaskPathFinal.CGPath
                        newC.view.layer.mask = maskLayer
                        
                        self.view.addSubview(newC.view)
                        
                        
                        UIView.transitionWithView(self.view, duration: 1.0, options: nil, animations: { () -> Void in
                            
                            // Perform the circle mask animation
                            
                            var maskLayerAnimation = CABasicAnimation(keyPath: "path")
                            maskLayerAnimation.fromValue = circleMaskPathInitial.CGPath
                            maskLayerAnimation.toValue = circleMaskPathFinal.CGPath
                            maskLayerAnimation.duration = 1
                            maskLayerAnimation.delegate = self
                            maskLayer.addAnimation(maskLayerAnimation, forKey: "path")
                            
                            }) { (finished) -> Void in
                                
                                // Shows menu buttons with animation
                                println(finished)
                                maskLayer.path = circleMaskPathFinal.CGPath
                                UIView.animateWithDuration(1, delay: 1, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: nil, animations: { () -> Void in
                                    
                                    // Updates the status bar appearance
                                    self.setNeedsStatusBarAppearanceUpdate()
                                    
                                    switch newCID {
                                    case 0:
                                        (newC as! ViewController).aBtn!.transform = CGAffineTransformIdentity
                                        (newC as! ViewController).bBtn!.transform = CGAffineTransformIdentity
                                        (newC as! ViewController).cBtn!.transform = CGAffineTransformIdentity
                                        
                                        (newC as! ViewController).aImg!.transform = CGAffineTransformIdentity
                                        (newC as! ViewController).bImg!.transform = CGAffineTransformIdentity
                                        (newC as! ViewController).cImg!.transform = CGAffineTransformIdentity
                                        break
                                    case 1:
                                        (newC as! StudentViewController).aBtn!.transform = CGAffineTransformIdentity
                                        (newC as! StudentViewController).bBtn!.transform = CGAffineTransformIdentity
                                        (newC as! StudentViewController).cBtn!.transform = CGAffineTransformIdentity
                                        
                                        (newC as! StudentViewController).aImg!.transform = CGAffineTransformIdentity
                                        (newC as! StudentViewController).bImg!.transform = CGAffineTransformIdentity
                                        (newC as! StudentViewController).cImg!.transform = CGAffineTransformIdentity
                                        break
                                    case 2:
                                        (newC as! MusicianViewController).aBtn!.transform = CGAffineTransformIdentity
                                        (newC as! MusicianViewController).bBtn!.transform = CGAffineTransformIdentity
                                        (newC as! MusicianViewController).cBtn!.transform = CGAffineTransformIdentity
                                        
                                        (newC as! MusicianViewController).aImg!.transform = CGAffineTransformIdentity
                                        (newC as! MusicianViewController).bImg!.transform = CGAffineTransformIdentity
                                        (newC as! MusicianViewController).cImg!.transform = CGAffineTransformIdentity
                                        break
                                    case 3:
                                        (newC as! DeveloperViewController).aBtn!.transform = CGAffineTransformIdentity
                                        (newC as! DeveloperViewController).bBtn!.transform = CGAffineTransformIdentity
                                        (newC as! DeveloperViewController).cBtn!.transform = CGAffineTransformIdentity
                                        
                                        (newC as! DeveloperViewController).aImg!.transform = CGAffineTransformIdentity
                                        (newC as! DeveloperViewController).bImg!.transform = CGAffineTransformIdentity
                                        (newC as! DeveloperViewController).cImg!.transform = CGAffineTransformIdentity
                                        break
                                    default:
                                        break
                                        
                                    }
                                    
                                    }, completion: { (finished) -> Void in
                                        
                                        println("ended")
                                        
                                        oldC.removeFromParentViewController()
                                        newC.didMoveToParentViewController(self)
                                        
                                })
                                
                                
                        }
                        
                        
                        
            })
            
        }
    }
    
    
    // Depending on the child view controller we need LightContent or Default appearance
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        
        if let id = currentControllerID {
            switch id {
            case 0, 1:
                return .LightContent
            case 2, 3:
                return .Default
            default:
                return .Default
                
            }

        } else {
            return .LightContent
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

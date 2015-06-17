//
//  ViewController.swift
//  Marc Clascà
//
//  Created by Marc Clascà on 14/4/15.
//  Copyright (c) 2015 Marc Clascà. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var aBtn: UIButton!
    @IBOutlet weak var bBtn: UIButton!
    @IBOutlet weak var cBtn: UIButton!

    @IBOutlet weak var aImg: UIImageView!
    @IBOutlet weak var bImg: UIImageView!
    @IBOutlet weak var cImg: UIImageView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    var controllers = [HelloViewController(coder: NSCoder()), IntroViewController(coder: NSCoder()), ReadyViewController(coder: NSCoder())]
    
    @IBAction func changeCategory(sender: UIButton, forEvent event: UIEvent) {
        println("Button CLicked")
        
        let images = [1: aImg, 2: bImg, 3: cImg]
        
        (parentViewController as! ContentController).cycleFromViewController(self, toViewController: sender.tag, sender: sender, img: images[sender.tag]!, event: event)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        aImg.transform = CGAffineTransformMakeScale(0, 0)
        bImg.transform = CGAffineTransformMakeScale(0, 0)
        cImg.transform = CGAffineTransformMakeScale(0, 0)
        aBtn.transform = CGAffineTransformMakeScale(0, 0)
        bBtn.transform = CGAffineTransformMakeScale(0, 0)
        cBtn.transform = CGAffineTransformMakeScale(0, 0)
        
        setupScrollView()
        
    }
    
    func setupScrollView() {
        
        scrollView.frame = self.view.frame
        println(scrollView.frame)
        
        
        scrollView.pagingEnabled = true
        scrollView.contentSize = CGSizeMake(self.scrollView.frame.width * CGFloat(controllers.count), self.scrollView.frame.height)
        scrollView.backgroundColor = UIColor.clearColor()
        
        
        scrollView.showsHorizontalScrollIndicator = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.delegate = self
        
        // add all views to scrollView
        for (index, vc) in enumerate(controllers) {
            var frame = self.scrollView.frame
            frame.origin.x = frame.width * CGFloat(index)
            frame.origin.y = 0
            vc.view.frame = frame
            
            self.addChildViewController(vc)
            self.scrollView.addSubview(vc.view)
            vc.didMoveToParentViewController(self)
        }
        
    
    }
    
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        if CGRectIntersectsRect(scrollView.bounds, controllers[2].view.frame) {
            
            UIView.animateWithDuration(0.8, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: nil, animations: { () -> Void in
                self.aImg.transform = CGAffineTransformIdentity
                self.bImg.transform = CGAffineTransformIdentity
                self.cImg.transform = CGAffineTransformIdentity
                self.aBtn.transform = CGAffineTransformIdentity
                self.bBtn.transform = CGAffineTransformIdentity
                self.cBtn.transform = CGAffineTransformIdentity
            }, completion: { (finished) -> Void in
                
            })
            
        }
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        
        
    }
    
    
    override func viewWillAppear(animated: Bool) {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


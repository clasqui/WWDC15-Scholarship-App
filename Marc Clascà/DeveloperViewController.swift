//
//  DeveloperViewController.swift
//  Marc Clascà
//
//  Created by Marc Clascà on 20/4/15.
//  Copyright (c) 2015 Marc Clascà. All rights reserved.
//

import UIKit

class DeveloperViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var aBtn: UIButton!
    @IBOutlet weak var bBtn: UIButton!
    @IBOutlet weak var cBtn: UIButton!
    
    @IBOutlet weak var aImg: UIImageView!
    @IBOutlet weak var bImg: UIImageView!
    @IBOutlet weak var cImg: UIImageView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    var controllers = [BeginingViewController(coder: NSCoder()), SkillsViewController(coder: NSCoder()), FirstMacViewController(coder: NSCoder()), PianoconcertViewController(coder: NSCoder()), WWDCViewController(coder: NSCoder())]
    
    @IBAction func changeStudent(sender: UIButton, forEvent event: UIEvent) {
        println("Button CLicked")
        
        let images = [0: aImg, 1: bImg, 2: cImg]
        
        (parentViewController as! ContentController).cycleFromViewController(self, toViewController: sender.tag, sender: sender, img: images[sender.tag]!, event: event)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupScrollView()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        
        
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

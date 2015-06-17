//
//  ElementaryViewController.swift
//  Marc Clascà
//
//  Created by Marc Clascà on 26/4/15.
//  Copyright (c) 2015 Marc Clascà. All rights reserved.
//

import UIKit

class UniversityViewController: UIViewController {

    required init(coder aDecoder: NSCoder) {
        super.init(nibName: "UniversityViewController", bundle: nil)
    }
    
    @IBOutlet weak var jumpLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        jumpLabel.alpha = 0
        jumpLabel.transform = CGAffineTransformMakeTranslation(0, -25)
        
        

        // Do any additional setup after loading the view.
    }
    
    func nowShowing() {
        
        UIView.animateWithDuration(1, delay: 5, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.6, options: nil, animations: { () -> Void in
            
            self.jumpLabel.alpha = 1
            self.jumpLabel.transform = CGAffineTransformIdentity
            
            }) { (finished) -> Void in
                
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

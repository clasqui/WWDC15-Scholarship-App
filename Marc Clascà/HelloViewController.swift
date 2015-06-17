//
//  HelloViewController.swift
//  Marc Clascà
//
//  Created by Marc Clascà on 26/4/15.
//  Copyright (c) 2015 Marc Clascà. All rights reserved.
//

import UIKit

class HelloViewController: UIViewController {

    @IBOutlet weak var profile: UIImageView!
    
    required init(coder aDecoder: NSCoder) {
        super.init(nibName: "HelloViewController", bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profile.layer.cornerRadius = profile.frame.size.width / 2
        profile.clipsToBounds = true
        profile.layer.borderWidth = 2.0
        profile.layer.borderColor = UIColor.blackColor().CGColor
        
        
        // Do any additional setup after loading the view.
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

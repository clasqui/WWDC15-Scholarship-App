//
//  MusicianViewController.swift
//  Marc Clascà
//
//  Created by Marc Clascà on 16/4/15.
//  Copyright (c) 2015 Marc Clascà. All rights reserved.
//

import UIKit

class MusicianViewController: UIViewController {

    
    @IBOutlet weak var aBtn: UIButton!
    @IBOutlet weak var bBtn: UIButton!
    @IBOutlet weak var cBtn: UIButton!
    
    @IBOutlet weak var aImg: UIImageView!
    @IBOutlet weak var bImg: UIImageView!
    @IBOutlet weak var cImg: UIImageView!
    
    @IBAction func changeCategory(sender: UIButton, forEvent event: UIEvent) {
        println("Button CLicked")
        
        let images = [0: aImg, 1: bImg, 3: cImg]
        
        (parentViewController as! ContentController).cycleFromViewController(self, toViewController: sender.tag, sender: sender, img: images[sender.tag]!, event: event)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

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

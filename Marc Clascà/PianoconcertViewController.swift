//
//  PianoconcertViewController.swift
//  Marc Clascà
//
//  Created by Marc Clascà on 26/4/15.
//  Copyright (c) 2015 Marc Clascà. All rights reserved.
//

import UIKit
import StoreKit

class PianoconcertViewController: UIViewController, SKStoreProductViewControllerDelegate {

    required init(coder aDecoder: NSCoder) {
        super.init(nibName: "PianoconcertViewController", bundle: nil)
    }
    
    @IBOutlet weak var icon: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        icon.layer.cornerRadius = 18.75
        icon.clipsToBounds = true

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func showPianoconcert(sender: UIButton, forEvent event: UIEvent) {

        var storeController = SKStoreProductViewController()
        storeController.delegate = self
        
        storeController.loadProductWithParameters([SKStoreProductParameterITunesItemIdentifier: "917595499"], completionBlock: { (result, error) -> Void in
            if result {
                self.presentViewController(storeController, animated: true, completion: nil)
            } else {
                var alert = UIAlertController(title: "Uh!", message: "There was a problem opening the app store", preferredStyle: .Alert)
                alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
            }
        })
    }
    
    func productViewControllerDidFinish(viewController: SKStoreProductViewController!) {
        //(parentViewController?.parentViewController as! ContentController).hideController()
        viewController.dismissViewControllerAnimated(true, completion: nil)
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

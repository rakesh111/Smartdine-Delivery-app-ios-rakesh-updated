//
//  SignatureViewController.swift
//  Smartdine_Delivery
//
//  Created by Rakesh on 30/12/15.
//  Copyright © 2015 Apple. All rights reserved.
//

import UIKit

class SignatureViewController: UIViewController {
    
    override func shouldAutorotate() -> Bool {
        return true
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return [UIInterfaceOrientationMask.Portrait, UIInterfaceOrientationMask.Landscape, UIInterfaceOrientationMask.LandscapeLeft, UIInterfaceOrientationMask.LandscapeRight, UIInterfaceOrientationMask.PortraitUpsideDown]
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
    }

   // @IBOutlet weak var signatureView: UIView!
   
    @IBOutlet weak var signatureView: SwiftSignatureView!
    
    @IBAction func cancelButton(sender: AnyObject) {
        
        signatureView.clear()
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

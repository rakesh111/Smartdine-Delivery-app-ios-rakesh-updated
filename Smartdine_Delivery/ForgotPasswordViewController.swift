//
//  ForgotPasswordViewController.swift
//  Smartdine_Delivery
//
//  Created by Rakesh on 04/01/16.
//  Copyright © 2016 Apple. All rights reserved.
//



import UIKit

class ForgotPasswordViewController: UIViewController,UITextFieldDelegate,NSURLConnectionDataDelegate {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var emailimage: UIImageView!
    @IBOutlet weak var forgetEmail: UIImageView!
    @IBOutlet weak var retrievePass: UIButton!
    @IBOutlet weak var forgotScrl: UIScrollView!
    
    var forPassActivityIndicatorView:UIActivityIndicatorView!
    
    var forPassResponseData:NSMutableData!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backBtn : UIBarButtonItem = UIBarButtonItem(title: "BACK", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("backClick"))
        
        navigationItem.leftBarButtonItem?.setTitleTextAttributes([NSFontAttributeName: UIFont(name: "Helvetica Neue", size: 15)!], forState: UIControlState.Normal)
        self.navigationController?.navigationBar .tintColor = UIColor(colorLiteralRed: 0.896, green: 0.085, blue: 0.000, alpha: 1.00)
        
        
        self.navigationItem.leftBarButtonItem = backBtn
        
        self.navigationController?.navigationBarHidden = false
        
        self.title = "Forgotten Password"
        
        self.retrievePass.backgroundColor = UIColor( colorLiteralRed:0.753, green:0.200, blue:0.122, alpha:1.00)
        self.forgetEmail.backgroundColor = UIColor (colorLiteralRed:0.753, green:0.196,blue:0.122, alpha:1.00)
        //self.emailimage.backgroundColor = UIColor(patternImage: UIImage(named: "email.png")!)

        // Do any additional setup after loading the view.
        
        let tapGesture = UITapGestureRecognizer(target: self, action: Selector("hideKeyboard"))
        tapGesture.cancelsTouchesInView = true
        forgotScrl.addGestureRecognizer(tapGesture)
        
        forgotScrl.contentSize = CGSizeMake(UIScreen .mainScreen().bounds.size.width, (retrievePass.frame.size.height + retrievePass.frame.origin.y)+15)
        
    }
    
    func hideKeyboard() {
        forgotScrl.endEditing(true)
        forgotScrl .setContentOffset(CGPointMake(0, 0), animated: true)
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        
        forgotScrl.setContentOffset(CGPointMake(0, textField.frame.origin.y-70), animated: true)
    }
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        forgotScrl .setContentOffset(CGPointMake(0, 58), animated: true)
        
        return true
    }
    
    func backClick()
    {
                let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController];
        self.navigationController!.popToViewController(viewControllers[viewControllers.count - 2], animated: true);
        
        
    }

    @IBAction func retrievePassword(sender: AnyObject) {
        
        if ((email.text!).characters.count == 0 ){
        
        let alert = UIAlertController(title: "Error", message: "Enter a valid email id", preferredStyle: UIAlertControllerStyle.Alert)
            
            alert.view.tintColor = UIColor.redColor()
        
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
        
        
        
        self.presentViewController(alert, animated: true, completion: nil)
        
        }
        
        else{
            
            resetPassword()
          
        }
    }
    
    
    func resetPassword(){
        
        let urlString = "http://ec2-54-149-149-21.us-west-2.compute.amazonaws.com:8080/DeliveryEngine/forgetPassword"
        
      let url = NSURL(string: urlString)
        
        let theRequest = NSMutableURLRequest(URL: url!)
        
        theRequest.HTTPMethod = "POST"
        
        let parameters = ["email":email.text!]
        
        let err:NSError!
        
        do{
            
            theRequest.HTTPBody = try NSJSONSerialization.dataWithJSONObject(parameters, options: [])
        }
        catch let error as NSError{
            
            err = error
            theRequest.HTTPBody = nil
        }
        
        theRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        theRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        
        var connectRequest = NSURLConnection(request: theRequest, delegate: self, startImmediately: true)
        
        connectRequest?.start()
        
        forPassActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.WhiteLarge)
        
        //myActivityIndicatorView.color = UIColor.whiteColor()
        self.view.addSubview(forPassActivityIndicatorView)
        forPassActivityIndicatorView.frame = CGRectMake(KScreenWidth1/2-15, KScreenHeight1/2-15, 30, 30)
        forPassActivityIndicatorView.color = UIColor.redColor()
        
        forPassActivityIndicatorView.startAnimating()

        
        
    }
    
    func connection(connection: NSURLConnection, didReceiveData data: NSData) {
        
        forPassResponseData.appendData(data)
    }
    
    func connection(connection: NSURLConnection, didReceiveResponse response: NSURLResponse) {
        
        NSLog("Received Response\(response)")
        forPassResponseData = NSMutableData()
    }
    
    func connectionDidFinishLoading(connection: NSURLConnection) {
        
        forPassActivityIndicatorView.stopAnimating()
        NSLog("\(forPassResponseData)")
        
        let strData = NSString(data: forPassResponseData, encoding: NSUTF8StringEncoding)
        print("Body: \(strData)", terminator: "")
    }
    
    func connection(connection: NSURLConnection, didFailWithError error: NSError) {
        
        NSLog("\(error)")
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

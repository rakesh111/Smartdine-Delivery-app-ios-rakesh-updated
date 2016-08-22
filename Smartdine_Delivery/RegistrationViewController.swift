//
//  RegistrationViewController.swift
//  Smartdine_Delivery
//
//  Created by Rakesh on 05/01/16.
//  Copyright © 2016 Apple. All rights reserved.
//

import UIKit
var KScreenWidth1 = UIScreen.mainScreen().bounds.size.width
var KScreenHeight1 = UIScreen.mainScreen().bounds.size.height

class RegistrationViewController: UIViewController,UITextFieldDelegate,NSURLConnectionDataDelegate {

    
    var myResponseData:NSMutableData!
    
    var myResponse : NSURLResponse!
    
    var myActivityIndicatorView:UIActivityIndicatorView!
    
    @IBOutlet weak var scrlView: UIScrollView!
    @IBOutlet weak var regFirstname: UITextField!
    
    @IBOutlet weak var regLastName: UITextField!
    
    @IBOutlet weak var regEmail: UITextField!
    
    @IBOutlet weak var regPassword: UITextField!
    
    
    @IBOutlet weak var regPhoneno: UITextField!
    
    
    
    @IBOutlet weak var fnImageView: UIImageView!
    
    @IBOutlet weak var lnImageView: UIImageView!
    
    @IBOutlet weak var emImageView: UIImageView!
    
    @IBOutlet weak var passImageView: UIImageView!
    
    @IBOutlet weak var phoneImageView: UIImageView!
    
    @IBOutlet weak var regButton: UIButton!
    override func viewDidLoad() {
        
        
        
        super.viewDidLoad()
        
        let backBtn : UIBarButtonItem = UIBarButtonItem(title: "BACK", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("backClick"))
        
        navigationItem.leftBarButtonItem?.setTitleTextAttributes([NSFontAttributeName: UIFont(name: "Helvetica Neue", size: 15)!], forState: UIControlState.Normal)
        self.navigationController?.navigationBar .tintColor = UIColor(colorLiteralRed: 0.896, green: 0.085, blue: 0.000, alpha: 1.00)
        
        
        self.navigationItem.leftBarButtonItem = backBtn
       
        
        self.navigationController?.navigationBarHidden = false
        self.navigationItem.title = "Registration"
        
        
        self.view.backgroundColor = UIColor.whiteColor()
//         self.regButton.backgroundColor = UIColor( colorLiteralRed:0.753, green:0.200, blue:0.122, alpha:1.00)
//        
//       
//        self.fnImageView.backgroundColor = UIColor (colorLiteralRed:0.753, green:0.196,blue:0.122, alpha:1.00)
//        self.lnImageView.backgroundColor = UIColor (colorLiteralRed:0.753, green:0.196,blue:0.122, alpha:1.00)
//        self.emImageView.backgroundColor = UIColor (colorLiteralRed:0.753, green:0.196,blue:0.122, alpha:1.00)
//        self.passImageView.backgroundColor = UIColor (colorLiteralRed:0.753, green:0.196,blue:0.122, alpha:1.00)
//        self.phoneImageView.backgroundColor = UIColor (colorLiteralRed:0.753, green:0.196,blue:0.122, alpha:1.00)




        
        
//         myStatus.textColor = UIColor(colorLiteralRed: 0.142, green: 0.742, blue: 0.146, alpha: 1.00)
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        
        let tapGesture = UITapGestureRecognizer(target: self, action: Selector("hideKeyboard"))
        tapGesture.cancelsTouchesInView = true
        scrlView.addGestureRecognizer(tapGesture)
        
        scrlView.contentSize = CGSizeMake(UIScreen .mainScreen().bounds.size.width, (regButton.frame.size.height + regButton.frame.origin.y)+15)

        
     //   scrlView.addGestureRecognizer(tapGesture)
        
        
        //self.navigationController!.navigationBarHidden = true
        
        // scrlView.contentSize = CGSizeMake(UIScreen .mainScreen().bounds.size.width, (regButton.frame.size.height + regButton.frame.origin.y)+25)

        // Do any additional setup after loading the view.
    }
        
    func backClick()
    {
                let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController];
        self.navigationController!.popToViewController(viewControllers[viewControllers.count - 2], animated: true);
        
        
    }

    
    func hideKeyboard() {
        scrlView.endEditing(true)
        scrlView .setContentOffset(CGPointMake(0, -58), animated: true)
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        
        scrlView.setContentOffset(CGPointMake(0, textField.frame.origin.y-70), animated: true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        
        textField.resignFirstResponder()
        
        scrlView .setContentOffset(CGPointMake(0, 0), animated: true)
        
        return true
    }
    
    func registerRequest(){
        
        let urlString = "http://52.39.225.135:8080/DeliveryEngine/register"
        
        let deviceToken = NSUserDefaults .standardUserDefaults().stringForKey(kDeviceTocken)
        print("userid:\(deviceToken)")                                    
        let url = NSURL(string: urlString)
        
        let theRequest = NSMutableURLRequest(URL: url!)
        
        theRequest.HTTPMethod = "POST"
        
        let parameters = ["firstName":regFirstname.text!, "password":regPassword.text!, "lastName":regLastName.text!,"phone":regPhoneno.text!,"email":regEmail.text!,"token":deviceToken!] as Dictionary<String,String>
        
        var err:NSError!
        
        
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
        
        myActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.WhiteLarge)
        
        //myActivityIndicatorView.color = UIColor.whiteColor()
        self.view.addSubview(myActivityIndicatorView)
        myActivityIndicatorView.frame = CGRectMake(KScreenWidth1/2-15, KScreenHeight1/2-15, 30, 30)
        myActivityIndicatorView.color = UIColor.grayColor()
        
        myActivityIndicatorView.startAnimating()
        
        
    }
    
    func connection(connection: NSURLConnection, didReceiveResponse response: NSURLResponse) {
        
        NSLog("Received response\(response)")
        
        myResponseData = NSMutableData()
        myResponse = NSURLResponse()
        
                                                                                    
    }
    
    func connection(connection: NSURLConnection, didReceiveData data: NSData) {
        
        myResponseData.appendData(data)
    }
    
    func connectionDidFinishLoading(connection: NSURLConnection) {
        
        NSLog("\(myResponseData)")
        myActivityIndicatorView.stopAnimating()
        
//        let strData = NSString(data: myResponseData, encoding: NSUTF8StringEncoding)
//        print("Body: \(strData)", terminator: "")
        
         let strData: NSDictionary! = (try! NSJSONSerialization.JSONObjectWithData(myResponseData, options: NSJSONReadingOptions.MutableContainers)) as! NSDictionary
        
         print("Body: \(strData)", terminator: "")
        
        let myValue = strData.valueForKeyPath("status") as! Bool
        
        if (myValue == true){
            
            let alertController = UIAlertController(title: "Registration", message: "Successfully registered", preferredStyle: .Alert)
            
            alertController.view.tintColor = UIColor.redColor()
            
            let okAction = UIAlertAction(title: "Ok", style: .Default)
                {(action)in
                    
                               
            let viewControllers: [UIViewController] = self.navigationController!.viewControllers ;
            self.navigationController!.popToViewController(viewControllers[viewControllers.count - 2], animated: true);
            }
            alertController.addAction(okAction)
            self.presentViewController(alertController, animated: true) {
            }

        
        
            
            
//            let alert = UIAlertController(title: "Alert", message: "Succesfully registered", preferredStyle: UIAlertControllerStyle.Alert)
//            
//            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
//            
//            
//            
//            self.presentViewController(alert, animated: true, completion: nil)
//
            
            
        }
            
           
            
            
        else{
            
            let alert = UIAlertController(title: "Alert", message: "Email id already exists", preferredStyle: UIAlertControllerStyle.Alert)
            
            alert.view.tintColor = UIColor.redColor()
            
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            
            
            
            self.presentViewController(alert, animated: true, completion: nil)
            
        }
        
        
        
//        var myResponseData1 = NSJSONSerialization.JSONObjectWithData(myResponseData, options: .MutableLeaves) as? NSDictionary

    }
    
    func connection(connection: NSURLConnection, didFailWithError error: NSError) {
        
        NSLog("\(error)")
    }
    
    
    
    
    
    
    @IBAction func regBtn(sender: AnyObject) {
        
        if(((regFirstname.text!).characters.count == 0) || ((regLastName.text!).characters.count == 0) || ((regEmail.text!).characters.count == 0) || ((regPassword.text!).characters.count == 0) || ((regPhoneno.text!).characters.count == 0))
        {
            let alert = UIAlertController(title: "Alert", message: "Please fill all the fields", preferredStyle: UIAlertControllerStyle.Alert)
            
            alert.view.tintColor = UIColor.redColor()
            
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            
            
            
            self.presentViewController(alert, animated: true, completion: nil)
        }
        else{
            
            registerRequest()
            
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

//
//  OTPViewController.swift
//  Smartdine_Delivery
//
//  Created by Rakesh on 05/02/16.
//  Copyright © 2016 Apple. All rights reserved.
//

import UIKit
import CoreData

//var orderId:String = String()

class OTPViewController: UIViewController,NSURLConnectionDataDelegate,UITextFieldDelegate {
    
    
    //let appdelegateObject = (UIApplication.sharedApplication().delegate as! AppDelegate)
    
    let managedContext: NSManagedObjectContext = AppDelegate.sharedAppDelegate().managedObjectContext!
    
    let entity =  NSEntityDescription.entityForName("Orders",
        inManagedObjectContext: AppDelegate.sharedAppDelegate().managedObjectContext!)
    
    @IBOutlet weak var completeOrder: UIButton!
    
   
    var myResponseData:NSMutableData!
    
    var tag:Int!
   var corderId:String?
    
    var arr: NSMutableArray!
    
    var otpActivityIndicatorView:UIActivityIndicatorView!

    @IBOutlet weak var scrlView: UIScrollView!
    @IBOutlet weak var firstDigit: UITextField!
    @IBOutlet weak var otpAction: UIButton!
    @IBOutlet weak var secondDigit:
    UITextField!
    
    
    @IBOutlet weak var thirdDigit: UITextField!
    @IBOutlet weak var fourthDigit: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        firstDigit.delegate = self
        secondDigit.delegate = self
        thirdDigit.delegate = self
        fourthDigit.delegate = self
        
        
        firstDigit.addTarget(self, action: "textFieldDidChange:", forControlEvents: UIControlEvents.EditingChanged)
        secondDigit.addTarget(self, action: "textFieldDidChange:", forControlEvents: UIControlEvents.EditingChanged)
        thirdDigit.addTarget(self, action: "textFieldDidChange:", forControlEvents: UIControlEvents.EditingChanged)
        fourthDigit.addTarget(self, action: "textFieldDidChange:", forControlEvents: UIControlEvents.EditingChanged)
        
        
        
        
        completeOrder.hidden = true
        
        let backBtn : UIBarButtonItem = UIBarButtonItem(title: "CANCEL", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("backClick"))
        
        navigationItem.leftBarButtonItem?.setTitleTextAttributes([NSFontAttributeName: UIFont(name: "Helvetica Neue", size: 15)!], forState: UIControlState.Normal)
        self.navigationController?.navigationBar .tintColor = UIColor(colorLiteralRed: 0.896, green: 0.085, blue: 0.000, alpha: 1.00)
    
        
        
        self.navigationItem.leftBarButtonItem = backBtn
        
        
        self.navigationController?.navigationBarHidden = false
        let tapGesture = UITapGestureRecognizer(target: self, action: Selector("hideKeyboard"))
        tapGesture.cancelsTouchesInView = true
        scrlView.addGestureRecognizer(tapGesture)
        
        scrlView.contentSize = CGSizeMake(UIScreen .mainScreen().bounds.size.width, (otpAction.frame.size.height + otpAction.frame.origin.y)+15)

        // Do any additional setup after loading the view.
    }
    
    
    func textFieldDidChange(textField: UITextField){
        
        let text = textField.text
        
        if text?.utf16.count==1{
            switch textField{
            case firstDigit:
                secondDigit.becomeFirstResponder()
            case secondDigit:
                thirdDigit.becomeFirstResponder()
            case thirdDigit:
                fourthDigit.becomeFirstResponder()
            case fourthDigit:
                fourthDigit.resignFirstResponder()
                
                scrlView.setContentOffset(CGPointMake(0, -58),animated: true)
            default:
                break
            }
        }else{
            
        }
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

    
    
    @IBAction func enterOTP(sender: AnyObject) {
        
        
        if(((firstDigit.text!).characters.count == 0) || ((secondDigit.text!).characters.count == 0) || ((thirdDigit.text!).characters.count == 0) || ((fourthDigit.text!).characters.count == 0)){
            
            
            let alert = UIAlertController(title: "Alert", message: "Please fill all the fields", preferredStyle: UIAlertControllerStyle.Alert)
            
            alert.view.tintColor = UIColor.redColor()
            
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            
            
            
            self.presentViewController(alert, animated: true, completion: nil)
        }
        else{
            
        enterOtpRequest()
            
        }
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        
        scrlView.setContentOffset(CGPointMake(0, textField.frame.origin.y-70), animated: true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        
        textField.resignFirstResponder()
        
        scrlView .setContentOffset(CGPointMake(0, 0), animated: true)
        
        return true
    }

    
    
    func enterOtpRequest(){
        
        self.tag = 1
        
        
      //  let orderID = NSUserDefaults.standardUserDefaults().integerForKey(KorderIdOriginal)
            
            let status:String = "Delivered"
//       let orderID =  NSUserDefaults .standardUserDefaults().integerForKey(KorderIdOriginal)
        print("userid:\(corderId)")
        
         let otpText:String = firstDigit.text! + secondDigit.text! + thirdDigit.text! + fourthDigit.text!
        
        let urlString = "http://52.39.225.135:8080/DeliveryEngine/verifyOTP"
        
        let url = NSURL(string: urlString)
        
        let theRequest = NSMutableURLRequest(URL: url!)
        
        theRequest.HTTPMethod = "POST"
        
        //let asd = corderId
       
//        
//        let parameters : Dictionary = ["otp":otpText,"orderID": NSNumber(integer:Int(corderId!)!)  ]
        
        
        let parameters : Dictionary = ["otp":otpText,"orderID": corderId! ]
        
//        let number = Int(corderId!)
//        let myNumber = NSNumber(integer:number!)
//        
//        let parameters : Dictionary = ["otp":otpText,"orderID": myNumber ]
        
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
        
        otpActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.WhiteLarge)
        
        //myActivityIndicatorView.color = UIColor.whiteColor()
        self.view.addSubview(otpActivityIndicatorView)
        otpActivityIndicatorView.frame = CGRectMake(KScreenWidth1/2-15, KScreenHeight1/2-15, 30, 30)
        
         otpActivityIndicatorView.startAnimating()
        
        otpActivityIndicatorView.color = UIColor.redColor()
        
    

    }
    
    
    func connection(connection: NSURLConnection, didReceiveResponse response: NSURLResponse) {
        
        
        NSLog("Received response\(response)")
        
        myResponseData = NSMutableData()
        
        //myResponse = NSURLResponse()
    }
    
    func connection(connection: NSURLConnection, didReceiveData data: NSData) {
     
        myResponseData.appendData(data)

    }
    
    func connectionDidFinishLoading(connection: NSURLConnection) {
        
        NSLog("\(myResponseData)")
        
        otpActivityIndicatorView.stopAnimating()
        
        let strData: NSDictionary! = (try! NSJSONSerialization.JSONObjectWithData(myResponseData, options: NSJSONReadingOptions.MutableContainers)) as! NSDictionary
        
        print("Body: \(strData)", terminator: "")
        
        if(self.tag == 1){
         let myValue = strData.valueForKeyPath("status") as! Bool
        if (myValue == true){
            
            let alertController = UIAlertController(title: "OTP Authorization", message: "OTP Verified", preferredStyle: .Alert)
            
            alertController.view.tintColor = UIColor.redColor()
            
            let okAction = UIAlertAction(title: "Ok", style: .Default)
                {(action)in
                    
                   self.completeOrder.hidden = false
            }
            alertController.addAction(okAction)
            self.presentViewController(alertController, animated: true) {
            }
            
            
                
                
            }
        else {
            
            let alertController = UIAlertController(title: "OTP Authorization", message: "OTP does not match", preferredStyle: .Alert)
            
            alertController.view.tintColor = UIColor.redColor()
            
            let okAction = UIAlertAction(title: "Ok", style: .Default)
                {(action)in
                    
                    self.firstDigit.text=""
                    self.secondDigit.text=""
                    self.thirdDigit.text=""
                    self.fourthDigit.text=""
                    
                   
            }
            alertController.addAction(okAction)
            self.presentViewController(alertController, animated: true) {
            }
            }
            
        }
        
        else{
            
            if(self.tag == 2){
                
                fetchDatabase()
                
                let alertController = UIAlertController(title: "Delivery Confirmation", message: "Delivery Confirmed", preferredStyle: .Alert)
                NSUserDefaults .standardUserDefaults().setObject("compleated", forKey: KOrderStatus)
                NSUserDefaults .standardUserDefaults().setInteger(0, forKey: kutilityButtonStatus)
                alertController.view.tintColor = UIColor.redColor()
                
                let okAction = UIAlertAction(title: "Ok", style: .Default)
                    {(action)in
                   
                  self.tabBarController?.selectedIndex = 0
                 self.navigationController?.popToRootViewControllerAnimated(false)
                        
                }
                alertController.addAction(okAction)
                self.presentViewController(alertController, animated: true) {
                }

            }
        }
        

    }
    
    
    
    func completeteStatus(){
        
        
        
        
        let userId = NSUserDefaults .standardUserDefaults().integerForKey(KuserId)
        print("userid:\(userId)")
        
       // let orderId = 2 as Int
        
        
        
        let urlString = "http://ec2-54-149-149-21.us-west-2.compute.amazonaws.com:8080/DeliveryEngine/acceptDeliveryRequest"
        
        let url = NSURL(string: urlString)
        
        let theRequest = NSMutableURLRequest(URL: url!)
        
        theRequest.HTTPMethod = "POST"
        
        //let parameters = ["orderID":corderId as! Int,"userID":userId,"status":"Delivered"]
        
        let parameters : Dictionary = ["orderID":NSNumber(integer:Int(corderId!)!),"userID":userId,"status":"delivered"]
        
        print("OrderID:\(corderId)")
        
        print("dictionary\(parameters.debugDescription)")

        
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
        
        otpActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.WhiteLarge)
        
        //myActivityIndicatorView.color = UIColor.whiteColor()
        self.view.addSubview(otpActivityIndicatorView)
        otpActivityIndicatorView.frame = CGRectMake(KScreenWidth1/2-15, KScreenHeight1/2-15, 30, 30)
        
        otpActivityIndicatorView.startAnimating()
        
        otpActivityIndicatorView.color = UIColor.redColor()
        

 
    }
    
    func fetchDatabase(){
        
       // let appdelegateObject = (UIApplication.sharedApplication().delegate as! AppDelegate)
        
        let managedContext = AppDelegate.sharedAppDelegate().managedObjectContext!
        let entity =  NSEntityDescription.entityForName("Orders",
            inManagedObjectContext: managedContext)
        
        
        let cond_predicate = NSPredicate(format: "orderId like %@", corderId!)
        
        var error: NSError?
        
        let fetchRequest = NSFetchRequest(entityName: "Orders")
        
        fetchRequest.predicate = cond_predicate
        
        
        do {
            let result = try managedContext.executeFetchRequest(fetchRequest)
            
            if (result.count > 0) {
                let person = result[0] as! NSManagedObject
                
                managedContext.deleteObject(person)
            
                do {
                    try managedContext.save()
                } catch {
                    let saveError = error as NSError
                    print(saveError)
                }
            }
            
        } catch {
            let fetchError = error as NSError
            print(fetchError)
        }
        
        
//        let  result  = (try? managedContext.executeFetchRequest(fetchRequest))
//        
//        arr = NSMutableArray();
//        
//        if let array = result   // check for nil and unwrap
//        {
//            
//            arr .addObject(array)
//            
//            managedContext.deleteObject(arr[0] as NSManagedObject)
//            managedContext.save()
//            AppDelegate.sharedAppDelegate().saveContext()
//            
//        }
        
        
        
        //myTable.reloadData()
        
    
    }

    
    
    
    
    
    
    @IBAction func completeOrderStatus(sender: AnyObject) {
    
        self.tag = 2
    
        completeteStatus()
    
    
        
        
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

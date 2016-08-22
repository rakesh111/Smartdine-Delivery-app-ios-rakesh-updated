




//
//  AccountViewController.swift
//  Smartdine_Delivery
//
//  Created by Rakesh on 21/12/15.
//  Copyright © 2015 Apple. All rights reserved.
//

import UIKit
import CoreData



// Define the specific path, image name
//let imagePath = fileInDocumentsDirectory(imageView)
class AccountViewController: UIViewController,UINavigationControllerDelegate, UIImagePickerControllerDelegate,NSURLConnectionDataDelegate {
    
    var tag:Int!
    var logOutActivityIndicatorView: UIActivityIndicatorView!
    
    @IBOutlet weak var nameLabel: UILabel!

    @IBOutlet weak var driverName: UILabel!
    @IBOutlet weak var imageView: UIImageView!

    @IBOutlet weak var chooseButton: UIButton!

    let imagePicker = UIImagePickerController()
    var finalImage:UIImage!
    
    let userid = NSUserDefaults .standardUserDefaults().stringForKey(KuserId)
    
    var statusResponseData : NSMutableData!
    var status: String!
    
    @IBOutlet weak var userId: UILabel!
    @IBOutlet weak var mySwitch: UISwitch!
    @IBOutlet weak var myStatus: UILabel!
    @IBAction func mySwitchTapped(sender: AnyObject) {
        
        
        self.tag = 1
        
        if mySwitch.on == true {
            
            status = "Online"
            NSUserDefaults .standardUserDefaults() .setObject("StatusOn", forKey: SwitchStatus)
            
            NSUserDefaults .standardUserDefaults() .synchronize()

        }
        
        else{
            
            status = "Offline"
            NSUserDefaults .standardUserDefaults() .setObject("StatusOff", forKey: SwitchStatus)
            
            NSUserDefaults .standardUserDefaults() .synchronize()

        }
        
        
        
        let userid = NSUserDefaults .standardUserDefaults().stringForKey(KuserId)
        print("userid:\(userid)")
        
        
        
        let urlString = "http://52.39.225.135:8080/DeliveryEngine/changeDriverStatus"
       
        let url = NSURL(string: urlString)
        
        let theRequest = NSMutableURLRequest(URL: url!)
        
        theRequest.HTTPMethod = "POST"
        
        let parameters = ["userId":userid!,"status":status]
        
        
        var err:NSError!
        
        do{
            
            theRequest.HTTPBody = try NSJSONSerialization.dataWithJSONObject(parameters, options: [])
        }
        
        catch let error as NSError
        {
            err = error
            theRequest.HTTPBody = nil
        }
        
        theRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        theRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        
        
        let connectRequest = NSURLConnection(request: theRequest, delegate: self, startImmediately: true)
        
        connectRequest?.start()
        
        
        updateSwitchStatus()
        
       
    }
    
    
    func connection(connection: NSURLConnection, didReceiveResponse response: NSURLResponse) {
        
        NSLog("Received Response\(response)")
        
        
        statusResponseData = NSMutableData()
    }
    
    func connection(connection: NSURLConnection, didReceiveData data: NSData) {
        
        statusResponseData.appendData(data)
    }
    
    
    func connectionDidFinishLoading(connection: NSURLConnection)
        {
        
        NSLog("\(statusResponseData)")
        
        let strData:NSDictionary! = (try! NSJSONSerialization.JSONObjectWithData(statusResponseData, options: NSJSONReadingOptions.MutableContainers)) as! NSDictionary
//        let strData = NSString(data: statusResponseData, encoding: NSUTF8StringEncoding)
        print("Body: \(strData)", terminator: "")
        
        if(self.tag == 2){
            let myValue = strData.valueForKeyPath("status") as! Bool
            if (myValue == true){
                
                
                
                
                
                
                NSUserDefaults .standardUserDefaults() .setObject("Logout", forKey: KloginKey)
                
                NSUserDefaults .standardUserDefaults() .synchronize()
                let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                appDelegate .setRoot()
                
                appDelegate . updateLocation()
                self.logOutActivityIndicatorView.stopAnimating()

                           }}
        
        
        
        
        
           }
    
    func connection(connection: NSURLConnection, didFailWithError error: NSError) {
        
        NSLog("\(error)")
    }
    
    override func viewWillAppear(animated: Bool) {
        let name = NSUserDefaults .standardUserDefaults() .stringForKey(KuserName)
       driverName.text = name
        let userid = NSUserDefaults .standardUserDefaults().stringForKey(KuserId)
        userId.text = userid

        
        self.navigationController?.navigationBarHidden = true
        
    }
    
    
    
    
    override func viewDidLoad() {
        
        
    
        super.viewDidLoad()
        updateSwitchStatus()
        
//        
//        let name = NSUserDefaults .standardUserDefaults() .stringForKey(KuserName)
//        driverName.text = name
//        self.nameLabel.text = String(name)
//        self.nameLabel.text? = name!
        
           self.navigationItem.title="S-Delivery";
        self.navigationController?.navigationBar .titleTextAttributes = [NSForegroundColorAttributeName:UIColor (colorLiteralRed: 0.000, green: 0.416, blue: 0.576, alpha: 1.00)]//(colorLiteralRed: 0.000, green: 0.416, blue: 0.576, alpha: 1.00)
       
        
        self.view.backgroundColor = UIColor.whiteColor()

        // Do any additional setup after loading the view.
    }
    
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func updateSwitchStatus(){
        
        if mySwitch.on{
            
            NSUserDefaults .standardUserDefaults() .setObject("online", forKey: "SwitchStatus")
            
            
            
            myStatus.textColor = UIColor(colorLiteralRed: 0.142, green: 0.742, blue: 0.146, alpha: 1.00)
            
            navigationItem.rightBarButtonItem=UIBarButtonItem(title: "I'M ONLINE", style:.Plain, target:self, action:nil)
            
            navigationItem.rightBarButtonItem?.tintColor=UIColor(colorLiteralRed: 0.142, green: 0.742, blue: 0.146, alpha: 1.00)
            
            navigationItem.rightBarButtonItem!.setTitleTextAttributes([ NSFontAttributeName: UIFont(name: "Helvetica Neue", size: 15.0)!], forState: UIControlState.Normal)
            
            
            
            myStatus.text = "I'M ONLINE"
            
        }
            
        else{
            NSUserDefaults .standardUserDefaults() .setObject("offline", forKey: "SwitchStatus");
            
            navigationItem.rightBarButtonItem=UIBarButtonItem(title: "I'M OFFLINE", style: .Plain, target: self, action:nil);
            navigationItem.rightBarButtonItem?.tintColor=UIColor(colorLiteralRed: 0.896, green: 0.085, blue: 0.000, alpha: 1.00)
            
            navigationItem.rightBarButtonItem!.setTitleTextAttributes([ NSFontAttributeName: UIFont(name: "Helvetica Neue", size: 15.0)!], forState: UIControlState.Normal)
            
            
            
            
            myStatus.textColor = UIColor(colorLiteralRed: 0.896, green: 0.085, blue: 0.000, alpha: 1.00)
            
            
            
            myStatus.text = "I'M OFFLINE"
        }
    }

    @IBAction func shootPhoto() {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
        imagePicker.cameraCaptureMode = .Photo
        imagePicker.modalPresentationStyle = .FullScreen
        presentViewController(imagePicker,
            animated: true,
            completion: nil)
    }
    
       @IBAction func btnClicked(){
        

        
        let alertController = UIAlertController(title: "Choose an option", message: "", preferredStyle: .Alert)
        
        let cameraRollAction = UIAlertAction(title: "Camera Roll", style: .Default) { (action) in
            self.imagePicker.delegate = self
            self.imagePicker.sourceType = UIImagePickerControllerSourceType.SavedPhotosAlbum;
            
            self.imagePicker.allowsEditing = true
            self.presentViewController(self.imagePicker, animated: true, completion: nil)
            
        }
        alertController.addAction(cameraRollAction)
        
        let takePictureAction = UIAlertAction(title: "Take a picture", style: .Default) { (action) in
            self.imagePicker.delegate = self
            self.imagePicker.allowsEditing = true
            self.imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
            self.imagePicker.cameraCaptureMode = .Photo
            self.imagePicker.modalPresentationStyle = .FullScreen
            self.presentViewController(self.imagePicker,
                animated: true,
                completion: nil)
        }
        alertController.addAction(takePictureAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (action) in
        }
        alertController.addAction(cancelAction)
        
        self.presentViewController(alertController, animated: true) {
        }
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: NSDictionary) {
        
        self.dismissViewControllerAnimated(true, completion: {()-> Void in
            
            })
        
        imageView.image = image
        
        
    
    }
    
   
   
    
    
    
    
        @IBAction func ChangePassword(sender: AnyObject)
    {
        
        
        
        
        let obj = ChangePasswordViewController(nibName: "ChangePasswordViewController", bundle: nil)
        self .navigationController?.pushViewController(obj, animated: true)
        

        
    }
    @IBAction func EditBankDetails(sender: AnyObject)
    
    
    {
        
        let obj = BankDetailsViewController(nibName: "BankDetailsViewController", bundle: nil)
        self.navigationController?.pushViewController(obj, animated: true)
        
        
    }
    
    
    
    
    func logOutRequest(){
        
        self.tag = 2
        
        let userid = NSUserDefaults .standardUserDefaults().stringForKey(KuserId)
        print("userid:\(userid)")
        let urlString = "http://52.39.225.135:8080/DeliveryEngine/changeDriverStatus"
        
        let url = NSURL(string: urlString)
        
        let theRequest = NSMutableURLRequest(URL: url!)
        
        theRequest.HTTPMethod = "POST"
        
        let parameters = ["userId":userid!,"status":"Offline"]
        
        
        var err:NSError!
        
        do{
            
            theRequest.HTTPBody = try NSJSONSerialization.dataWithJSONObject(parameters, options: [])
        }
            
        catch let error as NSError
        {
            err = error
            theRequest.HTTPBody = nil
        }
        
        theRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        theRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        
        
        let connectRequest = NSURLConnection(request: theRequest, delegate: self, startImmediately: true)
        
        connectRequest?.start()
        
        
        
        
    }
    
    


    @IBAction func logOutButton(sender: AnyObject) {
        
        self.tag = 2
        //logOutRequest()
            
            
            let alert = UIAlertController(title: "Logout", message: "Are you sure you want to log out?", preferredStyle: UIAlertControllerStyle.Alert)
            alert.view.tintColor = UIColor .redColor()
            alert.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.Default, handler: nil))
            alert.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.Destructive, handler: { ACTION in
                self.logOutRequest()
                self.logOutActivityIndicatorView = UIActivityIndicatorView()
                self.logOutActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.WhiteLarge)
                self.logOutActivityIndicatorView.frame = CGRectMake(KScreenWidth1/2-15, KScreenHeight1/2-15, 30, 30)
                self.logOutActivityIndicatorView.color = UIColor.redColor()
                
                self.logOutActivityIndicatorView.startAnimating()
                self.view.addSubview(self.logOutActivityIndicatorView)
                
//                NSUserDefaults .standardUserDefaults() .setObject("Logout", forKey: KloginKey)
//                
//                NSUserDefaults .standardUserDefaults() .synchronize()
//                let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
//                appDelegate .setRoot()
//                
//                appDelegate . updateLocation()
                
                
            }))
            self.presentViewController(alert, animated: true, completion: nil)
            
            
            // self .navigationController?.pushViewController(obj, animated: true)
        }
    
       
    
        
        
    }


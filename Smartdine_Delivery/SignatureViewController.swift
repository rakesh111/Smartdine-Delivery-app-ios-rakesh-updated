//
//  SignatureViewController.swift
//  Smartdine_Delivery
//
//  Created by Rakesh on 30/12/15.
//  Copyright © 2015 Apple. All rights reserved.
//

import UIKit

class SignatureViewController: UIViewController,NSURLConnectionDataDelegate,UIImagePickerControllerDelegate {
    
    var signatureResponseData : NSMutableData!
    
    @IBOutlet weak var signature:UIImageView!
    
    override func shouldAutorotate() -> Bool {
        return true
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return [UIInterfaceOrientationMask.Portrait, UIInterfaceOrientationMask.Landscape, UIInterfaceOrientationMask.LandscapeLeft, UIInterfaceOrientationMask.LandscapeRight, UIInterfaceOrientationMask.PortraitUpsideDown]
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
       let backBtn : UIBarButtonItem = UIBarButtonItem(title: "BACK", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("backClick"))
        
        navigationItem.leftBarButtonItem?.setTitleTextAttributes([NSFontAttributeName: UIFont(name: "Helvetica Neue", size: 15)!], forState: UIControlState.Normal)
        self.navigationController?.navigationBar .tintColor = UIColor(colorLiteralRed: 0.896, green: 0.085, blue: 0.000, alpha: 1.00)

        
       self.navigationItem.leftBarButtonItem = backBtn
/* [self.navigationItem.leftBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
[UIFont fontWithName:@"Helvetica Neue" size:15.0], NSFontAttributeName,
[UIColor colorWithRed:0.896 green:0.085 blue:0.000 alpha:1.00], NSForegroundColorAttributeName,
nil]
forState:UIControlStateNormal];

*/
// self.navigationItem.leftBarButtonItem = UIColor(colorLiteralRed: 0.142, green: 0.742, blue: 0.146, alpha: 1.00)
                   }
    func backClick()
{




    let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController];
    self.navigationController!.popToViewController(viewControllers[viewControllers.count - 2], animated: true);


    }

   
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

    @IBAction func completeOrder(sender: AnyObject) {
        
        let pushVc = OTPViewController()
        
        self.navigationController?.pushViewController(pushVc, animated: true)
        
       // myImageUploadRequest()
        
//        
//        var urlString = ""
//        
//        let url = NSURL(string: urlString)
//        
//        let theRequest = NSMutableURLRequest(URL: url!)
//        
//        theRequest.HTTPMethod = "POST"
//        
//        let parameters = []
//        
//        var err:NSError!
//        
//        do{
//            theRequest.HTTPBody = try NSJSONSerialization.dataWithJSONObject(parameters, options: [])
//        }
//        
//        catch let error as NSError{
//            
//            err = error
//            theRequest.HTTPBody = nil
//            
//        }
//        
//        theRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
//        theRequest.addValue("application/json", forHTTPHeaderField: "Accept")
//        
//        
//        var connectRequest = NSURLConnection(request: theRequest, delegate: self, startImmediately: true)
//        
//        connectRequest?.start()

        
//        let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController];
//        self.navigationController!.popToViewController(viewControllers[viewControllers.count - 3], animated: true);
        

        
        
    }
    
    func connection(connection: NSURLConnection, didReceiveResponse response: NSURLResponse) {
        
        NSLog("Received response\(response)")
        
        signatureResponseData = NSMutableData()
        //myResponse = NSURLResponse()
        
        
    }
    
    func connection(connection: NSURLConnection, didReceiveData data: NSData) {
        
        signatureResponseData.appendData(data)
    }
    
    func connectionDidFinishLoading(connection: NSURLConnection) {
        
        NSLog("\(signatureResponseData)")
        //myActivityIndicatorView.stopAnimating()
        
        //        let strData = NSString(data: myResponseData, encoding: NSUTF8StringEncoding)
        //        print("Body: \(strData)", terminator: "")
        
        let strData: NSDictionary! = (try! NSJSONSerialization.JSONObjectWithData(signatureResponseData, options: NSJSONReadingOptions.MutableContainers)) as! NSDictionary
        
        print("Body: \(strData)", terminator: "")
        
            
        }
    
    func connection(connection: NSURLConnection, didFailWithError error: NSError) {
        
        NSLog("\(error)")
    }
    
    func myImageUploadRequest()
    {
        
        let myUrl = NSURL(string: "http://www.swiftdeveloperblog.com/http-post-example-script/");
       
        
        let request = NSMutableURLRequest(URL:myUrl!);
        request.HTTPMethod = "POST";
        
        let param = ["userId": "9"]
        
        let boundary = generateBoundaryString()
        
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        
        let imageData = UIImageJPEGRepresentation(signature.image!, 1)
        
        if(imageData==nil)  { return; }
        
        request.HTTPBody = createBodyWithParameters(param, filePathKey: "file", imageDataKey: imageData!, boundary: boundary)
        
        
        
        //myActivityIndicator.startAnimating();
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            data, response, error in
            
            if error != nil {
                print("error=\(error)")
                return
            }
            
            // You can print out response object
            print("******* response = \(response)")
            
            // Print out reponse body
            let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
            print("****** response data = \(responseString!)")
            
            var err: NSError?
            do{
            var json = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers) as? NSDictionary
            }
            
            catch let error as NSError{
                
                            err = error
                            request.HTTPBody = nil
                            
                        }

            
            
            
            dispatch_async(dispatch_get_main_queue(),{
                //self.myActivityIndicator.stopAnimating()
                self.signature.image = nil;
            });
            
            /*
            if let parseJSON = json {
            var firstNameValue = parseJSON["firstName"] as? String
            println("firstNameValue: \(firstNameValue)")
            }
            */
            
        }
        
        task.resume()
        
    }
    
    
    func createBodyWithParameters(parameters: [String: String]?, filePathKey: String?, imageDataKey: NSData, boundary: String) -> NSData {
        var body = NSMutableData();
        
        if parameters != nil {
            for (key, value) in parameters! {
                body.appendString("--\(boundary)\r\n")
                body.appendString("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
                body.appendString("\(value)\r\n")
            }
        }
        
        let filename = signature
        
        let mimetype = "image/jpg"
        
        body.appendString("--\(boundary)\r\n")
        body.appendString("Content-Disposition: form-data; name=\"\(filePathKey!)\"; filename=\"\(filename)\"\r\n")
        body.appendString("Content-Type: \(mimetype)\r\n\r\n")
        body.appendData(imageDataKey)
        body.appendString("\r\n")
        
        
        
        body.appendString("--\(boundary)--\r\n")
        
        return body
    }
    
    
    
    
    func generateBoundaryString() -> String {
        return "Boundary-\(NSUUID().UUIDString)"
    }
    
    
    
}



extension NSMutableData {
    
    func appendString(string: String) {
        let data = string.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)
        appendData(data!)
    }
}

    
    


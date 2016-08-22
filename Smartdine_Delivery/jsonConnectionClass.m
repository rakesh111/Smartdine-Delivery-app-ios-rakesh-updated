//
//  jsonConnectionClass.m
//  Smartdine_Delivery
//
//  Created by Apple on 1/14/16.
//  Copyright © 2016 Apple. All rights reserved.
//
#import "jsonConnectionClass.h"
#import "jsonDelegate.h"



@implementation NSDictionary (JSONReaderNavigation)

- (id)retrieveForPath:(NSString *)navPath
{
    // Split path on dots
    NSArray *pathItems = [navPath componentsSeparatedByString:@"."];
    
    // Enumerate through array
    NSEnumerator *e = [pathItems objectEnumerator];
    NSString *path;
    
    // Set first branch from self
    id branch = [self objectForKey:[e nextObject]];
    int count = 1;
    
    while ((path = [e nextObject]))
    {
        // Check if this branch is an NSArray
        if([branch isKindOfClass:[NSArray class]])
        {
            if ([path isEqualToString:@"last"])
            {
                branch = [branch lastObject];
            }
            else
            {
                if ([branch count] > [path intValue])
                {
                    branch = [branch objectAtIndex:[path intValue]];
                }
                else
                {
                    branch = nil;
                }
            }
        }
        
        else if ([branch isKindOfClass:[NSNull class]])
        {
            NSLog(@"NO DATA HERE");
            
            branch=nil;
            
        }
        
        else
        {
            if (path==nil) {
                
                NSLog(@"NO DATA HERE");
                branch=nil;
            }
            else
            {
                branch = [branch objectForKey:path];
                
            }
            
            
            
            // branch is assumed to be an NSDictionary
        }
        
        count++;
    }
    
    return branch;
}

@end


float    contentLength;


@implementation jsonConnectionClass


@synthesize Delegate;
- (instancetype)init
{
    self = [super init];
    if (self) {
        
        MutableData=[[NSMutableData alloc]init];
    }
    return self;
}


/********************************************************************************************
 @Method Name  : Perform_Service_Request
 @Param        :
 @Return       : NSUrlRequest
 @Description  :Create Url
 ********************************************************************************************/
-(void)Perform_Service_Request :(NSString *)LinkApi   {
    
    //BaseString=BaseApi;
    API=[NSString stringWithFormat:@"%@%@",BaseString,LinkApi];
    NSLog(@"%@",API);
    ConnectionRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:API]];
    [self CreateConnection:ConnectionRequest];
}


/********************************************************************************************
 @Method Name  : CreateConnection
 @Param        :
 @Return       : NSUrlRequest
 @Description  :Create
 ********************************************************************************************/
-(void)CreateConnection:(NSURLRequest *)URLRequest      {
    NSOperationQueue *myQueue = [[NSOperationQueue alloc] init];
    
    
    
    
    if (Web_Connection==nil) {
        
    }
    
    else
    {
        [Web_Connection cancel];
    }
    
    if ([[NSOperationQueue mainQueue]operationCount]>0) {
        [[NSOperationQueue mainQueue] cancelAllOperations];
    }
    else
    {
        [myQueue addOperationWithBlock:^{
            
            
            // Background work
            
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                // Main thread work (UI usually)
                Web_Connection=   [NSURLConnection connectionWithRequest:URLRequest delegate:self];
                
                
            }];
        }];
        
    }
    
    
    
    
}

/********************************************************************************************
 @Method Name  : willcachereesponse
 @Param        :
 @Return       : NSCachedURLResponse
 @Description  :to clear url cache
 ********************************************************************************************/

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection willCacheResponse:(NSCachedURLResponse *)cachedResponse {
    return nil;
}



- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"Error :%@",error);

    [Delegate ConnectionError];
    
    NSLog(@"Error :%@",error);
}

/********************************************************************************************
 @Method Name  : CreateConnection
 @Param        :
 @Return       : NSUrlRequest
 @Description  :Create
 ********************************************************************************************/
- (NSURLRequest *)connection:(NSURLConnection *)connection willSendRequest:(NSURLRequest *)request redirectResponse:(NSURLResponse *)response       {
    
    
    return request;
}
/********************************************************************************************
 @Method Name  : didReceiveResponse
 @Param        :
 @Return       : NSUrlRequest
 @Description  :Create
 ********************************************************************************************/
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response       {
    //    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
    //    float statusCode = [httpResponse statusCode];
    //    if ((statusCode/100) == 2)
    //    {
    //         contentLength = [httpResponse expectedContentLength];
    //        if (contentLength == NSURLResponseUnknownLength)
    //            NSLog(@"unknown content length %f", contentLength);
    //    }
    
    [Delegate ConnectionRecived_Response];
    NSLog(@"%@",response);
}
/********************************************************************************************
 @Method Name  : didReceiveData
 @Param        :
 @Return       : NSUrlRequest
 @Description  :Create
 ********************************************************************************************/
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data  {
    
    [MutableData appendData:data];
    // float  downloadprogress = ((float) [MutableData length] /  contentLength);
    //  NSLog(@"unknown content length %f", downloadprogress);
    //    [Delegate DidRecivedData:downloadprogress];
    
}


/********************************************************************************************
 @Method Name  : connectionDidFinishLoading
 @Param        :
 @Return       : NSUrlRequest
 @Description  :Create
 ********************************************************************************************/
- (void)connectionDidFinishLoading:(NSURLConnection *)connection        {
    NSError *localError = nil;
    NSArray *parsedObject;
    if (!parsedObject) {
        //  parsedObject =[[NSArray alloc]init];
    }
    
    [Web_Connection cancel];
    
    
    
    parsedObject = [NSJSONSerialization JSONObjectWithData:MutableData options:0 error:&localError];
    //NSLog(@"%lu",(unsigned long)[parsedObject count]);
    
    if (Delegate!=nil) {
        //NSLog(@"Delegate lost!!!!!");
        
        if (parsedObject&&parsedObject.count>0) {
            
            [Delegate finishedReceivingDataArray:parsedObject :nil];
        }
        
        else
        {
            
            NSString *myString = [[NSString alloc] initWithData:MutableData encoding:NSUTF8StringEncoding];
            
            NSLog(@"Error response: %@",myString);
            
            [self connection:connection didFailWithError:localError];
        }
        
    }
    
    else
    {
        
    }

}


@end

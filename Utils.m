//
//  Utils.m
//  PaperFold
//
//  Created by CODANGEL on 04/04/13.
//  Copyright (c) 2013 honcheng@gmail.com. All rights reserved.
//

#import "Utils.h"
#import "Reachability.h"
#import <SystemConfiguration/SystemConfiguration.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>


@implementation Utils

+(void)asyncImageLoadByName:(NSString*) image toImageView:(UIImageView*)imageView withQuality:(float)quality
{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0);
    imageView.image = nil;
    
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    spinner.center = imageView.center;
    [spinner startAnimating];
    [imageView addSubview:spinner];

    dispatch_async(queue, ^{
        
        UIImage* img = [UIImage imageNamed:image];
        float width= img.size.width*quality;
        float height= img.size.height*quality;
        UIImage* resized = [Utils imageWithImage:img scaledToSize:(CGSizeMake(width, height))];

        dispatch_async(dispatch_get_main_queue(), ^{
            imageView.alpha=0;
            [imageView setImage:resized];
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:0.5f];
            imageView.alpha = 1.0f;
            [UIView commitAnimations];
            [spinner removeFromSuperview];
        });
    });
}



+(void)imageLoadFromUrl:(NSNumber*)userID withImage:(UIImageView*)imageView
{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0);
    dispatch_async(queue, ^{
        NSURL *url =[NSURL URLWithString:[NSString stringWithFormat:@"http://graph.facebook.com/%@/picture?width=128&height=128",userID]];
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage *imageFB = [UIImage imageWithData:data];
        dispatch_async(dispatch_get_main_queue(), ^{
            [imageView setImage:[self makeRoundedImage:imageFB radius:27]];
        });
    });
}


+(UIImage *)makeRoundedImage:(UIImage *) image radius: (float) radius
{
    CALayer *imageLayer = [CALayer layer];
    imageLayer.frame = CGRectMake(0, 0, image.size.width, image.size.height);
    imageLayer.contents = (id) image.CGImage;
    
    imageLayer.masksToBounds = YES;
    imageLayer.cornerRadius = radius;
    
    UIGraphicsBeginImageContext(image.size);
    [imageLayer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *roundedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return roundedImage;
}


+(NSString*)convertFromUTF8String:(NSString*)UTF8String
{
    const char *c = [UTF8String cStringUsingEncoding:NSISOLatin1StringEncoding];
    NSString *newString = [[NSString alloc]initWithCString:c encoding:NSUTF8StringEncoding];
    return newString;
}

+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    //UIGraphicsBeginImageContext(newSize);
    
    CGSize size = image.size;
    
    float height = (image.size.height / image.size.width) * newSize.width;
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    image = nil;
    
    
//    float oldWidth = image.size.width;
//    float scaleFactor = newSize.width / oldWidth;
//    
//    float newHeight = image.size.height * scaleFactor;
//    float newWidth = oldWidth * scaleFactor;
//    
//    UIGraphicsBeginImageContext(CGSizeMake(newWidth, newHeight));
//    [image drawInRect:CGRectMake(0, 0, newWidth, newHeight)];
//    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
    
    
    return newImage;
}


+(NSData*)decodeFromBase64:(NSString*)base64
{
    unsigned long ixtext, lentext;
    unsigned char ch, inbuf[4], outbuf[3];
    short i, ixinbuf;
    Boolean flignore, flendtext = false;
    const unsigned char *tempcstring;
    NSMutableData *theData;
    
    if (base64 == nil)
    {
        return [NSData data];
    }
    
    ixtext = 0;
    
    tempcstring = (const unsigned char *)[base64 UTF8String];
    
    lentext = [base64 length];
    
    theData = [NSMutableData dataWithCapacity: lentext];
    
    ixinbuf = 0;
    
    while (true)
    {
        if (ixtext >= lentext)
        {
            break;
        }
        
        ch = tempcstring [ixtext++];
        
        flignore = false;
        
        if ((ch >= 'A') && (ch <= 'Z'))
        {
            ch = ch - 'A';
        }
        else if ((ch >= 'a') && (ch <= 'z'))
        {
            ch = ch - 'a' + 26;
        }
        else if ((ch >= '0') && (ch <= '9'))
        {
            ch = ch - '0' + 52;
        }
        else if (ch == '+')
        {
            ch = 62;
        }
        else if (ch == '=')
        {
            flendtext = true;
        }
        else if (ch == '/')
        {
            ch = 63;
        }
        else
        {
            flignore = true;
        }
        
        if (!flignore)
        {
            short ctcharsinbuf = 3;
            Boolean flbreak = false;
            
            if (flendtext)
            {
                if (ixinbuf == 0)
                {
                    break;
                }
                
                if ((ixinbuf == 1) || (ixinbuf == 2))
                {
                    ctcharsinbuf = 1;
                }
                else
                {
                    ctcharsinbuf = 2;
                }
                
                ixinbuf = 3;
                
                flbreak = true;
            }
            
            inbuf [ixinbuf++] = ch;
            
            if (ixinbuf == 4)
            {
                ixinbuf = 0;
                
                outbuf[0] = (inbuf[0] << 2) | ((inbuf[1] & 0x30) >> 4);
                outbuf[1] = ((inbuf[1] & 0x0F) << 4) | ((inbuf[2] & 0x3C) >> 2);
                outbuf[2] = ((inbuf[2] & 0x03) << 6) | (inbuf[3] & 0x3F);
                
                for (i = 0; i < ctcharsinbuf; i++)
                {
                    [theData appendBytes: &outbuf[i] length: 1];
                }
            }
            
            if (flbreak)
            {
                break;
            }
        }
    }
    return theData;
}

+(NSString*)base64forData:(NSData*)theData {
    const uint8_t* input = (const uint8_t*)[theData bytes];
    NSInteger length = [theData length];
    
    static char table[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";
    
    NSMutableData* data = [NSMutableData dataWithLength:((length + 2) / 3) * 4];
    uint8_t* output = (uint8_t*)data.mutableBytes;
    
    NSInteger i;
    for (i=0; i < length; i += 3) {
        NSInteger value = 0;
        NSInteger j;
        for (j = i; j < (i + 3); j++) {
            value <<= 8;
            
            if (j < length) {
                value |= (0xFF & input[j]);
            }
        }
        
        NSInteger theIndex = (i / 3) * 4;
        output[theIndex + 0] =                    table[(value >> 18) & 0x3F];
        output[theIndex + 1] =                    table[(value >> 12) & 0x3F];
        output[theIndex + 2] = (i + 1) < length ? table[(value >> 6)  & 0x3F] : '=';
        output[theIndex + 3] = (i + 2) < length ? table[(value >> 0)  & 0x3F] : '=';
    }
    
    return [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
}

+ (UIImage *)fixrotation:(UIImage *)image{
    
    
    if (image.imageOrientation == UIImageOrientationUp) return image;
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (image.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, image.size.width, image.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, image.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, image.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationUpMirrored:
            break;
    }
    
    switch (image.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, image.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, image.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationDown:
        case UIImageOrientationLeft:
        case UIImageOrientationRight:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, image.size.width, image.size.height,
                                             CGImageGetBitsPerComponent(image.CGImage), 0,
                                             CGImageGetColorSpace(image.CGImage),
                                             CGImageGetBitmapInfo(image.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (image.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,image.size.height,image.size.width), image.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,image.size.width,image.size.height), image.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}


+ (UIImage*)rotateImage:(UIImage*)img byOrientationFlag:(UIImageOrientation)orient
{
    CGImageRef          imgRef = img.CGImage;
    CGFloat             width = CGImageGetWidth(imgRef);
    CGFloat             height = CGImageGetHeight(imgRef);
    CGAffineTransform   transform = CGAffineTransformIdentity;
    CGRect              bounds = CGRectMake(0, 0, width, height);
    CGSize              imageSize = bounds.size;
    CGFloat             boundHeight;
    
    switch(orient) {
            
        case UIImageOrientationUp: //EXIF = 1
            transform = CGAffineTransformIdentity;
            break;
            
        case UIImageOrientationDown: //EXIF = 3
            transform = CGAffineTransformMakeTranslation(imageSize.width, imageSize.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft: //EXIF = 6
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(imageSize.height, imageSize.width);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
            
        case UIImageOrientationRight: //EXIF = 8
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(0.0, imageSize.width);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
            
        default:
            // image is not auto-rotated by the photo picker, so whatever the user
            // sees is what they expect to get. No modification necessary
            transform = CGAffineTransformIdentity;
            break;
            
    }
    
    UIGraphicsBeginImageContext(bounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    if ((orient == UIImageOrientationDown) || (orient == UIImageOrientationRight) || (orient == UIImageOrientationUp)){
        // flip the coordinate space upside down
        CGContextScaleCTM(context, 1, -1);
        CGContextTranslateCTM(context, 0, -height);
    }
    
    CGContextConcatCTM(context, transform);
    CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, width, height), imgRef);
    UIImage *imageCopy = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return imageCopy;
}



+(NSString *)getUUID
{
    CFUUIDRef theUUID = CFUUIDCreate(NULL);
    CFStringRef string = CFUUIDCreateString(NULL, theUUID);
    CFRelease(theUUID);
    //NSString *aNSString = [[NSString alloc] initWithCString:string encoding:<#(NSStringEncoding)#>];
    NSString *aNSString = [NSString stringWithFormat:@"%@", string];
    CFRelease(string);
    return aNSString;
}

+(CGFloat)calculateDistanceBetweenSource:(CLLocationCoordinate2D)firstCoords andDestination:(CLLocationCoordinate2D)secondCoords
{
    
    // this radius is in KM => if miles are needed it is calculated during setter of Place.distance
    
    double nRadius = 6371;
    
    // Get the difference between our two points
    
    // then convert the difference into radians
    
    double nDLat = (firstCoords.latitude - secondCoords.latitude)* (M_PI/180);
    double nDLon = (firstCoords.longitude - secondCoords.longitude)* (M_PI/180);
    
    double nLat1 =  secondCoords.latitude * (M_PI/180);
    double nLat2 =  secondCoords.latitude * (M_PI/180);
    
    double nA = pow ( sin(nDLat/2), 2 ) + cos(nLat1) * cos(nLat2) * pow ( sin(nDLon/2), 2 );
    
    double nC = 2 * atan2( sqrt(nA), sqrt( 1 - nA ));
    
    double nD = nRadius * nC;
    
    //NSLog(@"Distance is %f",nD);
    
    return nD;
}




+(void)testInternetConnection:(hasInternetBlock) block
{
    Reachability* internetReachableFoo = [Reachability reachabilityWithHostname:@"www.google.com"];
    // Internet is reachable
    internetReachableFoo.reachableBlock = ^(Reachability*reach)
    {
        // Update the UI on the main thread
        dispatch_async(dispatch_get_main_queue(), ^{
            block(YES);
        });
    };
    
    // Internet is not reachable
    internetReachableFoo.unreachableBlock = ^(Reachability*reach)
    {
        // Update the UI on the main thread
        dispatch_async(dispatch_get_main_queue(), ^{
            block(NO);
        });
    };
    
    [internetReachableFoo startNotifier];
}



+(void) getFBPlacesAt:(NSNumber*)lat Lat:(NSNumber*)lon withBlock:(finishLoadingPlaces) block
{
    NSString *latitude = [NSString stringWithFormat:@"%f",lat.doubleValue];
    NSString *longitude= [NSString stringWithFormat:@"%f", lon.doubleValue];
    
    if(lat==0 && lon==0)
    {
        block([NSArray new]);
    }
    else{
        NSString * query=[@"SELECT name, page_id, categories,location,page_url, description,type, general_info FROM page WHERE page_id IN"
                          @"(SELECT page_id FROM place WHERE distance(latitude, longitude, \"" stringByAppendingString: latitude];
        
        query=[query stringByAppendingString:@"\",\""];
        query=[query stringByAppendingString:longitude];
        query=[query stringByAppendingString:@"\") < 5000)"];
        
        
        // Set up the query parameter
        NSDictionary *queryParam =
        [NSDictionary dictionaryWithObjectsAndKeys:query, @"q", nil];
        // Make the API request that uses FQL
        [FBRequestConnection startWithGraphPath:@"/fql" parameters:queryParam HTTPMethod:@"GET" completionHandler:^(FBRequestConnection *connection, id result, NSError *error)
        {
            if (error)
            {
                block([NSArray new]);
            }
            else
            {
                if(result==Nil)
                {
                    block([NSArray new]);
                }
                else
                {
                    if([[result objectForKey:@"data"] count]==0)
                    {
                        block([NSArray new]);
                    }
                else
                {
                    // não preciso de nada disto
                   // block([self readPlaces:result]);
                }
              }
          }
      }];
    }
}

+(NSData*)downloadFileFromUrl:(NSString*)url
{
    NSURL *myurl =[NSURL URLWithString:url];
    return [NSData dataWithContentsOfURL:myurl];
}

+(NSNumber*)getUserID{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSNumber* userid = [userDefaults objectForKey:@"user_id"];
    return userid;
}

+(NSString*)getUserName{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString* username = [userDefaults objectForKey:@"user_name"];
    return username;
}

+(void)saveUserImage:(NSData*)imageData forUserID:(NSNumber*)userID
{
    [Utils writeDataToFile:imageData withFileName:userID.description];
}

+(UIImage*)loadUserImage:(NSNumber*)userID
{
    NSData *data;
    NSURL *url =[NSURL URLWithString:[NSString stringWithFormat:@"http://graph.facebook.com/%@/picture?width=128&height=128",userID.description]];
    data = [NSData dataWithContentsOfURL:url];
    
    if(data.length==0)
        data = [Utils loadDataFromFile:userID.description];
    
    UIImage* userImage;
    if(data && data.length>0)
    {
        userImage = [UIImage imageWithData:data];
        [Utils saveUserImage:data forUserID:userID];
    }
    
    return userImage;
}

+(NSData*)loadDataFromFile:(NSString*)filename
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *appFile = [documentsDirectory stringByAppendingPathComponent:filename];
    NSData* data =[NSData dataWithContentsOfFile:appFile];
    return data;;
}

+(void)createAndLoadThumbnailForVideo:(NSString*)videoPath toImageView:(UIImageView*)imageView
{
//   // dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0);
//   // dispatch_async(queue, ^{
//        NSURL *videoURL = [NSURL fileURLWithPath:videoPath];
//        
//        MPMoviePlayerController *player = [[MPMoviePlayerController alloc] initWithContentURL:videoURL];
//        UIImage *thumbnail = [player thumbnailImageAtTime:1.0 timeOption:MPMovieTimeOptionNearestKeyFrame];
//        [player stop];
//        
//       // dispatch_async(dispatch_get_main_queue(), ^{
//           // imageView.image = thumbnail;
//        //});
//    //});
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0);
        dispatch_async(queue, ^{
            NSURL* asseturl = [NSURL fileURLWithPath:videoPath];
            AVAsset *asset = [AVAsset assetWithURL:asseturl];
            AVAssetImageGenerator *imageGenerator = [[AVAssetImageGenerator alloc]initWithAsset:asset];
            CMTime time = CMTimeMake(16, 1);
            CGImageRef imageRef = [imageGenerator copyCGImageAtTime:time actualTime:NULL error:NULL];
            UIImage *thumbnail = [UIImage imageWithCGImage:imageRef];
            CGImageRelease(imageRef);  // CGImageRef won't be released by ARC
            
            dispatch_async(dispatch_get_main_queue(), ^{
                imageView.image = thumbnail;
            });
        });
}

+(NSString*)doubleToDateString:(double)date
{
    NSDate *d = [NSDate dateWithTimeIntervalSince1970:date];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"dd.MM.yyyy"];
    return [dateFormat stringFromDate:d];
}

+(void)writeDataToFile:(NSData*)data withFileName:(NSString*)filename
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *appFile = [documentsDirectory stringByAppendingPathComponent:filename];
    NSError* error;
    [data writeToFile:appFile options:NSDataWritingAtomic error:&error];
    if(error)
        NSLog(error.description);
}





+(BOOL)connectedToInternet
{
    NSLog(@"Start internet test");
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [reachability currentReachabilityStatus];
    NSLog(@"Start internet end");
    return !(networkStatus == NotReachable);
}

+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0, 0, 1, 1);
    // Create a 1 by 1 pixel context
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    [color setFill];
    UIRectFill(rect);   // Fill it with your color
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

//+(BOOL)galleryAcess{
//   // return YES;
//    
//     ALAuthorizationStatus status = [ALAssetsLibrary authorizationStatus];
//    if (status == ALAuthorizationStatusDenied) {
//        return NO;
//        
//    }else{
//        return YES;
//    }
//}


+(BOOL)isIphone5
{
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        if (screenSize.height > 480.0f)
        {
            return YES;
        }
        else
        {
            return NO;
        }
    }
    return NO;
}

+(NSString *)GetDeviceToken{
    NSUserDefaults *defaults = [NSUserDefaults new];
    NSString *token = [defaults objectForKey:@"dev_token"];
    NSString *newToken = token;
	newToken = [newToken stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
	newToken = [newToken stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSLog(@"new token %@", newToken);
    
    if(newToken==nil)
        return @"";
    else
        return newToken;
}


@end

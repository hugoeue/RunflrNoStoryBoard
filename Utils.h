//
//  Utils.h
//  PaperFold
//
//  Created by CODANGEL on 04/04/13.
//  Copyright (c) 2013 honcheng@gmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <QuartzCore/QuartzCore.h>
#import <FacebookSDK/FacebookSDK.h>


@interface Utils : NSObject

typedef void (^finishLoadingPlaces)(NSArray *places);
typedef void (^hasInternetBlock)(BOOL hasInternet);

+(NSString *)getUUID;
+(CGFloat)calculateDistanceBetweenSource:(CLLocationCoordinate2D)firstCoords andDestination:(CLLocationCoordinate2D)secondCoords;
+(UIImage*)rotateImage:(UIImage*)img byOrientationFlag:(UIImageOrientation)orient;
+(UIImage *)fixrotation:(UIImage *)image;
+(UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize ;
+(void)asyncImageLoadByName:(NSString*) image toImageView:(UIImageView*)imageView withQuality:(float)quality;

+(NSString*)convertFromUTF8String:(NSString*)UTF8String;
+(void)imageLoadFromUrl:(NSNumber*)userID withImage:(UIImageView*)imageView;
+(NSNumber*)getUserID;
+(NSString*)getUserName;
+(void) getFBPlacesAt:(NSNumber*)lat Lat:(NSNumber*)lon withBlock:(finishLoadingPlaces) block;
+(void)saveUserImage:(NSData*)imageData forUserID:(NSNumber*)userID;
+(UIImage*)loadUserImage:(NSNumber*)userID;
+(NSData*)loadDataFromFile:(NSString*)filename;
+(void)writeDataToFile:(NSData*)data withFileName:(NSString*)filename;
+(void)testInternetConnection:(hasInternetBlock) block;
+(NSString*)base64forData:(NSData*)theData;
+(NSData*)decodeFromBase64:(NSString*)base64;
+(void)createAndLoadThumbnailForVideo:(NSString*)videoPath toImageView:(UIImageView*)imageView;
+(NSString*)doubleToDateString:(double)date;
+(UIImage *)makeRoundedImage:(UIImage *) image radius: (float) radius;
//Pop up NO Net
+(void)popUpNoNet;
+(BOOL)connectedToInternet;
+ (UIImage *)imageWithColor:(UIColor *)color;
+(BOOL)galleryAcess;
+(void)popUpNoGalleryAcess;
+(BOOL)isIphone5;
+(NSData*)downloadFileFromUrl:(NSString*)url;
+(NSString *)GetDeviceToken;

@end

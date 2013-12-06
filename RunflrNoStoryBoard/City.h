//
//  City.h
//  City Chef
//
//  Created by Helder Pereira on 7/13/13.
//  Copyright (c) 2013 Tecnoled. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface City : NSObject

@property (nonatomic) int dbId;
@property (strong, nonatomic) NSString* name;
@property (strong, nonatomic) NSString* lat;
@property (strong, nonatomic) NSString* lon;

@end

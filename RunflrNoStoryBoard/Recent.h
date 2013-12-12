//
//  Recent.h
//  rundlr
//
//  Created by Helder Pereira on 8/17/13.
//  Copyright (c) 2013 reality6. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Recent : NSObject

@property (nonatomic) int restId;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *date;
@property (nonatomic) int typeId;
@property (strong, nonatomic) NSString *typeText;
@property (strong, nonatomic) NSString *typeImage;
@property (strong, nonatomic) NSURL *typeImageUrl;

@end

//
//  Option.h
//  rundlr
//
//  Created by Helder Pereira on 8/23/13.
//  Copyright (c) 2013 reality6. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Option : NSObject

@property (nonatomic) int dbId;
@property (strong, nonatomic) NSString *name;
@property (nonatomic) BOOL selected;

@end

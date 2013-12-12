//
//  Comments.h
//  rundlr
//
//  Created by Helder Pereira on 8/14/13.
//  Copyright (c) 2013 reality6. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Comments : NSObject

@property (nonatomic) BOOL isUseful;
@property (strong, nonatomic) NSString *usefulText;
@property (nonatomic) BOOL isUserFollow;

@property (nonatomic) int commentId;

@property (nonatomic) int userNumberF;
@property (nonatomic) int userNumberC;

@property (nonatomic) int userId;
@property (strong, nonatomic) NSString *facebookId;
@property (strong, nonatomic) NSString *facebookPhoto;
@property (strong, nonatomic) NSString *userName;
@property (strong, nonatomic) NSString *vote;
@property (strong, nonatomic) NSString *text;
@property (strong, nonatomic) NSString *rank;
@property (nonatomic) int rankId;
@property (strong, nonatomic) NSString *date;
@property (nonatomic) int order;
@property (strong, nonatomic) NSString *rest;
@property (strong, nonatomic) NSString *restParish;
@property (strong, nonatomic) NSString *restPhone;

@property (nonatomic) int restId;

@end

//
//  User.h
//  City Chef
//
//  Created by Helder Pereira on 7/17/13.
//  Copyright (c) 2013 Tecnoled. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property (nonatomic) int dbId;
// para saber qual o o tipo de login utilisado
@property (strong, nonatomic) NSString *loginType;
@property (strong, nonatomic) NSString *faceId;
@property (nonatomic) BOOL isFace;
@property (nonatomic) BOOL isPublish;
@property (nonatomic) BOOL isMe;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *phone;
@property (strong, nonatomic) NSString *email;
@property (nonatomic) int numberCredits;
@property (nonatomic) int userLevelId;
@property (strong, nonatomic) NSString *userLevelText;
@property (strong, nonatomic) NSString *photo;
@property (strong, nonatomic) NSURL *photoUrl;
@property (strong, nonatomic) NSMutableArray *following;
@property (strong, nonatomic) NSMutableArray *followers;
@property (strong, nonatomic) NSMutableArray *comments;
@property (strong, nonatomic) NSMutableArray *favs;
@property (strong, nonatomic) NSMutableArray *beens;
@property (strong, nonatomic) NSMutableArray *recents;
@property (nonatomic) int numberF;
@property (nonatomic) int numberC;


@end

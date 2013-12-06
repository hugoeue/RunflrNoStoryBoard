//
//  Restaurant.h
//  City Chef
//
//  Created by Helder Pereira on 7/13/13.
//  Copyright (c) 2013 Tecnoled. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Restaurant : NSObject

@property (nonatomic) int dbId;

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *city;
@property (strong, nonatomic) NSString *parish;
@property (strong, nonatomic) NSString *price;
@property (nonatomic) int priceId;

@property (nonatomic) int phone;
@property (nonatomic) double lat;
@property (nonatomic) double lon;

@property (nonatomic) BOOL adherent;
@property (nonatomic) BOOL featured;

@property (strong, nonatomic) NSString *chef;
@property (strong, nonatomic) NSString *description;

@property (strong, nonatomic) NSString *address;

@property (strong, nonatomic) NSString *bestChoices;
@property (strong, nonatomic) NSArray *cuisines;
@property (strong, nonatomic) NSArray *paymentOptions;

@property (strong, nonatomic) NSString *schedule;
@property (strong, nonatomic) NSArray *openingTimes;

@property (strong, nonatomic) NSURL *featuredImage;
@property (strong, nonatomic) NSString *featuredImageString;
@property (strong, nonatomic) NSArray *images;

@property (strong, nonatomic) NSArray *options;

@property (strong, nonatomic) NSArray *filters;
@property (strong, nonatomic) NSArray *filtersId;

@property (nonatomic) int fav;
@property (nonatomic) double rating;
@property (nonatomic) int votesNumber;


@property (strong, nonatomic) NSMutableArray *dishes;

@property (strong, nonatomic) NSString *cuisinesResultText;
@property (strong, nonatomic) NSString *recommendedResultText;


@property (nonatomic) BOOL isUserFav;
@property (nonatomic) BOOL isUserBeen;

@property (nonatomic) BOOL isUserNews;
@property (nonatomic) BOOL isUserMenu;
@property (nonatomic) BOOL isUserVouchers;
@property (nonatomic) BOOL isUserComments;

@end

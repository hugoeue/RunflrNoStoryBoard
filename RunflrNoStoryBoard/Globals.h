//
//  Globals.h
//  City Chef
//
//  Created by Helder Pereira on 7/17/13.
//  Copyright (c) 2013 Tecnoled. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "City.h"
#import "Restaurant.h"
#import "User.h"

@interface Globals : NSObject

+ (void)setImagemFeedBack:(NSString *)img;
+ (NSString *)getImagemFeedBack;

+ (void)setImagemGenerica:(UIImage *)img;
+ (UIImage *)getImagemGenerica;

+ (void)setLang:(NSString *)lang;
+ (NSString *)lang;

+ (void)setNewsDay:(NSMutableArray *)newsDay;
+ (NSMutableArray *)newsDay;

+ (void)setTop10Rest:(NSMutableArray *)top10Rest;
+ (NSMutableArray *)top10Rest;

+ (void)setLevels:(NSMutableArray *)levels;
+ (NSMutableArray *)levels;

+ (void)setFacebookId:(int)facebookId;
+ (int)facebookId;

+ (void)setSearchQuery:(NSString *)searchQuery;
+ (NSString *)searchQuery;

+ (void)setSearchResult:(NSMutableArray *)searchResult;
+ (NSMutableArray *)searchResult;

+ (void)setCities:(NSMutableArray *)cities;
+ (NSMutableArray *)cities;


+ (void)setFeatured:(NSMutableArray *)featured;
+ (NSMutableArray *)featured;

+ (void)setCityId:(int)cityId;
+ (int)cityId;

+ (void)setOtherCityId:(int)otherCityId;
+ (int)otherCityId;

+ (void)setRestaurantId:(int)restaurantId;
+ (int)restaurantId;

+ (void)setCommentId:(int)commentId;
+ (int)commentId;

+ (void)setRestaurant:(Restaurant *)restaurant;
+ (Restaurant *)restaurant;

+ (void)setUser:(User *)user;
+ (User *)user;

+ (void)setComments:(NSMutableArray *)comments;
+ (NSMutableArray *)comments;

+ (void)setDays:(NSMutableArray *)days;
+ (NSMutableArray *)days;

+ (void)setChoices:(NSMutableArray *)choices;
+ (NSMutableArray *)choices;

+ (void)setDaySpecials:(NSMutableArray *)daySpecials;
+ (NSMutableArray *)daySpecials;

+ (void)setOptions:(NSMutableArray *)options;
+ (NSMutableArray *)options;

+ (void)setCuisines:(NSMutableArray *)cuisines;
+ (NSMutableArray *)cuisines;

+ (NSString *)dia;
+ (NSString *)dia_semana;
+ (NSString *)data;
+ (NSString *)dia_semana_data;

+ (NSString *)hostWithFile:(NSString *)file andGetData:(NSString *)getData;

@end


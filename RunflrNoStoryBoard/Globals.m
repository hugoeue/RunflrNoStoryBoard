//
//  Globals.m
//  City Chef
//
//  Created by Helder Pereira on 7/17/13.
//  Copyright (c) 2013 Tecnoled. All rights reserved.
//

#import "Globals.h"

static NSString *_lang = nil;

static NSMutableArray *_newsDay = nil;

static NSMutableArray *_top10Rest = nil;

static NSMutableArray *_levels;

static int _facebookId;

static NSString *_searchQuery = nil;
static NSMutableArray *_searchResult = nil;
static NSMutableArray *_cities = nil;
static NSMutableArray *_featured = nil;
static int _cityId;
static int _otherCityId;
static int _restaurantId;
static int _commentId;
static Restaurant *_restaurant = nil;
static User *_user = nil;

static NSMutableArray *_comments = nil;

static NSMutableArray *_days = nil;
static NSMutableArray *_choices = nil;

static NSMutableArray *_daySpecials = nil;

static NSMutableArray *_options = nil;
static NSMutableArray *_cuisines = nil;

@implementation Globals

+ (void)setLang:(NSString *)lang
{
    _lang = lang;
}

+ (NSString *)lang
{
    return _lang;
}

+ (void)setNewsDay:(NSMutableArray *)newsDay
{
    _newsDay = newsDay;
}

+ (NSMutableArray *)newsDay
{
    return _newsDay;
}

+ (void)setTop10Rest:(NSMutableArray *)top10Rest
{
    _top10Rest = top10Rest;
}

+ (NSMutableArray *)top10Rest
{
    return _top10Rest;
}

+ (void)setLevels:(NSMutableArray *)levels
{
    _levels = levels;
}

+ (NSMutableArray *)levels
{
    return _levels;
}

+ (void)setFacebookId:(int)facebookId
{
    _facebookId = facebookId;
}

+ (int)facebookId
{
    return _facebookId;
}

+ (void)setSearchQuery:(NSString *)searchQuery
{
    _searchQuery = searchQuery;
}

+ (NSString *)searchQuery
{
    return _searchQuery;
}


+ (void)setSearchResult:(NSMutableArray *)searchResult
{
    _searchResult = searchResult;
}

+ (NSMutableArray *)searchResult
{
    return _searchResult;
}

+ (void)setCities:(NSMutableArray *)cities
{
    _cities = cities;
}

+ (NSMutableArray *)cities
{
    return _cities;
}

+ (void)setFeatured:(NSMutableArray *)featured
{
    _featured = featured;
}

+ (NSMutableArray *)featured
{
    return _featured;
}

+ (void)setCityId:(int)cityId
{
    _cityId = cityId;
}

+ (int)cityId
{
    return _cityId;
}

+ (void)setOtherCityId:(int)otherCityId
{
    _otherCityId = otherCityId;
}

+ (int)otherCityId
{
    return _otherCityId;
}

+ (void)setRestaurantId:(int)restaurantId
{
    _restaurantId = restaurantId;
}

+ (int)restaurantId
{
    return _restaurantId;
}

+ (void)setCommentId:(int)commentId
{
    _commentId = commentId;
}

+ (int)commentId
{
    return _commentId;
}

+ (void)setRestaurant:(Restaurant *)restaurant
{
    _restaurant = restaurant;
}

+ (Restaurant *)restaurant
{
    return _restaurant;
}

+ (void)setUser:(User *)user
{
    _user = user;
}

+ (User *)user
{
    return _user;
}

+ (void)setComments:(NSMutableArray *)comments
{
    _comments = comments;
}

+ (NSMutableArray *)comments
{
    return _comments;
}

+ (void)setDays:(NSMutableArray *)days
{
    _days = days;
}

+ (NSMutableArray *)days
{
    return _days;
}

+ (void)setChoices:(NSMutableArray *)choices
{
    _choices = choices;
}

+ (NSMutableArray *)choices
{
    return _choices;
}

+ (void)setDaySpecials:(NSMutableArray *)daySpecials
{
    _daySpecials = daySpecials;
}

+ (NSMutableArray *)daySpecials
{
    return _daySpecials;
}

+ (void)setOptions:(NSMutableArray *)options
{
    _options = options;
}

+ (NSMutableArray *)options
{
    return _options;
}

+ (void)setCuisines:(NSMutableArray *)cuisines
{
    _cuisines = cuisines;
}

+ (NSMutableArray *)cuisines
{
    return _cuisines;
}

+ (NSString *)dia
{
    NSLocale *ptLocale;
    if ([[Globals lang] isEqualToString:@"en"]) {
        ptLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    } else if ([[Globals lang] isEqualToString:@"es"]) {
        ptLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"es_US"];
    } else if ([[Globals lang] isEqualToString:@"fr"]) {
        ptLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"fr_FR"];
    } else {
        ptLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"pt_PT"];
    }
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setLocale:ptLocale];
    [dateFormat setTimeZone:[NSTimeZone localTimeZone]];
    [dateFormat setDateFormat:@"dd"];
    
    NSDate* today = [NSDate date];
    
    return [dateFormat stringFromDate:today];
}

+ (NSString *)dia_semana
{
    NSLocale *ptLocale;
    if ([[Globals lang] isEqualToString:@"en"]) {
        ptLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    } else if ([[Globals lang] isEqualToString:@"es"]) {
        ptLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"es_US"];
    } else if ([[Globals lang] isEqualToString:@"fr"]) {
        ptLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"fr_FR"];
    } else {
        ptLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"pt_PT"];
    }
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setLocale:ptLocale];
    [dateFormat setTimeZone:[NSTimeZone localTimeZone]];
    [dateFormat setDateFormat:@"EEEE"];
    
    NSDate* today = [NSDate date];
    
    return [dateFormat stringFromDate:today];
}

+ (NSString *)data
{
    
    NSLocale *ptLocale;
    if ([[Globals lang] isEqualToString:@"en"]) {
        ptLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    } else if ([[Globals lang] isEqualToString:@"es"]) {
        ptLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"es_US"];
    } else if ([[Globals lang] isEqualToString:@"fr"]) {
        ptLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"fr_FR"];
    } else {
        ptLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"pt_PT"];
    }
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setLocale:ptLocale];
    [dateFormat setTimeZone:[NSTimeZone localTimeZone]];
    [dateFormat setDateFormat:@"d MMMM yyyy"];
    
    NSDate* today = [NSDate date];
    
    return [dateFormat stringFromDate:today];
}

+ (NSString *)dia_semana_data
{
    NSLocale *ptLocale;
    if ([[Globals lang] isEqualToString:@"en"]) {
        ptLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    } else if ([[Globals lang] isEqualToString:@"es"]) {
        ptLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"es_US"];
    } else if ([[Globals lang] isEqualToString:@"fr"]) {
        ptLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"fr_FR"];
    } else {
        ptLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"pt_PT"];
    }
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setLocale:ptLocale];
    [dateFormat setTimeZone:[NSTimeZone localTimeZone]];
    [dateFormat setDateFormat:@"EEE, d MMMM yyyy"];
    
    NSDate* today = [NSDate date];
    
    return [dateFormat stringFromDate:today];
}

+ (NSString *)hostWithFile:(NSString *)file andGetData:(NSString *)getData
{
    
    
    //NSMutableString *host = [NSMutableString stringWithString:@"http://cms.citychef.pt/data/"];
    NSMutableString *host = [NSMutableString stringWithString:@"http://192.168.0.101/Rundlr_Package/rundlrweb/data/"];
    
    [host appendString:file];
    [host appendString:@"?api_key=RrNDLR20_13_h3ld3r"];
    [host appendFormat:@"&lang=%@", [Globals lang]];
    [host appendFormat:@"&user_id=%d", [Globals user].dbId];
    [host appendFormat:@"&user_face=%@", [Globals user].faceId];
    [host appendString:getData];
    
    return [NSString stringWithString:host];
}


@end

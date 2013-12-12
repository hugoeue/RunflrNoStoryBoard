//
//  RestaurantParser.m
//  City Chef
//
//  Created by Helder Pereira on 7/18/13.
//  Copyright (c) 2013 Tecnoled. All rights reserved.
//

#import "RestaurantParser.h"

@interface RestaurantParser ()
{
    NSString *currentChars;
    
    Restaurant *currentRestaurant;

    NSMutableArray *currentCuisines;
    NSMutableArray *currentOptions;
    NSMutableArray *currentFilters;
    NSMutableArray *currentPayments;
    NSMutableArray *currentImages;
}

@end

@implementation RestaurantParser

- (id)initXMLParser {
    if (self = [super init]) {
//        [Globals setCities: [[NSMutableArray alloc] init]];
    }
    return self;
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    
    if ([elementName isEqualToString:@"restaurant"]) {
        currentRestaurant = [[Restaurant alloc] init];
    }
    
    if ([elementName isEqualToString:@"cuisines"]) {
        currentCuisines = [[NSMutableArray alloc] init];
    }

    if ([elementName isEqualToString:@"options"]) {
        currentOptions = [[NSMutableArray alloc] init];
    }

    if ([elementName isEqualToString:@"filters"]) {
        currentFilters = [[NSMutableArray alloc] init];
    }
    
    if ([elementName isEqualToString:@"payments"]) {
        currentPayments = [[NSMutableArray alloc] init];
    }
    
    if ([elementName isEqualToString:@"images"]) {
        currentImages = [[NSMutableArray alloc] init];
    }
    
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    currentChars = string;
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    // USER FOLLOWING STUFF
    
    if ([elementName isEqualToString:@"user_fav"]) {
        if (currentChars.intValue == 1)
            currentRestaurant.isUserFav = YES;
        else
            currentRestaurant.isUserFav = NO;
    }
    
    if ([elementName isEqualToString:@"user_been"]) {
        if (currentChars.intValue == 1)
            currentRestaurant.isUserBeen = YES;
        else
            currentRestaurant.isUserBeen = NO;
    }

    if ([elementName isEqualToString:@"user_follow_news"]) {
        if (currentChars.intValue == 1)
            currentRestaurant.isUserNews = YES;
        else
            currentRestaurant.isUserNews = NO;
    }
    
    if ([elementName isEqualToString:@"user_follow_menu"]) {
        if (currentChars.intValue == 1)
            currentRestaurant.isUserMenu = YES;
        else
            currentRestaurant.isUserMenu = NO;
    }
    
    if ([elementName isEqualToString:@"user_follow_vouchers"]) {
        if (currentChars.intValue == 1)
            currentRestaurant.isUserVouchers = YES;
        else
            currentRestaurant.isUserVouchers = NO;
    }
    
    if ([elementName isEqualToString:@"user_follow_comments"]) {
        if (currentChars.intValue == 1)
            currentRestaurant.isUserComments = YES;
        else
            currentRestaurant.isUserComments = NO;
    }
    
    //
    
    if ([elementName isEqualToString:@"rating"]) {
        currentRestaurant.rating = [currentChars floatValue];
    }
    
    if ([elementName isEqualToString:@"votes_number"]) {
        currentRestaurant.votesNumber = [currentChars intValue];
    }
    
    if ([elementName isEqualToString:@"chef"]) {
        currentRestaurant.chef = currentChars;
    }
    
    if ([elementName isEqualToString:@"id"]) {
        currentRestaurant.dbId = [currentChars intValue];
    }
    
    if ([elementName isEqualToString:@"name"]) {
        currentRestaurant.name = currentChars;
    }
    
    if ([elementName isEqualToString:@"parish"]) {
        currentRestaurant.parish = currentChars;
    }
    
    if ([elementName isEqualToString:@"city"]) {
        currentRestaurant.city = currentChars;
    }
    
    if ([elementName isEqualToString:@"price"]) {
        currentRestaurant.price = currentChars;
    }
    
    if ([elementName isEqualToString:@"price_id"]) {
        currentRestaurant.priceId = currentChars.intValue;
    }

    if ([elementName isEqualToString:@"phone"]) {
        currentRestaurant.phone = currentChars.intValue;
    }
    
    if ([elementName isEqualToString:@"lat"]) {
        currentRestaurant.lat = currentChars.doubleValue;
    }
    
    if ([elementName isEqualToString:@"lon"]) {
        currentRestaurant.lon = currentChars.doubleValue;
    }
    
    if ([elementName isEqualToString:@"choices"]) {
        currentRestaurant.bestChoices = currentChars;
    }
    
    if ([elementName isEqualToString:@"adherent"]) {
        if (currentChars.intValue == 1)
            currentRestaurant.adherent = YES;
        else
            currentRestaurant.adherent = NO;
    }
    
    if ([elementName isEqualToString:@"featured"]) {
        if (currentChars.intValue == 1)
            currentRestaurant.featured = YES;
        else
            currentRestaurant.featured = NO;    }
    
    if ([elementName isEqualToString:@"address"]) {
        currentRestaurant.address = currentChars;
    }
    
    if ([elementName isEqualToString:@"chef"]) {
        currentRestaurant.chef = currentChars;
    }
    
    if ([elementName isEqualToString:@"description"]) {
        currentRestaurant.description = currentChars;
    }
    
    if ([elementName isEqualToString:@"schedule"]) {
        currentRestaurant.schedule = currentChars;
    }
    
    if ([elementName isEqualToString:@"cuisine"]) {
        [currentCuisines addObject:currentChars];
    }
    
    if ([elementName isEqualToString:@"cuisines"]) {
        currentRestaurant.cuisines = [NSArray arrayWithArray:currentCuisines];
        currentCuisines = nil;
    }
    
    if ([elementName isEqualToString:@"option"]) {
        [currentOptions addObject:currentChars];
    }
    
    if ([elementName isEqualToString:@"options"]) {
        currentRestaurant.options = [NSArray arrayWithArray:currentOptions];
        currentOptions = nil;
    }
    
    if ([elementName isEqualToString:@"filterid"]) {
        [currentFilters addObject:currentChars];
    }
    
    if ([elementName isEqualToString:@"filters"]) {
        currentRestaurant.filters = [NSArray arrayWithArray:currentFilters];
        currentFilters = nil;
    }
    
    if ([elementName isEqualToString:@"payment"]) {
        [currentPayments addObject:currentChars];
    }
    
    if ([elementName isEqualToString:@"payments"]) {
        currentRestaurant.paymentOptions = [NSArray arrayWithArray:currentPayments];
        currentPayments = nil;
    }
    
    if ([elementName isEqualToString:@"image"]) {
        [currentImages addObject:currentChars];
    }
    
    if ([elementName isEqualToString:@"images"]) {
        currentRestaurant.images = [NSArray arrayWithArray:currentImages];
        currentImages = nil;
    }
    
    if ([elementName isEqualToString:@"restaurant"]) {
        [Globals setRestaurant:currentRestaurant];
        currentRestaurant = nil;
    }
}

@end

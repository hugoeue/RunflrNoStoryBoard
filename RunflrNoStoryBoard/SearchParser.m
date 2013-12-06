//
//  SearchParser.m
//  rundlr
//
//  Created by Helder Pereira on 7/28/13.
//  Copyright (c) 2013 Tecnoled. All rights reserved.
//

#import "SearchParser.h"

@interface SearchParser ()
{
    Restaurant *currentRestaurant;
    Option *currentOption;
    Cuisine *currentCuisine;
    
    NSString *currentChars;
}

@end

@implementation SearchParser

- (id)initXMLParser {
    if (self = [super init]) {
        [Globals setSearchResult:[[NSMutableArray alloc] init]];
        
        [Globals setOptions:[[NSMutableArray alloc] init]];
        [Globals setCuisines:[[NSMutableArray alloc] init]];
    }
    return self;
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    
    if ([elementName isEqualToString:@"restaurant"]) {
        currentRestaurant = [[Restaurant alloc] init];
    }
    
    if ([elementName isEqualToString:@"option"]) {
        currentOption = [[Option alloc] init];
    }
    
    if ([elementName isEqualToString:@"cuisine"]) {
        currentCuisine = [[Cuisine alloc] init];
    }
    
    
    
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    currentChars = string;
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    // ALL CUISINES
    
    if ([elementName isEqualToString:@"cuisine_id"]) {
        currentCuisine.dbId = [currentChars intValue];
    }

    if ([elementName isEqualToString:@"cuisine_name"]) {
        currentCuisine.name = currentChars;
    }
    
    if ([elementName isEqualToString:@"cuisine"]) {
        [Globals.cuisines addObject:currentCuisine];
    }
    
    // ALL OPTIONS
    
    if ([elementName isEqualToString:@"option_id"]) {
        currentOption.dbId = [currentChars intValue];
    }
    
    if ([elementName isEqualToString:@"option_name"]) {
        currentOption.name = currentChars;
    }
    
    if ([elementName isEqualToString:@"option"]) {
        [Globals.options addObject:currentOption];
    }
    
    // SEARCH RESULTS
    
    if ([elementName isEqualToString:@"id"]) {
        currentRestaurant.dbId = [currentChars intValue];
    }
    
    if ([elementName isEqualToString:@"name"]) {
        currentRestaurant.name = currentChars;
    }
    
    if ([elementName isEqualToString:@"rating"]) {
        currentRestaurant.rating = currentChars.floatValue;
    }
    
    if ([elementName isEqualToString:@"fav"]) {
        currentRestaurant.fav = currentChars.intValue;
    }
    
    if ([elementName isEqualToString:@"parish"]) {
        currentRestaurant.parish = currentChars;
    }
    
    if ([elementName isEqualToString:@"recommended"]) {
        currentRestaurant.recommendedResultText = currentChars;
    }
    
    if ([elementName isEqualToString:@"cuisines"]) {
        currentRestaurant.cuisinesResultText = currentChars;
    }
    
    if ([elementName isEqualToString:@"restaurant"]) {
        [Globals.searchResult addObject:currentRestaurant];
    }
}
@end

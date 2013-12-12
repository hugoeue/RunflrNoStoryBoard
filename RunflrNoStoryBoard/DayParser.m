//
//  DayParser.m
//  rundlr
//
//  Created by Helder Pereira on 8/15/13.
//  Copyright (c) 2013 reality6. All rights reserved.
//

#import "DayParser.h"
#import "Menu.h"

@interface DayParser ()
{
    Restaurant *currentRestaurant;
    Menu *currentMenu;
    NSString *currentChars;
}

@end

@implementation DayParser

- (id)initXMLParser {
    if (self = [super init]) {
        [Globals setDaySpecials: [[NSMutableArray alloc] init]];
    }
    return self;
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    
    if ([elementName isEqualToString:@"restaurant"]) {
        currentRestaurant = [[Restaurant alloc] init];
        currentRestaurant.dishes = [[NSMutableArray alloc] init];
    }
    
    if ([elementName isEqualToString:@"dish"]) {
        currentMenu = [[Menu alloc] init];
    }
    
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    currentChars = string;
}



- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    
    if ([elementName isEqualToString:@"name"]) {
        currentRestaurant.name = currentChars;
    }
    
    if ([elementName isEqualToString:@"value"]) {
        currentRestaurant.rating = [currentChars floatValue];
    }
    
    if ([elementName isEqualToString:@"dishname"]) {
        currentMenu.dish = currentChars;
//            NSLog(@"CCHARS:%@", currentMenu.dish);
    }
    
    if ([elementName isEqualToString:@"extra"]) {
        currentMenu.extra = currentChars;
    }
    
    if ([elementName isEqualToString:@"description"]) {
        currentMenu.description = currentChars;
    }
    
    if ([elementName isEqualToString:@"dish"]) {
        [currentRestaurant.dishes addObject: currentMenu];
    }
    
    if ([elementName isEqualToString:@"restaurant"]) {
        [Globals.daySpecials addObject:currentRestaurant];
    }
}

@end
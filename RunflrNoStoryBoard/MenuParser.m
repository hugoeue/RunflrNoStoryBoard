//
//  MenuParser.m
//  rundlr
//
//  Created by Helder Pereira on 8/14/13.
//  Copyright (c) 2013 reality6. All rights reserved.
//

#import "MenuParser.h"
#import "Menu.h"

@interface MenuParser ()
{
    Menu *currentMenu;
    NSString *currentChars;
}

@end

@implementation MenuParser

- (id)initXMLParser {
    if (self = [super init]) {
        [Globals setDays: [[NSMutableArray alloc] init]];
        [Globals setChoices: [[NSMutableArray alloc] init]];
    }
    return self;
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    
    if ([elementName isEqualToString:@"day"]) {
        currentMenu = [[Menu alloc] init];
    }
    
    if ([elementName isEqualToString:@"choice"]) {
        currentMenu = [[Menu alloc] init];
    }
    
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    currentChars = string;
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    
    if ([elementName isEqualToString:@"dish"]) {
        currentMenu.dish = currentChars;
    }
    
    if ([elementName isEqualToString:@"tipo"]) {
        currentMenu.tipo = currentChars;
    }
    
    if ([elementName isEqualToString:@"tipod"]) {
        currentMenu.tipod = currentChars;
    }
    
    if ([elementName isEqualToString:@"extra"]) {
        currentMenu.extra = currentChars;
    }
    
    if ([elementName isEqualToString:@"description"]) {
        currentMenu.description = currentChars;
    }
    
    if ([elementName isEqualToString:@"day"]) {
        [Globals.days addObject:currentMenu];
    }
    
    if ([elementName isEqualToString:@"choice"]) {
        [Globals.choices addObject:currentMenu];
    }
}

@end

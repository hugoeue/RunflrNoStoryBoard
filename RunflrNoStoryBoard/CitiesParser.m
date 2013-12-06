//
//  CitiesParser.m
//  City Chef
//
//  Created by Helder Pereira on 7/17/13.
//  Copyright (c) 2013 Tecnoled. All rights reserved.
//

#import "CitiesParser.h"

@interface CitiesParser ()
{
    City *currentCity;
    NSString *currentChars;
}

@end

@implementation CitiesParser

- (id)initXMLParser {
    if (self = [super init]) {
        [Globals setCities: [[NSMutableArray alloc] init]];
    }
    return self;
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    
    if ([elementName isEqualToString:@"city"]) {
        currentCity = [[City alloc] init];
    }
    
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    currentChars = string;
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    
    if ([elementName isEqualToString:@"id"]) {
        currentCity.dbId = [currentChars intValue];
    }
    
    if ([elementName isEqualToString:@"name"]) {
        currentCity.name = currentChars;
    }
    
    if ([elementName isEqualToString:@"lat"]) {
        currentCity.lat = currentChars;
    }
    
    if ([elementName isEqualToString:@"lon"]) {
        currentCity.lon = currentChars;
    }
    
    if ([elementName isEqualToString:@"city"]) {
        [Globals.cities addObject:currentCity];
    }
}
@end

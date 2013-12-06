//
//  FeaturedParser.m
//  City Chef
//
//  Created by Helder Pereira on 7/17/13.
//  Copyright (c) 2013 Tecnoled. All rights reserved.
//

#import "FeaturedParser.h"

@interface FeaturedParser ()
{
    Restaurant *currentRestaurant;
    NSString *currentChars;
    NSMutableArray *featured;
}
@end

@implementation FeaturedParser
- (id)initXMLParser {
    if (self = [super init]) {
        [Globals setFeatured:[[NSMutableArray alloc] init]];
    }
    return self;
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    
    if ([elementName isEqualToString:@"featured"]) {
        featured = [[NSMutableArray alloc] init];
    }
    
    if ([elementName isEqualToString:@"restaurant"]) {
        currentRestaurant = [[Restaurant alloc] init];
    }
    
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    currentChars = string;
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    
    if ([elementName isEqualToString:@"id"]) {
        currentRestaurant.dbId = [currentChars intValue];
    }
    
    if ([elementName isEqualToString:@"name"]) {
        currentRestaurant.name = currentChars;
    }
    
    if ([elementName isEqualToString:@"image"]) {
        NSString *urlStr = [NSString stringWithFormat:@"http://cms.citychef.pt%@", currentChars];
        currentRestaurant.featuredImageString = urlStr;
        currentRestaurant.featuredImage = [NSURL URLWithString:urlStr];
    }
    
    if ([elementName isEqualToString:@"restaurant"]) {
        [featured addObject:currentRestaurant];
    }
    
    if ([elementName isEqualToString:@"featured"]) {
        [Globals setFeatured:[NSArray arrayWithArray:featured]];
        featured = nil;
    }
}
@end

//
//  CommentsParser.m
//  rundlr
//
//  Created by Helder Pereira on 8/14/13.
//  Copyright (c) 2013 reality6. All rights reserved.
//

#import "CommentsParser.h"
#import "Comments.h"

@interface CommentsParser ()
{
    Comments *currentComment;
    NSString *currentChars;
}

@end

@implementation CommentsParser

- (id)initXMLParser {
    if (self = [super init]) {
        [Globals setComments: [[NSMutableArray alloc] init]];
    }
    return self;
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    
    if ([elementName isEqualToString:@"comment"]) {
        currentComment = [[Comments alloc] init];
    }
    
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    currentChars = string;
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    
    if ([elementName isEqualToString:@"useful"]) {
        if (currentChars.intValue == 1)
            currentComment.isUseful = YES;
        else
            currentComment.isUseful = NO;
    }
    
    if ([elementName isEqualToString:@"useful_text"]) {
        currentComment.usefulText = currentChars;
    }
    
    if ([elementName isEqualToString:@"user_follow"]) {
        if (currentChars.intValue == 1)
            currentComment.isUserFollow = YES;
        else
            currentComment.isUserFollow = NO;
    }
    
    if ([elementName isEqualToString:@"comment_id"]) {
        currentComment.commentId = [currentChars intValue];
    }
    
    if ([elementName isEqualToString:@"user_number_f"]) {
        currentComment.userNumberF = [currentChars intValue];
    }
    
    if ([elementName isEqualToString:@"user_number_c"]) {
        currentComment.userNumberC = [currentChars intValue];
    }
    
    if ([elementName isEqualToString:@"rest_id"]) {
        currentComment.restId = [currentChars intValue];
    }
    
    if ([elementName isEqualToString:@"rest_name"]) {
        currentComment.rest = currentChars;
    }
    
    if ([elementName isEqualToString:@"rest_parish"]) {
        currentComment.restParish = currentChars;
    }
    
    if ([elementName isEqualToString:@"rest_phone"]) {
        currentComment.restPhone = currentChars;
    }
    
    if ([elementName isEqualToString:@"user_id"]) {
        currentComment.userId = [currentChars intValue];
    }
    
    if ([elementName isEqualToString:@"facebook_id"]) {
        currentComment.facebookId = currentChars;
    }
    
    if ([elementName isEqualToString:@"facebook_photo"]) {
        currentComment.facebookPhoto = currentChars;
    }
    
    if ([elementName isEqualToString:@"user_name"]) {
        currentComment.userName = currentChars;
    }
    
    if ([elementName isEqualToString:@"vote"]) {
        currentComment.vote = currentChars;
    }
    
    if ([elementName isEqualToString:@"text"]) {
        currentComment.text = currentChars;
    }
    
    if ([elementName isEqualToString:@"rank"]) {
        currentComment.rank = currentChars;
    }
    
    if ([elementName isEqualToString:@"rank_id"]) {
        currentComment.rankId = [currentChars intValue];
    }

    if ([elementName isEqualToString:@"date"]) {
        currentComment.date = currentChars;
    }

    
    if ([elementName isEqualToString:@"comment"]) {
        [Globals.comments addObject:currentComment];
    }
}

@end

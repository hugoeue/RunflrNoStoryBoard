//
//  UserParser.m
//  rundlr
//
//  Created by Helder Pereira on 8/17/13.
//  Copyright (c) 2013 reality6. All rights reserved.
//

#import "UserParser.h"
#import "Comments.h"
#import "Recent.h"

@interface UserParser ()
{
    User *currentUser;
    
    User *currentFollow;
    Comments *currentComment;
    Restaurant *currentRest;
    Recent *currentRecent;
    
    NSString *currentChars;
}

@end

@implementation UserParser

- (id)initXMLParser {
    if (self = [super init]) {
        if(![Globals user])
        {
            currentUser = [[User alloc] init];
        }else
        {
            currentUser = [Globals user];
        }
        
        currentUser.following = [[NSMutableArray alloc] init];
        currentUser.followers = [[NSMutableArray alloc] init];
        currentUser.comments = [[NSMutableArray alloc] init];
        currentUser.favs = [[NSMutableArray alloc] init];
        currentUser.beens = [[NSMutableArray alloc] init];
        currentUser.recents = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    
    if ([elementName isEqualToString:@"following_user"]) {
        currentFollow = [[User alloc] init];
    }
    
    if ([elementName isEqualToString:@"followers_user"]) {
        currentFollow = [[User alloc] init];        
    }
    
    if ([elementName isEqualToString:@"comment"]) {
        currentComment = [[Comments alloc] init];
    }
    
    if ([elementName isEqualToString:@"fav"]) {
        currentRest = [[Restaurant alloc] init];
    }
    
    if ([elementName isEqualToString:@"been"]) {
        currentRest = [[Restaurant alloc] init];
    }
    
    if ([elementName isEqualToString:@"recent"]) {
        currentRecent = [[Recent alloc] init];
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    currentChars = string;
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    
    if ([elementName isEqualToString:@"id"]) {
        currentUser.dbId = [currentChars intValue];
    }
    
    if ([elementName isEqualToString:@"face_id"]) {
        currentUser.faceId = currentChars;
    }
    
    if ([elementName isEqualToString:@"is_face"]) {
        if ([currentChars intValue] == 1) {
            currentUser.isFace = YES;
        } else {
            currentUser.isFace = NO;
        }
    }
    
    if ([elementName isEqualToString:@"is_publish"]) {
        if ([currentChars intValue] == 1) {
            currentUser.isPublish = YES;
        } else {
            currentUser.isPublish = NO;
        }
    }
    
    if ([elementName isEqualToString:@"is_me"]) {
        if ([currentChars intValue] == 1) {
            currentUser.isMe = YES;
        } else {
            currentUser.isMe = NO;
        }
    }
    
    if ([elementName isEqualToString:@"name"]) {
        currentUser.name = currentChars;
    }
    
    if ([elementName isEqualToString:@"phone"]) {
        currentUser.phone = currentChars;
    }
    
    if ([elementName isEqualToString:@"email"]) {
        currentUser.email = currentChars;
    }
    
    if ([elementName isEqualToString:@"number_credits"]) {
        currentUser.numberCredits = [currentChars intValue];
    }

    if ([elementName isEqualToString:@"user_level_id"]) {
        currentUser.userLevelId = [currentChars intValue];
    }
    
    if ([elementName isEqualToString:@"user_level_text"]) {
        currentUser.userLevelText = currentChars;
    }
    
    if ([elementName isEqualToString:@"photo"]) {
        currentUser.photo = currentChars;
        currentUser.photoUrl = [NSURL URLWithString:currentChars];
    }
    
    // START FOLLOWING / FOLLOWERS
    
    if ([elementName isEqualToString:@"follow_id"]) {
        currentFollow.dbId = [currentChars intValue];
    }
    
    if ([elementName isEqualToString:@"follow_face_id"]) {
        currentFollow.faceId = currentChars;
    }
    
    if ([elementName isEqualToString:@"follow_name"]) {
        currentFollow.name = currentChars;
    }
    
    if ([elementName isEqualToString:@"follow_user_level_id"]) {
        currentFollow.userLevelId = [currentChars intValue];
    }
    
    if ([elementName isEqualToString:@"follow_user_level_text"]) {
        currentFollow.userLevelText = currentChars;
    }
    
    if ([elementName isEqualToString:@"follow_user_number_f"]) {
        currentFollow.numberF = [currentChars intValue];
    }
    
    if ([elementName isEqualToString:@"follow_user_number_c"]) {
        currentFollow.numberC = [currentChars intValue];
    }
    
    if ([elementName isEqualToString:@"following_user"]) {
        [currentUser.following addObject:currentFollow];
    }
    
    if ([elementName isEqualToString:@"followers_user"]) {
        [currentUser.followers addObject:currentFollow];
    }
    
    // START COMMENTS
    
    if ([elementName isEqualToString:@"comment_user_id"]) {
        currentComment.userId = [currentChars intValue];
    }
    
    if ([elementName isEqualToString:@"comment_facebook_id"]) {
        currentComment.facebookId = currentChars;
    }
    
    if ([elementName isEqualToString:@"comment_useful"]) {
        if (currentChars.intValue == 1)
            currentComment.isUseful = YES;
        else
            currentComment.isUseful = NO;
    }

    if ([elementName isEqualToString:@"comment_useful_text"]) {
        currentComment.usefulText = currentChars;
    }
    
    if ([elementName isEqualToString:@"comment_user_follow"]) {
        if (currentChars.intValue == 1)
            currentComment.isUserFollow = YES;
        else
            currentComment.isUserFollow = NO;
    }
    
    if ([elementName isEqualToString:@"comment_user_name"]) {
        currentComment.userName = currentChars;
    }
    
    if ([elementName isEqualToString:@"comment_user_number_f"]) {
        currentComment.userNumberF = [currentChars intValue];
    }
    
    if ([elementName isEqualToString:@"comment_user_number_c"]) {
        currentComment.userNumberC = [currentChars intValue];
    }
    
    if ([elementName isEqualToString:@"comment_id"]) {
        currentComment.commentId = [currentChars intValue];
    }
    
    if ([elementName isEqualToString:@"comment_rest_id"]) {
        currentComment.restId = [currentChars intValue];
    }
    
    if ([elementName isEqualToString:@"comment_rest_parish"]) {
        currentComment.restParish = currentChars;
    }
    
    if ([elementName isEqualToString:@"comment_rest_phone"]) {
        currentComment.restPhone = currentChars;
    }
    
    if ([elementName isEqualToString:@"comment_order"]) {
        currentComment.order = [currentChars intValue];
    }
    
    if ([elementName isEqualToString:@"comment_rating"]) {
        currentComment.vote = currentChars;
    }
    
    if ([elementName isEqualToString:@"comment_date"]) {
        currentComment.date = currentChars;
    }
    
    if ([elementName isEqualToString:@"comment_rest"]) {
        currentComment.rest = currentChars;
    }
    
    if ([elementName isEqualToString:@"comment_text"]) {
        currentComment.text = currentChars;
    }
    
    if ([elementName isEqualToString:@"comment"]) {
        [currentUser.comments addObject:currentComment];
    }
    
    // START RESTAURANTS: FAVS / BEENS
    
    if ([elementName isEqualToString:@"rest_id"]) {
        currentRest.dbId = [currentChars intValue];
    }
    
    if ([elementName isEqualToString:@"rest_name"]) {
        currentRest.name = currentChars;
    }
    
    if ([elementName isEqualToString:@"rest_extra"]) {
        currentRest.description = currentChars;
    }
    
    if ([elementName isEqualToString:@"rest_fav"]) {
        currentRest.fav = [currentChars intValue];
    }
    
    if ([elementName isEqualToString:@"rest_phone"]) {
        currentRest.phone = [currentChars intValue];
    }

    if ([elementName isEqualToString:@"fav"]) {
        [currentUser.favs addObject:currentRest];
    }
    
    if ([elementName isEqualToString:@"been"]) {
        [currentUser.beens addObject:currentRest];
    }
    
    // START RECENTS
    
    if ([elementName isEqualToString:@"recent_id"]) {
        currentRecent.restId = [currentChars intValue];
    }
    
    if ([elementName isEqualToString:@"recent_name"]) {
        currentRecent.name = currentChars;
    }
    
    if ([elementName isEqualToString:@"recent_date"]) {
        currentRecent.date = currentChars;
    }
    
    if ([elementName isEqualToString:@"recent_type_id"]) {
        currentRecent.typeId = [currentChars intValue];
    }
    
    if ([elementName isEqualToString:@"recent_type_text"]) {
        currentRecent.typeText = currentChars;
    }

    if ([elementName isEqualToString:@"recent_type_image"]) {
        currentRecent.typeImage = currentChars;
        currentRecent.typeImageUrl = [NSURL URLWithString:currentChars];
    }
    
    if ([elementName isEqualToString:@"recent"]) {
        [currentUser.recents addObject:currentRecent];
    }
    
    // FINISH PARSER
    
    if ([elementName isEqualToString:@"user"]) {
        [Globals setUser:currentUser];
    }
}
@end

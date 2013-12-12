//
//  RestaurantParser.h
//  City Chef
//
//  Created by Helder Pereira on 7/18/13.
//  Copyright (c) 2013 Tecnoled. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Restaurant.h"

@interface RestaurantParser : NSObject <NSXMLParserDelegate>

- (id)initXMLParser;

@end

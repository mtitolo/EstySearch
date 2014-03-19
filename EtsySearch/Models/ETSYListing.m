//
//  ETSYListing.m
//  EtsySearch
//
//  Created by Michele Titolo on 3/19/14.
//  Copyright (c) 2014 Michele Titolo. All rights reserved.
//

#import "ETSYListing.h"

@implementation ETSYListing

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [self init];
    
    if (self) {
        self.listingName = [dictionary objectForKey:@"title"];
        self.mainImage = [[dictionary objectForKey:@"MainImage"] objectForKey:@"url_570xN"];
    }
    
    return self;
}

@end

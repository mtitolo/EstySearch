//
//  ETSYPaginationInfo.m
//  EtsySearch
//
//  Created by Michele Titolo on 3/19/14.
//  Copyright (c) 2014 Michele Titolo. All rights reserved.
//

#import "ETSYPaginationInfo.h"

@implementation ETSYPaginationInfo

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [self init];
    
    if (self) {
        self.currentPage = [[dictionary objectForKey:@"effective_page"] integerValue];
        self.currentOffset = [[dictionary objectForKey:@"effective_offest"] integerValue];
        
        if (![[dictionary objectForKey:@"next_page"] isEqual:[NSNull null]]) {
            self.nextPage = [[dictionary objectForKey:@"next_page"] integerValue];
        }
        
        if (![[dictionary objectForKey:@"next_offset"] isEqual:[NSNull null]]) {
            self.nextOffset = [[dictionary objectForKey:@"next_offset"] integerValue];
        }
        
        
        self.pageSize = [[dictionary objectForKey:@"effective_limit"] integerValue];
    }
    
    return self;
}

@end

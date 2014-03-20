//
//  EtsyPaginationInfoTests.m
//  EtsySearch
//
//  Created by Michele Titolo on 3/20/14.
//  Copyright (c) 2014 Michele Titolo. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "ETSYPaginationInfo.h"

SPEC_BEGIN(EtsyPaginationInfo)

describe(@"ETSYPaginationInfo", ^{
    
    it(@"can be initialized with a dictionary", ^{
        ETSYPaginationInfo* pagination = [[ETSYPaginationInfo alloc] initWithDictionary:@{@"effective_limit": @25,
                                                                                          @"effective_offset": @25,
                                                                                          @"next_offset": @50,
                                                                                          @"effective_page": @2,
                                                                                          @"next_page": @3}];
        
        [[theValue(pagination.pageSize) should] equal:theValue(25)];
        [[theValue(pagination.currentOffset) should] equal:theValue(25)];
        [[theValue(pagination.currentPage) should] equal:theValue(2)];
        [[theValue(pagination.nextOffset) should] equal:theValue(50)];
        [[theValue(pagination.nextPage) should] equal:theValue(3)];
        
    });
    
    it(@"can handle null values for next offset and page", ^{
        ETSYPaginationInfo* pagination = [[ETSYPaginationInfo alloc] initWithDictionary:@{@"effective_limit": @25,
                                                                                          @"effective_offset": @25,
                                                                                          @"next_offset": [NSNull null],
                                                                                          @"effective_page": @2,
                                                                                          @"next_page": [NSNull null]}];
        [[theValue(pagination.pageSize) should] equal:theValue(25)];
        [[theValue(pagination.currentOffset) should] equal:theValue(25)];
        [[theValue(pagination.currentPage) should] equal:theValue(2)];
        [[theValue(pagination.nextOffset) should] equal:theValue(0)];
        [[theValue(pagination.nextPage) should] equal:theValue(0)];
    });
    
});

SPEC_END

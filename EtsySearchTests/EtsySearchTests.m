//
//  EtsySearchTests.m
//  EtsySearchTests
//
//  Created by Michele Titolo on 3/19/14.
//  Copyright (c) 2014 Michele Titolo. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "ETSYSearchController.h"
#import "ETSYPaginationInfo.h"

// So we can test with this info
@interface ETSYSearchController (Test)

@property (nonatomic, copy) NSString* searchTerm;
@property (nonatomic, strong) ETSYPaginationInfo* pagination;

@end

SPEC_BEGIN(SearchControllerSpec)

describe(@"ETSYSearchController", ^{
   
    __block ETSYSearchController* searchController = nil;
    
    beforeAll(^{
        searchController = [[ETSYSearchController alloc] init];
    });
    
    it(@"can search for a keyword", ^{
        __block NSArray* results = nil;
        
        [searchController searchWithTerm:@"polka dot shirt" completion:^(NSArray *items, NSError *error) {
            if (!error) {
                results = items;
            }
        }];
        
        [[results shouldEventually] beNonNil];
    });
    
    context(@"a search has already occured", ^{
        let(pagination, ^id{
            ETSYPaginationInfo* info = [[ETSYPaginationInfo alloc] initWithDictionary:@{@"effective_limit": @25,
                                                                                        @"effective_offset": @25,
                                                                                        @"next_offset": @50,
                                                                                        @"effective_page": @2,
                                                                                        @"next_page": @3}];
            return info;
        });
        
        beforeEach(^{
            searchController.pagination = pagination;
            searchController.searchTerm = @"polka dot shirt";
        });
        
        it(@"can load the next page", ^{
            [searchController loadNextPageOfCurrentSearchWithCompletion:nil];
            [[theValue(searchController.pagination.currentPage) shouldEventually] beGreaterThan:theValue(2)];
        });
        
        it(@"clears the search term", ^{
            [searchController clearSearch];
            
            [[searchController.pagination should] beNil];
            [[searchController.searchTerm should] beNil];
        });
    });
});

SPEC_END
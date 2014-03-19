//
//  ETSYSearchController.h
//  EtsySearch
//
//  Created by Michele Titolo on 3/19/14.
//  Copyright (c) 2014 Michele Titolo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ETSYSearchController : NSObject

/**
 *  This will clear the current search term and pagination information.
 */
- (void)clearSearch;

/**
 *  Starts a new search. Will clear the current state.
 *
 *  @param searchTerm The term to search for
 *  @param completion A completion block to be executed when the request completes
 */
- (void)searchWithTerm:(NSString*)searchTerm completion:(void(^)(NSArray* items, NSError* error))completion;

/**
 *  Uses the current search term and pagination information to load the next page
 *
 *  @param completion A completion block to be executed when the request completes
 */
- (void)loadNextPageOfCurrentSearchWithCompletion:(void(^)(NSArray* items, NSError* error))completion;

@end

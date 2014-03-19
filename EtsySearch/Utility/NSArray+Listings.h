//
//  NSArray+Listings.h
//  EtsySearch
//
//  Created by Michele Titolo on 3/19/14.
//  Copyright (c) 2014 Michele Titolo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Listings)

/**
 *  Given an array parsed from JSON of Listing objects, returns 
 *  an array of ETSYListings.
 *
 *  @return A new array of ETSYListing objects.
 */
- (NSArray*)arrayOfListingsFromJSON;

@end

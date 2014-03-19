//
//  NSArray+Listings.m
//  EtsySearch
//
//  Created by Michele Titolo on 3/19/14.
//  Copyright (c) 2014 Michele Titolo. All rights reserved.
//

#import "NSArray+Listings.h"
#import "ETSYListing.h"

@implementation NSArray (Listings)

- (NSArray*)arrayOfListingsFromJSON
{
    NSMutableArray* listings = [NSMutableArray arrayWithCapacity:self.count];
    
    for (NSDictionary* listingJSON in self) {
        ETSYListing* newListing = [[ETSYListing alloc] initWithDictionary:listingJSON];
        [listings addObject:newListing];
    }
    
    return listings;
}

@end

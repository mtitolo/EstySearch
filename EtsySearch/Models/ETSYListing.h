//
//  ETSYListing.h
//  EtsySearch
//
//  Created by Michele Titolo on 3/19/14.
//  Copyright (c) 2014 Michele Titolo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ETSYListing : NSObject

@property (nonatomic, copy) NSString* listingName;
@property (nonatomic, copy) NSString* mainImage;

- (instancetype)initWithDictionary:(NSDictionary*)dictionary;

@end

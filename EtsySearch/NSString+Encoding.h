//
//  NSString+Encoding.h
//  EtsySearch
//
//  Created by Michele Titolo on 3/20/14.
//  Copyright (c) 2014 Michele Titolo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Encoding)

/**
 *  Returns a new string with percent encoding, to be used in URLs
 *
 *  @return The new string
 */
- (NSString*)percentEncodedString;

@end

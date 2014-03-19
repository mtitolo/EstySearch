//
//  ETSYPaginationInfo.h
//  EtsySearch
//
//  Created by Michele Titolo on 3/19/14.
//  Copyright (c) 2014 Michele Titolo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ETSYPaginationInfo : NSObject

@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, assign) NSInteger currentOffset;
@property (nonatomic, assign) NSInteger nextPage;
@property (nonatomic, assign) NSInteger nextOffset;

@property (nonatomic, assign) NSInteger pageSize;

- (instancetype)initWithDictionary:(NSDictionary*)dictionary;

@end

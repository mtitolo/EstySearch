//
//  MRTListingCell.h
//  EtsySearch
//
//  Created by Michele Titolo on 3/19/14.
//  Copyright (c) 2014 Michele Titolo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ETSYListing;

@interface MRTListingCell : UICollectionViewCell

- (void)setupWithListing:(ETSYListing*)listing;

@end

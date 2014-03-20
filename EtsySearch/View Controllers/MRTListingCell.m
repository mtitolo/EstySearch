//
//  MRTListingCell.m
//  EtsySearch
//
//  Created by Michele Titolo on 3/19/14.
//  Copyright (c) 2014 Michele Titolo. All rights reserved.
//

#import "MRTListingCell.h"
#import "ETSYListing.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface MRTListingCell ()

@property (nonatomic, strong) ETSYListing* listing;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end

@implementation MRTListingCell


- (void)setupWithListing:(ETSYListing *)listing
{
    [self.imageView setImageWithURL:[NSURL URLWithString:listing.mainImage]];
    self.nameLabel.text = listing.listingName;
}

- (void)prepareForReuse
{
    [self.imageView cancelCurrentImageLoad];
    self.nameLabel.text = nil;
}

@end

//
//  MRTViewController.m
//  EtsySearch
//
//  Created by Michele Titolo on 3/19/14.
//  Copyright (c) 2014 Michele Titolo. All rights reserved.
//

#import "MRTViewController.h"
#import "ETSYSearchController.h"
#import "ETSYListing.h"
#import "MRTListingCell.h"

@interface MRTViewController ()

@property (nonatomic, assign, getter = isLoadingMore) BOOL loadingMore;

@property (nonatomic, strong) ETSYSearchController* searchController;
@property (nonatomic, strong) NSArray* listings;

@end

@implementation MRTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.searchController = [[ETSYSearchController alloc] init];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.listings.count;
}

- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MRTListingCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ListingCell" forIndexPath:indexPath];
    
    [cell setupWithListing:self.listings[indexPath.row]];
    
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y > scrollView.contentSize.height - 600 && !self.isLoadingMore) {
        self.loadingMore = YES;
        [self.searchController loadNextPageOfCurrentSearchWithCompletion:^(NSArray *items, NSError *error) {
            self.loadingMore = NO;
            self.listings = [self.listings arrayByAddingObjectsFromArray:items];
            [self.collectionView reloadData];
        }];
    }
}

#pragma mark - UISearchBarDelegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    [self.searchController searchWithTerm:searchBar.text completion:^(NSArray *items, NSError *error) {
        self.listings = items;
        [self.collectionView reloadData];
    }];
}

@end

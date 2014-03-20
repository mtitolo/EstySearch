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

NS_ENUM(NSInteger, ListingCollectionViewSectionType){
    ListingCollectionViewSectionItems = 0,
    ListingCollectionViewSectionAccessory,
    ListingCollectionViewSectionCount
};

@interface MRTViewController ()

@property (nonatomic, assign, getter = isLoading) BOOL loading;

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
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return ListingCollectionViewSectionCount;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == ListingCollectionViewSectionAccessory) {
        return 0;
    }
    
    return self.listings.count;
}

- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MRTListingCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ListingCell" forIndexPath:indexPath];
    
    [cell setupWithListing:self.listings[indexPath.row]];
    
    return cell;
}

- (UICollectionReusableView*)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    return [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"LoadingView" forIndexPath:indexPath];
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    CGSize footerSize = CGSizeZero;
    
    if (self.isLoading && section == ListingCollectionViewSectionAccessory) {
        footerSize = CGSizeMake(310, 44);
    }
    
    return footerSize;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y > scrollView.contentSize.height - 600 && !self.isLoading) {
        self.loading = YES;
        [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:ListingCollectionViewSectionAccessory]];
        [self.searchController loadNextPageOfCurrentSearchWithCompletion:^(NSArray *items, NSError *error) {
            self.loading = NO;
            self.listings = [self.listings arrayByAddingObjectsFromArray:items];
            [self.collectionView reloadData];
        }];
    }
}

#pragma mark - UISearchBarDelegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];

    self.loading = YES;
    [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:ListingCollectionViewSectionAccessory]];
    [self.searchController searchWithTerm:searchBar.text completion:^(NSArray *items, NSError *error) {
        self.loading = NO;
        self.listings = items;
        [self.collectionView reloadData];
    }];
}

@end

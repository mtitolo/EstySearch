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

NS_ENUM(NSInteger, CollectionViewResultsState){
    CollectionViewResultsNoSearch,
    CollectionViewResultsLoading,
    CollectionViewResultsNormal,
    CollectionViewResultsNone,
    CollectionViewResultsAllShowing
};

@interface MRTViewController ()

@property (nonatomic, assign, getter = isLoading) BOOL loading;
@property (nonatomic, assign) NSInteger currentState;

@property (nonatomic, strong) ETSYSearchController* searchController;
@property (nonatomic, strong) NSArray* listings;

@end

@implementation MRTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.searchController = [[ETSYSearchController alloc] init];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"NoResultsView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"NoResultsView"];
    [self.collectionView registerNib:[UINib nibWithNibName:@"EmptyView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"EmptyView"];
    [self.collectionView registerNib:[UINib nibWithNibName:@"NoMoreResultsView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"NoMoreResultsView"];
    
    self.currentState = CollectionViewResultsNoSearch;
    [self.collectionView reloadData];
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
    UICollectionReusableView* view = nil;
    
    switch (self.currentState) {
        case CollectionViewResultsNoSearch:
            view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"EmptyView" forIndexPath:indexPath];
            break;
        case CollectionViewResultsLoading:
            view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"LoadingView" forIndexPath:indexPath];
            break;
        case CollectionViewResultsNone:
            view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"NoResultsView" forIndexPath:indexPath];
            break;
        case CollectionViewResultsAllShowing:
            view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"NoMoreResultsView" forIndexPath:indexPath];
            break;
        default:
            break;
    }
    
    return view;
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    CGSize footerSize = CGSizeZero;
    
    if (self.currentState != CollectionViewResultsNormal && section == ListingCollectionViewSectionAccessory) {
        footerSize = CGSizeMake(310, 44);
    }
    
    return footerSize;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y > scrollView.contentSize.height - 600 && self.currentState == CollectionViewResultsNormal) {
        self.currentState = CollectionViewResultsLoading;
        [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:ListingCollectionViewSectionAccessory]];
        [self.searchController loadNextPageOfCurrentSearchWithCompletion:^(NSArray *items, NSError *error) {
            
            if (!error) {
                if (items) {
                    self.currentState = CollectionViewResultsNormal;
                    self.listings = [self.listings arrayByAddingObjectsFromArray:items];
                }
                
                [self.collectionView reloadData];
            }
            
        }];
    }
}

#pragma mark - UISearchBarDelegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    
    self.currentState = CollectionViewResultsLoading;
    self.listings = nil;
    [self.collectionView reloadData];

    [self.searchController searchWithTerm:searchBar.text completion:^(NSArray *items, NSError *error) {
        if (!error) {
            self.currentState = CollectionViewResultsNormal;
            self.listings = items;
            [self.collectionView reloadData];
        }
        
    }];
}

@end

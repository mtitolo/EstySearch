//
//  ETSYSearchController.m
//  EtsySearch
//
//  Created by Michele Titolo on 3/19/14.
//  Copyright (c) 2014 Michele Titolo. All rights reserved.
//

#import "ETSYSearchController.h"
#import "ETSYPaginationInfo.h"
#import "ETSYListing.h"
#import "NSArray+Listings.h"

#define kAPIBaseString @"https://api.etsy.com/v2/listings/active?api_key=liwecjs0c3ssk6let4p1wqt9&includes=MainImage&"

@interface ETSYSearchController ()

@property (nonatomic, copy) NSString* searchTerm;
@property (nonatomic, strong) ETSYPaginationInfo* pagination;

@end

@implementation ETSYSearchController

- (void)clearSearch
{
    self.searchTerm = nil;
    self.pagination = nil;
}

- (void)searchWithTerm:(NSString *)searchTerm completion:(void (^)(NSArray *, NSError *))completion
{
    [self clearSearch];
    self.searchTerm = searchTerm;
    
    [self makeSearchRequestWithCompletion:completion];
}

- (void)loadNextPageOfCurrentSearchWithCompletion:(void (^)(NSArray *, NSError *))completion
{
    [self makeSearchRequestWithCompletion:completion];
}

- (void)makeSearchRequestWithCompletion:(void (^)(NSArray *, NSError *))completion
{
    NSURLRequest* request = [self requestForCurrentSearchTerm];
    
    NSURLSessionDataTask* task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (!error) {
            [self processResponse:data withCompletion:completion];
        }
        else {
            completion(nil, error);
        }
    }];
    
    [task resume];
}

- (BOOL)canLoadNextPage
{
    return (self.pagination.currentPage < self.pagination.nextPage);
}

#pragma mark - Private

- (NSURL*)searchURLForTerm:(NSString*)searchTerm
{
    NSString *encodedString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(
                                                                                  NULL,
                                                                                  (CFStringRef)searchTerm,
                                                                                  NULL,
                                                                                  (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                                  kCFStringEncodingUTF8 ));
    
    NSString* baseString = [NSString stringWithFormat:@"%@keywords=%@", kAPIBaseString, encodedString];
    
    if (self.pagination) {
        baseString = [baseString stringByAppendingString:[NSString stringWithFormat:@"&page=%d", self.pagination.nextPage]];
    }
    
    return [NSURL URLWithString:baseString];
}

- (NSURLRequest*)requestForCurrentSearchTerm
{
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:[self searchURLForTerm:self.searchTerm]];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    return request;
}

- (void)processResponse:(NSData*)responseData withCompletion:(void (^)(NSArray *, NSError *))completion
{
    NSError* error = nil;
    NSDictionary* responseDict = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:&error];
    
    if (responseDict) {
        self.pagination = [[ETSYPaginationInfo alloc] initWithDictionary:[responseDict objectForKey:@"pagination"]];
        NSArray* listings = [[responseDict objectForKey:@"results"] arrayOfListingsFromJSON];
        completion(listings, nil);
    }
    else {
        completion(nil, error);
    }
}

@end

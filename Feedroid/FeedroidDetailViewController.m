//
//  FeedroidDetailViewController.m
//  Feedroid
//
//  Created by Thanos Polymeneas on 31/03/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FeedroidDetailViewController.h"

@interface FeedroidDetailViewController ()
@property (strong, nonatomic) UIPopoverController *masterPopoverController;
- (void)configureView;
@end

@implementation FeedroidDetailViewController

@synthesize detailItem = _detailItem;
@synthesize feedTitle = _feedTitle;
@synthesize feedImage = _feedImage;
@synthesize masterPopoverController = _masterPopoverController;

- (void)dealloc
{
    [_detailItem release];
    [_masterPopoverController release];
    [super dealloc];
}

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        [_detailItem release];
        _detailItem = [newDetailItem retain];

        // Update the view.
        [self configureView];
    }

    if (self.masterPopoverController != nil) {
        [self.masterPopoverController dismissPopoverAnimated:YES];
    }        
}

- (NSString *)getImageURL:(NSString *)htmlCode
{
    NSString *imageURL = NULL;
    
    NSRange start = [htmlCode rangeOfString:@"src=\""];
    
    //check range exists
    if (start.location != NSNotFound) {
        NSString *strippedCode = [htmlCode substringFromIndex:start.location + start.length];
        NSRange end = [strippedCode rangeOfString:@"\""];
        if (end.location != NSNotFound) {
            imageURL = [strippedCode substringToIndex:end.location];
        }
    }

    return imageURL;
}

- (void)configureView
{
    // Update the user interface for the detail item.
    
    if (self.detailItem) {
        NSString *title = [self.detailItem valueForKey:@"title"];
        NSString *bodyText = [[self.detailItem valueForKey:@"body"] description];
        NSString *imageUrl = [self getImageURL: bodyText];
        
        self.feedTitle.title = title;
        
        NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: imageUrl]];
        self.feedImage.image = [UIImage imageWithData: imageData];

    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    self.feedTitle.title = @"Choose a comic";
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

#pragma mark - Split view

- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{
    barButtonItem.title = @"Choose";
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
    self.masterPopoverController = popoverController;
}

- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    // Called when the view is shown again in the split view, invalidating the button and popover controller.
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.masterPopoverController = nil;
}

@end

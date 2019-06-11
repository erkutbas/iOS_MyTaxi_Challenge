//
//  ListDataViewController.m
//  iOS_MyTaxi_Challenge
//
//  Created by Erkut Baş on 6/11/19.
//  Copyright © 2019 Erkut Baş. All rights reserved.
//

#import "ListDataViewController.h"
#import "ListDataTableViewCell.h"
#import "QuartzCore/CALayer.h"

@interface ListDataViewController ()

@end

@implementation ListDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.listDataTableView.delegate = self;
    self.listDataTableView.dataSource = self;
    
    self.title = @"Taxi List Screen";
    
    [self changeHeaderImageViewLayerConfigurations];
    [self changeNavigationControllerConfigurations];
}

- (void) changeHeaderImageViewLayerConfigurations {
    self.imageContainerView.layer.cornerRadius = 80;
    self.imageContainerView.layer.maskedCorners = kCALayerMinXMaxYCorner;
    
    [self.imageContainerView.layer setShadowColor:[UIColor whiteColor].CGColor];
    [self.imageContainerView.layer setShadowOpacity:0.8];
    [self.imageContainerView.layer setShadowRadius:5.0];
    [self.imageContainerView.layer setShadowOffset:CGSizeMake(2.0, 2.0)];
    
    self.headerImageView.layer.cornerRadius = 80;
    self.headerImageView.layer.maskedCorners = kCALayerMinXMaxYCorner;
    self.headerImageView.clipsToBounds = true;
    
    
    
}

- (void) changeNavigationControllerConfigurations {
 
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
//    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [self.navigationController.navigationBar setTranslucent:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    ListDataTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ListDataCell" forIndexPath:indexPath];

    return cell;

}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
}

@end

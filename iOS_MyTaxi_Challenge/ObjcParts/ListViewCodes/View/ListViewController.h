//
//  ListViewController.h
//  iOS_MyTaxi_Challenge
//
//  Created by Erkut Baş on 6/10/19.
//  Copyright © 2019 Erkut Baş. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ListViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *listTableView;

@end

NS_ASSUME_NONNULL_END

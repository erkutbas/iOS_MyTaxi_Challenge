//
//  ListDataTableViewCell.m
//  iOS_MyTaxi_Challenge
//
//  Created by Erkut Baş on 6/11/19.
//  Copyright © 2019 Erkut Baş. All rights reserved.
//

#import "ListDataTableViewCell.h"

@implementation ListDataTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self cellViewConfiguration];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) cellViewConfiguration {
    self.cellContainerView.layer.cornerRadius = 10;
    //self.cellContainerView.layer.maskedCorners = kCALayerMinXMaxYCorner;
    
    [self.cellContainerView.layer setShadowColor:[UIColor whiteColor].CGColor];
    [self.cellContainerView.layer setShadowOpacity:0.8];
    [self.cellContainerView.layer setShadowRadius:4.0];
    //[self.cellContainerView.layer setShadowOffset:CGSizeMake(2.0, 2.0)];
}

@end

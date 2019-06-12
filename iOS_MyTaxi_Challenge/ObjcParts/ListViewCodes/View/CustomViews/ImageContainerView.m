//
//  ImageContainerView.m
//  iOS_MyTaxi_Challenge
//
//  Created by Erkut Baş on 6/11/19.
//  Copyright © 2019 Erkut Baş. All rights reserved.
//

#import "ImageContainerView.h"
#import "Constants.h"

@implementation ImageContainerView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    printf("ImageContainerView initiates");
    [self prepareViewConfigurations];
    
    return self;
}

- (void) prepareViewConfigurations {
    [self addHeaderView];
    [self addScreenTitleLabel];
    [self addBlurView];
    [self changeCornerRadius];
}

- (void) addHeaderView {
    
    _headerImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    _headerImageView.translatesAutoresizingMaskIntoConstraints = false;
    _headerImageView.clipsToBounds = true;
    _headerImageView.contentMode = UIViewContentModeScaleAspectFill;
    [_headerImageView setImage:[UIImage imageNamed:@"taxiSample.jpg"]];
    [self addSubview:_headerImageView];
    
    [NSLayoutConstraint activateConstraints:@[ [_headerImageView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor],
                                               [_headerImageView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor],
                                               [_headerImageView.topAnchor constraintEqualToAnchor:self.topAnchor],
                                               [_headerImageView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor],
                                              
                                              ]
     ];
    
}

- (void) addBlurView {
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    _blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    _blurEffectView.translatesAutoresizingMaskIntoConstraints = false;
    _blurEffectView.alpha = 0;
    
    //[_headerImageView addSubview:_blurEffectView];
    [_headerImageView insertSubview:_blurEffectView atIndex:0];
    
    [NSLayoutConstraint activateConstraints:@[[_blurEffectView.leadingAnchor constraintEqualToAnchor:_headerImageView.leadingAnchor],
                                              [_blurEffectView.trailingAnchor constraintEqualToAnchor:_headerImageView.trailingAnchor],
                                              [_blurEffectView.topAnchor constraintEqualToAnchor:_headerImageView.topAnchor constant:-UIApplication.sharedApplication.statusBarFrame.size.height],
                                              [_blurEffectView.bottomAnchor constraintEqualToAnchor:_headerImageView.bottomAnchor],
                                              ]
     ];
}

- (void) blurViewActivationManager:(BOOL *)value {
    [UIView animateWithDuration:0.3 animations:^(void) {
        if (value) {
            self.blurEffectView.alpha = 1;
        } else {
            self.blurEffectView.alpha = 0;
        }
    }];
}

- (void) addScreenTitleLabel {
    _mainScreenTitle = [[UILabel alloc] initWithFrame:CGRectZero];
    _mainScreenTitle.translatesAutoresizingMaskIntoConstraints = false;
    _mainScreenTitle.text = @"Vehicle List Screen";
    _mainScreenTitle.alpha = 0;
    [_mainScreenTitle setFont:[UIFont fontWithName:@"Avenier-Heavy" size:25]];
    [_mainScreenTitle setTextColor:UIColor.whiteColor];
    [_headerImageView addSubview:_mainScreenTitle];
    
    _detailScreenTitle = [[UILabel alloc] initWithFrame:CGRectZero];
    _detailScreenTitle.translatesAutoresizingMaskIntoConstraints = false;
    _detailScreenTitle.text = @"Vehicle List Screen";
    _detailScreenTitle.alpha = 0;
    [_detailScreenTitle setFont:[UIFont fontWithName:@"Avenier-Light" size:18]];
    [_detailScreenTitle setTextColor:UIColor.whiteColor];
    [_headerImageView addSubview:_detailScreenTitle];
    
    [NSLayoutConstraint activateConstraints:@[[_mainScreenTitle.centerXAnchor constraintEqualToAnchor:_headerImageView.centerXAnchor],
                                              [_mainScreenTitle.bottomAnchor constraintEqualToAnchor:_headerImageView.bottomAnchor constant:-30],
                                              [_detailScreenTitle.centerXAnchor constraintEqualToAnchor:_headerImageView.centerXAnchor],
     [_detailScreenTitle.bottomAnchor constraintEqualToAnchor:_headerImageView.bottomAnchor constant:-10],
                                              ]
     ];
}

- (void) screenTitleActivationManager:(BOOL *)value {
    [UIView animateWithDuration:0.3 animations:^(void) {
        if (value) {
            self.mainScreenTitle.alpha = 1;
            self.detailScreenTitle.alpha = 1;
        } else {
            self.mainScreenTitle.alpha = 0;
            self.detailScreenTitle.alpha = 0;
        }
    }];
}

- (void) changeCornerRadius {
    _headerImageView.layer.cornerRadius = cornerRadius_20;
    _headerImageView.layer.maskedCorners = kCALayerMinXMaxYCorner | kCALayerMaxXMaxYCorner;
    
}

- (void)setHeaderImageView:(UIImageView *)headerImageView {
    [_headerImageView setImage:headerImageView];
}

- (void)setTitlePrompts:(CountryInformaton *)data {
    [_mainScreenTitle setText:data.countryTitle];
    [_detailScreenTitle setText:data.cityTitle];
}

@end

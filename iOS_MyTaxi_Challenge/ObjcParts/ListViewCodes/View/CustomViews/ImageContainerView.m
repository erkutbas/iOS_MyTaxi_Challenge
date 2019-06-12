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
    _screenTitle = [[UILabel alloc] initWithFrame:CGRectZero];
    _screenTitle.translatesAutoresizingMaskIntoConstraints = false;
    _screenTitle.text = @"Vehicle List Screen";
    _screenTitle.alpha = 0;
    [_screenTitle setFont:[UIFont fontWithName:@"Avenier-Medium" size:20]];
    [_screenTitle setTextColor:UIColor.whiteColor];
    [_headerImageView addSubview:_screenTitle];
    
    [NSLayoutConstraint activateConstraints:@[[_screenTitle.centerXAnchor constraintEqualToAnchor:_headerImageView.centerXAnchor],
                                              [_screenTitle.bottomAnchor constraintEqualToAnchor:_headerImageView.bottomAnchor constant:-20],
                                              ]
     ];
}

- (void) screenTitleActivationManager:(BOOL *)value {
    [UIView animateWithDuration:0.3 animations:^(void) {
        if (value) {
            self.screenTitle.alpha = 1;
        } else {
            self.screenTitle.alpha = 0;
        }
    }];
}

- (void) changeCornerRadius {
    _headerImageView.layer.cornerRadius = cornerRadius_20;
    _headerImageView.layer.maskedCorners = kCALayerMinXMaxYCorner | kCALayerMaxXMaxYCorner;
    
}

@end

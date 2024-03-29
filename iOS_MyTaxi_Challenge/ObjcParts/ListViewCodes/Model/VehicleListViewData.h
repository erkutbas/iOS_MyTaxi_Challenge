//
//  VehicleListViewData.h
//  iOS_MyTaxi_Challenge
//
//  Created by Erkut Baş on 6/12/19.
//  Copyright © 2019 Erkut Baş. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VehicleInformation.h"
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface VehicleListViewData : NSObject

@property (nonatomic, copy, readonly) NSMutableArray<VehicleInformation *> *vehicleArray;
@property (nonatomic, copy, readonly) UIImage *topImage;

- (instancetype)initWithArrayData:(NSMutableArray<VehicleInformation *> *)arrayData topImage:(UIImage *)inputImage;

@end

NS_ASSUME_NONNULL_END


/*
 
 var id: Int
 var location: CLLocation
 var state: VehicleState
 var type: VehicleType
 var heading: CGFloat
 
 
 
 */

//
//  ListDataViewModel.h
//  iOS_MyTaxi_Challenge
//
//  Created by Erkut Baş on 6/12/19.
//  Copyright © 2019 Erkut Baş. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VehicleListViewData.h"

NS_ASSUME_NONNULL_BEGIN

@interface ListDataViewModel : NSObject

@property (nonatomic, copy, readonly) NSMutableArray<VehicleInformation *> *vehicleArray;

- (instancetype)initWithArrayData:(NSMutableArray<VehicleInformation *> *)arrayData;

- (NSString *) activationTitle:(NSUInteger)index;
- (NSString *) idValue:(NSUInteger)index;
- (NSUInteger*) numberOfVehicle;
- (VehicleInformation *) returnVehicleInformationData:(NSUInteger)index;

@end

NS_ASSUME_NONNULL_END

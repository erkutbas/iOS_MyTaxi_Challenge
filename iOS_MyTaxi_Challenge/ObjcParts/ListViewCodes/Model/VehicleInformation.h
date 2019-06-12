//
//  VehicleInformation.h
//  iOS_MyTaxi_Challenge
//
//  Created by Erkut Baş on 6/12/19.
//  Copyright © 2019 Erkut Baş. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface VehicleInformation : NSObject

@property (nonatomic, copy, readonly) NSString *vehicleID;
@property (nonatomic, copy, readonly) NSString *vehicleState;

- (instancetype)initWithID:(NSString *)vehicleID state:(NSString *)vehicleState;

@end

NS_ASSUME_NONNULL_END

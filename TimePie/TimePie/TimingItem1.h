//
//  TimingItem.h
//  TimePie
//
//  Created by Storm Max on 4/16/14.
//  Copyright (c) 2014 TimePieOrg. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TimingItem : NSObject


+ (id)randomItem;
- (id)initWithItemName:(NSString *)name;
- (NSDate*) check:(BOOL)add;


@property (nonatomic) int itemID;
@property (nonatomic, strong) NSString * itemName;
@property (nonatomic, strong) NSDate * dateCreated;
@property (nonatomic) double time;
@property (nonatomic, strong) UIColor * color;
@property (nonatomic, strong) UIColor * lightColor;
@property (nonatomic, strong) NSDate* lastCheck;
@property (nonatomic) BOOL active;



@end

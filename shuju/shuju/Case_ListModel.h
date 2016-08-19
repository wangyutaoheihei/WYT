//
//  Case_ListModel.h
//  CactusHomeFurnish
//
//  Created by zhuxunyi on 16/4/9.
//  Copyright © 2016年 muyou. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface Case_ListModel : NSObject
@property(nonatomic,copy)NSString *iId;
@property(nonatomic,copy)NSString *mid;
@property(nonatomic,copy)NSString *memtype;
@property(nonatomic,copy)NSString *pic;
@property(nonatomic,copy)NSString *userpic;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *hx;
@property(nonatomic,copy)NSString *mj;
@property(nonatomic,copy)NSString *price;
@property(nonatomic,copy)NSString *package;
@property (nonatomic, assign) int ifcollect;

@end

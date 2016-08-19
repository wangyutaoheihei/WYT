//
//  CaseListTableViewCell.h
//  CactusHomeFurnish
//
//  Created by zhuxunyi on 16/4/9.
//  Copyright © 2016年 muyou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Case_ListModel.h"


@protocol CellColletBtnActionDelegate <NSObject>

- (void)cellColletBtnActionDelegate:(UIButton *)sender cid:(NSInteger)cid cell:(id)cell isCollection:(BOOL)isCollection ;

@end

@interface CaseListTableViewCell : UITableViewCell
@property (nonatomic, assign) id<CellColletBtnActionDelegate> delegate;
@property (nonatomic, strong) UIView *background;
@property(nonatomic,strong)UIImageView *imgView;
@property(nonatomic,strong)UIImageView *logoView;
@property(nonatomic,strong)UILabel *comboLab;//套餐
@property(nonatomic,strong)UILabel *styleLab;
@property(nonatomic,strong)UILabel *otherLab;
@property(nonatomic,strong)UIButton *colletBtn;
@property (nonatomic, strong) UIView *space;
@property (nonatomic, assign) NSInteger cid;// 案例ID
@property (nonatomic, assign) BOOL isCollection;
@property (nonatomic, strong) Case_ListModel *model;



@end

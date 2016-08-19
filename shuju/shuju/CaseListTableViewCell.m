//
//  CaseListTableViewCell.m
//  CactusHomeFurnish
//
//  Created by zhuxunyi on 16/4/9.
//  Copyright © 2016年 muyou. All rights reserved.
//

#import "CaseListTableViewCell.h"
#import "UIView+SDAutoLayout.h"
#import "UIImageView+WebCache.h"

#define Height  CGRectGetHeight([UIScreen mainScreen].bounds)
#define Width   CGRectGetWidth([UIScreen mainScreen].bounds)
#define Color   [UIColor colorWithRed:155 / 255.0 green:210 / 255.0 blue:105 / 255.0 alpha:1.0]
@implementation CaseListTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _imgView = [[UIImageView alloc]init];
        [_imgView setImage:[UIImage imageNamed:@"414x220"]];
        [self.contentView addSubview:_imgView];
        self.imgView.sd_layout.leftSpaceToView(self.contentView,0).rightSpaceToView(self.contentView,0).topSpaceToView(self.contentView,0).heightIs(220);
        
        
        self.background = [[UIView alloc]init];
        self.background.backgroundColor = [UIColor whiteColor];
        [self.imgView addSubview:self.background];
        self.background.sd_layout.leftSpaceToView(self.imgView,10).topSpaceToView(self.imgView,10).heightIs((120.0 /750.0) * Width).widthIs((120.0 /750.0) * Width);
        self.background.layer.masksToBounds = YES;
        self.background.layer.cornerRadius = self.background.bounds.size.height / 2;
        self.background.layer.borderColor = [UIColor colorWithRed:242.0/255.0 green:242.0/255.0 blue:242.0/255.0 alpha:1.0].CGColor;
        self.background.layer.borderWidth = 2;
        
        
        _logoView = [[UIImageView alloc]init];
        [self.background addSubview:_logoView];
        self.logoView.sd_layout.centerXEqualToView(self.background).centerYEqualToView(self.background).heightIs((120.0 /750.0) * Width).widthIs((120.0 /750.0) * Width);
        
        _comboLab = [[UILabel alloc]init];
        _comboLab.layer.cornerRadius = 10;
        _comboLab.backgroundColor = Color;
        _comboLab.textColor = [UIColor whiteColor];
        _comboLab.clipsToBounds = YES;
        _comboLab.font = [UIFont systemFontOfSize:12];
        _comboLab.text = @"加载中...";
        [self.imgView addSubview:_comboLab];
        self.comboLab.sd_layout.rightSpaceToView(self.imgView,-10).bottomSpaceToView(self.imgView,10).heightIs(20).widthIs((150.0 / 750.0) * Width);
        //
        _styleLab = [[UILabel alloc]init];
        _styleLab.font = [UIFont systemFontOfSize:16];
        _styleLab.text = @"加载中...";
        [self.contentView addSubview:_styleLab];
        self.styleLab.sd_layout.leftSpaceToView(self.contentView,10).topSpaceToView(self.imgView,15).heightIs(30).widthIs((230.0 / 750.0) * Width);
        
        
        _colletBtn = [[UIButton alloc]init];
        
//        [self.contentView addSubview:_colletBtn];
        
        self.colletBtn.sd_layout.rightSpaceToView(self.contentView,10).centerYEqualToView(self.styleLab).widthIs(30).heightIs(20);
        [self.colletBtn addTarget:self action:@selector(colletBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        
        _otherLab = [[UILabel alloc]init];
//        _otherLab.backgroundColor = [UIColor orangeColor];
        _otherLab.font = [UIFont systemFontOfSize:12];
        self.otherLab.textColor = [UIColor grayColor];
        _otherLab.text = @"加载中...";
        self.otherLab.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_otherLab];
        self.otherLab.sd_layout.rightSpaceToView(self.contentView,10).centerYEqualToView(self.styleLab).heightIs(30).widthIs((350.0 / 750.0) * Width);
        
        self.space = [[UIView alloc]init];
        self.space.backgroundColor = [UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:1.0];
        [self.contentView addSubview:self.space];
        self.space.sd_layout.leftSpaceToView(self.contentView,0).rightSpaceToView(self.contentView,0).topSpaceToView(self.styleLab,8).bottomSpaceToView(self.contentView,0);
        
        
        
        
    }
    return self;
    
}


- (void)colletBtn:(UIButton *)sender{
    sender.userInteractionEnabled = NO;
    [self.delegate cellColletBtnActionDelegate:sender cid:self.cid cell:self isCollection:self.isCollection];
}
- (void)setModel:(Case_ListModel *)model {
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:model.pic]];
    [self.logoView sd_setImageWithURL:[NSURL URLWithString:model.userpic] placeholderImage:[UIImage imageNamed:@"我的_未登陆头像"]];
    self.styleLab.text = model.title;
    NSString *otherString = [NSString stringWithFormat:@"%@  %@  %@",model.price,model.hx,model.mj];
    self.otherLab.text = otherString;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

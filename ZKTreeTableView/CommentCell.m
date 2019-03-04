//
//  CommentCell.m
//  ZKTreeTableView
//
//  Created by bestdew on 2018/8/30.
//  Copyright © 2018年 bestdew. All rights reserved.
//

#import "CommentCell.h"
#import "CommentModel.h"

@interface CommentCell ()

@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UILabel *nickNameLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIButton *expandButton;

@end

@implementation CommentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self.view addSubview:self.imgView];
        [self.view addSubview:self.nickNameLabel];
        [self.view addSubview:self.expandButton];
        [self.view addSubview:self.contentLabel];
    }
    return self;
}

#pragma mark -- Action
- (void)expand:(UIButton *)button
{
    if (self.block) {
        self.block(self.node);
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat imgX = 0.f, imgY = 0.f, imgSize = 0.f;
    if (self.node.level == 0) {
        imgX = 16.f;
        imgY = 18.f;
        imgSize = 40.f;
    } else if (self.node.level == 1) {
        imgX = 12.f;
        imgY = 12.f;
        imgSize = 24.f;
    } else {
        imgX = 8.f;
        imgY = 12.f;
        imgSize = 24.f;
    }
    
    _imgView.frame = CGRectMake(imgX, imgY, imgSize, imgSize);
    _imgView.layer.cornerRadius = imgSize / 2;
    _nickNameLabel.frame = CGRectMake(imgX + imgSize + 12.f, imgY, self.view.frame.size.width - imgX - imgSize - 50.f, 24.f);
    _expandButton.frame = CGRectMake(CGRectGetMaxX(_nickNameLabel.frame) + 2.f, _nickNameLabel.frame.origin.y, 20.f, 20.f);
    _contentLabel.frame = CGRectMake(imgX + imgSize + 4.f, CGRectGetMaxY(_nickNameLabel.frame) + 4.f, self.view.frame.size.width - imgX - imgSize - 20.f, self.view.frame.size.height - CGRectGetMaxY(_nickNameLabel.frame) - 4.f);
    _contentLabel.layer.cornerRadius = 8.f;
}

- (void)setNode:(ZKTreeNode *)node
{
    [super setNode:node]; // 必须调用父类方法
    
    CommentModel *model = (CommentModel *)node.data;
    
    _nickNameLabel.text = model.nick_name;
    _expandButton.selected = node.isExpand;
    _expandButton.hidden = (node.childNodes.count == 0);
    _imgView.image = [UIImage imageNamed:model.image_name];
    _contentLabel.attributedText = [self attributedTextWithString:model.content];
}

- (NSAttributedString *)attributedTextWithString:(NSString *)string
{
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.alignment = NSTextAlignmentLeft;
    paraStyle.firstLineHeadIndent = 10.f;
    paraStyle.headIndent = 10.f;
    //paraStyle.lineSpacing = 2.f;
    paraStyle.tailIndent = -5.f;
    paraStyle.minimumLineHeight = 24.f;
    
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:17.f],
                          NSParagraphStyleAttributeName:paraStyle};
    NSAttributedString *attributeText = [[NSAttributedString alloc] initWithString:string attributes:dic];
    
    return attributeText;
}

- (UILabel *)nickNameLabel
{
    if (_nickNameLabel == nil) {

        _nickNameLabel = [[UILabel alloc] init];
        _nickNameLabel.font = [UIFont systemFontOfSize:14.f];
    }
    return _nickNameLabel;
}

- (UIImageView *)imgView
{
    if (_imgView == nil) {
        
        _imgView = [[UIImageView alloc] init];
    }
    return _imgView;
}

- (UILabel *)contentLabel
{
    if (_contentLabel == nil) {
        
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.layer.backgroundColor = [UIColor colorWithRed:0.94 green:0.95 blue:0.95 alpha:1.00].CGColor;
        _contentLabel.numberOfLines = 0;
    }
    return _contentLabel;
}

- (UIButton *)expandButton
{
    if (_expandButton == nil) {
        
        _expandButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_expandButton setImage:[UIImage imageNamed:@"select_top_icon"] forState:UIControlStateNormal];
        [_expandButton setImage:[UIImage imageNamed:@"select_down_icon"] forState:UIControlStateSelected];
        [_expandButton addTarget:self action:@selector(expand:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _expandButton;
}

@end

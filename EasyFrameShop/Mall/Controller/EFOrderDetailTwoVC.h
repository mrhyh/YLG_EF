//
//  EFOrderDetailVC.h
//  EF_MallDemo
//
//  Created by ylgwhyh on 16/6/14.
//  Copyright © 2016年 MH. All rights reserved.
//

#import "EFBaseViewController.h"
#import "EFOrderListModel.h"

@interface EFOrderDetailTwoVC : EFBaseViewController
- (instancetype)initWithProductId:(NSInteger)orderId andOrderStatus:(NSString *)orderStatus andOrderModel:(OrderModel *)orderModel;
@end

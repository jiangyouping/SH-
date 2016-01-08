//
//  SHUserResult.m
//  SH微博
//
//  Created by juan on 15/11/9.
//  Copyright © 2015年 juan. All rights reserved.
//

#import "SHUserResult.h"

@implementation SHUserResult

- (int)messageCount
{
    return _cmt + _dm + _mention_cmt + _mention_status;
}

- (int)totoalCount
{
    return self.messageCount + _status + _follower;
}

@end

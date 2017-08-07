//
//  BqFile.h
//  SaveVideoToAlbum
//
//  Created by LinBq on 2017/8/7.
//  Copyright © 2017年 BqLin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BqFile : NSObject

/// 文件名称
@property (nonatomic, copy, readonly) NSString *fileName;

/// 路径
@property (nonatomic, copy, readonly) NSString *path;

// TODO: 文件类型

// TODO: 子文件夹

- (instancetype)initWithPath:(NSString *)path;

@end

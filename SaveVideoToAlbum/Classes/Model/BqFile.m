//
//  BqFile.m
//  SaveVideoToAlbum
//
//  Created by LinBq on 2017/8/7.
//  Copyright © 2017年 BqLin. All rights reserved.
//

#import "BqFile.h"

@interface BqFile ()

/// 文件名称
@property (nonatomic, copy) NSString *fileName;

/// 路径
@property (nonatomic, copy) NSString *path;


@end

@implementation BqFile

#pragma mark - property
- (void)setPath:(NSString *)path {
    path = [path stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (!path.length) {
        return;
    }
    _path = path;
    _fileName = [path lastPathComponent];
}

#pragma mark - dealloc & init

- (instancetype)initWithPath:(NSString *)path {
    if (self = [super init]) {
        self.path = path;
    }
    return self;
}

@end

//
//  BqDocumentsViewController.m
//  SaveVideoToAlbum
//
//  Created by LinBq on 2017/8/7.
//  Copyright © 2017年 BqLin. All rights reserved.
//

#import "BqDocumentsViewController.h"
#import "BqFile.h"

static NSString * const BqFileCellID = @"BqFileCell";

@interface BqDocumentsViewController ()

@property (nonatomic, strong) NSMutableArray<BqFile *> *documents;

@end

@implementation BqDocumentsViewController

#pragma mark - property

- (NSMutableArray<BqFile *> *)documents {
    if (!_documents) {
        _documents = [NSMutableArray array];
    }
    return _documents;
}

#pragma mark - view controller

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.documents.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BqFile *file = self.documents[indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:BqFileCellID forIndexPath:indexPath];
    
    cell.textLabel.text = file.fileName;
    
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    BqFile *file = self.documents[indexPath.row];
    
    UISaveVideoAtPathToSavedPhotosAlbum(file.path, self, @selector(video:didFinishSavingWithError:contextInfo:), nil);
}

- (void)video:(NSString *)videoPath didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInf {
    //NSLog(@"videoPath: %@", videoPath);
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:self.tableView.indexPathForSelectedRow];
    cell.selected = NO;
    if (error) {
        NSLog(@"保存视频过程中发生错误，错误信息:%@",error.localizedDescription);
    }else{
        NSLog(@"视频保存成功.");
        dispatch_async(dispatch_get_main_queue(), ^{
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        });
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - 按钮事件
- (IBAction)reloadButtonDidClick:(UIBarButtonItem *)sender {
    NSString *docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    NSArray *files = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:docPath error:nil];
    NSMutableArray *fileModels = [NSMutableArray array];
    for (NSString *fileName in files) {
        NSString *path = [docPath stringByAppendingPathComponent:fileName];
        BqFile *file = [[BqFile alloc] initWithPath:path];
        [fileModels addObject:file];
    }
    self.documents = fileModels;
    
    [self.tableView reloadData];
}


@end

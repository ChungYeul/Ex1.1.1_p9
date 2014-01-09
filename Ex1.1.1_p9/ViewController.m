//
//  ViewController.m
//  Ex1.1.1_p9
//
//  Created by SDT-1 on 2014. 1. 9..
//  Copyright (c) 2014년 T. All rights reserved.
//

#import "ViewController.h"
#import "Model.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *productNameField;
@property (weak, nonatomic) IBOutlet UITableView *table;

@end

@implementation ViewController
- (IBAction)addNewProduct:(id)sender {
    // 모델에게 제품 추가하도록
    Model *model = [Model sharedModel];
    NSString *productName = self.productNameField.text;
    [model addProduct:productName];
    
    // 뷰에 반영
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:([model numberOfProduct]-1) inSection:0];
    NSArray *newRow = [NSArray arrayWithObject:indexPath];
    [self.table insertRowsAtIndexPaths:newRow withRowAnimation:UITableViewRowAnimationAutomatic];
    
    // 텍스트 필드 정리
    [self.productNameField setText:@""];
    [self.productNameField resignFirstResponder];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

// Delegate
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    // 모델에게 제품 삭제
    [[Model sharedModel] removeProductAt:(int)indexPath.row];
    
    // 뷰에 반영
    NSArray *rowForDelete = [NSArray arrayWithObject:indexPath];
    [tableView deleteRowsAtIndexPaths:rowForDelete withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[Model sharedModel] numberOfProduct];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // Dynamic Prototypes 사용
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL_ID" forIndexPath:indexPath];
    
    // 모델에게 제품 정보를 얻어오기
    Model *model = [Model sharedModel];
    cell.textLabel.text = [model productAt:indexPath.row];
    return cell;
}
@end

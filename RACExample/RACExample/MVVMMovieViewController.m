//
//  MVVMMovieViewController.m
//  RACExample
//
//  Created by 海啸 on 2017/11/8.
//  Copyright © 2017年 海啸. All rights reserved.
//

#import "MVVMMovieViewController.h"
#import "NetManager.h"
#import "MVVMMovieCollectionViewCell.h"
#import "MVVMMovieModel.h"
#import "MVVMMovieViewModel.h"

#import <SDWebImage/UIImageView+WebCache.h>

@interface MVVMMovieViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic)  MVVMMovieModel *movieModel;
@property (strong, nonatomic) NSArray <MVVMMovieModel *> *movieModelArray;
@property (strong, nonatomic) MVVMMovieViewModel *movieViewModel;

@property (strong, nonatomic) AFHTTPSessionManager *sessionManager;
@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) UICollectionViewFlowLayout *flowLayout;
@property (strong, nonatomic) MVVMMovieCollectionViewCell *collectionCell;
@property (strong, nonatomic) NSMutableArray *dataArray;

@end

@implementation MVVMMovieViewController

#pragma mark UI
- (void)setupUI {
  
    self.collectionView = ({
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        flowLayout.itemSize = CGSizeMake(([UIScreen screenWidth] - 20)/2 , ([UIScreen screenHeight] - 20) /2 +50);
        //定义每个UICollectionView 横向的间距
        flowLayout.minimumLineSpacing = 5;
        //定义每个UICollectionView 纵向的间距
        flowLayout.minimumInteritemSpacing = 0;
        //定义每个UICollectionView 的边距距
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 5, 5, 5);//上左下右
        
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ReusableView"];
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [self.view addSubview:_collectionView];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.showsHorizontalScrollIndicator = false;
        _collectionView.showsVerticalScrollIndicator = false;
        

        [_collectionView registerClass:[MVVMMovieCollectionViewCell class] forCellWithReuseIdentifier:@"cellId"];
        _collectionView;
    });
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(10, 0, 0, 0));
    }];
    
}

#pragma mark  Collection Delegate

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MVVMMovieCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];

    [cell initWithModel:self.movieModelArray[indexPath.row]];
    
    return cell;
    
}
 
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.movieModelArray.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(200, 200);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(5, 5, 5, 5);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupUI];
    self.sessionManager = [NetManager sharedNetManager];
    self.movieViewModel = [MVVMMovieViewModel new];
    self.movieModel = [MVVMMovieModel new];
    
    [self bindViewModel];

}

- (void)bindViewModel {
    @weakify(self);
    [self.movieViewModel.command.executionSignals.switchToLatest subscribeNext:^(NSArray<MVVMMovieModel *> *array) {
        @strongify(self);
        self.movieModelArray = array;
        [self.collectionView reloadData];
    }];
    
    //执行command
    [self.movieViewModel.command execute:nil];
}



@end

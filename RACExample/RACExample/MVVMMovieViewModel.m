//
//  MVVMMovieViewModel.m
//  RACExample
//
//  Created by 海啸 on 2017/11/8.
//  Copyright © 2017年 海啸. All rights reserved.
//

#import "MVVMMovieViewModel.h"
#import "MVVMMovieModel.h"
#import "NetManager.h"

#import <AFNetworking.h>
#import <YYModel.h>

@interface MVVMMovieViewModel()
@property (strong, nonatomic) MVVMMovieModel *movieModel;
@property (strong, nonatomic) NSMutableArray<MVVMMovieModel*> *movieModelArray;
@property (strong, nonatomic) RACCommand *command;

@end

@implementation MVVMMovieViewModel

- (instancetype)init {
    self = [super init];
    if (self) {
//        [self initViewModel];
        [self initViewModelTwo];
    }
    return self;
}

- (void)initViewModelTwo  {
    self.movieModel = [MVVMMovieModel new];
    self.movieModelArray = [NSMutableArray new];
    @weakify(self);
    self.command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        return [RACSignal createSignal:^RACDisposable *(id <RACSubscriber> subscriber) {
            @strongify(self);
            NSString *url = @"https://api.douban.com/v2/movie/in_theaters?apikey=0b2bdeda43b5688921839c8ecb20399b&city=%E5%8C%97%E4%BA%AC&start=0&count=100&client=&udid=";

            AFHTTPSessionManager *manager = [NetManager sharedNetManager];
            manager.responseSerializer = [AFJSONResponseSerializer serializer];

            [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
                NSArray *subjectsArray = responseObject[@"subjects"];
                [[[[[subjectsArray rac_sequence] signal] doNext:^(id  _Nullable x) {
                    self.movieModel = [MVVMMovieModel yy_modelWithDictionary:x];
                    [self.movieModelArray addObject:self.movieModel];
                }] filter:^BOOL(id  _Nullable value) {
                    return self.movieModelArray.count == subjectsArray.count;
                }] subscribeNext:^(id x) {
                    [subscriber sendNext:self.movieModelArray];
                    [subscriber sendCompleted];
                }];
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                [subscriber sendError:[NSError errorWithDomain:@"afn" code:0 userInfo:nil]];
            }];
            return nil;
        }];
    }];
}


- (void)initViewModel {
    self.movieModel = [MVVMMovieModel new];
    self.movieModelArray = [NSMutableArray new];
    @weakify(self);
    _command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        @strongify(self);
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            @strongify(self);
            [self getDoubanList:^(NSArray<MVVMMovieModel *> *array) {
                [subscriber sendNext:array];
                [subscriber sendCompleted];
            }];
            return nil;
        }];
    }];
}

- (void)getDoubanList:(void(^)(NSArray<MVVMMovieModel *> *array))sucessedBlock {

    NSString *url = @"https://api.douban.com/v2/movie/in_theaters?apikey=0b2bdeda43b5688921839c8ecb20399b&city=%E5%8C%97%E4%BA%AC&start=0&count=100&client=&udid=";
    
    AFHTTPSessionManager *manager = [NetManager sharedNetManager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];

    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray *subjects = responseObject[@"subjects"];
        
        [subjects hx_each:^(id obj) {
            self.movieModel = [MVVMMovieModel yy_modelWithDictionary:obj];
            [self.movieModelArray addObject:self.movieModel];
        }];

        if (sucessedBlock) {
            sucessedBlock(self.movieModelArray);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
   
}

@end

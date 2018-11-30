//
//  ViewController.m
//  CoreDataDemo
//
//  Created by xygj on 2018/10/9.
//  Copyright © 2018 xygj. All rights reserved.
//

#import "ViewController.h"
#import "City+CoreDataClass.h"

@interface ViewController ()

@property (nonatomic ,strong)  NSManagedObjectContext *context;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initContext];
}

// 手动创建context
- (void)initContext {
    
    // 从程序中加载模型文件(数据库)
    NSManagedObjectModel *model = [NSManagedObjectModel mergedModelFromBundles:nil];
    
    NSPersistentStoreCoordinator *per = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
    
    // SQLite路径
    NSString *docs = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSURL *url = [NSURL fileURLWithPath:[docs stringByAppendingPathComponent:@"CoreDateDemo.data"]];
    
    NSLog(@"缓存所在路径: %@", url);
    
    // 持久化存储类型: NSSQLiteStoreType(SQLite) NSBinaryStoreType(二进制文件) NSInMemoryStoreType(内存库, 无法永久保存)
    NSError *error = nil;
    [per addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:url options:nil error:&error];
    
    if (error) {
        NSLog(@"添加数据库异常");
    }else {
        NSLog(@"添加数据库成功");
    }
    
    // 创建上下文
    _context = [[NSManagedObjectContext alloc] initWithConcurrencyType:(NSConfinementConcurrencyType)];
    // 设置上下文持久化容器
    _context.persistentStoreCoordinator = per;
    
}

- (void)coredataTest {
    // NSManagedObject-->NSManagedObjectContext(持久化上下文)-->NSPersistentStoreCoordinator(持久化容器)-->NSManagedObjectModel + 持久化数据类型 + 数据存储路径和名称
    // NSManagedObject, 保存了实现Core Data对象所需要的所有基本行为.
    // NSManagedObjectModel, 允许将表中的数据映射到对象中.
    
}

- (IBAction)save:(id)sender {
    
    static int cityIndex = 0;
    
    // 创建对象
    City *city = [NSEntityDescription insertNewObjectForEntityForName:@"City" inManagedObjectContext:_context];
    city.cityName = [NSString stringWithFormat:@"杭州%d", cityIndex++];
    city.cityId = @"0023";
    NSError *error = nil;
    [_context save:&error];
    if (error) {
        NSLog(@"保存失败: %@", error.userInfo);
    }else {
        NSLog(@"数据插入到数据库成功---%@", city.cityName);
    }
    
}
- (IBAction)delete:(id)sender {
    
    NSFetchRequest *request = [City fetchRequest];
    
    //设置条件过滤
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"cityName=%@", @"杭州"];
    request.predicate = predicate;
    
    //遍历所有实体，将每个实体的信息存放在数组中
    NSArray *arr = [_context executeFetchRequest:request error:nil];
    
    //删除并保存
    if(arr.count){
        for (City *p in arr){
            [_context deleteObject:p];
            NSLog(@"删除%@成功！",p.cityName);
        }
        //保存
        [_context save:nil];
    }
}
- (IBAction)update:(id)sender {
}

- (IBAction)search:(id)sender {
    NSFetchRequest *request = [City fetchRequest];
    // 查询条件
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"cityName = %@", @"杭州"];
    request.predicate = pre;
    
    NSError *error = nil;
    
    NSArray *resultArray = [_context executeFetchRequest:request error:&error];
    
    for (City *city in resultArray) {
        NSLog(@"城市名称: %@", city.cityName);
    }
    
}

@end

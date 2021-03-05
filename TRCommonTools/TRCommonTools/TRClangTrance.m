//
//  TRClangTrance.m
//  Runner
//
//  Created by 控客 on 2021/3/5.
//

#import "TRClangTrance.h"
#import <dlfcn.h>
//用于定义原子队列
#import <libkern/OSAtomic.h>

@implementation TRClangTrance

void __sanitizer_cov_trace_pc_guard_init(uint32_t *start,uint32_t *stop) {
    static uint64_t N;
    // Counter for the guards.
    if (start == stop || *start) return;
    // Initialize only once.
    for (uint32_t *x = start; x < stop; x++)
    
    *x = ++N;
    // Guards should start from 1.
}

//定义原子队列
static  OSQueueHead symbolList = OS_ATOMIC_QUEUE_INIT;

//定义符号结构体
typedef struct {
    void *pc;
    void *next;
    
} SymbolNode;

void __sanitizer_cov_trace_pc_guard(uint32_t *guard) {
    //排除load方法
    //if (!*guard) return;
    
    //当前函数返回到上一个方法继续执行的地址
    void *PC = __builtin_return_address(0);
    
    
    Dl_info info;
    dladdr(PC, &info);
    printf("fname:%s \nfbase:%p \nsname:%s \nsaddr:%p\n\n\n",info.dli_fname,info.dli_fbase,info.dli_sname,info.dli_saddr);
    
    char PcDescr[1024];
    //__sanitizer_symbolize_pc(PC, "%p %F %L", PcDescr, sizeof(PcDescr));
    printf("guard: %p %x PC %s\n", guard, *guard, PcDescr);
    
    
    
    SymbolNode *node = malloc(sizeof(SymbolNode));
    *node = (SymbolNode){PC, NULL};
    OSAtomicEnqueue(&symbolList, node, offsetof(SymbolNode, next));
}

+ (void)generateOrderFile {
    
    NSMutableArray <NSString *> *symbolNames = [NSMutableArray array];
    
    while (YES) {
        //一次循环!也会被HOOK一次!!（Tracing PCs只要有跳转(汇编中b/bl指令)就会被HOOK）
        
        SymbolNode * node = OSAtomicDequeue(&symbolList, offsetof(SymbolNode, next));
        if (node == NULL) {
            break;
        }
        
        Dl_info info = {0};
        dladdr(node->pc, &info);
        printf("%s \n",info.dli_sname);
        
        NSString *name = @(info.dli_sname);
        free(node);
        
        // 判断是不是oc方法，是的话直接加入符号数组  C函数前需加 _
        BOOL isInstanceMethod = [name hasPrefix:@"-["];
        BOOL isClassMethod = [name hasPrefix:@"+["];
        
        BOOL isObjc = isInstanceMethod || isClassMethod;
        
        NSString * symbolName = isObjc ? name: [@"_" stringByAppendingString:name];
        if (![symbolNames containsObject:symbolName]) {
            [symbolNames addObject:symbolName];
        }
    }
           
    // 取反:将先调用的函数放到前面
    NSEnumerator * emt = [symbolNames reverseObjectEnumerator];
    
    
    // 去重：由于一个函数可能执行多次，__sanitizer_cov_trace_pc_guard会执行多次，就加了重复的了，所以去重一下
    
    //反向数组
    NSMutableArray<NSString *> *funcs = [NSMutableArray arrayWithCapacity:symbolNames.count];
    NSString *name;
    while (name = [emt nextObject]) {
        if (![funcs containsObject:name]) {
            [funcs addObject:name];
        }
    }
    
    // 由于trace了所有执行的函数，这里我们就把本函数移除掉 去掉当前方法
    [funcs removeObject:[NSString stringWithFormat:@"%s",__FUNCTION__]];
    
    // 写order文件
    //数组转成字符串
    NSString *funcStr = [funcs componentsJoinedByString:@"\n"];
    //字符串写入文件
    NSString *filePath = [NSTemporaryDirectory() stringByAppendingPathComponent:@"trclangtrace.order"];
    //文件内容
    NSData *fileContents = [funcStr dataUsingEncoding:NSUTF8StringEncoding];
    
    [[NSFileManager defaultManager] createFileAtPath:filePath contents:fileContents attributes:nil];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]){
        NSLog(@"orderPath:%@",filePath);
    }else{
        NSLog(@"生成orderPath失败");
    }
}

#pragma mark - Util
+ (BOOL)isObjcMethodBySymbolName:(NSString *)symbolName {
    
    BOOL isInstanceMethod = [symbolName hasPrefix:@"-["];
    BOOL isClassMethod = [symbolName hasPrefix:@"+["];
    return isInstanceMethod || isClassMethod;
}

@end

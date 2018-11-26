//
//  TRPingTestHelper.m
//  Pods
//
//  Created by Tracky on 2017/11/20.
//

#import "TRPingTestHelper.h"

@implementation TRPingItem

- (NSString *)description {
    switch (self.status) {
        case STDPingStatusDidStart:
            return [NSString stringWithFormat:@"PING %@ (%@): %ld data bytes",self.originalAddress, self.IPAddress, (long)self.dateBytesLength];
        case STDPingStatusDidReceivePacket:
            return [NSString stringWithFormat:@"%ld bytes from %@: icmp_seq=%ld ttl=%ld time=%.3f ms", (long)self.dateBytesLength, self.IPAddress, (long)self.ICMPSequence, (long)self.timeToLive, self.timeMilliseconds];
        case STDPingStatusDidTimeout:
            return [NSString stringWithFormat:@"Request timeout for icmp_seq %ld", (long)self.ICMPSequence];
        case STDPingStatusDidFailToSendPacket:
            return [NSString stringWithFormat:@"Fail to send packet to %@: icmp_seq=%ld", self.IPAddress, (long)self.ICMPSequence];
        case STDPingStatusDidReceiveUnexpectedPacket:
            return [NSString stringWithFormat:@"Receive unexpected packet from %@: icmp_seq=%ld", self.IPAddress, (long)self.ICMPSequence];
        case STDPingStatusError:
            return [NSString stringWithFormat:@"Can not ping to %@", self.originalAddress];
        default:
            break;
    }
    if (self.status == STDPingStatusDidReceivePacket) {
    }
    return super.description;
}

+ (NSString *)statisticsWithPingItems:(NSArray *)pingItems {
    //    --- ping statistics ---
    //    5 packets transmitted, 5 packets received, 0.0% packet loss
    //    round-trip min/avg/max/stddev = 4.445/9.496/12.210/2.832 ms
    NSString *address = [pingItems.firstObject originalAddress];
    __block NSInteger receivedCount = 0, allCount = 0;
    __block double sumTime = 0;
    [pingItems enumerateObjectsUsingBlock:^(TRPingItem *obj, NSUInteger idx, BOOL *stop) {
        if (obj.status != STDPingStatusFinished && obj.status != STDPingStatusError) {
            allCount ++;
            if (obj.status == STDPingStatusDidReceivePacket) {
                receivedCount ++;
                sumTime += obj.timeMilliseconds;
            }
        }
    }];
    
    NSMutableString *description = [NSMutableString stringWithCapacity:50];
    [description appendFormat:@"--- %@ ping statistics ---\n", address];
    CGFloat lossPercent = (CGFloat)(allCount - receivedCount) / MAX(1.0, allCount) * 100;
    [description appendFormat:@"%ld packets transmitted, %ld packets received, %.1f%% packet loss\n", (long)allCount, (long)receivedCount, lossPercent];
    CGFloat avgTime = sumTime / MAX(1.0, allCount);
    NSLog(@"%.2f", avgTime);
    return [description stringByReplacingOccurrencesOfString:@".0%" withString:@"%"];
}


+ (NSArray *)statisticsArrayWithPingItems:(NSArray *)pingItems {
    __block NSInteger receivedCount = 0, allCount = 0;
    __block double sumTime = 0;
    [pingItems enumerateObjectsUsingBlock:^(TRPingItem *obj, NSUInteger idx, BOOL *stop) {
        if (obj.status != STDPingStatusFinished && obj.status != STDPingStatusError) {
            allCount ++;
            if (obj.status == STDPingStatusDidReceivePacket) {
                receivedCount ++;
                sumTime += obj.timeMilliseconds;
            }
        }
    }];
    
    CGFloat lossPercent = (CGFloat)(allCount - receivedCount) / MAX(1.0, allCount) * 100;
    CGFloat avgTime = sumTime / MAX(1.0, allCount);

    NSString *avgTimeStr = [NSString stringWithFormat:@"%.1fms", avgTime];
    NSString *lossPercentStr = [NSString stringWithFormat:@"%.1f%%", lossPercent];
    // 这里网络正常与否仅提供示例
    NSString *flagStr = lossPercent >= 1 ? @"网络异常" : @"正常";
    return [NSArray arrayWithObjects:avgTimeStr, lossPercentStr, flagStr, nil];
}
@end


@interface TRPingTestHelper () <TRSimplePingDelegate> {
    BOOL _hasStarted;
    BOOL _isTimeout;
    NSInteger   _repingTimes;
    NSInteger   _sequenceNumber;
    NSMutableArray *_pingItems;
}

@property(nonatomic, copy)   NSString   *address;
@property(nonatomic, strong) TRSimplePing *simplePing;

@property(nonatomic, strong)void(^callbackHandler)(TRPingItem *item, NSArray *pingItems);

@end



@implementation TRPingTestHelper

+ (TRPingTestHelper *)startPingAddress:(NSString *)address
                      callbackHandler:(void(^)(TRPingItem *item, NSArray *pingItems))handler {
    TRPingTestHelper * pingServices = [[TRPingTestHelper alloc] initWithAddress:address];
    pingServices.callbackHandler = handler;
    [pingServices startPing];
    return pingServices;
}

- (instancetype)initWithAddress:(NSString *)address {
    self = [super init];
    if (self) {
        self.timeoutMilliseconds = 500;
        self.maximumPingTimes = 100;
        self.address = address;
        self.simplePing = [[TRSimplePing alloc] initWithHostName:address];
        self.simplePing.addressStyle = TRSimplePingAddressStyleAny;
        self.simplePing.delegate = self;
        _pingItems = [NSMutableArray arrayWithCapacity:10];
    }
    return self;
}

- (void)startPing {
    _repingTimes = 0;
    _hasStarted = NO;
    [_pingItems removeAllObjects];
    [self.simplePing start];
}

- (void)reping {
    [self.simplePing stop];
    [self.simplePing start];
}

- (void)_timeoutActionFired {
    TRPingItem *pingItem = [[TRPingItem alloc] init];
    pingItem.ICMPSequence = _sequenceNumber;
    pingItem.originalAddress = self.address;
    pingItem.status = STDPingStatusDidTimeout;
    [self.simplePing stop];
    [self _handlePingItem:pingItem];
}

- (void)_handlePingItem:(TRPingItem *)pingItem {
    if (pingItem.status == STDPingStatusDidReceivePacket || pingItem.status == STDPingStatusDidTimeout) {
        [_pingItems addObject:pingItem];
    }
    if (_repingTimes < self.maximumPingTimes - 1) {
        if (self.callbackHandler) {
            self.callbackHandler(pingItem, [_pingItems copy]);
        }
        _repingTimes ++;
        NSTimer *timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(reping) userInfo:nil repeats:NO];
        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    } else {
        if (self.callbackHandler) {
            self.callbackHandler(pingItem, [_pingItems copy]);
        }
        [self cancel];
    }
}

- (void)cancel {
    [[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(_timeoutActionFired) object:nil];
    [self.simplePing stop];
    TRPingItem *pingItem = [[TRPingItem alloc] init];
    pingItem.status = STDPingStatusFinished;
    [_pingItems addObject:pingItem];
    if (self.callbackHandler) {
        self.callbackHandler(pingItem, [_pingItems copy]);
    }
}

- (void)st_simplePing:(TRSimplePing *)pinger didStartWithAddress:(NSData *)address {
    NSData *packet = [pinger packetWithPingData:nil];
    if (!_hasStarted) {
        TRPingItem *pingItem = [[TRPingItem alloc] init];
        pingItem.IPAddress = pinger.IPAddress;
        pingItem.originalAddress = self.address;
        pingItem.dateBytesLength = packet.length - sizeof(STICMPHeader);
        pingItem.status = STDPingStatusDidStart;
        if (self.callbackHandler) {
            self.callbackHandler(pingItem, nil);
        }
        _hasStarted = YES;
    }
    [pinger sendPacket:packet];
    [self performSelector:@selector(_timeoutActionFired) withObject:nil afterDelay:self.timeoutMilliseconds / 1000.0];
}

// If this is called, the SimplePing object has failed.  By the time this callback is
// called, the object has stopped (that is, you don't need to call -stop yourself).

// IMPORTANT: On the send side the packet does not include an IP header.
// On the receive side, it does.  In that case, use +[SimplePing icmpInPacket:]
// to find the ICMP header within the packet.

- (void)st_simplePing:(TRSimplePing *)pinger didSendPacket:(NSData *)packet sequenceNumber:(uint16_t)sequenceNumber {
    _sequenceNumber = sequenceNumber;
}

- (void)st_simplePing:(TRSimplePing *)pinger didFailToSendPacket:(NSData *)packet sequenceNumber:(uint16_t)sequenceNumber error:(NSError *)error {
    [[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(_timeoutActionFired) object:nil];
    _sequenceNumber = sequenceNumber;
    TRPingItem *pingItem = [[TRPingItem alloc] init];
    pingItem.ICMPSequence = _sequenceNumber;
    pingItem.originalAddress = self.address;
    pingItem.status = STDPingStatusDidFailToSendPacket;
    [self _handlePingItem:pingItem];
}

- (void)st_simplePing:(TRSimplePing *)pinger didReceiveUnexpectedPacket:(NSData *)packet {
    [[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(_timeoutActionFired) object:nil];
    TRPingItem *pingItem = [[TRPingItem alloc] init];
    pingItem.ICMPSequence = _sequenceNumber;
    pingItem.originalAddress = self.address;
    pingItem.status = STDPingStatusDidReceiveUnexpectedPacket;
    //    [self _handlePingItem:pingItem];
}

- (void)st_simplePing:(TRSimplePing *)pinger didReceivePingResponsePacket:(NSData *)packet timeToLive:(NSInteger)timeToLive sequenceNumber:(uint16_t)sequenceNumber timeElapsed:(NSTimeInterval)timeElapsed {
    [[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(_timeoutActionFired) object:nil];
    TRPingItem *pingItem = [[TRPingItem alloc] init];
    pingItem.IPAddress = pinger.IPAddress;
    pingItem.dateBytesLength = packet.length;
    pingItem.timeToLive = timeToLive;
    pingItem.timeMilliseconds = timeElapsed * 1000;
    pingItem.ICMPSequence = sequenceNumber;
    pingItem.originalAddress = self.address;
    pingItem.status = STDPingStatusDidReceivePacket;
    [self _handlePingItem:pingItem];
}

- (void)st_simplePing:(TRSimplePing *)pinger didFailWithError:(NSError *)error {
    [[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(_timeoutActionFired) object:nil];
    [self.simplePing stop];
    
    TRPingItem *errorPingItem = [[TRPingItem alloc] init];
    errorPingItem.originalAddress = self.address;
    errorPingItem.status = STDPingStatusError;
    if (self.callbackHandler) {
        self.callbackHandler(errorPingItem, [_pingItems copy]);
    }
    
    TRPingItem *pingItem = [[TRPingItem alloc] init];
    pingItem.originalAddress = self.address;
    pingItem.IPAddress = pinger.IPAddress ?: pinger.hostName;
    [_pingItems addObject:pingItem];
    pingItem.status = STDPingStatusFinished;
    if (self.callbackHandler) {
        self.callbackHandler(pingItem, [_pingItems copy]);
    }
}

@end

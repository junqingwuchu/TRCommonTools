//
//  CHDTRPingTestHelper.h
//  Pods
//
//  Created by Tracky on 2017/11/20.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import "TRSimplePing.h"

typedef NS_ENUM(NSInteger, STDPingStatus) {
    STDPingStatusDidStart,
    STDPingStatusDidFailToSendPacket,
    STDPingStatusDidReceivePacket,
    STDPingStatusDidReceiveUnexpectedPacket,
    STDPingStatusDidTimeout,
    STDPingStatusError,
    STDPingStatusFinished,
};

@interface TRPingItem : NSObject

@property(nonatomic) NSString *originalAddress;
@property(nonatomic, copy) NSString *IPAddress;

@property(nonatomic) NSUInteger dateBytesLength;
@property(nonatomic) double     timeMilliseconds;
@property(nonatomic) NSInteger  timeToLive;
@property(nonatomic) NSInteger  ICMPSequence;

@property(nonatomic) STDPingStatus status;

+ (NSString *)statisticsWithPingItems:(NSArray *)pingItems;

+ (NSArray *)statisticsArrayWithPingItems:(NSArray *)pingItems;
@end


@interface CHDTRPingTestHelper : NSObject

// 超时时间, default 100ms
@property(nonatomic) double timeoutMilliseconds;

+ (CHDTRPingTestHelper *)startPingAddress:(NSString *)address
                      callbackHandler:(void(^)(TRPingItem *pingItem, NSArray *pingItems))handler;
// 最大连续ping次数
@property(nonatomic) NSInteger  maximumPingTimes;
- (void)cancel;

@end

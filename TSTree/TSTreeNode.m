//
//  TSTree.m
//  TSTree
//
//  Created by Punit Kulkarni on 9/20/16.
//  Copyright © 2016 Punit Kulkarni. All rights reserved.
//

#import "TSTreeNode.h"

@interface TSTreeNode()

@property (nonatomic, strong) NSMutableDictionary *mutableDict;
@property (nonatomic, assign) BOOL isLeafNode;
@property (nonatomic, strong) NSMutableSet *entries;

- (void)setNode:(TSTreeNode *)node forKey:(NSString *)key;
- (TSTreeNode *)nodeForKey:(NSString *)key;

@end

@implementation TSTreeNode

- (instancetype)init {
    
    if (self=[super init]) {
        _mutableDict = [NSMutableDictionary new];
        _entries = [NSMutableSet new];
    }
    return self;
}

- (void)setNode:(TSTreeNode *)node forKey:(NSString *)key {
    [_mutableDict setObject:node forKey:key];
}

- (TSTreeNode *)nodeForKey:(NSString *)key {
    return [self.mutableDict objectForKey:key];
}

#pragma mark - Information Feeding

+ (void)parseString:(NSString *)inputString inNode:(TSTreeNode *)node origString:(NSString *)origString {
    
    [node.entries addObject:origString];
    TSTreeNode *nextNode = [node.mutableDict objectForKey:[inputString substringWithRange:NSMakeRange(0, 1)]];
    if (!nextNode) {
        nextNode = [[TSTreeNode alloc] init];
        [node setNode:nextNode forKey:[inputString substringWithRange:NSMakeRange(0, 1)]];
    }
    
    if (inputString.length == 1) {
        nextNode.isLeafNode = YES;
    }
    else {
        [TSTreeNode parseString:[inputString substringWithRange:NSMakeRange(1, inputString.length-1)] inNode:nextNode origString:origString];
    }
}

- (void)parseDataSet:(NSArray *)dataSet {
    for (NSString *inputString in dataSet) {
        [TSTreeNode parseString:inputString inNode:self origString:inputString];
    }
}

#pragma mark - Information Retrieval

- (NSSet*)findValuesForTerm:(NSString*)value {
    
    TSTreeNode *nodeToUse = self;
    
    for (int i = 0; i<value.length; i++) {
        nodeToUse = [nodeToUse nodeForKey:[value substringWithRange:NSMakeRange(i, 1)]];
    }
    
    NSMutableSet *setToReturn = nodeToUse.entries;;
    if (nodeToUse.isLeafNode) {
        [setToReturn addObject:value];
    }
    return setToReturn.copy;
}

@end

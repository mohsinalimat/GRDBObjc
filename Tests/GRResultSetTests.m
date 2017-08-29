#import "GRDBObjcTestCase.h"
#import <sqlite3.h>

@interface GRResultSetTests : GRDBObjcTestCase
@end

@implementation GRResultSetTests

- (void)createValuesTableInDatabase:(GRDatabase *)db
{
    NSError *error;
    BOOL success = [db executeUpdate:@"CREATE TABLE v(integer INTEGER, double DOUBLE, text TEXT, blob BLOB, \"null\")" error:&error];
    XCTAssert(success, @"%@", error);
    success = [db executeUpdate:@"INSERT INTO v(integer, double, text, blob, \"null\") VALUES (?, ?, ?, ?, ?)"
               values:@[@(123), @(1.5), @"20 little cigars", [@"654" dataUsingEncoding:NSUTF8StringEncoding], [NSNull null]]
                error:&error];
    XCTAssert(success, @"%@", error);
}

- (GRResultSet *)executeValuesQueryInDatabase:(GRDatabase *)db
{
    NSError *error;
    GRResultSet *rs = [db executeQuery:@"SELECT integer, double, text, blob, \"null\" FROM v" error:&error];
    XCTAssertNotNil(rs, @"%@", error);
    return rs;
}

- (void)testIntValue
{
    GRDatabaseQueue *dbQueue = [GRDatabaseQueue databaseQueueWithPath:[self makeTemporaryDatabasePath] error:NULL];
    [dbQueue inDatabase:^(GRDatabase *db) {
        [self createValuesTableInDatabase:db];
        GRResultSet *rs = [self executeValuesQueryInDatabase:db];
        XCTAssert([rs next]);
        XCTAssertEqual([rs intForColumnIndex:0], 123);
        XCTAssertEqual([rs intForColumn:@"integer"], 123);
        XCTAssertEqual([rs intForColumnIndex:1], 1);
        XCTAssertEqual([rs intForColumn:@"double"], 1);
        XCTAssertEqual([rs intForColumnIndex:2], 20);
        XCTAssertEqual([rs intForColumn:@"text"], 20);
        XCTAssertEqual([rs intForColumnIndex:3], 654);
        XCTAssertEqual([rs intForColumn:@"blob"], 654);
        XCTAssertEqual([rs intForColumnIndex:4], 0);
        XCTAssertEqual([rs intForColumn:@"null"], 0);
    }];
}

- (void)testLongValue
{
    GRDatabaseQueue *dbQueue = [GRDatabaseQueue databaseQueueWithPath:[self makeTemporaryDatabasePath] error:NULL];
    [dbQueue inDatabase:^(GRDatabase *db) {
        [self createValuesTableInDatabase:db];
        GRResultSet *rs = [self executeValuesQueryInDatabase:db];
        XCTAssert([rs next]);
        XCTAssertEqual([rs longForColumnIndex:0], 123);
        XCTAssertEqual([rs longForColumn:@"integer"], 123);
        XCTAssertEqual([rs longForColumnIndex:1], 1);
        XCTAssertEqual([rs longForColumn:@"double"], 1);
        XCTAssertEqual([rs longForColumnIndex:2], 20);
        XCTAssertEqual([rs longForColumn:@"text"], 20);
        XCTAssertEqual([rs longForColumnIndex:3], 654);
        XCTAssertEqual([rs longForColumn:@"blob"], 654);
        XCTAssertEqual([rs longForColumnIndex:4], 0);
        XCTAssertEqual([rs longForColumn:@"null"], 0);
    }];
}

- (void)testLongLongIntValue
{
    GRDatabaseQueue *dbQueue = [GRDatabaseQueue databaseQueueWithPath:[self makeTemporaryDatabasePath] error:NULL];
    [dbQueue inDatabase:^(GRDatabase *db) {
        [self createValuesTableInDatabase:db];
        GRResultSet *rs = [self executeValuesQueryInDatabase:db];
        XCTAssert([rs next]);
        XCTAssertEqual([rs longLongIntForColumnIndex:0], 123);
        XCTAssertEqual([rs longLongIntForColumn:@"integer"], 123);
        XCTAssertEqual([rs longLongIntForColumnIndex:1], 1);
        XCTAssertEqual([rs longLongIntForColumn:@"double"], 1);
        XCTAssertEqual([rs longLongIntForColumnIndex:2], 20);
        XCTAssertEqual([rs longLongIntForColumn:@"text"], 20);
        XCTAssertEqual([rs longLongIntForColumnIndex:3], 654);
        XCTAssertEqual([rs longLongIntForColumn:@"blob"], 654);
        XCTAssertEqual([rs longLongIntForColumnIndex:4], 0);
        XCTAssertEqual([rs longLongIntForColumn:@"null"], 0);
    }];
}

- (void)testUnsignedLongLongIntValue
{
    GRDatabaseQueue *dbQueue = [GRDatabaseQueue databaseQueueWithPath:[self makeTemporaryDatabasePath] error:NULL];
    [dbQueue inDatabase:^(GRDatabase *db) {
        [self createValuesTableInDatabase:db];
        GRResultSet *rs = [self executeValuesQueryInDatabase:db];
        XCTAssert([rs next]);
        XCTAssertEqual([rs unsignedLongLongIntForColumnIndex:0], 123);
        XCTAssertEqual([rs unsignedLongLongIntForColumn:@"integer"], 123);
        XCTAssertEqual([rs unsignedLongLongIntForColumnIndex:1], 1);
        XCTAssertEqual([rs unsignedLongLongIntForColumn:@"double"], 1);
        XCTAssertEqual([rs unsignedLongLongIntForColumnIndex:2], 20);
        XCTAssertEqual([rs unsignedLongLongIntForColumn:@"text"], 20);
        XCTAssertEqual([rs unsignedLongLongIntForColumnIndex:3], 654);
        XCTAssertEqual([rs unsignedLongLongIntForColumn:@"blob"], 654);
        XCTAssertEqual([rs unsignedLongLongIntForColumnIndex:4], 0);
        XCTAssertEqual([rs unsignedLongLongIntForColumn:@"null"], 0);
    }];
}

- (void)testBoolValue
{
    GRDatabaseQueue *dbQueue = [GRDatabaseQueue databaseQueueWithPath:[self makeTemporaryDatabasePath] error:NULL];
    [dbQueue inDatabase:^(GRDatabase *db) {
        [self createValuesTableInDatabase:db];
        GRResultSet *rs = [self executeValuesQueryInDatabase:db];
        XCTAssert([rs next]);
        XCTAssertEqual([rs boolForColumnIndex:0], YES);
        XCTAssertEqual([rs boolForColumn:@"integer"], YES);
        XCTAssertEqual([rs boolForColumnIndex:1], YES);
        XCTAssertEqual([rs boolForColumn:@"double"], YES);
        XCTAssertEqual([rs boolForColumnIndex:2], YES);
        XCTAssertEqual([rs boolForColumn:@"text"], YES);
        XCTAssertEqual([rs boolForColumnIndex:3], YES);
        XCTAssertEqual([rs boolForColumn:@"blob"], YES);
        XCTAssertEqual([rs boolForColumnIndex:4], NO);
        XCTAssertEqual([rs boolForColumn:@"null"], NO);
    }];
}

- (void)testDoubleValue
{
    GRDatabaseQueue *dbQueue = [GRDatabaseQueue databaseQueueWithPath:[self makeTemporaryDatabasePath] error:NULL];
    [dbQueue inDatabase:^(GRDatabase *db) {
        [self createValuesTableInDatabase:db];
        GRResultSet *rs = [self executeValuesQueryInDatabase:db];
        XCTAssert([rs next]);
        XCTAssertEqual([rs doubleForColumnIndex:0], 123.0);
        XCTAssertEqual([rs doubleForColumn:@"integer"], 123.0);
        XCTAssertEqual([rs doubleForColumnIndex:1], 1.5);
        XCTAssertEqual([rs doubleForColumn:@"double"], 1.5);
        XCTAssertEqual([rs doubleForColumnIndex:2], 20.0);
        XCTAssertEqual([rs doubleForColumn:@"text"], 20.0);
        XCTAssertEqual([rs doubleForColumnIndex:3], 654.0);
        XCTAssertEqual([rs doubleForColumn:@"blob"], 654.0);
        XCTAssertEqual([rs doubleForColumnIndex:4], 0.0);
        XCTAssertEqual([rs doubleForColumn:@"null"], 0.0);
    }];
}

- (void)testStringValue
{
    GRDatabaseQueue *dbQueue = [GRDatabaseQueue databaseQueueWithPath:[self makeTemporaryDatabasePath] error:NULL];
    [dbQueue inDatabase:^(GRDatabase *db) {
        [self createValuesTableInDatabase:db];
        GRResultSet *rs = [self executeValuesQueryInDatabase:db];
        XCTAssert([rs next]);
        XCTAssertEqualObjects([rs stringForColumnIndex:0], @"123");
        XCTAssertEqualObjects([rs stringForColumn:@"integer"], @"123");
        XCTAssertEqualObjects([rs stringForColumnIndex:1], @"1.5");
        XCTAssertEqualObjects([rs stringForColumn:@"double"], @"1.5");
        XCTAssertEqualObjects([rs stringForColumnIndex:2], @"20 little cigars");
        XCTAssertEqualObjects([rs stringForColumn:@"text"], @"20 little cigars");
        XCTAssertEqualObjects([rs stringForColumnIndex:3], @"654");
        XCTAssertEqualObjects([rs stringForColumn:@"blob"], @"654");
        XCTAssertNil([rs stringForColumnIndex:4]);
        XCTAssertNil([rs stringForColumn:@"null"]);
    }];
}

- (void)testDataValue
{
    GRDatabaseQueue *dbQueue = [GRDatabaseQueue databaseQueueWithPath:[self makeTemporaryDatabasePath] error:NULL];
    [dbQueue inDatabase:^(GRDatabase *db) {
        [self createValuesTableInDatabase:db];
        GRResultSet *rs = [self executeValuesQueryInDatabase:db];
        XCTAssert([rs next]);
        XCTAssertEqualObjects([rs dataForColumnIndex:0], [@"123" dataUsingEncoding:NSUTF8StringEncoding]);
        XCTAssertEqualObjects([rs dataForColumn:@"integer"], [@"123" dataUsingEncoding:NSUTF8StringEncoding]);
        XCTAssertEqualObjects([rs dataForColumnIndex:1], [@"1.5" dataUsingEncoding:NSUTF8StringEncoding]);
        XCTAssertEqualObjects([rs dataForColumn:@"double"], [@"1.5" dataUsingEncoding:NSUTF8StringEncoding]);
        XCTAssertEqualObjects([rs dataForColumnIndex:2], [@"20 little cigars" dataUsingEncoding:NSUTF8StringEncoding]);
        XCTAssertEqualObjects([rs dataForColumn:@"text"], [@"20 little cigars" dataUsingEncoding:NSUTF8StringEncoding]);
        XCTAssertEqualObjects([rs dataForColumnIndex:3], [@"654" dataUsingEncoding:NSUTF8StringEncoding]);
        XCTAssertEqualObjects([rs dataForColumn:@"blob"], [@"654" dataUsingEncoding:NSUTF8StringEncoding]);
        XCTAssertNil([rs dataForColumnIndex:4]);
        XCTAssertNil([rs dataForColumn:@"null"]);
    }];
}

- (void)testObjectValue
{
    GRDatabaseQueue *dbQueue = [GRDatabaseQueue databaseQueueWithPath:[self makeTemporaryDatabasePath] error:NULL];
    [dbQueue inDatabase:^(GRDatabase *db) {
        [self createValuesTableInDatabase:db];
        GRResultSet *rs = [self executeValuesQueryInDatabase:db];
        XCTAssert([rs next]);
        {
            NSNumber *value = [rs objectForColumnIndex:0];
            XCTAssert([value isKindOfClass:[NSNumber class]]);
            XCTAssert(strcmp([value objCType], @encode(sqlite3_int64)) == 0);
            XCTAssertEqual([value integerValue], 123);
        }
        {
            NSNumber *value = [rs objectForColumn:@"integer"];
            XCTAssert([value isKindOfClass:[NSNumber class]]);
            XCTAssert(strcmp([value objCType], @encode(sqlite3_int64)) == 0);
            XCTAssertEqual([value integerValue], 123);
        }
        {
            NSNumber *value = [rs objectForColumnIndex:1];
            XCTAssert([value isKindOfClass:[NSNumber class]]);
            XCTAssert(strcmp([value objCType], @encode(double)) == 0);
            XCTAssertEqual([value doubleValue], 1.5);
        }
        {
            NSNumber *value = [rs objectForColumn:@"double"];
            XCTAssert([value isKindOfClass:[NSNumber class]]);
            XCTAssert(strcmp([value objCType], @encode(double)) == 0);
            XCTAssertEqual([value doubleValue], 1.5);
        }
        {
            NSString *value = [rs objectForColumnIndex:2];
            XCTAssert([value isKindOfClass:[NSString class]]);
            XCTAssertEqualObjects(value, @"20 little cigars");
        }
        {
            NSString *value = [rs objectForColumn:@"text"];
            XCTAssert([value isKindOfClass:[NSString class]]);
            XCTAssertEqualObjects(value, @"20 little cigars");
        }
        {
            NSData *value = [rs objectForColumnIndex:3];
            XCTAssert([value isKindOfClass:[NSData class]]);
            XCTAssertEqualObjects(value, [@"654" dataUsingEncoding:NSUTF8StringEncoding]);
        }
        {
            NSData *value = [rs objectForColumn:@"blob"];
            XCTAssert([value isKindOfClass:[NSData class]]);
            XCTAssertEqualObjects(value, [@"654" dataUsingEncoding:NSUTF8StringEncoding]);
        }
        XCTAssertNil([rs objectForColumnIndex:4]);
        XCTAssertNil([rs objectForColumn:@"null"]);
    }];
}

- (void)testNextAfterCompletion
{
    
}

- (void)testColumnNameIsCaseInsensitive
{
    
}

@end
// Copyright (c) 2019 WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
//
// WSO2 Inc. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

import ballerina/io;
import ballerina/java;
import ballerina/test;

@test:Config {}
function testValidEnv() {
    string expectedValue = getExpectedValidEnv();
    test:assertEquals(getEnv("JAVA_HOME"), expectedValue);
}

@test:Config {}
function testEmptyEnv() {
    test:assertEquals(getEnv("JAVA_XXXX"), "");
}

@test:Config {}
function testGetUserHome() {
    test:assertEquals(getUserHome(), getExpectedUserHome());
}

@test:Config {}
function testGetUsername() {
    test:assertEquals(getUsername(), getExpectedUserName());
}

@test:Config {}
function testRandomString() {
    test:assertEquals(uuid().length(), 36);
}

function toString(io:ReadableByteChannel input) returns string|error {
    string result = "";
    io:ReadableCharacterChannel charIn = new(input, "UTF-8");
    while (true) {
        var x = charIn.read(1);
        if (x is error) { break; }
        else { result = result + x; }
    }
    check charIn.close();
    return <@untainted> result;
}

//function testExecInUnixLike1() returns [string, int, int]|error {
//    Process x1 = check exec("env", { "BAL_EXEC_TEST_VAR":"X" });
//    Process x2 = check exec("grep", {}, (), "BAL_EXEC_TEST_VAR");
//    var x2out = x1.pipe(x2).stdout();
//    var ec1 = check x2.waitForExit();
//    var ec2 = check x2.exitCode();
//    var result = check toString(x2out);
//    return [result, ec1, ec2];
//}

//function testExecInUnixLike2() returns string|error {
//    system:Process x1 = check system:exec("pwd", {}, "/");
//    var x1out = x1.stdout();
//    var result = check toString(x1out);
//    return result;
//}
//
//function testExecInUnixLike3() returns string|error {
//    system:Process x1 = check system:exec("grep", {}, (), "BAL_TEST");
//    io:WritableDataChannel ch = new(x1.stdin());
//    check ch.writeString("BAL_TEST", "UTF-8");
//    check ch.close();
//    var result = check toString(x1.stdout());
//    return result;
//}
//
//function testExecInUnixLike4() returns string|error {
//    system:Process x1 = check system:exec("env", { "BAL_EXEC_TEST_VAR":"X" });
//    system:Process x2 = check system:exec("grep", {}, (), "BAL_EXEC_TEST_VAR");
//    system:Process x3 = check system:exec("wc", {}, (), "-l");
//    var x3out = x1.pipe(x2).pipe(x3).stdout();
//    var result = check toString(x3out);
//    return result;
//}
//
//function testExecWithError() returns string|error {
//    system:Process x1 = check system:exec("eee", {}, (), "BAL_EXEC_TEST_VAR");
//    var x3out = x1.stdout();
//    var result = check toString(x3out);
//    return result;
//}

function getExpectedValidEnv() returns string = @java:Method {
    name: "testValidEnv",
    class: "org.ballerinalang.stdlib.system.testutils.SystemTestUtils"
} external;

function getExpectedUserHome() returns string = @java:Method {
    name: "testGetUserHome",
    class: "org.ballerinalang.stdlib.system.testutils.SystemTestUtils"
} external;

function getExpectedUserName() returns string = @java:Method {
    name: "testGetUserName",
    class: "org.ballerinalang.stdlib.system.testutils.SystemTestUtils"
} external;

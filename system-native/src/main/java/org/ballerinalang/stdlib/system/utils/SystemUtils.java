/*
 * Copyright (c) 2018, WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
 *
 * WSO2 Inc. licenses this file to you under the Apache License,
 * Version 2.0 (the "License"); you may not use this file except
 * in compliance with the License.
 * You may obtain a copy of the License at
 *
 *    http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied. See the License for the
 * specific language governing permissions and limitations
 * under the License.
 */
package org.ballerinalang.stdlib.system.utils;

import org.ballerinalang.jvm.BallerinaErrors;
import org.ballerinalang.jvm.BallerinaValues;
import org.ballerinalang.jvm.values.ErrorValue;
import org.ballerinalang.jvm.values.ObjectValue;

import java.io.IOException;

import static org.ballerinalang.stdlib.system.utils.SystemConstants.PROCESS_FIELD;
import static org.ballerinalang.stdlib.system.utils.SystemConstants.PROCESS_TYPE;
import static org.ballerinalang.stdlib.system.utils.SystemConstants.SYSTEM_PACKAGE_ID;

/**
 * @since 0.94.1
 */
public class SystemUtils {

    private static final String UNKNOWN_MESSAGE = "Unknown Error";

    /**
     * Returns error object  with message. Error type is generic ballerina error type. This utility to construct
     * error object from message.
     *
     * @param typeId The string type ID of the particular error object.
     * @param ex    Java throwable object to capture description of error struct. If throwable object is null,
     *              "Unknown Error" sets to message by default.
     * @return Ballerina error object.
     */
    public static ErrorValue getBallerinaError(String typeId, Throwable ex) {
        String errorMsg = ex != null && ex.getMessage() != null ? ex.getMessage() : UNKNOWN_MESSAGE;
        return getBallerinaError(typeId, errorMsg);
    }

    /**
     * Returns error object with message. Error type is generic ballerina error type. This utility to construct error
     * object from message.
     *
     * @param typeId  The specific error type ID.
     * @param message Java throwable object to capture description of error struct. If throwable object is null,
     *                "Unknown Error" is set to message by default.
     * @return Ballerina error object.
     */
    public static ErrorValue getBallerinaError(String typeId, String message) {
        return BallerinaErrors.createDistinctError(typeId, SYSTEM_PACKAGE_ID, message);
    }

    public static ObjectValue getProcessObject(Process process) throws IOException {
        ObjectValue obj = BallerinaValues.createObjectValue(SYSTEM_PACKAGE_ID, PROCESS_TYPE);
        obj.addNativeData(PROCESS_FIELD, process);
        return obj;
    }
    
    public static Process processFromObject(ObjectValue objVal) {
        return (Process) objVal.getNativeData(PROCESS_FIELD);
    }

    /**
     * Returns the system property which corresponds to the given key.
     *
     * @param key system property key
     * @return system property as a {@link String} or {@code BTypes.typeString.getZeroValue()} if the property does not
     * exist.
     */
    public static String getSystemProperty(String key) {
        String value = System.getProperty(key);
        if (value == null) {
            return org.ballerinalang.jvm.types.BTypes.typeString.getZeroValue();
        }
        return value;
    }

    private SystemUtils() {
    }
}

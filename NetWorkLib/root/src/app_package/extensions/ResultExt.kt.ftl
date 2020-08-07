package ${escapeKotlinIdentifiers(packageName)}.extensions

import ${escapeKotlinIdentifiers(packageName)}.Result

fun Result<*>.getException(): Exception {
    return (this as Result.Error).exception
}

fun <T> Result<T>.getData(): T? = (this as Result.Success).data

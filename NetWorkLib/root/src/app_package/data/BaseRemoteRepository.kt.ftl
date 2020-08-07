package ${escapeKotlinIdentifiers(packageName)}.data


import ${escapeKotlinIdentifiers(packageName)}.exceptions.NetworkException
import ${escapeKotlinIdentifiers(packageName)}.Result
import kotlinx.coroutines.CoroutineDispatcher
import kotlinx.coroutines.withContext
import retrofit2.Response
import java.net.ConnectException
import java.net.UnknownHostException

open class BaseRemoteRepository(
    private val ioDispatcher: CoroutineDispatcher
) {

    suspend fun <T : Any> serviceCall(call: suspend () -> Response<T>): Result<T> {

        val response = try {
            withContext(ioDispatcher) { call.invoke() }
        } catch (e: java.lang.Exception) {
            e.printStackTrace()

            val exception = when (e) {
                is ConnectException, is UnknownHostException -> {
                    NetworkException("Connection Error")
                }
                else -> e
            }

            return Result.Error(exception)
        }

        return if (response.isSuccessful) {
            Result.Success(response.body())
        } else {
            val exception = Exception(response.errorBody()?.string())
            Result.Error(exception)
        }
    }
}
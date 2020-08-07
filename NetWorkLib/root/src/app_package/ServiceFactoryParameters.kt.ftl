package ${escapeKotlinIdentifiers(packageName)}

import okhttp3.Interceptor
import retrofit2.CallAdapter
import java.net.URL

data class ServiceFactoryParameters(
    val url: String = "https://bull-s-hamburgueria.firebaseio.com/",//"https://firestore.googleapis.com/v1/projects/bull-s-hamburgueria/databases/(default)/"
    val interceptors: Set<Interceptor> = emptySet(),
    val networkInterceptors: Set<Interceptor> = emptySet(),
    val headers: HashMap<String, String> = HashMap(),
    val callAdapterFactory: CallAdapter.Factory? = null,
    val connectTimeout: Long? = null,
    val readTimeout: Long? = null,
    val writeTimeout: Long? = null
) {
    fun getBaseUrl() = url
}
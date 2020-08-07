package ${escapeKotlinIdentifiers(packageName)}


import okhttp3.*
import okhttp3.logging.HttpLoggingInterceptor
import retrofit2.Retrofit
import retrofit2.adapter.rxjava2.RxJava2CallAdapterFactory
import retrofit2.converter.gson.GsonConverterFactory
import java.util.concurrent.TimeUnit

private const val SERVICE_FACTORY_TAG = "ServiceFactory"

object ServiceFactory {

    fun getRetrofit(params: ServiceFactoryParameters): Retrofit = Retrofit.Builder()
        .addCallAdapterFactory(params.callAdapterFactory ?: RxJava2CallAdapterFactory.create())
        .addConverterFactory(GsonConverterFactory.create())
        .client(getClient(params))
        .baseUrl(params.getBaseUrl())
        .build()

    fun getLoggingInterceptor() = HttpLoggingInterceptor().setLevel(
        if (BuildConfig.DEBUG) HttpLoggingInterceptor.Level.BODY
        else HttpLoggingInterceptor.Level.NONE
    )

    private fun headerInterceptor(headerMap: HashMap<String, String>) = object : Interceptor {
        override fun intercept(chain: Interceptor.Chain): Response {

            val builder = chain.request().newBuilder()
                .apply { for (i in headerMap.keys) addHeader(i, headerMap[i].orEmpty()) }
                .addHeader("Accept", "application/json")

            return chain.proceed(builder.build())
        }
    }

    private fun getClient(params: ServiceFactoryParameters): OkHttpClient {
        val builder = OkHttpClient.Builder()
            .connectTimeout(params.connectTimeout ?: 10, TimeUnit.SECONDS)
            .readTimeout(params.readTimeout ?: 10, TimeUnit.SECONDS)
            .writeTimeout(params.writeTimeout ?: 10, TimeUnit.SECONDS)
            .addInterceptor(headerInterceptor(params.headers))

        params.interceptors.forEach { builder.addInterceptor(it) }
        params.networkInterceptors.forEach { builder.addNetworkInterceptor(it) }

        builder.addInterceptor(getLoggingInterceptor())

        return builder.build()
    }
}
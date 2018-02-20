package digital.wup.superhero.module

import android.app.Application
import com.jakewharton.picasso.OkHttp3Downloader
import com.squareup.picasso.Picasso
import dagger.Module
import dagger.Provides
import digital.wup.android.UseCaseThreadPoolScheduler
import digital.wup.android.data.CharactersLocalDataSource
import digital.wup.android.data.CharactersRemoteDataSource
import digital.wup.android.data.network.NetworkInterceptor
import digital.wup.android.presentation.ui.details.DetailsPresenterImpl
import digital.wup.superheroapp.common.UseCaseHandler
import digital.wup.superheroapp.common.UseCaseScheduler
import digital.wup.superheroapp.common.characters.CharactersMvpPresenter
import digital.wup.superheroapp.common.characters.CharactersPresenter
import digital.wup.superheroapp.common.characters.domain.usecase.GetCharactersUseCase
import digital.wup.superheroapp.common.charaterdetail.CharacterDetailMvpPresenter
import digital.wup.superheroapp.common.charaterdetail.CharacterDetailMvpView
import digital.wup.superheroapp.common.charaterdetail.domain.usecase.GetCharacterUseCase
import digital.wup.superheroapp.common.datasource.CharactersDataSource
import digital.wup.superheroapp.common.datasource.CharactersRepository
import okhttp3.OkHttpClient
import okhttp3.logging.HttpLoggingInterceptor
import javax.inject.Singleton

@Module
class SuperheroModule(private val application: Application) {

    @Singleton
    @Provides
    fun provideApplication(): Application {
        return application
    }

    @Singleton
    @Provides
    fun providCharactersLocalDataSource(application: Application): CharactersLocalDataSource {
        return CharactersLocalDataSource(application)
    }

    @Singleton
    @Provides
    fun providCharactersRemoteDataStore(okHttpClient: OkHttpClient): CharactersRemoteDataSource {
        return CharactersRemoteDataSource(okHttpClient)
    }

    @Singleton
    @Provides
    fun providCharactersDataSsource(remoteDataSource: CharactersRemoteDataSource, localDataSource: CharactersLocalDataSource): CharactersDataSource {
        return CharactersRepository(remoteDataSource, localDataSource)
    }

    @Singleton
    @Provides
    fun providGetCharactersUseCase(charactersDataStore: CharactersDataSource): GetCharactersUseCase {
        return GetCharactersUseCase(charactersDataStore)
    }

    @Singleton
    @Provides
    fun provideUseCaseScheduler(): UseCaseScheduler {
        return UseCaseThreadPoolScheduler()
    }

    @Singleton
    @Provides
    fun provideUseCaseHandler(useCaseScheduler: UseCaseScheduler): UseCaseHandler {
        return UseCaseHandler(useCaseScheduler)
    }

    @Singleton
    @Provides
    fun provideCharactersPresenter(useCaseHandler: UseCaseHandler, useCase: GetCharactersUseCase): CharactersMvpPresenter {
        return CharactersPresenter(useCaseHandler, useCase)
    }

    @Singleton
    @Provides
    fun provideGetCharacterUseCase(dataStore: CharactersDataSource): GetCharacterUseCase {
        return GetCharacterUseCase(dataStore)
    }

    @Singleton
    @Provides
    fun provideOkHttpClient(interceptor: HttpLoggingInterceptor): OkHttpClient {
        return OkHttpClient.Builder()
                .addInterceptor(NetworkInterceptor())
                .addInterceptor(interceptor)
                .build()
    }

    @Singleton
    @Provides
    fun provideHttpLoggingInterceptor(): HttpLoggingInterceptor {
        val loggingInterceptor = HttpLoggingInterceptor()
        loggingInterceptor.level = HttpLoggingInterceptor.Level.BODY
        return loggingInterceptor
    }

    @Singleton
    @Provides
    fun provideDetailsPresenter(useCase: GetCharacterUseCase, useCaseHandler: UseCaseHandler): CharacterDetailMvpPresenter {
        return DetailsPresenterImpl(useCase, useCaseHandler)
    }

    @Singleton
    @Provides
    fun providePicasso(application: Application, client: OkHttpClient): Picasso {
        return Picasso.Builder(application.applicationContext).downloader(OkHttp3Downloader(client)).build()
    }
}

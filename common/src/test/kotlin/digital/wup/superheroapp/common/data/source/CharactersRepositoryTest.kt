package digital.wup.superheroapp.common.data.source

import com.nhaarman.mockito_kotlin.any
import com.nhaarman.mockito_kotlin.argumentCaptor
import com.nhaarman.mockito_kotlin.eq
import digital.wup.superheroapp.common.characters.domain.model.Character
import digital.wup.superheroapp.common.characters.domain.model.Page
import digital.wup.superheroapp.common.datasource.CharactersDataSource
import digital.wup.superheroapp.common.datasource.CharactersRepository
import org.junit.Before
import org.junit.Test
import org.mockito.Mock
import org.mockito.Mockito.verify
import org.mockito.MockitoAnnotations.initMocks

/**
 * @author Balazs Varga
 */
class CharactersRepositoryTest {

    private val characters = listOf<Character>()
    private val page = Page()
    @Mock private lateinit var localDataSource: CharactersDataSource
    @Mock private lateinit var remoteDataSource: CharactersDataSource
    @Mock private lateinit var successCallback: (List<Character>) -> Unit
    @Mock private lateinit var errorCallback: () -> Unit
    private lateinit var charactersRepository: CharactersDataSource
    private val successCaptor = argumentCaptor<(List<Character>) -> Unit>()
    private val errorCaptor = argumentCaptor<() -> Unit>()

    @Before
    fun setupRepository() {
        initMocks(this)
        charactersRepository = CharactersRepository(localDataSource, remoteDataSource)
    }

    @Test
    fun loadCharacters_repositoryCachesAfterFirstApiCall() {

        twoLoadCharactersCallsToRepository(page, successCallback, errorCallback)

        verify(remoteDataSource).loadCharacters(eq(page), any(), any())
    }

    private fun twoLoadCharactersCallsToRepository(page: Page,
                                                   success: (List<Character>) -> Unit,
                                                   error: () -> Unit) {

        charactersRepository.loadCharacters(page, success, error)

        verify(localDataSource)
                .loadCharacters(eq(page), any(), errorCaptor.capture())

        errorCaptor.lastValue.invoke()

        verify(remoteDataSource)
                .loadCharacters(eq(page), successCaptor.capture(), any())

        successCaptor.lastValue.invoke(characters)

        charactersRepository.loadCharacters(page, success, error)
    }
}
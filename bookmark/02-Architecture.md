# Guide to app architecture

## Guide to app architecture
- App composition
  - Multiple form factors
  - Resource constraints
  - Variable launch conditions
- Common architectural principles
  - Separation of concerns
  - Adaptive layouts
  - Single source of truth (SSOT)
  - Unidirectional data flow (UDF)
- Recommended app architecture
  - UI layer
  - Domain layer (optional)
  - Data layer
- UI layer
  - UI elements that render the data on the screen.
  - State holders (such as `ViewModel`) that hold data, expose it to the UI, and handle logic. State holders should live for the same duration as the UI element they are providing state for. For example, a ViewModel for a screen should be retained in memory until the screen is removed from the app's navigation back stack.
- Data layer
  - Repository
  - DataSource
- Domain layer
  - UseCase
- Manage dependencies between components
  - Dependency injection (DI)
  - Service locator
- General best practices
  - Don't store data in app components.
  - Reduce dependencies on Android classes.
  - Define clear boundaries of responsibility between modules in your app.
  - Expose as little as possible from each module.
  - Focus on the unique core of your app so it stands out from other apps.
  - Use canonical layouts and app design patterns.
  - Preserve UI state across configuration changes.
  - Design reusable and composable UI components.
  - Consider how to make each part of your app testable in isolation.
  - Types are responsible for their concurrency policy.
  - Persist as much relevant and fresh data as possible.


## Recommendations for Android architecture
- Layered architecture: Our recommended layered architecture favors separation of concerns. It drives UI from data models, complies with the single source of truth principle, and follows unidirectional data flow principles.
  - Use a clearly defined data layer. (Strongly recommended)
  - Use a clearly defined UI layer. (Strongly recommended)
  - Expose application data from the data layer using a repository. (Strongly recommended)
  - Use coroutines and flows. (Strongly recommended)
  - Use a domain layer. (Recommended in big apps)
- UI layer: The role of the UI layer is to display the application data on the screen and serve as the primary point of user interaction.
  - Follow Unidirectional Data Flow (UDF). (Strongly recommended)
  - Use AAC ViewModels if their benefits apply to your app. (Strongly recommended)
  - Use lifecycle-aware UI state collection. (Strongly recommended)
    - `collectAsStateWithLifecycle()`
  - Do not send events from the ViewModel to the UI. (Strongly recommended)
  - Use a single-activity application. (Strongly recommended)
  - Use Jetpack Compose. (Strongly recommended)
- ViewModel: ViewModels are responsible for providing the UI state and accessing the data layer
  - Keep ViewModels independent of the Android lifecycle. (Strongly recommended)
  - Use coroutines and flows. (Strongly recommended)
  - Use ViewModels at screen level. (Strongly recommended)
    - `rememberViewModelStoreOwner()`
  - Use plain state holder classes in reusable UI components. (Strongly recommended)
  - Do not use `AndroidViewModel`. (Recommended)
  - Expose a UI state. (Recommended)
    - `StateFlow`, `stateIn`, `WhileSubscribed(5000)`
- Lifecycle
  - Use lifecycle-aware effects in composables instead of overriding `Activity` lifecycle callbacks. (Strongly recommended)
    - `LifecycleStartEffect`, `LifecycleResumeEffect`
- Handle dependencies
  - Use dependency injection. (Strongly recommended)
  - Scope to a component when necessary. (Strongly recommended)
  - Use Hilt. (Recommended)
- Testing
  - Know what to test. (Strongly recommended)
  - Prefer fakes to mocks. (Strongly recommended)
  - Test StateFlows. (Strongly recommended)
- Models
  - Create a model per layer in complex apps. (Recommended)
- Naming conventions
  - Naming methods. (Optional)
    - `makePayment()`
  - Naming properties. (Optional)
    - `inProgressTopicSelection`
  - Naming streams of data. (Optional)
    - `getAuthorsStream(): Flow<List<Author>>`
  - Naming interfaces implementations. (Optional)
    - `NewsRepository`
    - `DefaultNewsRepository`
    - `FakeAuthorsRepository`


## UI layer libraries

## UI layer
- The term UI refers to UI elements such as containers and composable functions that display data.
- `UI Elements` + `UI State` = `UI`
- Naming conventions in this guide
  - `NewsUiState`, `NewsItemUiState`
- the UI state is an immutable snapshot of the details needed for the UI to render
- State holders
  - State holders are the classes responsible for producing UI state and for the logic needed to produce that state.
  - Key Point: The ViewModel type is the recommended implementation for the management of screen-level UI state with access to the data layer. Furthermore, it survives configuration changes automatically. **ViewModel** classes define the logic to be applied to events in the app and produce updated state as a result.
- Types of logic
  - **Business logic** is the implementation of product requirements for app data. Business logic is usually placed in the domain or data layers, but never in the UI layer.
  - **UI behavior logic** or **UI logic** is how to display state changes on the screen.
- Keep UI logic in the UI, not in the ViewModel, particularly when it involves UI types like `Context`. If the UI grows in complexity and you want to delegate the UI logic to another class to favor testability and separation of concerns, **you can create a simple class as a state holder**. Simple classes created in the UI can take Android SDK dependencies because they follow the lifecycle of the UI; ViewModel objects have a longer lifespan.
- Expose UI state
``` kotlin
class NewsViewModel(
    private val repository: NewsRepository
) : ViewModel() {
    var uiState by mutableStateOf(NewsUiState())
        private set

    private var fetchJob: Job? = null

    fun fetchArticles(category: String) {
        fetchJob?.cancel()
        fetchJob = viewModelScope.launch {
            try {
                val newsItems = repository.newsItemsForCategory(category)
                uiState = uiState.copy(newsItems = newsItems)
            } catch (ioe: IOException) {
                val messages = getMessagesFromThrowable(ioe)
                uiState = uiState.copy(userMessages = messages)
            }
        }
    }
}
```
- Use a single UI state object to handle states that are related to each other.
- UI states: single stream or multiple streams?
  - Except: 
    - Unrelated data types
    - `UiState` diffing
- Threading and concurrency
  - Make sure all work performed in a ViewModel is main-safe—safe to call from the main thread. The data and domain layers are responsible for moving work to a different thread.
- Navigation
- Paging
- Animations


### UI event
- _UI events_ are actions that should be handled in the UI layer, either by the UI or by the ViewModel. The most common type of events are _user events_. The user produces user events by interacting with the app—for example, by tapping the screen or by generating gestures.
- Key terms:
  - UI: Code that handles the user interface.
  - UI events: Actions that should be handled in the UI layer.
  - User events: Events that the user produces when interacting with the app.
- The ViewModel is normally responsible for handling the business logic of a particular user event—for example, the user clicking on a button to refresh some data. Usually, the ViewModel handles this by exposing functions that the UI can call. User events might also have UI behavior logic that the UI can handle directly—for example, navigating to a different screen or showing a Snackbar.
- While the _business logic_ remains the same for the same app on different mobile platforms or form factors, the _UI behavior logic_ is an implementation detail that might differ between those cases. The UI layer page defines these types of logic as follows:
  - **Business logic** refers to what to do with state changes. The domain and data layers usually handle this logic. Throughout this guide, the Architecture Components ViewModel class is used as an opinionated solution for classes that handle business logic.
  - **UI behavior logic** or **UI logic** refers to how to display state changes. The UI handles this logic.
- Handle ViewModel events
  - UI actions that originate from the ViewModel—ViewModel events—should always result in a UI state update.
  - In other words: don't think about what actions the UI needs to make; think about how those actions affect the UI state.
- Consuming events can trigger state updates
- Navigation events
  - dropUnlessResumed()
  - Navigation events when the destination is kept in the back stack
- If you think your UI event use case cannot be solved with UI state updates, you might need to reconsider how data flows in your app. Consider the following principles:
  - **Each class should do what it's responsible for, not more.** The UI is in charge of screen-specific behavior logic such as navigation calls, click events, and obtaining permission requests. The ViewModel contains business logic and converts the results from lower layers of the hierarchy into UI state.
  - **Think about where the event originates.** Follow the decision tree presented at the beginning of this guide, and make each class handle what it's responsible for. For example, if the event originates from the UI and it results in a navigation event, then that event has to be handled in the UI. Some logic might be delegated to the ViewModel, but handling the event can't be entirely delegated to the ViewModel.
  - **If you have multiple consumers and you're worried about the event being consumed multiple times, you might need to reconsider your app architecture.** Having multiple concurrent consumers results in the _delivered exactly once_ contract becoming extremely difficult to guarantee, so the amount of complexity and subtle behavior explodes. If you're having this problem, consider pushing those concerns upwards in your UI tree; you might need a different entity scoped higher up in the hierarchy.
  - **Think about when the state needs to be consumed.** In certain situations, you might not want to keep consuming state when the app is in the background—for example, showing a `Toast`. In those cases, consider consuming the state when the UI is in the foreground.
  - Note: In some apps, you might have seen ViewModel events being exposed to the UI using Kotlin Channels or other reactive streams. When the producer (the ViewModel) outlives the consumer (Compose UI), these solutions don't guarantee the delivery and processing of those events. This can result in future problems for the developer, and it's also an unacceptable user experience for most apps because this could leave the app in an inconsistent state, it could introduce bugs, or the user might miss critical information.
    If you're in one of these situations, reconsider what that one-off ViewModel event actually means for your UI. Handle such events immediately and reduce them to UI state. UI state better represents the UI at a given point in time, it gives you more delivery and processing guarantees, it's usually easier to test, and it integrates consistently with the rest of your app.


### State holders and UI state
- Elements of the UI state production pipeline
  - The UI state and the logic that produces it defines the UI layer.
- UI state
  - UI state is the property that describes the UI. There are two types of UI state:
    - **Screen UI state** is what you need to display on the screen. This state is usually connected with other layers of the hierarchy because it contains app data.
    - **UI element state** refers to properties intrinsic to UI elements that influence how they are rendered.
- Logic
  - UI State → Logic → New UI State
  - **Business logic** is the implementation of product requirements for app data. The state holder usually delegates this logic to those layers by calling the methods they expose.
  - **UI logic** is related to how to display UI state on the screen. 
- Android lifecycle and the types of UI state and logic
  - **UI lifecycle independent**: This part of the UI layer deals with the data producing layers of the app (data or domain layers) and is defined by business logic. Lifecycle, configuration changes, and Activity recreation in the UI may affect if the UI state production pipeline is active, but do not affect the validity of the data produced.
  - **UI lifecycle dependent**: This part of the UI layer deals with UI logic, and is directly influenced by lifecycle or configuration changes. These changes directly affect the validity of the sources of data read within it, and as a result its state can only change when its lifecycle is active. Examples of this include runtime permissions and getting configuration dependent resources like localized strings.
  -
  | UI Lifecycle independent | UI Lifecycle dependent |
  | ------------------------ | ---------------------- |
  | Business logic           | UI Logic               |
  | Screen UI state          |                        |
- The UI state production pipeline
  - UI state produced and managed by the UI itself.
  - UI logic → UI.
  - Business logic → UI.
  - Business logic → UI logic → UI.
- In the case where both kinds of logic are applied to the UI state production pipeline, **business logic must always be applied before UI logic**. Trying to apply business logic after UI logic would imply that the business logic depends on UI logic.
- Note: State holders are not strictly necessary. Simple UIs may host their logic inline with their presentation code.
- Types of state holders
  - Similar to the kinds of UI state and logic, there are two types of state holders in the UI layer defined by their relationship to the UI lifecycle:
    - The business logic state holder.
    - The UI logic state holder.
- Business logic and its state holder
  - Produces UI State
  - Retained through activity recreation
  - Possess long lived state
  - Is unique to its UI and is not reusable
  - Note: The business logic state holder is typically implemented with a ViewModel instance because ViewModel instances support many of the features outlined above, particularly surviving Activity recreation.
  - Warning: Don't pass ViewModel instances down to other composable functions. Doing so couples the composable function with the ViewModel type, making it less reusable and harder to test and preview. Also, there would be no clear single source of truth (SSOT) that manages the ViewModel instance. Passing the ViewModel down allows multiple composables to call ViewModel functions and modify its state, making bugs harder to debug. Instead, follow UDF best practices and pass down just the necessary state. Likewise, pass the propagating events up until they reach the ViewModel's composable SSOT. That is the SSOT which handles the event and calls the corresponding ViewModel methods.
- The ViewModel as a business logic state holder
  - **The benefits of ViewModels** in Android development make them suitable for providing access to the business logic and preparing the application data for presentation on the screen. These benefits include the following:
    - Operations triggered by ViewModels survive configuration changes.
    - Integration with Navigation:
      - Navigation caches ViewModels while the screen is on the back stack. This is important to have your previously loaded data instantly available when you return to your destination. This is something more difficult to do with a state holder that follows the lifecycle of the composable screen.
      - The ViewModel is also cleared when the destination is popped off the back stack, ensuring that your state is automatically cleaned up. This is different from listening for the composable disposal that can happen for multiple reasons such as going to a new screen, due to a configuration change, or other reasons.
    - Integration with other Jetpack libraries such as Hilt.
  - Note: If ViewModel benefits don't apply to your use case or you do things in a different way you can move ViewModel's responsibilities into plain state holder classes.
- UI logic and its state holder
  - UI logic is logic that operates on data that the UI itself provides. This may be on UI elements' state, or on UI data sources like the permissions API or `Resources`. State holders that utilize UI logic typically have the following properties:
    - **Produces UI state and manages UI elements state.**
    - **Does not survive Activity recreation**: State holders that are hosted in UI logic are often dependent on data sources from the UI itself, and attempting to retain this information across configuration changes more often than not causes a memory leak. If state holders need data to persist across configuration changes, they need to delegate to another component better suited to surviving Activity recreation.
    - **Has references to UI scoped sources of data**: Sources of data like lifecycle APIs and Resources can safely be referenced and read as the UI logic state holder has the same lifecycle as the UI.
    - **Is reusable across multiple UIs**: Different instances of the same UI logic state holder may be reused in different parts of the app.
  - The UI logic state holder is typically implemented with a plain class. This is because the UI itself is responsible for the creation of the UI logic state holder and the UI logic state holder has the same lifecycle as the UI itself
  - Note: Plain class state holders are used when UI logic is complex enough to be moved out of the UI. Otherwise, UI logic can be implemented inline in the UI.
  - Note: Plain state holder classes are recommended for reusable pieces of UI like search bars or chip groups. You shouldn't use ViewModels in this case because they are best used for managing state for navigation destinations and access to business logic.
- **Ultimately, you should produce UI state using state holders closest to where it is consumed**. Less formally, you should hold state as low as possible while maintaining proper ownership. If you need access to business logic and need the UI state to persist as long as a screen may be navigated to, even across Activity recreation, a ViewModel is a great choice for your business logic state holder implementation. For shorter-lived UI state and UI logic, a plain class whose lifecycle is dependent solely on the UI should suffice.
- State holders are compoundable
  - State holders can depend on other state holders as long as the dependencies have an equal or shorter lifetime.
    - a UI logic state holder can depend on another UI logic state holder.
    - a screen level state holder can depend on a UI logic state holder.
  - Caution: Given that screen level state holders manage the business logic complexity of a screen or part of it, it wouldn't make sense a screen level state holder depends on another screen level state holder. If you're in this scenario, reconsider your screens and state holders and ensure that's what you need.


### UI State production
- Fundamentally, state production is the incremental application of these changes to the UI state. State always exists, and it changes as a result of events. The differences between events and state are summarized in the table below:
| Events | State |
| ------ | ----- |
| Transient, unpredictable, and exist for a finite period. | Always exists. |
| The inputs of state production. | The output of state production. |
| The product of the UI or other sources. | Is consumed by the UI. |
- A great mnemonic that summarizes the above is **state is; events happen**.
- Events can come from the following:
  - **Users**: As they interact with the app's UI.
  - **Other sources of state change**: APIs that present app data from UI, domain, or data layers like Snackbar timeout events, use cases, or repositories, respectively.
- The UI state production pipeline
  - **Inputs**: The sources of state change. 
    - Local to the UI layer: 
    - External to the UI layer:
    - A mixture of the above.
  - **State holders**: Types that apply business logic and UI logic to sources of state change, and that process user events to produce UI state.
  - **Output**: The UI State that the app can render to provide users the information they need.
- State production APIs
| Pipeline stage | API |
| ------ | ----- |
| Input | Use asynchronous APIs like Coroutines and Flows to perform work off the UI thread to keep the UI jank-free. |
| Output | se observable data holder APIs like Compose State or StateFlow to invalidate and re-render the UI when state changes. Observable data holders ensure that the UI always has a UI state to display on the screen. |
- State production pipeline assembly
  - Lifecycle aware: In the case where the UI is not visible or active, the state production pipeline must not consume any resources unless explicitly required.
  - Easy to consume: The UI must be able to easily render the produced UI state. In Jetpack Compose, state consumption is central to the UI, because composables can update based on state changes.
- Inputs in state production pipelines
  - One-shot operations that can be synchronous or asynchronous—for example, calls to `suspend` functions.
  - Stream APIs—for example, `Flows`.
  - All of the above.
- One-shot APIs as sources of state change
  - Mutating the UI state from asynchronous calls
    - `mutableStateOf()`, `MutableStateFlow`
    - `CoroutineScope`, `MutableStateFlow.update()`
  - Mutating the UI state from background threads
    - `withContext()`
    - `MutableStateFlow.update()`
    - `Snapshot.withMutableSnapshot()`
      - Warning: Updating Compose state from a non-UI thread without using **Snapshot.withMutableSnapshot{ }** can cause inconsistencies in the state produced.
- Stream APIs as sources of state change
  - `Flow.combine()`
















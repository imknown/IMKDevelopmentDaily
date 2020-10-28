``` java
private ExecutorService executor;

private static final short THREAD_POOL_SIZE = 15;

public MyResult() {
	executor = Executors.newFixedThreadPool(THREAD_POOL_SIZE);
}

@Override
public void putResult(final String result) {
	executor.execute(new Runnable(){
		@Override
		public void run() {
		  // TODO save result
		}
	});
}

@Override
public String getResult() {
	FutureTask<String> watcher = new FutureTask<>(new Callable<Bitmap>() {
		@Override
		public String call() throws Exception {
			String result = "";
			
			// TODO deal with result
			
			return result;
		}
	});
	
	// new Thread(watcher).start();
	executor.execute(watcher);
	
	String result = "";
	try {
		result = watcher.get();
	} catch (InterruptedException e) {
		e.printStackTrace();
	} catch (ExecutionException e) {
		e.printStackTrace();
	}

	return result;
}
```

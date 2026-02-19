package controller;

import exceptions.MyException;
import model.PrgState;
import model.values.Value;
import repository.IRepository;
import controller.GarbageCollector;

import java.util.*;
import java.util.concurrent.*;
import java.util.stream.Collectors;

public class Controller {

    private final IRepository repo;
    private ExecutorService executor;

    public Controller(IRepository repo) {
        this.repo = repo;
    }

    private List<PrgState> removeCompletedPrg(List<PrgState> prgList) {
        return prgList.stream()
                .filter(PrgState::isNotCompleted) 
                .collect(Collectors.toList());
    }

    private void oneStepForAllPrg(List<PrgState> prgList) throws MyException {

        prgList.forEach(prg -> {
            try {
                repo.logPrgStateExec(prg);
            } catch (MyException e) { System.err.println(e.getMessage()); }
        });


        List<Callable<PrgState>> callList = prgList.stream()
                .map((PrgState p) -> (Callable<PrgState>) p::oneStep)
                .collect(Collectors.toList());

        List<PrgState> newPrg = new ArrayList<>();

        try {

            List<Future<PrgState>> futures = executor.invokeAll(callList);

            for (Future<PrgState> f : futures) {
                try {
                    PrgState result = f.get();
                    if (result != null) {
                        newPrg.add(result);
                    }
                }
                catch (ExecutionException ex) {

                    Throwable cause = ex.getCause();
                    if (cause instanceof MyException)
                        throw (MyException) cause;
                    throw new MyException("Error during execution: " + cause);
                }
            }
        }
        catch (InterruptedException e) {
            throw new MyException("Execution interrupted: " + e.getMessage());
        }

        prgList.addAll(newPrg);

        prgList.forEach(prg -> {
            try {
                repo.logPrgStateExec(prg);
            }
            catch (MyException e) {
                System.err.println(e.getMessage());
            }
        });

        repo.setPrgList(prgList);
    }

    private void runGarbageCollector(List<PrgState> prgList) {

        if (prgList.isEmpty()) return;

        Set<Integer> reachable = new HashSet<>();

        for (PrgState prg : prgList) {
            reachable.addAll(
                    GarbageCollector.getReachableAddresses(
                            prg.getSymTable().getContent().values(),
                            prg.getHeap().getContent()
                    )
            );
        }

        // Run GC once on the shared heap
        Map<Integer, Value> newHeap = GarbageCollector.safeGarbageCollector(
                reachable,
                prgList.get(0).getSymTable().getContent(),
                prgList.get(0).getHeap().getContent() 
        );


        prgList.forEach(p -> p.getHeap().setContent(newHeap));
    }

    public void allStep() throws MyException {

        executor = Executors.newFixedThreadPool(2);

        List<PrgState> prgList = removeCompletedPrg(repo.getPrgList());

        while (!prgList.isEmpty()) {

            // Perform one step for all active threads
            oneStepForAllPrg(prgList);

            runGarbageCollector(prgList);

            prgList = removeCompletedPrg(repo.getPrgList());
        }

        executor.shutdownNow();

        repo.setPrgList(prgList);
    }

    public IRepository getRepo(){
        return this.repo;
    }
}
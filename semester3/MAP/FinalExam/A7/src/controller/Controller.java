package controller;

import exceptions.LanguageInterpreterException;
import model.state.ProgramState;
import model.value.IValue;
import repository.IRepository;

import java.util.*;
import java.util.concurrent.*;
import java.util.stream.Collectors;

public class Controller {
    private final IRepository repository;
    private ExecutorService executor;

    public Controller(IRepository repository) {
        this.repository = repository;
        this.executor = Executors.newFixedThreadPool(2);
    }

    public List<ProgramState> getProgramsList() {
        return this.repository.getProgramsList();
    }

    public List<ProgramState> removeCompletedPrograms(List<ProgramState> programStateList) {
        return programStateList.stream()
                .filter(ProgramState::isNotCompleted)
                .collect(Collectors.toList());
    }

    public void oneStepForAll(List<ProgramState> programList) throws Exception {
        programList.forEach(repository::logPrgStateExec);
        programList.forEach(System.out::println);

        List<Callable<ProgramState>> callList = programList.stream()
                .map(p -> (Callable<ProgramState>) p::oneStep)
                .collect(Collectors.toList());

        List<ProgramState> newThreads = executor.invokeAll(callList).stream()
                .map(future -> {
                    try {
                        return future.get();
                    } catch (InterruptedException | ExecutionException e) {
                        throw new LanguageInterpreterException(e.getMessage());
                    }
                })
                .filter(Objects::nonNull)
                .toList();

        programList.addAll(newThreads);
        programList.forEach(repository::logPrgStateExec);
        repository.setProgramsList(programList);
        programList.forEach(System.out::println);
    }

    public void allSteps() throws Exception {
        List<ProgramState> programList = removeCompletedPrograms(repository.getProgramsList());

        while (!programList.isEmpty()) {
            Set<Integer> referenced = programList.stream()
                    .flatMap(p -> GarbageCollector.getAddrFromSymTable(
                            p.symbolTable().getAll().values()
                    ).stream())
                    .collect(Collectors.toSet());

            Map<Integer, IValue> newHeap =
                    GarbageCollector.safeGarbageCollector(
                            referenced,
                            programList.getFirst().heap().getAll()
                    );

            programList.getFirst().heap().setContent(newHeap);

            oneStepForAll(programList);
            programList = removeCompletedPrograms(repository.getProgramsList());
        }

        shutdownExecutor();
        repository.setProgramsList(programList);
    }

    public void shutdownExecutor() {
        if (executor != null && !executor.isShutdown()) {
            executor.shutdown();
        }
    }
}

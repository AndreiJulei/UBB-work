package model.state;

import exceptions.LanguageInterpreterException;
import model.adt.*;
import model.statement.IStatement;
import model.value.IValue;
import model.value.StringValue;

import java.io.BufferedReader;
import java.util.ArrayList;
import java.util.List;

public record ProgramState(
        int id,
        IStack<IStatement> executionStack,
        IDictionary<String, IValue> symbolTable,
        IFileTable<StringValue, BufferedReader> fileTable, 
        IList<IValue> out,
        IHeap<Integer, IValue> heap,
        IBarrierTable barrierTable
) {

    private static int nextId = 0;

    public static synchronized int generateId() {
        return nextId++;
    }

    public ProgramState(
            IStack<IStatement> executionStack,
            IDictionary<String, IValue> symbolTable,
            IFileTable<StringValue, BufferedReader> fileTable,
            IList<IValue> out,
            IHeap<Integer, IValue> heap,
            IBarrierTable barrierTable,
            IStatement startingStatement
    ) {
        this(generateId(), executionStack, symbolTable, fileTable, out, heap, barrierTable);

        if (startingStatement != null) {
            executionStack.push(startingStatement);
        }
    }

    public boolean isNotCompleted() {
        return !executionStack.isEmpty();
    }

    public ProgramState oneStep() throws LanguageInterpreterException {
        if (executionStack.isEmpty())
            throw new LanguageInterpreterException("Execution stack is empty");

        IStatement statement = executionStack.pop();

        return statement.execute(this);
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        String header = "PROGRAM STATE " + id;

        var stack = executionStack().getAll();
        String stackLine = (stack == null || stack.isEmpty())
                ? "(empty)"
                : String.join(" -> ", stack.stream()
                .map(Object::toString)
                .toArray(String[]::new));

        var symEntries = symbolTable().getAll().entrySet();
        List<String> symLines = new ArrayList<>();
        if (symEntries.isEmpty()) {
            symLines.add("(empty)");
        } else {
            int maxKey = symEntries.stream()
                    .mapToInt(e -> e.getKey().length())
                    .max().orElse(0);
            for (var e : symEntries) {
                symLines.add(String.format("%-" + maxKey + "s = %s",
                        e.getKey(), String.valueOf(e.getValue())));
            }
        }

        var fileEntries = fileTable().getAll().entrySet();
        List<String> fileLines = new ArrayList<>();
        if (fileEntries.isEmpty()) {
            fileLines.add("(empty)");
        } else {
            for (var e : fileEntries) {
                fileLines.add(e.getKey().toString());
            }
        }

        var heapEntries = heap().getAll().entrySet();
        List<String> heapLines = new ArrayList<>();
        if (heapEntries.isEmpty()) {
            heapLines.add("(empty)");
        } else {
            for (var e : heapEntries) {
                heapLines.add(e.getKey() + " = " + e.getValue());
            }
        }

        var outputs = out().getAll();
        List<String> outLines = new ArrayList<>();
        if (outputs == null || outputs.isEmpty()) {
            outLines.add("(empty)");
        } else {
            outputs.forEach(v -> outLines.add(String.valueOf(v)));
        }

        List<String> allContent = new ArrayList<>();
        allContent.add(header);
        allContent.add("Execution Stack: " + stackLine);
        allContent.add("Symbol Table:");
        allContent.addAll(symLines);
        allContent.add("File Table:");
        allContent.addAll(fileLines);
        allContent.add("Heap:");
        allContent.addAll(heapLines);
        allContent.add("Output:");
        allContent.addAll(outLines);

        int innerWidth = allContent.stream().mapToInt(String::length).max().orElse(header.length());
        int finalInnerWidth = innerWidth + 2;

        java.util.function.Function<String, String> padLine = (line) -> {
            int spaces = finalInnerWidth - line.length();
            return " " + line + " ".repeat(Math.max(0, spaces - 1));
        };

        sb.append("┌").append("─".repeat(finalInnerWidth)).append("┐\n");
        sb.append("│").append(padLine.apply(header)).append("│\n");
        sb.append("├").append("─".repeat(finalInnerWidth)).append("┤\n");

        sb.append("│").append(padLine.apply("Execution Stack: " + stackLine)).append("│\n");
        sb.append("├").append("─".repeat(finalInnerWidth)).append("┤\n");

        sb.append("│").append(padLine.apply("Symbol Table:")).append("│\n");
        for (String sl : symLines)
            sb.append("│").append(padLine.apply(sl)).append("│\n");
        sb.append("├").append("─".repeat(finalInnerWidth)).append("┤\n");

        sb.append("│").append(padLine.apply("File Table:")).append("│\n");
        for (String fl : fileLines)
            sb.append("│").append(padLine.apply(fl)).append("│\n");
        sb.append("├").append("─".repeat(finalInnerWidth)).append("┤\n");

        sb.append("│").append(padLine.apply("Heap:")).append("│\n");
        for (String hl : heapLines)
            sb.append("│").append(padLine.apply(hl)).append("│\n");
        sb.append("├").append("─".repeat(finalInnerWidth)).append("┤\n");

        sb.append("│").append(padLine.apply("Output:")).append("│\n");
        for (String ol : outLines)
            sb.append("│").append(padLine.apply(ol)).append("│\n");

        sb.append("└").append("─".repeat(finalInnerWidth)).append("┘\n");
        return sb.toString();
    }

    public void pushStatement(IStatement statement) {
        if(statement != null) {
            executionStack.push(statement);
        }
    }
}

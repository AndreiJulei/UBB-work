package model.adt;

import exceptions.MyException;
import model.values.StringValue;
import java.io.BufferedReader;
import java.util.Map;

public class FileTable implements MyIDictionary<StringValue, BufferedReader> {
    private final MyIDictionary<StringValue, BufferedReader> fileTable;

    public FileTable() {
        this.fileTable = new MyDictionary<>();
    }

    @Override
    public boolean isDefined(StringValue key) {
        return fileTable.isDefined(key);
    }

    @Override
    public BufferedReader lookup(StringValue key) throws MyException {
        return fileTable.lookup(key);
    }

    @Override
    public void update(StringValue key, BufferedReader value) {
        fileTable.update(key, value);
    }

    @Override
    public void put(StringValue key, BufferedReader value) {
        fileTable.put(key, value);
    }

    @Override
    public Map<StringValue, BufferedReader> getContent() {
        return fileTable.getContent();
    }

    @Override
    public String toString() {
        return fileTable.toString();
    }

    @Override
    public FileTable clone() {
        FileTable cloned = new FileTable();
        for (Map.Entry<StringValue, BufferedReader> entry : fileTable.getContent().entrySet()) {
            cloned.put(entry.getKey(), entry.getValue());
        }
        return cloned;
    }
}

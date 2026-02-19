package model.state;

import exceptions.LanguageInterpreterADTException;
import model.adt.IDictionary;
import model.adt.IFileTable;

import java.util.HashMap;
import java.util.Map;

public class FileTable<K, V> implements IFileTable<K, V> {
    private final Map<K, V> map = new HashMap<>();

    @Override
    public boolean isDefined(K fileName) {
        return map.containsKey(fileName);
    }

    @Override
    public void declareVariable(K filename, V fileDescriptor)
            throws LanguageInterpreterADTException {
        if (map.containsKey(filename)) {
            throw new LanguageInterpreterADTException("File already opened: " + filename);
        }
        map.put(filename, fileDescriptor);
    }

    @Override
    public void update(K filename, V fileDescriptor)
            throws LanguageInterpreterADTException {
        if (!map.containsKey(filename)) {
            throw new LanguageInterpreterADTException("File not opened: " + filename);
        }
        map.put(filename, fileDescriptor);
    }

    @Override
    public void remove(K key) throws LanguageInterpreterADTException {
        if (!isDefined(key)) {
            throw new LanguageInterpreterADTException("File not opened: " + key);
        }
        map.remove(key);
    }

    @Override
    public V getValue(K filename)
            throws LanguageInterpreterADTException {
        if (!map.containsKey(filename)) {
            throw new LanguageInterpreterADTException("File not opened: " + filename);
        }
        return map.get(filename);
    }

    @Override
    public IDictionary<K, V> deepCopy() {
        FileTable<K, V> copy = new FileTable<>();

        for (Map.Entry<K, V> entry : map.entrySet()) {
            V value = entry.getValue();

            copy.map.put(entry.getKey(), value);
        }

        return copy;
    }

    @Override
    public Map<K, V> getAll() {
        return new HashMap<>(map);
    }
}

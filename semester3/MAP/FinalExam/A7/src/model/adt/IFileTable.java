package model.adt;

import exceptions.LanguageInterpreterADTException;

public interface IFileTable<K, V> extends IDictionary<K, V> {
    void remove(K key) throws LanguageInterpreterADTException;
}


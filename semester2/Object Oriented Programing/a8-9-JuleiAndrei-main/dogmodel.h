// dogmodel.h
#ifndef DOGMODEL_H
#define DOGMODEL_H

#include <QAbstractTableModel>
#include <vector>
#include "domain.h" // Your existing domain.h

class DogModel : public QAbstractTableModel {
    Q_OBJECT

public:
    explicit DogModel(const std::vector<Dog>& dogs, QObject *parent = nullptr);

    // Basic functions
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    int columnCount(const QModelIndex &parent = QModelIndex()) const override;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    QVariant headerData(int section, Qt::Orientation orientation, int role = Qt::DisplayRole) const override;

    // Custom function to update data
    void setDogs(const std::vector<Dog>& dogs);

private:
    std::vector<Dog> m_dogs;
};

#endif // DOGMODEL_H

#include "dogmodel.h"

DogModel::DogModel(const std::vector<Dog>& dogs, QObject *parent)
    : QAbstractTableModel(parent), m_dogs(dogs)
{
}

int DogModel::rowCount(const QModelIndex &parent) const
{
    if (parent.isValid())
        return 0;
    return m_dogs.size();
}

int DogModel::columnCount(const QModelIndex &parent) const
{
    if (parent.isValid())
        return 0;
    return 4; // Breed, Name, Age, Photo
}

QVariant DogModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid())
        return QVariant();

    if (index.row() >= m_dogs.size() || index.row() < 0)
        return QVariant();

    const Dog &dog = m_dogs[index.row()];

    if (role == Qt::DisplayRole) {
        switch (index.column()) {
            case 0: return QString::fromStdString(dog.get_breed());
            case 1: return QString::fromStdString(dog.get_name());
            case 2: return dog.get_age();
            case 3: return QString::fromStdString(dog.get_photo());
            default: break;
        }
    }
    return QVariant();
}

QVariant DogModel::headerData(int section, Qt::Orientation orientation, int role) const
{
    if (role == Qt::DisplayRole && orientation == Qt::Horizontal) {
        switch (section) {
            case 0: return QString("Breed");
            case 1: return QString("Name");
            case 2: return QString("Age");
            case 3: return QString("Photo URL");
            default: break;
        }
    }
    return QVariant();
}

void DogModel::setDogs(const std::vector<Dog>& dogs)
{
    beginResetModel(); // Notify views that the model data is about to change
    m_dogs = dogs;
    endResetModel();   // Notify views that the model data has changed
}

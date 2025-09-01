#include "utils.h"
#include <QDebug>

void logMessage(const QString& message) {
    qDebug() << message;
}

QString formatBacteriumInfo(const QString& name, const QString& characteristics) {
    return QString("Bacterium: %1, Characteristics: %2").arg(name, characteristics);
}
































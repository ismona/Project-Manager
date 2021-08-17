#ifndef EXPORTER_H
#define EXPORTER_H

#include <iostream>
#include <QObject>
#include <QString>
#include <QtWidgets>
#include <QPrinter>

using namespace std;

class Exporter : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString html WRITE setHtml)
    Q_PROPERTY(QString folderPath READ getFolderPath WRITE setFolderPath NOTIFY pathChanged)

public:
    Exporter(QObject *parent = nullptr);
    ~Exporter();

    void setHtml(const QString &html);
    Q_INVOKABLE void start_export(QString param);

    void setFolderPath(QString folderPath);
    Q_INVOKABLE void changePath();

    QString getFolderPath();

signals:
    void sendResult(int state);
    void pathChanged(QString folderPath);

private:
    QPrinter* printer;
    QString html;
    QString folderPath;
};

#endif // EXPORTER_H

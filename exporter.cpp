#include "exporter.h"
#include <iostream>
#include <QSettings>

using namespace std;


Exporter::Exporter(QObject *parent) : QObject(parent)
{
    printer = new QPrinter(QPrinter::PrinterResolution);
    printer->setOutputFormat(QPrinter::PdfFormat);
    printer->setPaperSize(QPrinter::A4);
}

Exporter::~Exporter()
{
    delete printer;
}


/* nastavenie path pre export */

void Exporter::setFolderPath(QString folderPath){
    this->folderPath = folderPath;
    emit pathChanged(folderPath);
}

QString Exporter::getFolderPath(){
    return folderPath;
}

void Exporter::changePath(){

    folderPath = QFileDialog::getExistingDirectory((QWidget*)nullptr, "Open Directory", folderPath, QFileDialog::ShowDirsOnly|QFileDialog::DontResolveSymlinks);
}


/* export */

void Exporter::setHtml(const QString &html)
{
    this->html = html;
    //cout << html.toUtf8().constData();
}

void Exporter::start_export(QString projectName)
{
    QString fileName = QFileDialog::getSaveFileName((QWidget*)nullptr, "Export do PDF",folderPath+"/"+projectName, "*.pdf");
    if (QFileInfo(fileName).suffix().isEmpty())
        fileName.append(".pdf");

    printer->setOutputFileName(fileName);

    QTextDocument doc;
    doc.setHtml(html.toUtf8().constData());
    doc.setPageSize(printer->pageRect().size());
    doc.print(printer);

    emit sendResult(printer->printerState());   //notifikacie pre stavy, 0=OK, >0=ERR
}


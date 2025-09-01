#include "mainwindow.h"
#include <QMessageBox>

MainWindow::MainWindow(Service &service, QWidget *parent) : QMainWindow(parent), ui(new Ui::MainWindow),
                                                            service(service) {
    ui->setupUi(this);
    auto equations = service.getEquations();
    for (auto &eq: equations) { 
        QString eqStr;
        if (eq.getA() != 0) {
            if (eq.getA() == 1) {
                eqStr += QString("x^2");
            } else {
                eqStr += QString::number(eq.getA()) + "x^2";
            }
        }
        if (eq.getB() != 0) {
            if (eq.getB() > 0 && !eqStr.isEmpty()) eqStr += "+";
            eqStr += QString::number(eq.getB()) + "x";
        }
        if (eq.getC() != 0) {
            if (eq.getC() > 0 && !eqStr.isEmpty()) eqStr += "+";
            eqStr += QString::number(eq.getC());
        }
        if (eqStr.isEmpty()) eqStr = "0";
        auto *item = new QListWidgetItem(eqStr);
        double discriminant = eq.getB() * eq.getB() - 4 * eq.getA() * eq.getC();
        if (discriminant >= 0) {
            item->setBackground(Qt::green);
        }
        ui->equations_list->addItem(item);
        connect(ui->add_equation, &QPushButton::clicked, this, &MainWindow::on_add_equation_clicked);
        connect(ui->solutions_button, &QPushButton::clicked, this, &MainWindow::show_solutions);
    }
}

void MainWindow::on_add_equation_clicked() {
    bool okA, okB, okC;
    double a = ui->a_value->text().toDouble(&okA);
    double b = ui->b_value->text().toDouble(&okB);
    double c = ui->c_value->text().toDouble(&okC);

    if (okA && okB && okC) {
        service.addEquation(a, b, c);
        QString eqStr;
        if (a != 0) {
            if (a == 1) {
                eqStr += QString("x^2");
            } else {
                eqStr += QString::number(a) + "x^2";
            }
        }
        if (b != 0) {
            if (b > 0 && !eqStr.isEmpty()) eqStr += "+";
            eqStr += QString::number(b) + "x";
        }
        if (c != 0) {
            if (c > 0 && !eqStr.isEmpty()) eqStr += "+";
            eqStr += QString::number(c);
        }
        if (eqStr.isEmpty()) eqStr = "0";
        auto *item = new QListWidgetItem(eqStr);
        double discriminant = b * b - 4 * a * c;
        if (discriminant >= 0) {
            item->setBackground(Qt::green);
        }
        ui->equations_list->addItem(item);

        ui->a_value->clear();
        ui->b_value->clear();
        ui->c_value->clear();
    }
}

void MainWindow::show_solutions() {
    int row = ui->equations_list->currentRow();
    if (row < 0 || row >= service.getEquations().size()) {
        ui->x1->setText("");
        ui->x2->setText("");
        return;
    }
    auto &eq = service.getEquations()[row];
    double a = eq.getA(), b = eq.getB(), c = eq.getC();
    double d = b * b - 4 * a * c;
    QString x1, x2;
    if (a == 0) {
        if (b != 0) {
            double sol = -c / b;
            x1 = x2 = QString::number(sol);
        } else {
            x1 = x2 = (c == 0) ? "Infinite solutions" : "No solution";
        }
    } else if (d >= 0) {
        double r1 = (-b + sqrt(d)) / (2 * a);
        double r2 = (-b - sqrt(d)) / (2 * a);
        x1 = QString::number(r1);
        x2 = QString::number(r2);
    } else {
        double real = -b / (2 * a);
        double imag = sqrt(-d) / (2 * a);
        x1 = QString("%1 + %2i").arg(real).arg(imag);
        x2 = QString("%1 - %2i").arg(real).arg(imag);
    }
    ui->x1->setText(x1);
    ui->x2->setText(x2);
}

MainWindow::~MainWindow() {
    delete ui;
}

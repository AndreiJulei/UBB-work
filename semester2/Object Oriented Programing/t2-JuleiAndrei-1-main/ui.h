#include "controller.h"


class UI{

    private:
    Portofolio* portofolio;

    public:
    UI(Portofolio* portofolio) :portofolio(portofolio){}

    void runUi();
};
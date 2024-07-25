#include <stdio.h>

// Diferansiyel denklemin katsay�lar�n� saklayacak yap�
typedef struct {
    double a;  // Katsay�
} DiffEq;

// Diferansiyel denklemin sa� taraf�n� hesaplayan fonksiyon
double f(double y, DiffEq eq) {
    return eq.a * y;
}

// Runge-Kutta 4. mertebe y�ntemi
double RK4(double y0, double h, double x, DiffEq eq) {
    double k1, k2, k3, k4;
    double y = y0;
    double t = 0;

    while (t < x) {
        k1 = h * f(y, eq);
        k2 = h * f(y + 0.5 * k1, eq);
        k3 = h * f(y + 0.5 * k2, eq);
        k4 = h * f(y + k3, eq);

        y = y + (k1 + 2*k2 + 2*k3 + k4) / 6;
        t += h;

        printf("t = %lf, y = %lf\n", t, y);
    }

    return y;
}

int main() {
    DiffEq eq;
    printf("Katsay� a giriniz: ");
    scanf("%lf", &eq.a);

    double y0, h, x;
    printf("Ba�lang�� de�eri y0 giriniz: ");
    scanf("%lf", &y0);
    printf("Ad�m boyutu h giriniz: ");
    scanf("%lf", &h);
    printf("Hedef ba��ms�z de�i�ken de�eri x giriniz: ");
    scanf("%lf", &x);

    double result = RK4(y0, h, x, eq);
    printf("Yakla��k ��z�m: x = %lf i�in y = %lf\n", x, result);

    return 0;
}


#include <stdio.h>

// Diferansiyel denklemin katsayýlarýný saklayacak yapý
typedef struct {
    double a;  // Katsayý
} DiffEq;

// Diferansiyel denklemin sað tarafýný hesaplayan fonksiyon
double f(double y, DiffEq eq) {
    return eq.a * y;
}

// Runge-Kutta 4. mertebe yöntemi
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
    printf("Katsayý a giriniz: ");
    scanf("%lf", &eq.a);

    double y0, h, x;
    printf("Baþlangýç deðeri y0 giriniz: ");
    scanf("%lf", &y0);
    printf("Adým boyutu h giriniz: ");
    scanf("%lf", &h);
    printf("Hedef baðýmsýz deðiþken deðeri x giriniz: ");
    scanf("%lf", &x);

    double result = RK4(y0, h, x, eq);
    printf("Yaklaþýk çözüm: x = %lf için y = %lf\n", x, result);

    return 0;
}

